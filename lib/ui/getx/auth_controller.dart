import 'package:ecom/main.dart';
import 'package:ecom/ui/screens/email_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  bool authState = false;


  void redireactUnauthenticatedUser(){
    Navigator.push(
      MyApp.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const EmailAuthScreen(),
      ),
    );
  }

  bool checkAuthState(){
    if(!authState){
      redireactUnauthenticatedUser();
      return false;
    }
    return true;
  }

 }