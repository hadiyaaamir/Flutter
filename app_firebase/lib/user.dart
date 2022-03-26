class User {
  final String name;
  final String email;
  final String phone;

  User({
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
