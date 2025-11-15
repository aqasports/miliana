/// User roles in the system
enum UserRole { admin, student, teacher }

/// Model for user with role
class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final UserRole role;
  final DateTime createdAt;
  final List<String> enrolledMutuns; // For students: list of mutun IDs they're enrolled in

  AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    required this.createdAt,
    this.enrolledMutuns = const [],
  });

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role.toString().split('.').last, // Convert enum to string
      'createdAt': createdAt.toIso8601String(),
      'enrolledMutuns': enrolledMutuns,
    };
  }

  /// Create from JSON (Firestore)
  factory AppUser.fromJson(Map<String, dynamic> json) {
    final roleString = json['role'] ?? 'student';
    UserRole role;
    
    switch (roleString) {
      case 'admin':
        role = UserRole.admin;
        break;
      case 'teacher':
        role = UserRole.teacher;
        break;
      default:
        role = UserRole.student;
    }

    return AppUser(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      role: role,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      enrolledMutuns: List<String>.from(json['enrolledMutuns'] ?? []),
    );
  }

  /// Create a copy with modified fields
  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    UserRole? role,
    DateTime? createdAt,
    List<String>? enrolledMutuns,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      enrolledMutuns: enrolledMutuns ?? this.enrolledMutuns,
    );
  }
}
