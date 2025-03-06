import 'package:flutter/material.dart';

class SisyButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color backgroundColor;
  final Function()? onPressed;

  const SisyButton({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor,
          ),
          elevation: const WidgetStatePropertyAll(0),
        ),
        child: child,
      ),
    );
  }
}