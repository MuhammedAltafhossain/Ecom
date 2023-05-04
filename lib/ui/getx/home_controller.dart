import 'package:ecom/data/model/product_slider_model.dart';
import 'package:ecom/data/network_utils.dart';
import 'package:ecom/data/urls.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ProductSliderModel productSliderModel = ProductSliderModel();

  bool getProductSliderInProgress = false;

  Future<bool> getProductSliderList() async {
    getProductSliderInProgress = true;
    update();
    final result = await NetworkUtils().getMethod(Urls.productSliderUrl);
    getProductSliderInProgress = false;
    update();

    if (result != null) {
      productSliderModel = ProductSliderModel.fromJson(result);
      return true;
    } else {
      update();
      return false;
    }
  }
}
