import 'dart:convert';

import 'package:ecom/data/model/product_details_model.dart';
import 'package:ecom/data/network_utils.dart';
import 'package:ecom/data/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  ProductDetailsModel productDetailsModel = ProductDetailsModel();

  bool getProductDetailsInProgress = false;

  Future<bool> getProductDetails(int id) async {
    getProductDetailsInProgress = true;
    update();

    final result =
        await NetworkUtils().getMethod(Urls.getProductDetailsById(id));
    getProductDetailsInProgress = false;

    if (result != null) {
      productDetailsModel = ProductDetailsModel.fromJson(result);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
