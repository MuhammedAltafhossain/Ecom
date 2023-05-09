import 'package:ecom/ui/getx/user_controller.dart';
import 'package:ecom/ui/screens/main_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  UserController userController = Get.put(UserController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUserToken().then((value){
      if(userController.userToken != null) {
        userController.getUserDetails();
      }
    });


    //2 second delayed next screen
    Future.delayed(const Duration(seconds: 2)).then((value) =>
    {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => const MainBottomNavigationBar()), (
              route) => false)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset(
              'assets/images/crafty-bay-logo.svg',
              width: 120,
              fit: BoxFit.scaleDown,
            ),
            const Spacer(),
            CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  letterSpacing: .6),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
