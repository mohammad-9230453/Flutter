// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohammad_blog_club/Article/her.dart';
import 'package:mohammad_blog_club/Article/mine.dart';
import 'package:mohammad_blog_club/page_select.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return PageSelect(
      herPage: const HerArticle(),
      myPage: const MyArticle(),
    );
  }
}
