import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohammad_blog_club/Article/Article.dart';
import 'package:mohammad_blog_club/Search.dart';
import 'package:mohammad_blog_club/home_screen.dart';
import 'package:mohammad_blog_club/main.dart';
import 'package:mohammad_blog_club/profile/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NavState navigationState = NavState.home;
  bool isntFullScreen = true;
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _articleKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();
  late final Map<NavState, GlobalKey<NavigatorState>> getKey =
      <NavState, GlobalKey<NavigatorState>>{
    NavState.home: _homeKey,
    NavState.articles: _articleKey,
    NavState.profile: _profileKey,
    NavState.search: _searchKey,
  };
  late final Map<NavState, Widget> getPage = <NavState, Widget>{
    NavState.home: HomeScreen(
      isntFullScreen: isntFullScreen,
    ),
    NavState.articles: ArticlePage(),
    NavState.profile: ProfilePage(),
    NavState.search: SearchPage(inputIndex: 0),
  };

  List<NavState> navStack = [NavState.home];
  Future<bool> onWillPop() async {
    final NavigatorState curentSelectedTabNavigatorState =
        getKey[navigationState]!.currentState!;
    if (curentSelectedTabNavigatorState.canPop()) {
      //  the current page that im into that has any child tree to back <
      curentSelectedTabNavigatorState.pop();
      setRotateNav(isntFS: isntFullScreen);
      return false;
    } else if (navStack.isNotEmpty) {
      // if my stack has value in her
      setState(() {
        navigationState = navStack.last; // set page to last one of navs stack

        navStack.removeLast(); // then remove the last nav from stack
        isntFullScreen = navigationState != NavState.search;
        setRotateNav(isntFS: isntFullScreen);
        if (navStack.isEmpty && navigationState != NavState.home) {
          navStack.add(NavState.home);
        }
      });
      return false;
    }

    return true; //false: back not working   .   true : back is working
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: isntFullScreen ? 65 : 0,
              child: IndexedStack(
                index: navigationState.index,
                children: [
                  navigator(
                      nav: NavState.home,
                      navkey: _homeKey,
                      page: HomeScreen(
                        isntFullScreen: isntFullScreen,
                      )),
                  _articleKey.currentState == null &&
                          navigationState != NavState.articles
                      ? Container()
                      : Offstage(
                          offstage: navigationState != NavState.articles,
                          child: Navigator(
                            key: _articleKey,
                            onGenerateRoute: (settings) => MaterialPageRoute(
                              builder: (context) => ArticlePage(),
                            ),
                          ),
                        ),
                  _searchKey.currentState == null &&
                          navigationState != NavState.search
                      ? Container()
                      : Offstage(
                          offstage: navigationState != NavState.search,
                          child: Navigator(
                            key: _searchKey,
                            onGenerateRoute: (settings) => MaterialPageRoute(
                              builder: (context) => SearchPage(
                                inputIndex: 1,
                              ),
                            ),
                          ),
                        ),
                  _profileKey.currentState == null &&
                          navigationState != NavState.profile
                      ? Container()
                      : Offstage(
                          offstage: navigationState != NavState.profile,
                          child: Navigator(
                            key: _profileKey,
                            onGenerateRoute: (settings) => MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: isntFullScreen,
                child: BottomNavigation(
                  onTap: (NavState navstate) {
                    // این تابعه هرموقعی که تو این کلاس در هرجاییش صدا زده شدش دستور توش اجرا شه

                    setState(() {
                      if (navigationState != navstate) {
                        navStack.remove(navigationState);
                        navStack.add(navigationState);
                        navigationState = navstate;
                      }
                      isntFullScreen = navigationState != NavState.search;
                      setRotateNav(isntFS: isntFullScreen);
                    });
                  },
                  navigationState: navigationState,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget navigator(
      {required NavState nav,
      required GlobalKey navkey,
      required Widget page}) {
    return navkey.currentState == null && navigationState != NavState.home
        ? Container()
        : Offstage(
            //offstage:true [dont paint this widget]
            offstage: navigationState != NavState.home,
            child: Navigator(
              key: _homeKey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => page,
              ),
            ),
          );
  }

  void setRotateNav({required bool isntFS}) {
    if (isntFS) {
      SystemChrome.setPreferredOrientations([
        // to cant rotate
        // DeviceOrientation.landscapeRight,
        // DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values); // to re-show bars
    } else {
      SystemChrome.setPreferredOrientations([
        // to cant rotate
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        // DeviceOrientation.portraitUp,
        // DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      //     overlays: [SystemUiOverlay.bottom]);
    }
  }
}

enum NavState {
  home,
  articles,
  search,
  profile,
}
