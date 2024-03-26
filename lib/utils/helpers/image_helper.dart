import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:stylesync/futures/ai/screens/colour_detection/colour_finder.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TImageInferenceHelperFunctions {
  Future<String> processImage(File imageFile) async {
    String modelPath = 'assets/new_model.tflite';
    File jpegImageFile = await convertToJpeg(imageFile);
    debugPrint("1");

    /// Load the image
    img.Image image = img.decodeImage(jpegImageFile.readAsBytesSync())!;
    debugPrint("2");

    /// Resize, normalize, and reshape the input data
    img.Image resizedImage = img.copyResize(image, width: 256, height: 384);
    debugPrint("3");

    Float32List inputData = await preprocessImage(resizedImage);
    debugPrint("4");

    /// Load TFLite model
    final interpreter = await Interpreter.fromAsset(modelPath);
    debugPrint("5");

    /// Prepare output tensor
    var outputBuffer = Float32List(1 * 384 * 256 * 4);
    debugPrint("6");

    /// Run inference
    interpreter.run(inputData.buffer.asUint8List(), outputBuffer.buffer);
    debugPrint("7");

    /// Extract probability map from output buffer
    var probabilityMap =
        List.generate(384 * 256, (index) => outputBuffer[index * 4 + 3]);
    debugPrint("8");

    /// Postprocess the probability map
    var clothMask = List.generate(
        384 * 256, (index) => probabilityMap[index] > 0.5 ? 1 : 0);
    debugPrint("9");

    /// Create a segmented image
    var segmentedImage = img.Image(width: 256, height: 384);
    for (int y = 0; y < 384; y++) {
      for (int x = 0; x < 256; x++) {
        if (clothMask[y * 256 + x] == 1) {
          var pixel = resizedImage.getPixel(x, y);
          segmentedImage.setPixel(
            x,
            y,
            img.ColorRgba8(
              pixel.r.toInt(),
              pixel.g.toInt(),
              pixel.b.toInt(),
              255,
            ),
          );
        }
      }
    }
    debugPrint("10");

    List<int> imageBytes = img.encodePng(segmentedImage);
    debugPrint("11");

    /// Get the app's documents directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    debugPrint("12");

    /// Generate a unique file name
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    debugPrint("13");

    /// Create a new file with the generated file name
    File imageFile2 = File('${appDocDir.path}/$fileName');
    debugPrint("14");

    /// Write the image bytes to the file
    await imageFile2.writeAsBytes(imageBytes);
    String imgPath = imageFile2.path;
    debugPrint("15");

    interpreter.close();
    debugPrint("16");

    return imgPath;
  }

  Future<Float32List> preprocessImage(img.Image image) async {
    Float32List inputData = Float32List(1 * 384 * 256 * 3);
    int index = 0;
    for (int y = 0; y < 384; y++) {
      for (int x = 0; x < 256; x++) {
        img.Pixel pixel = image.getPixel(x, y);
        inputData[index++] = (pixel.r.toDouble() / 255.0 - 0.5) * 2.0;
        inputData[index++] = (pixel.g.toDouble() / 255.0 - 0.5) * 2.0;
        inputData[index++] = (pixel.b.toDouble() / 255.0 - 0.5) * 2.0;
      }
    }
    return inputData;
  }

  Future<File> convertToJpeg(File imageFile) async {
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
    File jpegImageFile = File('${imageFile.path}.jpeg');
    await jpegImageFile.writeAsBytes(img.encodeJpg(image));

    return jpegImageFile;
  }

  void handleDataReceived(String data) {
    // Add your navigation logic here
    // For example:
    if (data.isNotEmpty) {
      // Adding a delay of 2 seconds before navigating
      Future.delayed(const Duration(seconds: 0), () {
        Get.to(() => ColorFinder(
              imageData: data,
            ));
      });
    }
  }
}
