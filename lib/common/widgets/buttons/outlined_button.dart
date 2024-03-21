import 'package:flutter/material.dart';
import 'package:stylesync/utils/constants/sizes.dart';

class TOutlinedButton extends StatelessWidget {
  const TOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.padding,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor:
                backgroundColor, // Background color is ignored for outlined button
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide.none, // Remove border color
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
