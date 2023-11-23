// ignore: unnecessary_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohammad_blog_club/data.dart';
import 'package:mohammad_blog_club/env.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';

import 'post_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.isntFullScreen});
  bool isntFullScreen;

  @override
  Widget build(BuildContext context) {
    final stories = AppDatabase.stories;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(Env.leftPadSize, 5, 5, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "MdStagram",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        Assets.img.icons.notification
                            .image(width: 30, height: 30),
                        // Assets.img.icons.logo,
                        // Image.asset(
                        //   "assets/img/icons/notification.png",
                        //   width: 30,
                        //   height: 30,
                        // ),
                        const Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2, right: 1),
                              child: Icon(
                                CupertinoIcons.heart,
                                size: 30,
                              ),
                            ),
                            Positioned(
                              top: 2.6,
                              right: 1.5,
                              child: Icon(
                                CupertinoIcons.circle_fill,
                                size: 12,
                                color: Color.fromARGB(255, 221, 3, 3),
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6.5, right: 6.5),
                              child: Icon(
                                CupertinoIcons.paperplane,
                                size: 30,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 19,
                                    height: 19,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(38.5)),
                                    child: Center(
                                      child: true
                                          ? Text(
                                              "45",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            )
                                          : Container(),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    Env.leftPadSize, 10, Env.rightPadSize, 10),
                child: Text("Today Is A Grade Day :)",
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              _StoriesList(
                  stories:
                      stories), //=========================================== Stories
              const SizedBox(
                height: 15,
              ),
              const _CategoryList(), //===================================================== Categories
              PostList(
                isntFullScreen: isntFullScreen,
              ), //===================================================== Posts
              const SizedBox(
                height: 85,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//================================================================================================================================================
//                                                                   External Widgets And Classes

//=============================================================================[ Category ]===================================================================

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;
    return CarouselSlider.builder(
      itemCount: categories.length,
      itemBuilder: (context, index, realIndex) {
        return _CategoryItem(
          left: realIndex == 0 ? Env.leftPadSize : 0,
          right: realIndex == categories.length - 1 ? Env.rightPadSize : 0,
          //Category Item===========================
          category: categories[realIndex],
        );
      },
      options: CarouselOptions(
        scrollDirection: Axis.horizontal,
        viewportFraction: 0.8, //افزایش طول به ضبدر
        aspectRatio: 1.2, //افزایش ارتفاع به ضبدر
        initialPage: 0, //اولین چیزی که نمایش میده 1 باشه که از 0 شروعه
        disableCenter: true, //مرکز قرار نگیرند
        enableInfiniteScroll: false, //حالت چرخشی لوپ
        padEnds: false, //فاصله از دیواره نداشته باشه دیگه

        scrollPhysics: const BouncingScrollPhysics(),
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,

        enlargeFactor: .3,
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final double left;
  final double right;
  final Category category;
  const _CategoryItem({
    required this.category,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
            //========================= shadow behind
            top: 100,
            left: 30,
            right: 30,
            bottom: 1,
            child: Container(
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(211, 13, 37, 60),
                    blurRadius: 10.5,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            //===================================  Image
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 16, 8),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Color.fromARGB(193, 13, 37, 60), Colors.transparent],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.amber[900],
                borderRadius: BorderRadius.circular(32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  "assets/img/posts/large/${category.imageFileName}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            //======================================  Text
            bottom: 48,
            left: 40,
            child: Text(
              category.title,
              style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}

//=============================================================================[ Stories ]===================================================================
///ListView
class _StoriesList extends StatelessWidget {
  const _StoriesList({
    required this.stories,
  });

  final List<StoryData> stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: ListView.builder(
        // physics: BouncingScrollPhysics(),
        itemCount: stories.length, //تعداد ایجادی لیستو میدم
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.fromLTRB(Env.leftPadSize, 0, Env.rightPadSize, 0),
        itemBuilder: (context, index) {
          // این تابع به تعدادی که بالا مشخص کردم تکرار میشه
          final story = stories[
              index]; //حالا میام و استوریا رو تو هر اجرا دونه دونه میگیرم
          final borderRadius = BorderRadius.circular(40);
          return _Story(
              borderRadius: borderRadius, story: story); //Story============
        },
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    required this.borderRadius,
    required this.story,
  });

  final BorderRadius borderRadius;
  final StoryData story;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            story.isViewed
                ? _profileBorderViewed(context)
                : _profileBorder(context),
            Positioned(
              bottom: -3,
              right: 8,
              child: Image.asset(
                "assets/img/icons/${story.iconFileName}",
                width: 28,
                height: 28,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 1.5,
        ),
        Text(story.name),
      ],
    );
  }

//=============================================================================[ profile ]===================================================================
  Widget _profileBorder(BuildContext context) {
    return Container(
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
              child: _profileImage(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileBorderViewed(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 2, 5, 0),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(40),
        strokeWidth: 2.5,
        color: const Color(0xff7B8BB2),
        dashPattern: const [10, 3, 5, 3],
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: 63,
            height: 63,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                  ),
                  child: _profileImage(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        "assets/img/stories/${story.imageFileName}",
      ),
    );
  }
}
