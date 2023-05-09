import 'dart:async';
import 'package:ecom/ui/getx/auth_controller.dart';
import 'package:ecom/ui/screens/complete_profile_screen.dart';
import 'package:ecom/ui/screens/main_bottom_navigation_bar.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:ecom/ui/widget/snackbar_widget.dart';
import 'package:get/get.dart';
import '../widget/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpTextEditingController =
      TextEditingController();

  late Timer _timer;
  int _start = 20;
  bool showResendCodeButton = false;

  Future<void> startTimer() async {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
    showResendCodeButton = true;
    _start = 20;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                  'Enter OTP Code',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'A 4 digit number sent to your email',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFa6a6a6),
                      letterSpacing: 0.5),
                ),
                const SizedBox(
                  height: 16,
                ),
                PinCodeTextField(
                  controller: _otpTextEditingController,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.red,
                    selectedFillColor: Colors.white,
                    selectedColor: AppColors.primaryColor,
                    inactiveFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<AuthController>(builder: (authController) {
                  if (authController.verifyOtpInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return AppElevatedButton(
                    text: 'Next',
                    onTap: () {
                      authController
                          .verifyOtp(widget.email, _otpTextEditingController.text)
                          .then((result) {
                        if (result) {
                          authController.readProfileDetails().then((value) {
                            if (value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainBottomNavigationBar()),
                                  (route) => false);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CompleteProfileScreen()));
                            }
                          });
                        } else {
                          showSnackbar(
                              context, 'Otp verification failed! Try again.');
                        }
                      });
                    },
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(
                    text: 'This code will expire in ',
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: '${_start}s',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                if (!showResendCodeButton)
                  TextButton(
                      onPressed: () {
                        startTimer();
                      },
                      child: const Text('Resend Code'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
