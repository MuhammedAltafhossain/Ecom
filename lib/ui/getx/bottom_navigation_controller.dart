import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  int selectedIndex = 0;

  //navigation
  void changeIndex(int index){
    selectedIndex = index;
    update();
  }

}