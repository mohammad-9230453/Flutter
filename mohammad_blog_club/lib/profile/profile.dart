import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohammad_blog_club/page_select.dart';
import 'package:mohammad_blog_club/profile/her_profile.dart';
import 'package:mohammad_blog_club/profile/my_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSelect(herPage: HerProfile(), myPage: MyProfile());
  }
}
