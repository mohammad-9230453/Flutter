import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohammad_blog_club/env.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';

class MyArticle extends StatefulWidget {
  const MyArticle({super.key});

  @override
  State<MyArticle> createState() => _MyArticleState();
}

class _MyArticleState extends State<MyArticle> {
  // @override
  // void initState() {
  // TODO: implement initState
  //   super.initState();
  //   SystemChrome.setPreferredOrientations([
  //     // to cant rotate
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     // DeviceOrientation.portraitUp,
  //     // DeviceOrientation.portraitDown,
  //   ]);
  // }

  // @override
  // void dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     // to cant rotate
  //     // DeviceOrientation.landscapeRight,
  //     // DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   super.dispose();
  // }

  // @override
  // void deactivate() {
  //   SystemChrome.setPreferredOrientations([
  //     // to cant rotate
  //     // DeviceOrientation.landscapeRight,
  //     // DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   // TODO: implement deactivate
  //   super.deactivate();
  // }

  // @override
  // void reassemble() {
  //   SystemChrome.setPreferredOrientations([
  //     // to cant rotate
  //     // DeviceOrientation.landscapeRight,
  //     // DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   // TODO: implement reassemble
  //   super.reassemble();
  // }
  // @override
  // void didUpdateWidget(covariant MyArticle oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   SystemChrome.setPreferredOrientations([
  //     // to cant rotate
  //     // DeviceOrientation.landscapeRight,
  //     // DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   super.didUpdateWidget(oldWidget);
  // }

  // @override
  // void didChangeDependencies() {
  //   SystemChrome.setPreferredOrientations([
  //     // to cant rotate
  //     // DeviceOrientation.landscapeRight,
  //     // DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    const String story2 =
        "Short stories date back to oral storytelling traditions which originally produced epics such as the Ramayana, the Mahabharata, and Homer's Iliad and Odyssey. Oral narratives were often told in the form of rhyming or rhythmic verse, often including recurring sections or, in the case of Homer, Homeric epithets. Such stylistic devices often acted as mnemonics for easier recall, rendition, and adaptation of the story. Short sections of verse might focus on individual narratives that could be told at one sitting. The overall arc of the tale would emerge only through the telling of multiple such sections.According to Azhikode, the short story has existed in the most ancient times as the parable, the adventure-story of men, gods and demons, the account of daily events, the joke.[15] All languages have had variations of short tales and stories almost since their inceptions.[15] Emerging in the 17th century from oral storytelling traditions, the short story has grown to encompass a body of work so diverse as to defy easy characterization. The short story as a carefully contrived literary form is of modern origin, wrote Azhikode.[15] Another ancient form of short story, the anecdote, was popular under the Roman Empire. Anecdotes functioned as a sort of parable, a brief realistic narrative that embodies a point. Many surviving Roman anecdotes were collected in the 13th or 14th century as the Gesta Romanorum. Anecdotes remained popular throughout Europe well into the 18th century with the publication of the fictional anecdotal letters of Sir Roger de Coverley.";
    const String story = "$story2 $story2 $story2";
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 32,
                  left: Env.leftPadSize,
                  right: Env.rightPadSize,
                  bottom: 28),
              child: Column(
                children: [
                  // =================================================== <    ...
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.back,
                        size: 27,
                      ),
                      Icon(
                        CupertinoIcons.ellipsis,
                        size: 27,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // ================================================== Title Top
                  Text(
                    "Four Things Every Woman Needs To Know",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(fontSizeFactor: 1.17),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // ================================================== Icon Name Send Save
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // ================================================== Image Icon
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Assets.img.posts.large.largePost6
                                .image(width: 40, height: 40),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          // ================================================== Name Date
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Richard Gervain",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(
                                        fontSizeFactor: 0.8,
                                        fontWeightDelta: 5),
                              ),
                              Text(
                                "2m ago",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(.8)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ================================================== Send ICON
                          Icon(
                            CupertinoIcons.paperplane,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            width: 27,
                          ),
                          // ================================================== Save ICON
                          Icon(
                            CupertinoIcons.bookmark,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            // ================================================== bottom ICON
            Expanded(
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width,
                    foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Color.fromARGB(218, 245, 246, 247),
                          Color.fromARGB(0, 228, 223, 223)
                        ],
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        children: [
                          // ================================================== Top Image
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: Assets.img.posts.large.largePost3
                                .image(fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              Env.leftPadSize,
                              32,
                              Env.rightPadSize,
                              32,
                            ),
                            // ================================================== Bottom TXT
                            child: Column(
                              children: [
                                // ================================================== SubTitle TXT
                                Text(
                                  "A mans sexuality is never your mind responsibility.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .apply(fontSizeFactor: 0.7),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                // ================================================== Body TXT
                                Text(
                                  story,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          fontSizeFactor: 0.8,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                ),
                                const SizedBox(
                                  height: 108,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //========================================================= Blue BTN
                  Positioned(
                    right: 40,
                    bottom: 40,
                    child: Container(
                      alignment: Alignment.center,
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          showSnackBar(context, "Like BTN is clicked.");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              CupertinoIcons.hand_thumbsup,
                              size: 25,
                              color: Colors.white60,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "2.1k",
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.apply(
                                        color: Colors.white60,
                                      ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
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

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
