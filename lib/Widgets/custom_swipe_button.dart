import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:virat_kohli/Themes/app_colors.dart';

class CustomSwipeButton extends StatefulWidget {
  final VoidCallback onFinished;
  final String btnText;
  const CustomSwipeButton({
    super.key,
    required this.onFinished,
    required this.btnText,
  });

  @override
  State<CustomSwipeButton> createState() => _CustomSwipeButtonState();
}

class _CustomSwipeButtonState extends State<CustomSwipeButton> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return SwipeableButtonView(
      onFinish: () async {
        widget.onFinished();
        setState(() {
          isFinished = false;
        });
      },
      isFinished: isFinished,
      onWaitingProcess: () {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            isFinished = true;
          });
        });
      },
      activeColor: AppColors.primaryRed,
      buttonWidget: Container(
        child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
      ),
      buttonText: widget.btnText,
    ) ;

  }
}
