import 'package:ecom/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      home: const SplashScreen(),
      navigatorKey: MyApp.navigatorKey,
    );
  }

}
