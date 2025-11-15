/// Model for a Chikh (Islamic teacher/scholar)
class Chikh {
  final String id;
  final String name;
  final String bio;
  final String imageUrl;
  final List<String> mutunIds; // References to mutun IDs this chikh teaches

  Chikh({
    required this.id,
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.mutunIds,
  });

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'imageUrl': imageUrl,
      'mutunIds': mutunIds,
    };
  }

  /// Create Chikh from JSON (Firestore)
  factory Chikh.fromJson(Map<String, dynamic> json) {
    return Chikh(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      mutunIds: List<String>.from(json['mutunIds'] ?? []),
    );
  }
}

/// Sample data - all chikhs in the institution
final List<Chikh> allChikhs = [
  Chikh(
    id: 'chikh_1',
    name: 'الشيخ محمد العريفي',
    bio: 'متخصص في تعليم القرآن والمتون الأساسية',
    imageUrl: 'assets/images/logo.png',
    mutunIds: ['mutun_1', 'mutun_2', 'mutun_3'],
  ),
  Chikh(
    id: 'chikh_2',
    name: 'الشيخ عبدالرحمن الشنقيطي',
    bio: 'متخصص في الفقه والأصول',
    imageUrl: 'assets/images/logo.png',
    mutunIds: ['mutun_4', 'mutun_5'],
  ),
  Chikh(
    id: 'chikh_3',
    name: 'الشيخ محمد الجزائري',
    bio: 'متخصص في الحديث والسيرة',
    imageUrl: 'assets/images/logo.png',
    mutunIds: ['mutun_6', 'mutun_7', 'mutun_8'],
  ),
];
