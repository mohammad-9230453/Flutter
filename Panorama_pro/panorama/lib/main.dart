import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PanoramaViewer(
          // child: ImageConverted(
          //   file: File("path"),
          // ) as Image,
          // child: Image.memory(Bitmap.fromHeadful(
          //         1000,
          //         1000,
          //         testComporessList(
          //                 testCompressFile(File("assets/1.jpg")) as Uint8List)
          //             as Uint8List)
          //     .buildHeaded()),
          child: Image.asset('assets/panorama2.webp'),
        ),
      ),
    );
  }
}

// class ImageConverted extends StatefulWidget {
//   ImageConverted({super.key, required this.file});

//   final File file;
//   Image imageWidget = Image.asset("assets/1.jpg");

//   @override
//   State<ImageConverted> createState() => _ImageConvertedState();

//   // Future<Widget> compressImage(File file) async {
//   //   List<int> image =
//   //       await testComporessList(testCompressFile(file) as Uint8List);
//   //   ImageProvider provider = MemoryImage(Uint8List.fromList(image));
//   //   imageWidget = Image(
//   //     image: provider ?? AssetImage('assets/OIF.webp'),
//   //   );
//   // }

//   Future<Uint8List> testComporessList(Uint8List list) async {
//     final result = await FlutterImageCompress.compressWithList(
//       list,
//       minHeight: 1080,
//       minWidth: 1080,
//       quality: 96,
//       rotate: 270,
//       format: CompressFormat.webp,
//     );
//     print(list.length);
//     print(result.length);
//     return result;
//   }

//   // 1. compress file and get Uint8List
//   Future<Uint8List> testCompressFile(File file) async {
//     final result = await FlutterImageCompress.compressWithFile(
//       file.absolute.path,
//       minWidth: 2300,
//       minHeight: 1500,
//       quality: 94,
//       rotate: 90,
//     );
//     print(file.lengthSync());
//     print(result!.length);
//     return result;
//   }
// }

// class _ImageConvertedState extends State<ImageConverted> {
//   @override
//   Image build(BuildContext context) {
//     return widget.imageWidget;
//   }
// }
