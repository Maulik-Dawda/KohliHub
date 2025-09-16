import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/View/Main%20Pages/homepage.dart';
import 'package:virat_kohli/View/OnBoarding/login.dart';
import 'package:virat_kohli/Widgets/custom_swipe_button.dart';
import 'package:virat_kohli/Widgets/custom_text_button.dart';
import 'package:virat_kohli/Widgets/custom_text_form_feild.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: DiagonalClipper(),
              child: Container(
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.brownishBg, AppColors.primaryRed],
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 230),
              child: Column(
                children: [
                  CustomFromTextField(
                    controller: emailController,
                    leadingIcon: Icons.chat_bubble_outline,
                    nameText: "Your Email",
                    hintText: "Enter Your Email",
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomFromTextField(
                    controller: passwordController,
                    leadingIcon: Icons.lock_open_outlined,
                    trailingIcon: Icons.remove_red_eye_outlined,
                    nameText: "Your Password",
                    hintText: "Enter Your Password",
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomFromTextField(
                    controller: confirmPasswordController,
                    leadingIcon: Icons.lock_open_outlined,
                    trailingIcon: Icons.remove_red_eye_outlined,
                    nameText: "Confirm Password",
                    hintText: "Confirm Your Password",
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomTextButton(
                      text: "Remember Me",
                      onPressed: () {},
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomSwipeButton(
                    onFinished: () {
                      Get.off(() => Homepage(),);
                    },
                    btnText: "Register",
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",style: TextStyle(color: Colors.white),),
                      CustomTextButton(text: "Log in!", onPressed:() => Get.off(() => Login()),color: AppColors.primaryRed,)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.35);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
