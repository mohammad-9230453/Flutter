import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panorama/image_convert.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Panorama(),
    );
  }
}

class Panorama extends StatefulWidget {
  const Panorama({super.key});

  @override
  State<Panorama> createState() => _PanoramaState();
}

class _PanoramaState extends State<Panorama> {
  @override
  void initState() {
    super.initState();
  }

  String pathimg = "assets/panorama2.webp";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              pathimg.split(".").last.toLowerCase() == "webp"
                  ? PanoramaViewer(
                      child: Image.file(File(pathimg)),
                    )
                  : ImageConvert(imageFile: File(pathimg)),
              Positioned(
                bottom: 0,
                left: 100,
                right: 100,
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Color.fromARGB(157, 255, 255, 255)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(36, 0, 0, 0))),
                    onPressed: () {
                      getImagePathFromUser(context);
                    },
                    child: Text(
                      "Select Image",
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getImagePathFromUser(BuildContext context) async {
    var pecker = ImagePicker();

    var peckedImg = await pecker.pickImage(source: ImageSource.gallery);
    if (peckedImg != null) {
      setState(() {
        pathimg = peckedImg.path;
        return;
      });
    }
  }
}
