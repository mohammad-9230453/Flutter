import 'package:flutter/material.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';
import 'package:mohammad_blog_club/main_screen.dart';

class HerAuthPage extends StatefulWidget {
  const HerAuthPage({super.key});

  @override
  State<HerAuthPage> createState() => _HerAuthPageState();
}

enum _PageState {
  login,
  singUp,
}

class _HerAuthPageState extends State<HerAuthPage> {
  _PageState state = _PageState.login;
  @override
  Widget build(BuildContext context) {
    final tabTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //===================================  Top Logo
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: Assets.img.icons.logo.svg(width: 120),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //===================================  Login Tab
                        TextButton(
                          onPressed: () => setState(() {
                            state = _PageState.login;
                          }),
                          child: Text(
                            "login".toUpperCase(),
                            style: tabTextStyle.apply(
                                color: state == _PageState.login
                                    ? Colors.white
                                    : Colors.white30),
                          ),
                        ),
                        //===================================  Sing Up Tab
                        TextButton(
                          onPressed: () => setState(() {
                            state = _PageState.singUp;
                          }),
                          child: Text(
                            "sing up".toUpperCase(),
                            style: tabTextStyle.apply(
                                color: state == _PageState.singUp
                                    ? Colors.white
                                    : Colors.white30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //===================================  Tab
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 48, left: 32, right: 32),
                          child: state == _PageState.login
                              ? const _Login()
                              : const _SingUp(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class _Login extends StatefulWidget {
  const _Login();

  @override
  State<_Login> createState() => _LoginState();
}

class _LoginState extends State<_Login> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //=================================== Welcome TXT
        Text(
          "Welcome back",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        //=================================== some TXT
        Text(
          "Sing in with your account.",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(fontSizeFactor: 0.8),
        ),
        const SizedBox(
          height: 16,
        ),
        //=================================== Username
        const TextField(
          decoration: InputDecoration(
            label: Text("Username"),
          ),
        ),
        //=================================== Password
        const _PasswordTextField(),
        const SizedBox(
          height: 16,
        ),
        //=================================== Login BTN
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
            foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.onPrimary),
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const MainScreen();
            }));
          },
          child: Text(
            "login".toUpperCase(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //=================================== Forget TXT
            const Text("Forgot your password"),
            //=================================== Forget BTN
            TextButton(onPressed: () {}, child: const Text("Reset here "))
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        //=================================== OR SING IN WITH
        const Center(
          child: Text(
            "OR SING IN WITH",
            style: TextStyle(letterSpacing: 2),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        //=================================== G F Tw
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.img.icons.google.image(width: 36, height: 36),
            const SizedBox(width: 24),
            Assets.img.icons.facebook.image(width: 36, height: 36),
            const SizedBox(width: 24),
            Assets.img.icons.twitter.image(width: 36, height: 36),
          ],
        ),
      ],
    );
  }
}

class _SingUp extends StatelessWidget {
  const _SingUp();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //=================================== Welcome TXT
        Text(
          "Welcome back",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        //=================================== some TXT
        Text(
          "Sing up your account.",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(fontSizeFactor: 0.8),
        ),
        const SizedBox(
          height: 16,
        ),
        //=================================== FullName
        const TextField(
          decoration: InputDecoration(
            label: Text("FullName"),
          ),
        ),
        //=================================== Username
        const TextField(
          decoration: InputDecoration(
            label: Text("Username"),
          ),
        ),
        //=================================== Password
        const _PasswordTextField(),
        const SizedBox(
          height: 32,
        ),
        //=================================== SingUp BTN
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
            foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.onPrimary),
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const MainScreen();
            }));
          },
          child: Text(
            "Sing Up".toUpperCase(),
          ),
        ),

        const SizedBox(
          height: 16,
        ),
        //=================================== OR SING IN WITH
        const Center(
          child: Text(
            "OR SING UP WITH",
            style: TextStyle(letterSpacing: 2),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        //=================================== G F Tw
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.img.icons.google.image(width: 36, height: 36),
            const SizedBox(width: 24),
            Assets.img.icons.facebook.image(width: 36, height: 36),
            const SizedBox(width: 24),
            Assets.img.icons.twitter.image(width: 36, height: 36),
          ],
        ),
      ],
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField();

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        suffix: InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Text(
            obscureText ? "Show" : "Hide",
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        label: const Text("Password"),
      ),
    );
  }
}
