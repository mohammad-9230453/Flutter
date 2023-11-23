import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohammad_blog_club/env.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';
import 'package:mohammad_blog_club/post_list.dart';

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var key = GlobalKey();
  final GlobalKey _keyRed = GlobalKey();

  double topWidth = 40;
  double maxTopWidth = 40;
  double scrollFlag = 0;
  double scrollFlagInChange = 0;
  bool isAppBarInChange = true;
  bool isScrollingToDown = true;
  bool isPointerUp = false;
  ScrollController scroll = ScrollController();

  @override
  void initState() {
    Listener(
      behavior: HitTestBehavior.translucent,
      onPointerUp: (event) {
        setState(() {
          isPointerUp = true;
          debugPrint(
              "UpUpUp---------------------------------------------------------------------------------------");
        });
      },
    );
    scroll.addListener(() {
      if (scroll.position.activity!.isScrolling && !isAppBarInChange) {
        setState(() {
          isAppBarInChange =
              isScrollingToDown == (scrollFlag - scroll.position.pixels) < 0;
          debugPrint(
              "scrollFlag=$scrollFlag[${scrollFlag - scroll.position.pixels}][toDown=$isScrollingToDown][change=$isAppBarInChange] , is go down?${isScrollingToDown}");
          isScrollingToDown = (scrollFlag - scroll.position.pixels) < 0;
          scrollFlag = scroll.position.pixels;
        });
      }
      if (scroll.position.activity!.isScrolling && isAppBarInChange) {
        setState(() {
          isScrollingToDown = (scrollFlagInChange - scroll.position.pixels) < 0;

          scrollFlagInChange = scroll.position.pixels;
          var d = (scrollFlag - scroll.position.pixels).abs() / 50;
          if (topWidth >= 0 && topWidth <= maxTopWidth) {
            topWidth += isScrollingToDown
                ? topWidth - d >= 0
                    ? -d
                    : -topWidth
                : topWidth + d <= maxTopWidth
                    ? d
                    : -topWidth + maxTopWidth;
          } else {
            topWidth = topWidth > 0 ? maxTopWidth : 0;
            debugPrint("===============[$topWidth]================");
            isAppBarInChange = false;
          }
          if (scroll.position.isScrollingNotifier.value == false ||
              scroll.position.atEdge ||
              scroll.position.extentAfter == 0 ||
              scroll.position.pixels.abs() >=
                  scroll.position.maxScrollExtent.abs() - 20 ||
              scroll.position.pixels.abs() <=
                  scroll.position.minScrollExtent.abs() + 20) {
            // topWidth = maxTopWidth;
            topWidth = isScrollingToDown ? 0 : maxTopWidth;
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double blueBoxWidth = 280;
    final borderRadius = BorderRadius.circular(40);
    var themeDate = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: topWidth,
        surfaceTintColor: themeDate.colorScheme.onPrimary,
        title: Text(
          "Profile",
          style: themeDate.textTheme.bodyLarge!
              .copyWith(
                  fontWeight: FontWeight.w700,
                  color: themeDate.textTheme.bodyLarge!.color!
                      .withOpacity(topWidth / maxTopWidth))
              .apply(fontSizeFactor: 0.98),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.ellipsis,
                size: 22,
                color: themeDate.textTheme.bodyLarge!.color!
                    .withOpacity(topWidth / maxTopWidth)),
          )
        ],
      ),
      body: GestureDetector(
        onPanEnd: (e) {
          debugPrint(
              "UpUpUp 2124 kkd---------------------------------------------------------------------------------------");
          setState(() {
            topWidth = isScrollingToDown ? 0 : maxTopWidth;
          });
        },
        child: SafeArea(
          child: Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      scroll.position.extentAfter == 0) {
                    // اسکرول متوقف شده است
                    setState(() {
                      topWidth = isScrollingToDown ? 0 : maxTopWidth;
                    });
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  controller: scroll,
                  child: Column(
                    children: [
                      // =============================================================  Profile      ***
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(
                      //       Env.leftPadSize, 32, Env.rightPadSize, 16),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       // ==================================================  Profile
                      //       Text(
                      //         "Profile",
                      //         style: themeDate.textTheme.bodyLarge!
                      //             .copyWith(fontWeight: FontWeight.w700)
                      //             .apply(fontSizeFactor: 0.98),
                      //       ),
                      //       // ==================================================  ***
                      //       Icon(
                      //         CupertinoIcons.ellipsis,
                      //         size: 22,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Env.leftPadSize, 0, Env.rightPadSize, 50),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 54),
                                key: _keyRed,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 20,
                                        spreadRadius: -30,
                                        blurStyle: BlurStyle.outer,
                                        offset: Offset(10, 18),
                                        color: Colors.black),
                                  ],
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.fromLTRB(
                                    Env.leftPadSize - 16, 16, 0, 5),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ProfileImage(
                                        borderRadius: borderRadius,
                                        hasLittleIcon: false,
                                        hasBottomText: false,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "@mohammad_maleks",
                                            style: themeDate
                                                .textTheme.titleMedium!
                                                .apply(fontSizeFactor: 0.7),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Mohammad Malekshahi",
                                            style: themeDate
                                                .textTheme.headlineMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w500)
                                                .apply(fontSizeFactor: 0.8),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Mohammad Design",
                                            style: themeDate
                                                .textTheme.headlineMedium!
                                                .copyWith(
                                                    color: themeDate
                                                        .colorScheme.primary,
                                                    fontWeight: FontWeight.w500)
                                                .apply(fontSizeFactor: 0.8),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        Env.leftPadSize - 8,
                                        32,
                                        Env.rightPadSize - 8,
                                        64),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "About me",
                                          style: themeDate.textTheme.bodyLarge!
                                              .apply(fontSizeFactor: 0.9),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "hi i am mohammad and i work with my profetional grop to build an strong app and web and so many more data that created by programing languages and design many things .",
                                          style: themeDate.textTheme.bodySmall!
                                              .apply(fontSizeFactor: 1.4),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 32, right: 32),
                                  // width: blueBoxWidth,
                                  height: blueBoxWidth / 3,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 60,
                                            color: Colors.black,
                                            offset: Offset(0, 30),
                                            spreadRadius: -22)
                                      ],
                                      color: themeDate.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    255, 16, 77, 209)
                                                .withOpacity(1),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 16, 16, 16),
                                          child: Center(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "52",
                                                    style: themeDate.textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                            color: Colors.white)
                                                        .apply(
                                                            fontSizeFactor:
                                                                0.8),
                                                  ),
                                                  Text(
                                                    "Posts",
                                                    style: themeDate
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400)
                                                        .apply(
                                                            fontSizeFactor:
                                                                0.75),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    255, 16, 77, 209)
                                                .withOpacity(0),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 16, 16, 16),
                                          child: Center(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "250",
                                                    style: themeDate.textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                            color: Colors.white)
                                                        .apply(
                                                            fontSizeFactor:
                                                                0.8),
                                                  ),
                                                  Text(
                                                    "Foloing",
                                                    style: themeDate
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400)
                                                        .apply(
                                                            fontSizeFactor:
                                                                0.75),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    255, 16, 77, 209)
                                                .withOpacity(0),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 16, 16, 16),
                                          child: Center(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "4.5K",
                                                    style: themeDate.textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                            color: Colors.white)
                                                        .apply(
                                                            fontSizeFactor:
                                                                0.8),
                                                  ),
                                                  Text(
                                                    "Folowers",
                                                    style: themeDate
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400)
                                                        .apply(
                                                            fontSizeFactor:
                                                                0.75),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              )
                            ],
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: themeDate.colorScheme.onPrimary,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 25,
                              spreadRadius: 0,
                              offset: Offset(0, 30),
                              color: Colors.black,
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Env.leftPadSize,
                                  32,
                                  Env.rightPadSize + 10,
                                  0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // ==================================================  Profile
                                  Expanded(
                                    child: Text(
                                      "My Posts",
                                      style: themeDate.textTheme.bodyLarge!
                                          .copyWith(fontWeight: FontWeight.w700)
                                          .apply(fontSizeFactor: 0.9),
                                    ),
                                  ),
                                  // ==================================================  ***
                                  Icon(
                                    CupertinoIcons.square_grid_2x2,
                                    color: themeDate.colorScheme.primary,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  // ==================================================  ***
                                  const Icon(
                                    CupertinoIcons.list_number_rtl,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 32),
                              child: PostListViewMine(isntFullScreen: false),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.borderRadius,
    required this.hasLittleIcon,
    required this.hasBottomText,
  });

  final BorderRadius borderRadius;
  final bool hasLittleIcon;
  final bool hasBottomText;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(1, 0, 1, 0),
              child: Container(
                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Color.fromARGB(255, 215, 4, 235),
                      Color.fromARGB(255, 194, 10, 10),
                      Color.fromARGB(255, 233, 157, 86),
                    ],
                    transform: GradientRotation(8.5),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(2.8),
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Container(
                    width: 68,
                    height: 68,
                    margin: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                      ),
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: Assets.img.stories.story10.image(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
                visible: hasLittleIcon,
                child: Positioned(
                    bottom: -3,
                    right: 8,
                    child: Assets.img.icons.category1
                        .image(width: 20, height: 20))),
          ],
        ),
        Visibility(visible: hasBottomText, child: const SizedBox(height: 1.5)),
        Visibility(visible: hasBottomText, child: const Text("mohammad")),
      ],
    ));
  }
}
