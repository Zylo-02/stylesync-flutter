import 'package:flutter/material.dart';
import 'package:stylesync/utils/constants/sizes.dart';

class TElevatedButton extends StatelessWidget {
  const TElevatedButton({
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
  final EdgeInsetsGeometry padding; // Added EdgeInsets variable

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding, // Use the padding variable
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide.none,
            ),
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
