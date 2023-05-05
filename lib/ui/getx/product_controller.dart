
import 'package:ecom/data/model/product_model.dart';
import 'package:ecom/data/network_utils.dart';
import 'package:ecom/data/urls.dart';
import 'package:get/get.dart';

enum ProductRemark{
  Populer,
  Special,
  New
}

class ProductController extends GetxController{

  ProductModel popularProductMode = ProductModel();
  ProductModel specialProductMode = ProductModel();
  ProductModel newProductMode = ProductModel();
  ProductModel productByCategoryModel = ProductModel();

  bool popularInProgress = false;
  bool specialInProgress = false;
  bool newInProgress = false;
  bool productByCategoryProgress = false;

  Future<bool> getPopularProducts() async {
    popularInProgress = true;
    update();
    final result = await NetworkUtils().getMethod(Urls.productRemarksPopular);
    popularInProgress = false;
    update();
    if (result != null) {
      popularProductMode = ProductModel.fromJson(result);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
  Future<bool> getSpecialProducts() async {
    specialInProgress = true;
    update();
    final response = await NetworkUtils().getMethod(Urls.productRemarksSpeceil);
    specialInProgress = false;
    update();
    if (response != null) {
      specialProductMode = ProductModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
  Future<bool> getNewProducts() async {
    newInProgress = true;
    update();
    final result = await NetworkUtils().getMethod(Urls.productRemarksNew);
    newInProgress = false;
    update();
    if (result != null) {
      newProductMode = ProductModel.fromJson(result);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }

  Future<bool> getProductsByCategory(String categoryId) async {
    productByCategoryProgress = true;
    update();
    final result = await NetworkUtils().getMethod(Urls.productbyCategoryUrl(categoryId));
    productByCategoryProgress = false;
    update();
    if (result != null) {
      productByCategoryModel = ProductModel.fromJson(result);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }



}