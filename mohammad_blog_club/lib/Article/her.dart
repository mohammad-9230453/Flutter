import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohammad_blog_club/env.dart';
import 'package:mohammad_blog_club/gen/assets.gen.dart';

class HerArticle extends StatefulWidget {
  const HerArticle({super.key});

  @override
  State<HerArticle> createState() => _HerArticleState();
}

class _HerArticleState extends State<HerArticle> {
  final ScrollController _scrollController = ScrollController();
  bool isInEndScrollPosition = false;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels.toInt() >=
          _scrollController.position.maxScrollExtent.toInt() - 50) {
        setState(() {
          isInEndScrollPosition = true;
        });
      } else {
        setState(() {
          isInEndScrollPosition = false;
        });
      }
      // debugPrint(
      //     "pixels=${_scrollController.position.pixels}   pixelsmax=${_scrollController.position.maxScrollExtent}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String story2 =
        "Short stories date back to oral storytelling traditions which originally produced epics such as the Ramayana, the Mahabharata, and Homer's Iliad and Odyssey. Oral narratives were often told in the form of rhyming or rhythmic verse, often including recurring sections or, in the case of Homer, Homeric epithets. Such stylistic devices often acted as mnemonics for easier recall, rendition, and adaptation of the story. Short sections of verse might focus on individual narratives that could be told at one sitting. The overall arc of the tale would emerge only through the telling of multiple such sections.According to Azhikode, the short story has existed in the most ancient times as the parable, the adventure-story of men, gods and demons, the account of daily events, the joke.[15] All languages have had variations of short tales and stories almost since their inceptions.[15] Emerging in the 17th century from oral storytelling traditions, the short story has grown to encompass a body of work so diverse as to defy easy characterization. The short story as a carefully contrived literary form is of modern origin, wrote Azhikode.[15] Another ancient form of short story, the anecdote, was popular under the Roman Empire. Anecdotes functioned as a sort of parable, a brief realistic narrative that embodies a point. Many surviving Roman anecdotes were collected in the 13th or 14th century as the Gesta Romanorum. Anecdotes remained popular throughout Europe well into the 18th century with the publication of the fictional anecdotal letters of Sir Roger de Coverley.";
    const String story = "$story2 $story2 $story2";
    final themeData = Theme.of(context);
    return Scaffold(
      floatingActionButton: Container(
        width: 111,
        height: 48,
        decoration: BoxDecoration(
            color: themeData.colorScheme.primary
                .withOpacity(isInEndScrollPosition ? 1 : .1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  color: themeData.colorScheme.primary
                      .withOpacity(isInEndScrollPosition ? .5 : .3)),
            ]),
        child: InkWell(
          onTap: () {
            showSnackBar(context, "Like BTN is clicked.");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.hand_thumbsup,
                size: 25,
                color: Colors.white60,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "12.14 k",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: themeData.colorScheme.surface),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: themeData.colorScheme.surface,

      //============================================ Body
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                //============================================ App Bar
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  title: const Text("data"),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_rounded)),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    Padding(
                      padding: const EdgeInsets.only(
                          left: Env.leftPadSize,
                          right: Env.rightPadSize,
                          top: 16,
                          bottom: 16),
                      child: Text(
                        "Four Things Every Human Needs To Know",
                        style: themeData.textTheme.headlineMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Env.leftPadSize, 16, Env.rightPadSize - 16, 16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Assets.img.stories.story3.image(
                                width: 48, height: 48, fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Richard Gervain",
                                  style: themeData.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text("2m ago"),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showSnackBar(context, "Save BTN is clicked.");
                            },
                            icon: Icon(
                              CupertinoIcons.bookmark,
                              color: themeData.colorScheme.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showSnackBar(context, "Send BTN is clicked.");
                            },
                            icon: Icon(
                              CupertinoIcons.share,
                              color: themeData.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        child: Assets.img.posts.large.largePost4.image()),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Env.leftPadSize, 32, Env.rightPadSize, 16),
                      child: Text(
                        "A mans sexuality is never your mind responsibility.",
                        style: themeData.textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Env.leftPadSize, 0, Env.rightPadSize, 16),
                      child: Text(
                        story,
                        style: themeData.textTheme.bodyLarge!
                            .apply(fontSizeFactor: 0.8),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ]),
                ),
              ],
            ),
            !isInEndScrollPosition
                ? Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 116,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            themeData.colorScheme.surface,
                            themeData.colorScheme.surface.withOpacity(0),
                          ])),
                    ),
                  )
                : Container(),
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
