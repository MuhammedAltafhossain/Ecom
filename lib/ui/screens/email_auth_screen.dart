import 'package:ecom/ui/getx/auth_controller.dart';
import 'package:get/get.dart';

import '../screens/verify_otp_screen.dart';
import '../widget/add_text_from_field_widget.dart';
import '../widget/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  AuthController authController = Get.put(AuthController());
  TextEditingController _emailEditingController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
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
                    controller: _emailEditingController,
                    hintText: "Email",
                    validator: (value) {
                      if (!isValidEmail(value.toString())) {
                        return 'Invalid Email';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<AuthController>(builder: (authController) {
                    if (authController.sendVerificatiionCodeToEmailInProcess) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AppElevatedButton(
                      text: 'Next',
                      onTap: () {
                        if (_fromKey.currentState!.validate()) {
                          authController
                              .sendVerificationCodeToEmail(
                                  _emailEditingController.text.trim())
                              .then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VerifyOtpScreen(),
                                  ),
                                ),
                              );
                        }
                      },
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
