import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chikh_model.dart';
import '../models/mutun_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';

/// Firestore service for managing all database operations
class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  
  late final FirebaseFirestore _firestore;

  FirestoreService._internal() {
    _firestore = FirebaseFirestore.instance;
  }

  factory FirestoreService() {
    return _instance;
  }

  // ==================== CHIKH OPERATIONS ====================

  /// Add a new chikh to Firestore
  Future<String> addChikh(Chikh chikh) async {
    try {
      final docRef = _firestore.collection('chikhs').doc(chikh.id);
      await docRef.set(chikh.toJson());
      return chikh.id;
    } catch (e) {
      throw Exception('فشل إضافة الشيخ: $e');
    }
  }

  /// Update an existing chikh
  Future<void> updateChikh(Chikh chikh) async {
    try {
      await _firestore.collection('chikhs').doc(chikh.id).update(chikh.toJson());
    } catch (e) {
      throw Exception('فشل تحديث الشيخ: $e');
    }
  }

  /// Delete a chikh
  Future<void> deleteChikh(String chikhId) async {
    try {
      await _firestore.collection('chikhs').doc(chikhId).delete();
    } catch (e) {
      throw Exception('فشل حذف الشيخ: $e');
    }
  }

  /// Get all chikhs
  Stream<List<Chikh>> getChikhsStream() {
    return _firestore.collection('chikhs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Chikh.fromJson(doc.data())).toList();
    });
  }

  /// Get a single chikh by ID
  Future<Chikh?> getChikhById(String chikhId) async {
    try {
      final doc = await _firestore.collection('chikhs').doc(chikhId).get();
      if (doc.exists) {
        return Chikh.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('فشل جلب الشيخ: $e');
    }
  }

  // ==================== MUTUN OPERATIONS ====================

  /// Add a new mutun to Firestore
  Future<String> addMutun(Mutun mutun) async {
    try {
      final docRef = _firestore.collection('mutuns').doc(mutun.id);
      await docRef.set(mutun.toJson());
      
      // Add mutun ID to chikh's mutunIds list
      await _firestore.collection('chikhs').doc(mutun.chikhId).update({
        'mutunIds': FieldValue.arrayUnion([mutun.id])
      });
      
      return mutun.id;
    } catch (e) {
      throw Exception('فشل إضافة المتن: $e');
    }
  }

  /// Update an existing mutun
  Future<void> updateMutun(Mutun mutun) async {
    try {
      await _firestore.collection('mutuns').doc(mutun.id).update(mutun.toJson());
    } catch (e) {
      throw Exception('فشل تحديث المتن: $e');
    }
  }

  /// Delete a mutun
  Future<void> deleteMutun(String mutunId, String chikhId) async {
    try {
      await _firestore.collection('mutuns').doc(mutunId).delete();
      
      // Remove mutun ID from chikh's mutunIds list
      await _firestore.collection('chikhs').doc(chikhId).update({
        'mutunIds': FieldValue.arrayRemove([mutunId])
      });
    } catch (e) {
      throw Exception('فشل حذف المتن: $e');
    }
  }

  /// Get all mutuns
  Stream<List<Mutun>> getMutunsStream() {
    return _firestore.collection('mutuns').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Mutun.fromJson(doc.data())).toList();
    });
  }

  /// Get mutuns for a specific chikh
  Stream<List<Mutun>> getMutunsByChikhStream(String chikhId) {
    return _firestore
        .collection('mutuns')
        .where('chikhId', isEqualTo: chikhId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Mutun.fromJson(doc.data())).toList();
        });
  }

  /// Get a single mutun by ID
  Future<Mutun?> getMutunById(String mutunId) async {
    try {
      final doc = await _firestore.collection('mutuns').doc(mutunId).get();
      if (doc.exists) {
        return Mutun.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('فشل جلب المتن: $e');
    }
  }

  // ==================== ORDER OPERATIONS ====================

  /// Add a new order
  Future<String> addOrder(OrderClass order) async {
    try {
      final docRef = _firestore.collection('orders').doc(order.id);
      await docRef.set(order.toJson());
      return order.id;
    } catch (e) {
      throw Exception('فشل إضافة الطلب: $e');
    }
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': newStatus,
      });
    } catch (e) {
      throw Exception('فشل تحديث الطلب: $e');
    }
  }

  /// Update an existing order
  Future<void> updateOrder(OrderClass order) async {
    try {
      await _firestore.collection('orders').doc(order.id).update(order.toJson());
    } catch (e) {
      throw Exception('فشل تحديث الطلب: $e');
    }
  }

  /// Delete an order
  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
    } catch (e) {
      throw Exception('فشل حذف الطلب: $e');
    }
  }

  /// Get all orders
  Stream<List<OrderClass>> getOrdersStream() {
    return _firestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => OrderClass.fromJson(doc.data())).toList();
    });
  }

  /// Get orders by status
  Stream<List<OrderClass>> getOrdersByStatusStream(String status) {
    return _firestore
        .collection('orders')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => OrderClass.fromJson(doc.data())).toList();
        });
  }

  /// Get orders for a specific student
  Stream<List<OrderClass>> getStudentOrdersStream(String studentName) {
    return _firestore
        .collection('orders')
        .where('studentName', isEqualTo: studentName)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => OrderClass.fromJson(doc.data())).toList();
        });
  }

  /// Get a single order by ID
  Future<OrderClass?> getOrderById(String orderId) async {
    try {
      final doc = await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return OrderClass.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('فشل جلب الطلب: $e');
    }
  }

  // ==================== USER OPERATIONS ====================

  /// Save user to Firestore
  Future<void> saveUser(AppUser user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toJson());
    } catch (e) {
      throw Exception('فشل حفظ المستخدم: $e');
    }
  }

  /// Get user by UID
  Future<AppUser?> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('فشل جلب المستخدم: $e');
    }
  }

  /// Update user role
  Future<void> updateUserRole(String uid, UserRole role) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'role': role.toString().split('.').last,
      });
    } catch (e) {
      throw Exception('فشل تحديث دور المستخدم: $e');
    }
  }

  /// Add mutun to student's enrollment list
  Future<void> enrollStudentInMutun(String studentUid, String mutunId) async {
    try {
      await _firestore.collection('users').doc(studentUid).update({
        'enrolledMutuns': FieldValue.arrayUnion([mutunId])
      });
    } catch (e) {
      throw Exception('فشل التحاق الطالب: $e');
    }
  }

  /// Remove mutun from student's enrollment list
  Future<void> unenrollStudentFromMutun(String studentUid, String mutunId) async {
    try {
      await _firestore.collection('users').doc(studentUid).update({
        'enrolledMutuns': FieldValue.arrayRemove([mutunId])
      });
    } catch (e) {
      throw Exception('فشل إلغاء التحاق الطالب: $e');
    }
  }

  // ==================== BATCH OPERATIONS ====================

  /// Initialize sample data in Firestore (for first-time setup)
  Future<void> initializeSampleData() async {
    try {
      // Add sample chikhs
      for (var chikh in allChikhs) {
        await addChikh(chikh);
      }
      
      // Add sample mutuns
      for (var mutun in allMatuns) {
        await addMutun(mutun);
      }
      
      // Add sample orders
      for (var order in sampleOrders) {
        await addOrder(order);
      }
    } catch (e) {
      throw Exception('فشل تهيئة البيانات: $e');
    }
  }

  /// Clear all data from Firestore (careful with this!)
  Future<void> clearAllData() async {
    try {
      final batch = _firestore.batch();
      
      // Delete all chikhs
      final chikhsSnapshot = await _firestore.collection('chikhs').get();
      for (var doc in chikhsSnapshot.docs) {
        batch.delete(doc.reference);
      }
      
      // Delete all mutuns
      final mutunsSnapshot = await _firestore.collection('mutuns').get();
      for (var doc in mutunsSnapshot.docs) {
        batch.delete(doc.reference);
      }
      
      // Delete all orders
      final ordersSnapshot = await _firestore.collection('orders').get();
      for (var doc in ordersSnapshot.docs) {
        batch.delete(doc.reference);
      }
      
      await batch.commit();
    } catch (e) {
      throw Exception('فشل حذف البيانات: $e');
    }
  }
}
