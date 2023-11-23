// ignore: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohammad_blog_club/Search.dart';
import 'package:mohammad_blog_club/data.dart';
import 'package:mohammad_blog_club/env.dart';
import 'package:mohammad_blog_club/gen/fonts.gen.dart';
import 'package:mohammad_blog_club/home_screen.dart';
import 'package:mohammad_blog_club/main_screen.dart';
import 'package:mohammad_blog_club/profile/profile.dart';

class PostList extends StatelessWidget {
  final posts = AppDatabase.posts;

  PostList({super.key, required this.isntFullScreen});

  bool isntFullScreen;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //=============================================================================  Newse ..  More
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Env.leftPadSize, 32, Env.rightPadSize - 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Latest Newse",
                  style: Theme.of(context).textTheme.headlineSmall),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "More",
                  style: TextStyle(
                    color: Color(0xff376AED),
                  ),
                ),
              ),
            ],
          ),
        ),
        //===================================================================================   Posts
        PostListViewMine(
          isntFullScreen: isntFullScreen,
        ), //====================================== Mine
        PostListViewHer(posts: posts)
      ],
    );
  }
}

class PostListViewHer extends StatelessWidget {
  const PostListViewHer({
    super.key,
    required this.posts,
  });

  final List<PostData> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const ClampingScrollPhysics(), //برای ترکیب دوتا اسکرولل در صفحه کلی
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          margin: const EdgeInsets.fromLTRB(
              Env.leftPadSize, 8, Env.rightPadSize, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Color(0x1a5282FF),
              )
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                //===================================================== her Image
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/img/posts/small/${post.imageFileName}",
                ),
              ),
              //===============================================  Right Texts And etc
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // =========================================== her caption
                        post.caption,
                        style: const TextStyle(
                          fontFamily: FontFamily.avenir,
                          color: Color(0xff376AED),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      //===================================================== her title
                      Text(
                        post.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      //-----------------
                      const SizedBox(
                        height: 16,
                      ),
                      //====================================================== her Footer
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //=================================================== her Hand Icon
                          Icon(
                            CupertinoIcons.hand_thumbsup,
                            size: 16,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          //-----------------
                          const SizedBox(
                            width: 4,
                          ),
                          //=================================================== her Likes
                          Text(
                            post.likes,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          //-----------------
                          const SizedBox(
                            width: 16,
                          ),
                          //=================================================== her Clock Icon
                          Icon(
                            CupertinoIcons.clock,
                            size: 16,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          //-----------------
                          const SizedBox(
                            width: 4,
                          ),
                          //=================================================== her Time
                          Text(
                            post.time,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          //=================================================== her BookMark Icon
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                post.isBookmarked
                                    ? CupertinoIcons.bookmark_fill
                                    : CupertinoIcons.bookmark,
                                size: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: posts.length,
      itemExtent: 141,
      shrinkWrap: true,
    );
  }
}

class PostListViewMine extends StatelessWidget {
  PostListViewMine({
    super.key,
    required this.isntFullScreen,
  });
  bool isntFullScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (PostData post in AppDatabase.posts)
          PostMine(
            post: post,
            isntFullScreen: isntFullScreen,
          ),
      ],
    );
  }
}

class PostMine extends StatefulWidget {
  PostMine({
    super.key,
    required this.post,
    required this.isntFullScreen,
  });
  bool isntFullScreen;

  final PostData post;

  @override
  State<PostMine> createState() =>
      _PostMineState(isntFullScreen: isntFullScreen);
}

class _PostMineState extends State<PostMine> {
  _PostMineState({required this.isntFullScreen});
  bool isntFullScreen;
  @override
  Widget build(BuildContext context) {
    const double postWeight = 200;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => true
                ? SearchPage(
                    inputIndex: 1,
                  )
                : ProfilePage()));
        setState(() {
          isntFullScreen = false;
        });
        SystemChrome.setPreferredOrientations([
          // to cant rotate
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          // DeviceOrientation.portraitUp,
          // DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
      },
      child: Container(
        margin:
            const EdgeInsets.fromLTRB(Env.leftPadSize, 5, Env.rightPadSize, 5),
        width: MediaQuery.of(context).size.width,
        height: postWeight,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x1a5282FF),
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              //==========================================   Image
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/img/posts/small/${widget.post.imageFileName}",
                fit: BoxFit.cover,
                width: 135,
                height: postWeight,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 32, 18, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //================================================ Caption
                          widget.post.caption,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          //________________________________________
                          height: 10,
                        ),
                        SizedBox(
                          //==========================================  title
                          width: 150,
                          child: Text(
                            widget.post.title,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    //=================================================== Footer
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //=========================================== Likes ICON
                        const Icon(
                          CupertinoIcons.hand_thumbsup,
                          size: 19,
                        ),
                        //-----------------
                        const SizedBox(
                          width: 3,
                        ),
                        //=========================================== Likes TXT
                        Text(
                          widget.post.likes,
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 13),
                        ),
                        //-----------------
                        const SizedBox(
                          width: 12,
                        ),
                        //==========================================  Time ICON
                        const Icon(
                          CupertinoIcons.clock,
                          size: 19,
                        ),
                        //-----------------
                        const SizedBox(
                          width: 3,
                        ),
                        //==========================================  Time TXT
                        Text(
                          widget.post.time,
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 13),
                        ),
                        //-----------------
                        // const SizedBox(
                        //   width: 18,
                        // ),
                        // ========================================  Saved ICON
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              widget.post.isBookmarked
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                              size: 19,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
