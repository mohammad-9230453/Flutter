import 'package:flutter/material.dart';
import 'package:mohammad_blog_club/auth_her.dart';
import 'package:mohammad_blog_club/env.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';
import 'package:mohammad_blog_club/main_screen.dart';

import 'page_select.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return PageSelect(
      herPage: const HerAuthPage(),
      myPage: _MyAuthPage(),
    );
  }
}

class _MyAuthPage extends StatefulWidget {
  @override
  State<_MyAuthPage> createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<_MyAuthPage> {
  AuthStatus authStatus = AuthStatus.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ===========================================================  Top Icon
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16,
                  top: 32,
                  left: Env.leftPadSize,
                  right: Env.rightPadSize),
              child: Center(
                  child: Assets.img.icons.logo.svg(width: 60, height: 60)),
            ),
            // ===========================================================  Tow Stack Blue_White
            Expanded(
              child: Stack(
                children: [
                  // ===========================================================  Blue_Part
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 650,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 38, 89, 228),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 32, left: 75, right: 75),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // ===========================================================  Login BTN
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        authStatus = AuthStatus.login;
                                      });
                                    },
                                    child: Text("LOGIN",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .apply(
                                                fontSizeFactor: 0.8,
                                                color: Colors.white.withOpacity(
                                                    authStatus ==
                                                            AuthStatus.login
                                                        ? 1
                                                        : .2))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // ===========================================================  Sing Up BTN
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        authStatus = AuthStatus.singUp;
                                      });
                                    },
                                    child: Text("SING UP",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .apply(
                                                fontSizeFactor: 0.8,
                                                color: Colors.white.withOpacity(
                                                    authStatus ==
                                                            AuthStatus.singUp
                                                        ? 1
                                                        : .2))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ===========================================================  White Part
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      height: 650,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      child: authStatus == AuthStatus.login
                          // ===========================================================  Login Page
                          ? const _LoginPage()
                          // ===========================================================  Sing Up Page
                          : const _SingUpPage(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginPage extends StatefulWidget {
  const _LoginPage();

  @override
  State<_LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage> {
  LoginPasswordShowState state = LoginPasswordShowState.hidden;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 60, right: 35),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ======================================================== Wecome back
            Text(
              "Welcome back",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 15,
            ),

            // ======================================================== Text
            Text(
              "Sing in with your account.",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(fontSizeFactor: 1.3),
            ),
            const SizedBox(
              height: 35,
            ),
            // ========================================================  User Name
            TextField(
              decoration: InputDecoration(
                  labelText: "User Name",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          // width: 5,
                          color: Colors.black.withOpacity(.3)))),
            ),
            // ========================================================  Password
            Stack(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: "password",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              // width: 5,
                              color: Colors.black.withOpacity(.3)))),
                  obscureText: state == LoginPasswordShowState.hidden,
                ),
                // ========================================================  show/hidden BTN
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        state = state == LoginPasswordShowState.hidden
                            ? LoginPasswordShowState.show
                            : LoginPasswordShowState.hidden;
                      });
                    },
                    child: Text(
                      state == LoginPasswordShowState.hidden
                          ? "Show"
                          : "Hidden",
                      style: const TextStyle(
                        color: Color(0xff376AED),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            // ========================================================  LOGIN BTN
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const MainScreen();
                }));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 38, 89, 228)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                minimumSize: MaterialStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width,
                    54,
                  ),
                ),
              ),
              child: Text(
                "LOGIN",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(fontSizeFactor: 0.8, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // ========================================================  Forgot Pass Message
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot your password?",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(fontSizeFactor: 1.3),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Reset here"),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
              child: Text(
                "OR SING IN WITH",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(fontSizeFactor: 1.3),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                Assets.img.icons.google.image(width: 30, height: 30),
                Assets.img.icons.facebook.image(width: 30, height: 30),
                Assets.img.icons.twitter.image(width: 30, height: 30),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum LoginPasswordShowState {
  show,
  hidden,
}

class _SingUpPage extends StatefulWidget {
  const _SingUpPage();

  @override
  State<_SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<_SingUpPage> {
  LoginPasswordShowState state = LoginPasswordShowState.hidden;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 48, left: 60, right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ======================================================== Wecome back
            Text(
              "Welcome back",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 15,
            ),

            // ======================================================== Text
            Text(
              "Sing up your account.",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(fontSizeFactor: 1.3),
            ),
            const SizedBox(
              height: 35,
            ),
            // ========================================================  Full Name
            TextField(
              decoration: InputDecoration(
                  labelText: "Full Name",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          // width: 5,
                          color: Colors.black.withOpacity(.3)))),
            ),
            // ========================================================  User Name
            TextField(
              decoration: InputDecoration(
                  labelText: "User Name",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          // width: 5,
                          color: Colors.black.withOpacity(.3)))),
            ),
            // ========================================================  Password
            Stack(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: "password",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              // width: 5,
                              color: Colors.black.withOpacity(.3)))),
                  obscureText: state == LoginPasswordShowState.hidden,
                ),
                // ========================================================  show/hidden BTN
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        state = state == LoginPasswordShowState.hidden
                            ? LoginPasswordShowState.show
                            : LoginPasswordShowState.hidden;
                      });
                    },
                    child: Text(
                      state == LoginPasswordShowState.hidden
                          ? "Show"
                          : "Hidden",
                      style: const TextStyle(
                        color: Color(0xff376AED),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            // ========================================================  Sind Up BTN
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const MainScreen();
                }));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 38, 89, 228)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                minimumSize: MaterialStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width,
                    54,
                  ),
                ),
              ),
              child: Text(
                "SING UP",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(fontSizeFactor: 0.8, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            // ========================================================  OR SING UP WITH
            Center(
              child: Text(
                "OR SING UP WITH",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(fontSizeFactor: 1.3),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // ========================================================  G  F  TW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                Assets.img.icons.google.image(width: 30, height: 30),
                Assets.img.icons.facebook.image(width: 30, height: 30),
                Assets.img.icons.twitter.image(width: 30, height: 30),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum AuthStatus {
  login,
  singUp,
}
