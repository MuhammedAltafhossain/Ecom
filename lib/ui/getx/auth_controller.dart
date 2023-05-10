import 'dart:convert';

import 'package:ecom/data/model/read_profile_model.dart';
import 'package:ecom/data/model/user_details_model.dart';
import 'package:ecom/data/network_utils.dart';
import 'package:ecom/data/urls.dart';
import 'package:ecom/ui/getx/user_controller.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  bool sendVerificatiionCodeToEmailInProcess = false;
  bool verifyOtpInProgress = false;
  UserController userController = Get.put(UserController());



  Future<bool> sendVerificationCodeToEmail(String email) async {
    sendVerificatiionCodeToEmailInProcess = true;
    update();
    final result = await NetworkUtils().getMethod(Urls.sendOtpToEmail(email));
    sendVerificatiionCodeToEmailInProcess = false;
    update();
    if (result != null && result['msg'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    verifyOtpInProgress = true;
    update();
    final result =
        await NetworkUtils().getMethod(Urls.otpVerification(email, otp));
    verifyOtpInProgress = false;
    update();
    if (result != null && result['msg'] == 'success') {
      userController.saveUserToken(result['data']);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> readProfileDetails() async {
    verifyOtpInProgress = true;
    update();
    final response = await NetworkUtils().getMethod(Urls.readProfileDetails);
    verifyOtpInProgress = false;
    if (response != null && response['msg'] == 'success') {
      ReadProfile readProfileModel = ReadProfile.fromJson(response);
      if ((readProfileModel.data?.length ?? 0) > 0) {
        ProfileData profileData = readProfileModel.data!.first;
        UserDetails userDetails = UserDetails(
          profileData.firstName ?? '',
          profileData.lastName ?? '',
          profileData.shippingAddress ?? '',
          profileData.email!,
          profileData.city ?? '',
          profileData.id!,
          profileData.mobile ?? '',

        );
        userController.saveUserDetails(userDetails);
        return true;
      } else {
        update();
        return false;
      }
    } else {
      return false;
    }
  }
}
