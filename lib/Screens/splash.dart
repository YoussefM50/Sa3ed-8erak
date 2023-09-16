import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:final_pro/Theme/appmode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Theme/theme.dart';
class MainSplashScreen extends StatelessWidget {
  Widget screen;
  MainSplashScreen(this.screen, {super.key});
  Widget build(BuildContext context) {
      return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: BlocProvider.of<AppmodeCubit>(context).IsDark?darkGreyClr:lightgray,
        curve: Curves.bounceInOut,
        duration: 500,
        splashIconSize: 350,
        splash: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset(
                  projectLogo,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const CircularProgressIndicator()
          ],
        ),
        nextScreen: screen,
      ),
    );
  }
}
