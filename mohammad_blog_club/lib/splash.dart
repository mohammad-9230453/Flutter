import 'package:flutter/material.dart';
import 'package:mohammad_blog_club/Article/Article.dart';
import 'package:mohammad_blog_club/auth.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';
import 'package:mohammad_blog_club/home_screen.dart';
import 'package:mohammad_blog_club/main_screen.dart';
import 'package:mohammad_blog_club/onboarding.dart';
import 'package:mohammad_blog_club/profile/profile.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const OnBoardingScreen();
        return MainScreen();
        return ProfilePage();
        return ArticlePage();
        return AuthPage();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
            child: Assets.img.background.splash.image(fit: BoxFit.cover)),
        Center(
          child: Assets.img.icons.logo.svg(width: 100),
        ),
      ]),
    );
  }
}
