import 'package:ecom/data/network_utils.dart';
import 'package:ecom/data/urls.dart';
import 'package:ecom/main.dart';
import 'package:ecom/ui/screens/email_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  bool authState = false;
bool sendVerificatiionCodeToEmailInProcess = false;

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

  Future<bool> sendVerificationCodeToEmail(String email) async{
    sendVerificatiionCodeToEmailInProcess = true;
    update();
    final result = await NetworkUtils().getMethod(Urls.sendOtpToEmail(email));
    sendVerificatiionCodeToEmailInProcess = false;
    update();
    if(result != null && result['msg'] == 'success'){
      return true;
    }
    else{
      return false;
    }


  }



 }