// Models
class Guest {
  String? email;
  int? gender;
  String? level;
  String? name;

  Guest({
    required this.email,
    required this.gender,
    required this.level,
    required this.name,
  });

  Guest.fromJson(Map<String, Object> json)
  : this(
    email: json['email'] as String,
    gender: json['gender'] as int,
    level: json['level'] as String,
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'gender': gender,
      'level': level,
      'name': name,
    };
  }
}

// final List<Guest> guestList = [
//   Guest(
//     UID: '6MyOhxsHQqeH8PoN3hmX2BSLskG2',
//     name: '김가연',
//     gender: 2,
//     email: 'app0212@naver.com',
//     password: '012345',
//   )
// ];