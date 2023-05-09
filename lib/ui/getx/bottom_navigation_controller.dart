import 'package:ecom/ui/getx/auth_controller.dart';
import 'package:ecom/ui/getx/user_controller.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  int selectedIndex = 0;
  UserController userController = Get.put(UserController());
  //navigation
  void changeIndex(int index) {
    if (index == 2 || index == 3) {
      if(!userController.checkAuthState()){
        return;
      }

    }
    selectedIndex = index;
    update();
  }
}
