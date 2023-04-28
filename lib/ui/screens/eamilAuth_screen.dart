import '../widget/app_elevated_button.dart';
import '../widget/add_textfromFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                SvgPicture.asset(
                  'assets/images/crafty-bay-logo.svg',
                  width: 120,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  height: 23,
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Please enter your email address',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFa6a6a6),
                      letterSpacing: 0.5),
                ),
                const SizedBox(
                  height: 16,
                ),
                AddTextFieldWidget(
                  controller: TextEditingController(),
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 16,
                ),
                AppElevatedButton(
                  text: 'Next',
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
