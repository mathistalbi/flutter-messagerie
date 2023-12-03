class Profile {
  Profile({
    required this.id,
    required this.username,
    required this.createdAt,
  });

  final String id;
  final String username;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        createdAt = DateTime.parse(map['created_at']);

  Profile copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return Profile(
      id: id ?? this.id,
      username: name ?? username,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
