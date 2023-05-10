
import 'package:ecom/data/network_utils.dart';
import 'package:ecom/data/urls.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  bool addToCartInProgress = false;
  
  
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
  
}