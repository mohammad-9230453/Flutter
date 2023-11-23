import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageConvert extends StatefulWidget {
  const ImageConvert({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<ImageConvert> createState() => _ImageConvertState();
}

class _ImageConvertState extends State<ImageConvert> {
  File? _convertedFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _convertImageToWebp() async {
    final tempDir = await Directory.systemTemp.createTemp();
    final tempPath = '${tempDir.path}/converted_image.webp';
    await FlutterImageCompress.compressAndGetFile(
        widget.imageFile.path, tempPath,
        format: CompressFormat.webp);
    setState(() {
      _convertedFile = File(tempPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _convertedFile != null
        ? Image.file(_convertedFile!)
        : CircularProgressIndicator();
  }
}
