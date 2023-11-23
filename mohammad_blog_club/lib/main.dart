// ignore: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohammad_blog_club/gen/fonts.gen.dart';
import 'package:mohammad_blog_club/main_screen.dart';

import 'env.dart';
import 'splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // static const String defaultFontFamily = "Avenir";
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      // to cant rotate
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    const primaryTextColor = Color(0xff0D253C);
    const secondaryTextColor = Color(0xff204379);
    const primaryColor = Color(0xff376AED);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //Theme===========================
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: primaryColor,
          onPrimary: Colors.white,
          onSurface: primaryTextColor,
          background: const Color(0xffFBFCFF),
          onBackground: primaryTextColor,
          surface: Colors.white,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.fixed,
        ),
        // colorScheme: ,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: secondaryTextColor,
          // elevation: 0,
          titleSpacing: 32,
        ),
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(TextStyle(
          fontFamily: FontFamily.avenir,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          // color: primaryColor,
        )))),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
            fontWeight: FontWeight.w200,
            fontSize: 18,
          ),
          headlineMedium: TextStyle(
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontFamily: FontFamily.avenir,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          bodyLarge: TextStyle(
            fontFamily: FontFamily.avenir,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          bodySmall: TextStyle(
            fontFamily: FontFamily.avenir,
            color: Color(0xff7B8BB2),
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
          titleLarge: TextStyle(
            fontFamily: FontFamily.avenir,
            fontWeight: FontWeight.w200,
            color: primaryTextColor,
            fontSize: 18,
          ),
          titleSmall: TextStyle(
            fontFamily: FontFamily.avenir,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 14,
          ),
        ),
      ),
      home: const SplashScreen(),
      // home: Stack(
      //   children: [
      //     const Positioned.fill(
      //       child: HomeScreen(),
      //       // child: HomeScreen(),
      //     ),
      //     Positioned(
      //       bottom: 0,
      //       left: 0,
      //       right: 0,
      //       child: _BottomNavigation(),
      //     )
      //   ],
      // ),
    );
  }
}

//=============================================================================[ Botom Navigation ]===================================================================

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.onTap, required this.navigationState});
  final NavState navigationState;
  final Function(NavState navstate)
      onTap; //حاا من  عملکرد این تابعو از پدرش گرفتم

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 85,
          color: Colors.transparent,
          child: Stack(
            children: [
              // ========================================== white space
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: const Color(0xff9B8487).withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Env.leftPadSize, 0, Env.rightPadSize, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _BottomNavigationItem(
                          iconFileName: 'Home.png',
                          selectedIconFileName: 'Home.png',
                          title: 'Home',
                          isSelected: navigationState == NavState.home,
                          onTap: () => onTap(NavState
                              .home), //تابع رو با عملکرد تعریفی پدرش اینجا استفاده کن با این ورودی
                        ),
                        _BottomNavigationItem(
                          iconFileName: 'Articles.png',
                          selectedIconFileName: 'Articles.png',
                          title: 'Articles',
                          isSelected: navigationState == NavState.articles,
                          onTap: () => onTap(NavState.articles),
                        ),
                        const Expanded(
                          child: SizedBox(
                            width: 8,
                          ),
                        ),
                        _BottomNavigationItem(
                          iconFileName: 'Search.png',
                          selectedIconFileName: 'Search.png',
                          title: 'Search',
                          isSelected: navigationState == NavState.search,
                          onTap: () => onTap(NavState.search),
                        ),
                        _BottomNavigationItem(
                          iconFileName: 'Menu.png',
                          selectedIconFileName: 'Menu.png',
                          title: 'Menu',
                          isSelected: navigationState == NavState.profile,
                          onTap: () => onTap(NavState.profile),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //========================================= add btn
              Center(
                child: Container(
                  height: 85,
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.5),
                      color: const Color(0xff376AED),
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.add,
                      color: Color.fromARGB(176, 255, 255, 255),
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  const _BottomNavigationItem({
    required this.iconFileName,
    required this.selectedIconFileName,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });
  final Function() onTap;
  final String iconFileName;
  final String selectedIconFileName;
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .background
                .withOpacity(isSelected ? 1 : 0),
            borderRadius: BorderRadius.circular(18)),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/icons/$iconFileName",
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).textTheme.bodySmall!.color,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).textTheme.bodySmall!.color,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
