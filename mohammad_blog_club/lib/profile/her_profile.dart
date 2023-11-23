import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohammad_blog_club/data.dart';
import 'package:mohammad_blog_club/env.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';
import 'package:mohammad_blog_club/post_list.dart';

class HerProfile extends StatelessWidget {
  const HerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = AppDatabase.posts;
    final themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                elevation: 0,
                backgroundColor:
                    themeData.colorScheme.background.withOpacity(0),
                title: Text(
                  "Profile",
                  style: themeData.textTheme.bodyLarge,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_horiz_rounded),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(
                        Env.leftPadSize, 0, Env.rightPadSize, 32),
                    decoration: BoxDecoration(
                        color: themeData.colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: themeData.colorScheme.onBackground
                                .withOpacity(0.1),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                          child: Row(
                            children: [
                              Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 4,
                                            blurStyle: BlurStyle.outer,
                                            color: Color.fromARGB(
                                                255, 13, 116, 201),
                                            spreadRadius: 5,
                                            offset: Offset(0, 0))
                                      ]),
                                  child: Assets.img.stories.story2
                                      .image(width: 84, height: 84)),
                              const SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("@mohammad_maleks"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Mohammad malekshahi",
                                    style: themeData.textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "FullStack worker",
                                    style: themeData.textTheme.bodyMedium!
                                        .apply(
                                            color:
                                                themeData.colorScheme.primary),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Env.leftPadSize, 0, Env.rightPadSize, 0),
                          child: Text(
                            "About me",
                            style: themeData.textTheme.headlineSmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Env.leftPadSize, 4, Env.rightPadSize, 32),
                          child: Text(
                            "hi i am mohammad malekshahi and im from khoram abad city that is in lorestan unity and in iran country and also i have 2 brother with names ali and reza that ali is my same age brother and reza is 10 years old smaller then me",
                            style: themeData.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w200),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 64,
                    right: 64,
                    child: Container(
                      height: 68,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeData.colorScheme.primary,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                blurRadius: 50,
                                blurStyle: BlurStyle.normal,
                                spreadRadius: -23,
                                offset: const Offset(0, 33))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xff2151CD)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "52",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: themeData.colorScheme.onPrimary),
                                  ),
                                  Text(
                                    "Post",
                                    style: themeData.textTheme.bodyMedium!
                                        .copyWith(
                                            color:
                                                themeData.colorScheme.onPrimary,
                                            fontWeight: FontWeight.w200),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "250",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: themeData.colorScheme.onPrimary),
                                ),
                                Text(
                                  "Folowing",
                                  style: themeData.textTheme.bodyMedium!
                                      .copyWith(
                                          color:
                                              themeData.colorScheme.onPrimary,
                                          fontWeight: FontWeight.w200),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "4.5K",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: themeData.colorScheme.onPrimary),
                                ),
                                Text(
                                  "Folowers",
                                  style: themeData.textTheme.bodyMedium!
                                      .copyWith(
                                          color:
                                              themeData.colorScheme.onPrimary,
                                          fontWeight: FontWeight.w200),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 64),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color:
                          themeData.colorScheme.onBackground.withOpacity(0.1),
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
                          Env.leftPadSize, 16, Env.rightPadSize, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(child: Text("My Posts")),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.square_grid_2x2,
                              color: themeData.colorScheme.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.list_number_rtl,
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (var post in posts)
                      PostMine(
                        post: post,
                        isntFullScreen: false,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
