import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/View/OnBoarding/login.dart';
import 'package:virat_kohli/Widgets/custom_swipe_button.dart';

class SecondIntro extends StatelessWidget {
  const SecondIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.brownishBg, AppColors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 60, left: 40,right: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  Text("Virat",style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )),
                  Text("Kohli",style: TextStyle(
                    fontSize: 32,
                    color: AppColors.primaryRed,
                    fontWeight: FontWeight.bold
                  )),
                ],
              ),
              SizedBox(
                  height: screenHeight * 0.7,
                  child: Image(image: AssetImage('assets/images/journey.png'),height: double.infinity,width: double.infinity,)),
              CustomSwipeButton(onFinished: () => Get.off(() => Login()) ,btnText: "Continue")
            ],
          ),
        ),
      ),
    );
  }
}
