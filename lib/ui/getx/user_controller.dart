import 'dart:convert';

import 'package:ecom/data/model/user_details_model.dart';
import 'package:ecom/ui/screens/email_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/main.dart';

class UserController extends GetxController {

  bool loggedIn = false;
  UserDetails? userDetails;
  String? userToken;

  Future<void> saveUserDetails(UserDetails uDetails) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(uDetails.toJson()));

    userDetails = userDetails;

  }

  Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    userToken = token;
  }
  Future<void> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('token');
  }


  Future<void> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user = sharedPreferences.getString('user') ?? '';
    userDetails = UserDetails.fromJson(jsonDecode(user));
  }

  void redireactUnauthenticatedUser() {
    Navigator.push(
      MyApp.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const EmailAuthScreen(),
      ),
    );
  }

  bool checkAuthState() {
    if (userToken == null) {
      redireactUnauthenticatedUser();
      return false;
    }
    return true;
  }

  Future<void> logout() async{
    userToken = null;
    userDetails = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences.clear();

  }

}
