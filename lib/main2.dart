import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

void main() => runApp(MyApp());

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
  String imagePath = ''; // Updated to store the selected image path

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void loadModel() async {
    await Tflite.loadModel(
      model: 'assets/converted_model_default.tflite',
    );
  }

  Future<void> processImage() async {
    if (imagePath.isEmpty) {
      // Show an error message or return, as no image is selected
      return;
    }

    // Read the image
    img.Image? image = img.decodeImage(File(imagePath).readAsBytesSync());

    // Resize the image to match the input size used during training
    image = img.copyResize(image!, width: 256, height: 384);

    // Run inference
    List<dynamic>? output = await Tflite.runModelOnBinary(
      binary: image.getBytes(),
    );

    // Postprocess the output
    var clothMask =
        List.generate(384 * 256, (index) => output![index] == 3 ? 1 : 0);

    // Create a black image with an alpha channel
    var segmentedCloth = Uint8List(384 * 256 * 4);

    // Get indices where clothMask is true
    var clothIndices = clothMask
        .asMap()
        .entries
        .where((entry) => entry.value == 1)
        .map((entry) => entry.key);

    // Set the RGB values for cloth pixels
    for (var index in clothIndices) {
      var pixel = image.getPixel(index % 256, index ~/ 256);
      segmentedCloth[index * 4] = pixel.r.toInt(); // Red
      segmentedCloth[index * 4 + 1] = pixel.g.toInt(); // Green
      segmentedCloth[index * 4 + 2] = pixel.b.toInt(); // Blue
      segmentedCloth[index * 4 + 3] = 255; // Alpha channel
    }

    // Save the segmented image
    File segmentedImagePath = File('segmented_cloth.png');
    segmentedImagePath.writeAsBytesSync(Uint8List.fromList(segmentedCloth));

    // Display the result
    _showSegmentedImage(segmentedImagePath);
  }

  void _showSegmentedImage(File segmentedImagePath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Image.memory(
          Uint8List.fromList(segmentedImagePath.readAsBytesSync()),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter TFLite Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _getImageFromGallery();
          },
          child: Text('Select Image from Gallery'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          processImage();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
