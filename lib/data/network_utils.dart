import 'dart:convert';
import 'dart:developer';
import 'package:ecom/ui/getx/user_controller.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart' as gt;
import 'package:http/http.dart';

class NetworkUtils {
  UserController userController = gt.Get.put(UserController());
  //Get Method for http request
  Future<dynamic> getMethod(String url, {VoidCallback? onUnathorize}) async {
     try {
      Uri uri = Uri.parse(url);
      final Response response = await get(uri, headers: {
        'content-type': 'Application/json',
        'token': userController.userToken ?? ''
      });
      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnathorize != null) {
          onUnathorize();
        }
      } else {
        log('status Code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //Post Method for http request
  Future<dynamic> postMethod(
    String url, {
    VoidCallback? onUnathorize,
    Map<String, String>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await post(uri,
          headers: {'content-type': 'Application/json', 'token': ''},
          body: body);
      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnathorize != null) {
          onUnathorize();
        }
      } else {
        log('status Code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
