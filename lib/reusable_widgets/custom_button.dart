import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final Color BgColor;
  final Color fontColor;
  final double width;
  final double height;
  final String text;
  final void Function() onPressed;

  const CustomButton({
    super.key,
    required this.BgColor,
    required this.fontColor,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: BgColor,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: fontColor,
        ),
      ),
    );
  }
}
