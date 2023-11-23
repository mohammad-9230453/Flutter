// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  SearchPage({super.key, required this.inputIndex});
  int inputIndex;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Search Page #$inputIndex",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPage(
                    inputIndex: inputIndex + 1,
                  ),
                ));
              },
              child: const Text("next page"),
            ),
          ],
        ),
      )),
    );
  }
}
