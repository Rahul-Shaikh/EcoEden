import 'package:meta/meta.dart';


class User{
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String mobile;
  final String password;
  final int id;
  User({this.firstName,this.lastName,this.email,this.userName,this.id,this.mobile,this.password});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userName: json['username'],
      email: json['email'],
      //score: json['score'],
      mobile: json['mobile'],
    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['username'] = userName;
    map['email'] = email;
    map['id'] = id;
    map['mobile'] = mobile;
    map['password'] = password;
    return map;
  }
}