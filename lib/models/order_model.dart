/// Model for a class order (enrollment in a mutun class)
class OrderClass {
  final String id;
  final DateTime date;
  final String studentName;
  final String phone;
  final String mutunId; // ID of the mutun being ordered
  final String mutunName; // Name of the mutun
  final String chikhId; // ID of the teacher
  final String status; // pending, approved, rejected, completed
  final String? notes; // Admin notes

  OrderClass({
    required this.id,
    required this.date,
    required this.studentName,
    required this.phone,
    required this.mutunId,
    required this.mutunName,
    required this.chikhId,
    required this.status,
    this.notes,
  });

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'studentName': studentName,
      'phone': phone,
      'mutunId': mutunId,
      'mutunName': mutunName,
      'chikhId': chikhId,
      'status': status,
      'notes': notes,
    };
  }

  /// Create from JSON (Firestore)
  factory OrderClass.fromJson(Map<String, dynamic> json) {
    return OrderClass(
      id: json['id'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      studentName: json['studentName'] ?? '',
      phone: json['phone'] ?? '',
      mutunId: json['mutunId'] ?? '',
      mutunName: json['mutunName'] ?? '',
      chikhId: json['chikhId'] ?? '',
      status: json['status'] ?? 'pending',
      notes: json['notes'],
    );
  }
}

/// Sample orders
final List<OrderClass> sampleOrders = [
  OrderClass(
    id: 'order_1',
    date: DateTime.now().subtract(const Duration(days: 5)),
    studentName: 'أحمد محمد',
    phone: '966501234567',
    mutunId: 'mutun_1',
    mutunName: 'اختصر الأخضري',
    chikhId: 'chikh_1',
    status: 'approved',
  ),
  OrderClass(
    id: 'order_2',
    date: DateTime.now().subtract(const Duration(days: 2)),
    studentName: 'فاطمة علي',
    phone: '966502345678',
    mutunId: 'mutun_4',
    mutunName: 'الورقات',
    chikhId: 'chikh_2',
    status: 'pending',
  ),
];
