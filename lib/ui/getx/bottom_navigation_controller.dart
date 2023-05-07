import 'package:ecom/ui/getx/auth_controller.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  int selectedIndex = 0;
  AuthController authController = Get.put(AuthController());

  //navigation
  void changeIndex(int index) {
    if (index == 2 || index == 3) {
      if(!authController.checkAuthState()){
        return;
      }

    }
    selectedIndex = index;
    update();
  }
}
