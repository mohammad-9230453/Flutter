import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class ImageConvert extends StatefulWidget {
  ImageConvert({super.key, required this.imageFile});
  File imageFile;

  @override
  State<ImageConvert> createState() => _ImageConvertState();
}

class _ImageConvertState extends State<ImageConvert> {
  File? _convertedFile;

  @override
  void initState() {
    _convertImageToWebp();
    super.initState();
  }

  Future<void> _convertImageToWebp() async {
    var tempDir = await Directory.systemTemp.createTemp();
    var tempPath = '${tempDir.path}/converted_image.webp';
    await FlutterImageCompress.compressAndGetFile(
        widget.imageFile.path, tempPath,
        format: CompressFormat.webp);
    setState(() {
      _convertedFile = File(tempPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _convertedFile != null
        ? PanoramaViewer(child: Image.file(_convertedFile!))
        : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(child: const CircularProgressIndicator()));
  }
}
