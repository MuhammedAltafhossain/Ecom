import 'package:ecom/ui/getx/bottom_navigation_controller.dart';
import 'package:ecom/ui/screens/carts_screen.dart';
import 'package:ecom/ui/screens/category_screen.dart';
import 'package:ecom/ui/screens/home_screen.dart';
import 'package:ecom/ui/screens/wish_list_screen.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  BottomNavigationController controller = Get.put(BottomNavigationController());

  final List<Widget> screen = const [
    HomeScreen(),
    ProductCategoryScreen(),
    CartsScreen(),
    WishListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomNavigationController>(
        builder: (_) {
          return screen[controller.selectedIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<BottomNavigationController>(builder: (_) {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            controller.changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: 'Wish'),
          ],
        );
      }),
    );
  }
}
