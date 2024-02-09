import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String modelPath =
      'assets/new_model.tflite'; // Replace with the actual TFLite model path

  Future<void> processImage(File imageFile) async {
    File jpegImageFile = await convertToJpeg(imageFile);

    // Load the image
    img.Image image = img.decodeImage(jpegImageFile.readAsBytesSync())!;
    print("1");

    // Resize, normalize, and reshape the input data
    img.Image resizedImage = img.copyResize(image, width: 256, height: 384);
    print("2");

    Float32List inputData = preprocessImage(resizedImage);
    print("3");

    // Load TFLite model
    final interpreter = await Interpreter.fromAsset(modelPath);
    print("4");

    // Prepare output tensor
    var outputBuffer = Float32List(1 * 384 * 256 * 4);
    var outputShape = interpreter.getOutputTensor(0).shape;

    // Run inference
    final output = List.generate(1 * 384 * 256, (index) => 0);
    print("5");

    interpreter.run(inputData.buffer.asUint8List(), outputBuffer.buffer);
    print("6");

    // Extract probability map from output buffer
    var probabilityMap =
        List.generate(384 * 256, (index) => outputBuffer[index * 4 + 3]);
    print("7");

    // Visualize the probability map and the binary mask
    visualizeProbabilityMapAndMask(resizedImage, probabilityMap);

    // Postprocess the probability map
    var clothMask = List.generate(
        384 * 256, (index) => probabilityMap[index] > 0.5 ? 1 : 0);
    print("8");

    var segmentedCloth = createSegmentedCloth(resizedImage, clothMask);
    print("9");

    // Rest of the code remains the same

    // Get the app's writable directory
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    // Save the segmented image
    String filePath = '$appDocPath/segmented_cloth_flutter.png';
    img.Image segmentedImage = img.Image.fromBytes(
      width: 256,
      height: 384,
      bytes: Float32List.fromList(segmentedCloth).buffer,
    );
    await File(filePath).writeAsBytes(img.encodePng(segmentedImage));
    print("9");

    // Display the segmented image in an alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.file(File('$appDocPath/segmented_cloth_flutter.png')),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );

    // Dispose of the interpreter
    interpreter.close();
  }

  Float32List preprocessImage(img.Image image) {
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
    // Read the image
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;

    // Create a new File to store the JPEG image
    File jpegImageFile = File('${imageFile.path}.jpeg');

    // Convert and write the image to JPEG format
    await jpegImageFile.writeAsBytes(img.encodeJpg(image));

    return jpegImageFile;
  }

  Float32List createSegmentedCloth(
      img.Image resizedImage, List<int> clothMask) {
    var segmentedCloth = Float32List(384 * 256 * 4);
    var clothIndices = clothMask
        .asMap()
        .entries
        .where((entry) => entry.value == 1)
        .map((entry) => entry.key);
    for (var index in clothIndices) {
      var pixel = resizedImage.getPixel(index % 256, index ~/ 256);
      segmentedCloth[index * 4] = pixel.r.toDouble(); // Red
      segmentedCloth[index * 4 + 1] = pixel.g.toDouble(); // Green
      segmentedCloth[index * 4 + 2] = pixel.b.toDouble(); // Blue
      segmentedCloth[index * 4 + 3] = 255; // Alpha channel
    }
    return segmentedCloth;
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      processImage(imageFile);
    }
  }

  // Visualize the probability map and the binary mask
  void visualizeProbabilityMapAndMask(
      img.Image resizedImage, List<double> probabilityMap) {
    var mask = List.generate(
        384 * 256, (index) => probabilityMap[index] > 0.5 ? 1.0 : 0.0);

    // Create a color image from the probability map
    var colorImage = img.Image(width: 256, height: 384);
    for (int y = 0; y < 384; y++) {
      for (int x = 0; x < 256; x++) {
        var pixel = resizedImage.getPixel(x, y);
        var r = pixel.r.toDouble() * probabilityMap[y * 256 + x];
        var g = pixel.g.toDouble() * probabilityMap[y * 256 + x];
        var b = pixel.b.toDouble() * probabilityMap[y * 256 + x];
        colorImage.setPixel(
            x, y, img.ColorRgba8(r.round(), g.round(), b.round(), 255));
      }
    }

    // Create a binary mask image
    var maskImage = img.Image(width: 256, height: 384);
    for (int y = 0; y < 384; y++) {
      for (int x = 0; x < 256; x++) {
        var intensity = (mask[y * 256 + x] * 255).round();
        maskImage.setPixel(
            x, y, img.ColorRgba8(intensity, intensity, intensity, 255));
      }
    }

    // Display the images in an alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Probability Map and Binary Mask'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.memory(img.encodePng(colorImage)),
              Image.memory(img.encodePng(maskImage)),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter TFLite Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: getImageFromGallery,
          child: Text('Select Image from Gallery'),
        ),
      ),
    );
  }
}
