class User {
  String username;
  String password;
  String name;
  String type;
  int year;
  String phone;
  String email;
  String school;
  String id;

  User(
      {this.username,
      this.password,
      this.name,
      this.type,
      this.year,
      this.phone,
      this.email,
      this.school,
      this.id});

  User.fromJson(Map<String, dynamic> json)
      : this(
            username: json['username'],
            password: json['password'],
            name: json['name'],
            type: json['type'],
            year: json['year'],
            phone: json['phone'],
            email: json['email'],
            school: json['school'],
            id: json['id'].toString());

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'name': name,
        'type': type,
        'year': year,
        'phone': phone,
        'email': email,
        'school': school,
        'id': id
      };
}
