import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PageSelect extends StatefulWidget {
  PageSelect({super.key, required this.herPage, required this.myPage});
  Widget herPage;
  Widget myPage;

  @override
  State<PageSelect> createState() => _PageSelectState();
}

class _PageSelectState extends State<PageSelect> {
  selectPage _pageStatus = selectPage.mine;
  @override
  Widget build(BuildContext context) {
    Widget page =
        (_pageStatus == selectPage.mine) ? widget.myPage : widget.herPage;
    //
    //
    //TODO: implement build
    return Stack(
      children: [
        Positioned.fill(child: page),
        Positioned(
          top: 32,
          left: 0,
          child: TextButton(
            onPressed: () => setState(() {
              _pageStatus = _pageStatus == selectPage.her
                  ? selectPage.mine
                  : selectPage.her;
            }),
            child: Text(
              _pageStatus == selectPage.her ? "go to mine" : "go to her",
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
enum selectPage {
  her,
  mine,
}
