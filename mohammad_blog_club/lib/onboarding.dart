import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohammad_blog_club/auth.dart';
import 'package:mohammad_blog_club/data.dart';
import 'package:mohammad_blog_club/env.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final List<OnBoardingItem> _onboardingItems = AppDatabase.onBoardingItems;
  int page = 0;
  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.round() != page) {
        setState(() {
          page = _pageController.page!.round();
          debugPrint(
              "_pageController[${_pageController.page!.round()}] page[$page]");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 7, left: 0),
              child: _ImagesBox(),
              // child: Assets.img.background.onboarding.image(fit: BoxFit.cover),
            ),
          ),
          Container(
            //
            height: 364,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.1),
                )
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  //======================================  PageView
                  child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController, //======   _pageController
                      itemCount: _onboardingItems.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: 32,
                                top: 32,
                                left: Env.leftPadSize,
                                right: Env.rightPadSize),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //=============================== Heder Text
                                  _onboardingItems[index].title,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  // ==============================  Description Text
                                  _onboardingItems[index].description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .apply(fontSizeFactor: 1.1),
                                ),
                              ],
                            ),
                          )),
                ),
                Container(
                  // =====================================================================  OOO_   ##
                  padding: const EdgeInsets.only(
                      left: Env.leftPadSize,
                      right: Env.rightPadSize,
                      bottom: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmoothPageIndicator(
                          // =======================================  Dots
                          effect: ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: Theme.of(context).primaryColor,
                            dotColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                          ),
                          axisDirection: Axis.horizontal,
                          textDirection: TextDirection.ltr,
                          onDotClicked: (index) {
                            _pageController.animateToPage(
                              index, //برو به این صفحه
                              duration: Duration(
                                  // این مدت زمانیه ک طول میکشه منتقل شه
                                  milliseconds:
                                      (1000 / (page - index).abs()).round()),
                              curve: Curves
                                  .decelerate, // اینم حالت رفتن از تند به کنده
                            );
                          },
                          controller: // کنترلری که اینو رو لینک میکنه به یک لیستی
                              _pageController, //======   _pageController
                          count: _onboardingItems.length),
                      Stack(
                        //======================================================   botton
                        children: [
                          Positioned(
                            top: 20,
                            left: 10,
                            bottom: 2,
                            right: 10,
                            child: Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                  blurRadius: 15,
                                  color: Colors.black,
                                )
                              ]),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (page == _onboardingItems.length - 1) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return const AuthPage();
                                  }));
                                } else {
                                  _pageController.animateToPage(page + 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate);
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(84, 54))),
                              child: Icon(
                                page == _onboardingItems.length - 1
                                    ? CupertinoIcons.check_mark
                                    : CupertinoIcons.arrow_right,
                                color: Colors.white,
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class _ImagesBox extends StatelessWidget {
  const _ImagesBox();
  final double dBetwinImages = 11;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        margin: const EdgeInsets.fromLTRB(32, 32, 32, 32),
        child: Column(
          children: [
            Row(
              children: [
                _Image(
                  image:
                      Assets.img.posts.large.largePost6.image(fit: BoxFit.fill),
                  isExpanded: false,
                  imageHeight: (constraints.maxHeight - 85) / 2,
                ),
                SizedBox(
                  width: dBetwinImages,
                ),
                _Image(
                  image:
                      Assets.img.posts.large.largePost3.image(fit: BoxFit.fill),
                  isExpanded: true,
                  imageHeight: (constraints.maxHeight - 85) / 2,
                ),
              ],
            ),
            SizedBox(
              height: dBetwinImages * 1.9,
            ),
            Row(
              children: [
                _Image(
                  image:
                      Assets.img.posts.large.largePost4.image(fit: BoxFit.fill),
                  isExpanded: true,
                  imageHeight: (constraints.maxHeight - 85) / 2,
                ),
                SizedBox(
                  width: dBetwinImages,
                ),
                _Image(
                  image:
                      Assets.img.posts.large.largePost5.image(fit: BoxFit.fill),
                  isExpanded: false,
                  imageHeight: (constraints.maxHeight - 85) / 2,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.image,
    required this.isExpanded,
    required this.imageHeight,
  });

  final double imageHeight;
  final Image image;
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    final double imageWidth = MediaQuery.of(context).size.width;
    const double imageRadius = 30;
    const double imageBlurRadius = 50;

    return isExpanded
        ? Expanded(
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Positioned(
                  bottom: 5,
                  left: 30,
                  top: 50,
                  right: 30,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(imageRadius),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: imageBlurRadius,
                            color: Colors.black,
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  width: imageWidth,
                  height: imageHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(imageRadius),
                    child: image,
                  ),
                )
              ],
            ),
          )
        : Stack(
            children: [
              Positioned(
                bottom: 5,
                left: 30,
                top: 50,
                right: 30,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(imageRadius),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: imageBlurRadius,
                          color: Colors.black,
                        )
                      ]),
                ),
              ),
              SizedBox(
                width: imageWidth / 3.6,
                height: imageHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageRadius),
                  child: image,
                ),
              )
            ],
          );
  }
}
