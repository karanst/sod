import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback? onTap;
  const CustomButton({Key? key, required this.buttonText, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}
