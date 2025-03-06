import 'package:flutter/material.dart';
import 'package:roqqu/core/utils/colors.dart';

class SisyDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  const SisyDivider({
    super.key,
    required this.height,
    required this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 1.5,
        height: 20,
        color: color ?? SisyColors.vdividercolor,
      ),
    );
  }
}
