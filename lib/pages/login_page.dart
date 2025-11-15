import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import 'admin_gate.dart';
import 'signup_page.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';
import '../constants/app_colors.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onSignedIn;
  const LoginPage({super.key, this.onSignedIn});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  AppUser? _loggedInUser;
  bool _showHelloPage = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // Removed display name controller from login page
  final _promoteEmailController = TextEditingController();
  final AuthService _auth = AuthService();
  final FirestoreService _firestore = FirestoreService();
  bool _loading = false;
  final List<String> _adminKeys = ['ADMINKEY123', 'SUPERADMIN456']; // Example keys

  final _adminKeyController = TextEditingController();
  bool _showAdminKeyDialog = false;
  // Registration moved to separate sign up page

  // Claim admin role removed from login page

  Future<void> _submitAdminKey() async {
    final enteredKey = _adminKeyController.text.trim();
    if (_auth.currentFirebaseUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب تسجيل الدخول أولاً قبل المطالبة بدور مسؤول.')),
      );
      setState(() => _showAdminKeyDialog = false);
      return;
    }
    if (_adminKeys.contains(enteredKey)) {
      // Promote current user to admin
      final user = _auth.currentFirebaseUser;
      await _firestore.updateUserRole(user!.uid, UserRole.admin);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت الترقية إلى مسؤول!')),
      );
      setState(() => _showAdminKeyDialog = false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('مفتاح غير صحيح')),
      );
    }
  }

  Future<void> _signIn() async {
    setState(() => _loading = true);
    try {
      await _auth.signInWithEmail(_emailController.text.trim(), _passwordController.text);
      final user = _auth.currentFirebaseUser;
      if (user != null) {
        final appUser = await _auth.getCurrentAppUser();
        if (appUser != null && appUser.role == UserRole.admin) {
          // Navigate to admin dashboard
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => AdminGate()),
              (route) => false,
            );
          }
        } else {
          setState(() {
            _loggedInUser = appUser;
            _showHelloPage = true;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل تسجيل الدخول: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _createTestAdmin() async {
    setState(() => _loading = true);
    try {
      await _auth.initTestAdminUser();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء مستخدم الاختبار بنجاح! البريد: admin@miliana.com, كلمة المرور: password123')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل الإنشاء: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _promoteToAdmin() async {
    final email = _promoteEmailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('أدخل البريد الإلكتروني')));
      return;
    }

    setState(() => _loading = true);
    try {
      // Search for user by email in Firestore users collection
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('لم يتم العثور على مستخدم بالبريد: $email')),
          );
        }
        return;
      }

      final userId = snapshot.docs.first.id;
      await _firestore.updateUserRole(userId, UserRole.admin);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم ترقية $email إلى مسؤول بنجاح!')),
        );
        _promoteEmailController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل الترقية: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _buildHelloPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('مرحباً، ${_loggedInUser?.displayName ?? ''}!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text('تاريخ التسجيل: ${_loggedInUser?.createdAt.toString().split(' ').first ?? ''}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 18),
                const Text('عن حضيرات ميليانة:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('حضيرات ميليانة هو تطبيق لإدارة وتتبع الأنشطة التعليمية والدينية في مدينة ميليانة، يتيح للطلاب والمعلمين والإداريين التفاعل بسهولة.'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _showAdminKeyDialog = true);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('مطالبة بدور مسؤول'),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                    if (mounted) {
                      setState(() {
                        _loggedInUser = null;
                        _showHelloPage = false;
                      });
                      if (widget.onSignedIn != null) widget.onSignedIn!();
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('تسجيل خروج'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.deepBlue),
                ),
                if (_showAdminKeyDialog)
                  AlertDialog(
                    title: const Text('إدخال مفتاح المسؤول'),
                    content: SingleChildScrollView(
                      child: TextField(
                        controller: _adminKeyController,
                        decoration: const InputDecoration(labelText: 'مفتاح المسؤول'),
                        obscureText: true,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() => _showAdminKeyDialog = false);
                        },
                        child: const Text('إلغاء'),
                      ),
                      ElevatedButton(
                        onPressed: _submitAdminKey,
                        child: const Text('تأكيد'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(title: const Text('تسجيل الدخول'), backgroundColor: AppColors.deepBlue),
      body: _showHelloPage && _loggedInUser != null
          ? _buildHelloPage()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('تسجيل الدخول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
                              const SizedBox(height: 16),
                              // Removed name field from login
                              TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(labelText: 'كلمة المرور'),
                                obscureText: true,
                              ),
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: _loading ? null : _signIn,
                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.deepBlue),
                                    child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('تسجيل الدخول'),
                                  ),
                                  // Registration button now navigates to SignUpPage
                                  ElevatedButton(
                                    onPressed: _loading
                                        ? null
                                        : () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => SignUpPage(
                                                  onSignedUp: widget.onSignedIn,
                                                ),
                                              ),
                                            );
                                          },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                    child: const Text('تسجيل جديد', style: TextStyle(fontSize: 11)),
                                  ),
                                ],
                              ),
                              if (_showAdminKeyDialog)
                                AlertDialog(
                                  title: const Text('إدخال مفتاح المسؤول'),
                                  content: TextField(
                                    controller: _adminKeyController,
                                    decoration: const InputDecoration(labelText: 'مفتاح المسؤول'),
                                    obscureText: true,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() => _showAdminKeyDialog = false);
                                      },
                                      child: const Text('إلغاء'),
                                    ),
                                    ElevatedButton(
                                      onPressed: _submitAdminKey,
                                      child: const Text('تأكيد'),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      // Removed old promote-to-admin-by-email section for cleaner UI
                    ],
                  ),
                ),
              ),
            ),
    );
  }

}
