import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_service.dart';
import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  AuthService._internal();
  factory AuthService() => _instance;

  // --- Claude's robust error-handling sign in ---
  Future<Map<String, dynamic>> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String role = await getUserRole(result.user!.uid);
      return {
        'success': true,
        'user': result.user,
        'role': role,
        'message': 'تم تسجيل الدخول بنجاح',
      };
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'لم يتم العثور على حساب بهذا البريد الإلكتروني';
          break;
        case 'wrong-password':
          message = 'كلمة المرور غير صحيحة';
          break;
        case 'invalid-email':
          message = 'البريد الإلكتروني غير صالح';
          break;
        case 'user-disabled':
          message = 'تم تعطيل هذا الحساب';
          break;
        case 'too-many-requests':
          message = 'محاولات كثيرة جداً. يرجى المحاولة لاحقاً';
          break;
        case 'invalid-credential':
          message = 'بيانات الدخول غير صحيحة';
          break;
        default:
          message = 'حدث خطأ: ${e.message}';
      }
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: $e',
      };
    }
  }

  // --- Claude's robust error-handling sign up ---
  Future<Map<String, dynamic>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
    String role = 'student',
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.updateDisplayName(name);
      await _firestore.collection('users').doc(result.user!.uid).set({
        'name': name,
        'email': email,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      });
      return {
        'success': true,
        'user': result.user,
        'role': role,
        'message': 'تم إنشاء الحساب بنجاح',
      };
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'هذا البريد الإلكتروني مستخدم بالفعل';
          break;
        case 'weak-password':
          message = 'كلمة المرور ضعيفة جداً';
          break;
        case 'invalid-email':
          message = 'البريد الإلكتروني غير صالح';
          break;
        default:
          message = 'حدث خطأ: ${e.message}';
      }
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع: $e',
      };
    }
  }

  // --- Methods your app expects ---
  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentFirebaseUser => _auth.currentUser;

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final uid = cred.user?.uid;
      if (uid != null) {
        final existing = await _firestoreService.getUserById(uid);
        if (existing == null) {
          final appUser = AppUser(uid: uid, email: email, displayName: cred.user?.displayName ?? '', role: UserRole.student, createdAt: DateTime.now(), enrolledMutuns: []);
          await _firestoreService.saveUser(appUser);
        }
      }
      return cred;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> registerWithEmail(String email, String password, {String? displayName}) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final uid = cred.user?.uid;
      if (uid != null) {
        final role = UserRole.student;
        final appUser = AppUser(uid: uid, email: email, displayName: displayName ?? '', role: role, createdAt: DateTime.now(), enrolledMutuns: []);
        await _firestoreService.saveUser(appUser);
      }
      return cred;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<AppUser?> getCurrentAppUser() async {
    final user = currentFirebaseUser;
    if (user == null) return null;
    return await _firestoreService.getUserById(user.uid);
  }

  Future<void> initTestAdminUser({
    String email = 'admin@miliana.com',
    String password = 'password123',
  }) async {
    try {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      } catch (e) {
        if (e.toString().contains('user-not-found')) {
          final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          final uid = cred.user?.uid;
          if (uid != null) {
            final adminUser = AppUser(
              uid: uid,
              email: email,
              displayName: 'Admin',
              role: UserRole.admin,
              createdAt: DateTime.now(),
              enrolledMutuns: [],
            );
            await _firestoreService.saveUser(adminUser);
          }
        } else {
          rethrow;
        }
      }
      final user = _auth.currentUser;
      if (user != null) {
        final appUser = await _firestoreService.getUserById(user.uid);
        if (appUser != null && appUser.role != UserRole.admin) {
          await _firestoreService.updateUserRole(user.uid, UserRole.admin);
        } else if (appUser == null) {
          final adminUser = AppUser(
            uid: user.uid,
            email: email,
            displayName: 'Admin',
            role: UserRole.admin,
            createdAt: DateTime.now(),
            enrolledMutuns: [],
          );
          await _firestoreService.saveUser(adminUser);
        }
        await signOut();
      }
    } catch (e) {
      print('Failed to init test admin user: $e');
    }
  }

  // --- Claude's role and utility methods ---
  Future<String> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        return data?['role'] ?? 'student';
      }
      return 'student';
    } catch (e) {
      print('Error getting user role: $e');
      return 'student';
    }
  }

  Future<void> updateLastLogin() async {
    if (currentFirebaseUser != null) {
      try {
        await _firestore.collection('users').doc(currentFirebaseUser!.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        print('Error updating last login: $e');
      }
    }
  }

  Future<bool> isAdmin() async {
    if (currentFirebaseUser == null) return false;
    String role = await getUserRole(currentFirebaseUser!.uid);
    return role == 'admin';
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return {
        'success': true,
        'message': 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني',
      };
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'لم يتم العثور على حساب بهذا البريد الإلكتروني';
          break;
        case 'invalid-email':
          message = 'البريد الإلكتروني غير صالح';
          break;
        default:
          message = 'حدث خطأ: ${e.message}';
      }
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ غير متوقع',
      };
    }
  }

  Stream<DocumentSnapshot> getUserDataStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }
}
