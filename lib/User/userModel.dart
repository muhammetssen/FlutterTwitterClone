import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User {
  String name = '';
  String email = '';
  String dateOfBirth = '';
  String username = '';
  String password = '';

  User({
    @required this.name,
    @required this.email,
    @required this.dateOfBirth,
    this.username,
    this.password
  });


  Map<String,dynamic> returnAsDict(){
    return({
      'name':this.name,
      'email':this.email,
      'dateOfBirth':this.dateOfBirth,
      'username':this.username,
      'password':this.password,
    });

  }
}
