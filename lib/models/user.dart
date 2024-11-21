class User {
  final int id;
  final String name;
  final String email;
  final bool notification;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.notification});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        notification: json['notification']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'notification': notification,
    };
  }
}
