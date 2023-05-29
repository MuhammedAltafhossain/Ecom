
import 'package:ecom/data/model/cart_list_model.dart';
import 'package:ecom/data/network_utils.dart';
import 'package:ecom/data/urls.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  bool addToCartInProgress = false;
  bool getCartListInProgress = false;
  CartListModel cartListModel = CartListModel();
  
  Future<bool> addToCart(int productId, String size, String color) async {
    addToCartInProgress = true;
    update();
    
    final result = await NetworkUtils().postMethod(Urls.addToCartUrl, body: {
        "product_id": productId.toString(),
        "color":color,
        "size": size

    });
    addToCartInProgress = false;
    update();

    if(result != null && result['msg'] == 'success'){
      return true;
    }
    else{
      return false;
    }

    
  }

  Future<bool> getCartList() async {
    getCartListInProgress = true;
    update();

    final result = await NetworkUtils().getMethod(Urls.getCartList);
    getCartListInProgress = false;
    update();

    if(result != null && result['msg'] == 'success'){
      cartListModel = CartListModel.fromJson(result);
      update();
      return true;
    }
    else{
      update();
      return false;
    }


  }


}