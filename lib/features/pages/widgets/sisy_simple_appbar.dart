import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roqqu/core/assets/asset.dart';
import 'package:roqqu/core/utils/colors.dart';

class SisyAppBar extends StatefulWidget {
  const SisyAppBar({super.key});

  @override
  State<SisyAppBar> createState() => _SisyAppBarState();
}

class _SisyAppBarState extends State<SisyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: SisyColors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: SisyColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemStatusBarContrastEnforced: false,
      ),
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            kcompanyLogo,
            height: 34,
            width: 121,
          ),
          Row(
            spacing: 16,
            children: [
              Image.asset(kprofile),
              SvgPicture.asset(
                kglobe,
              ),
              SvgPicture.asset(
                ktools,
              ),
            ],
          )
        ],
      ),
    );
  }
}
