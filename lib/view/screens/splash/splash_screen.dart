import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blnk_project/view/screens/home/home_screen.dart';
import 'package:blnk_project/view_model/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../view_model/utils/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: AppColors.darkBlue,
      splashIconSize: MediaQuery.of(context).size.height,
      duration: 500,
      nextScreen: const HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      splash: AppAssets.blnkWhiteLogo,
    );
  }
}
