import 'dart:async';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier{
  var currentUser;

  Authentication(){
    print('new authnetication');
  }

  Future getUser(){
    return Future.value(currentUser);
  }
}
