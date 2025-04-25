class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName, // Use underscore to match SQL convention
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'], // Match the underscore naming
      lastName: map['last_name'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
    );
  }
}