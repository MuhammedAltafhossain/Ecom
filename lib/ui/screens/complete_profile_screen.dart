import 'package:ecom/ui/screens/main_bottom_navigation_bar.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:ecom/ui/widget/add_text_from_field_widget.dart';
import 'package:ecom/ui/widget/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
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
                  'Complete Profile',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Get started with us with your details',
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
                  hintText: "First Name",
                  controller: TextEditingController(),
                ),
                const SizedBox(
                  height: 8,
                ),
                AddTextFieldWidget(
                  hintText: "Last Name",
                  controller: TextEditingController(),
                ),
                const SizedBox(
                  height: 8,
                ),
                AddTextFieldWidget(
                  hintText: "Mobile",
                  controller: TextEditingController(),
                ),
                const SizedBox(
                  height: 8,
                ),
                AddTextFieldWidget(
                  hintText: "City",
                  controller: TextEditingController(),
                ),
                const SizedBox(
                  height: 8,
                ),
                AddTextFieldWidget(
                  hintText: "Shipping Address",
                  controller: TextEditingController(),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 8,
                ),
                AppElevatedButton(
                  text: 'Complete',
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MainBottomNavigationBar()),
                        (route) => false);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
