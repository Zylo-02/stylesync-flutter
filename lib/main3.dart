
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:image/image.dart' as img;
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:transparent_image/transparent_image.dart';

// // Your existing code for arg_parser function

// InterpreterOptions _interpreterOptions = InterpreterOptions();

// Future<void> main(String[] args) async {
//   // Data load
//   final img.Image image = img.decodeImage(File('your_image.jpg').readAsBytesSync());

//   // Load TFLite model
//   var interpreter = await Interpreter.fromAsset('your_model.tflite',
//       options: _interpreterOptions);
//   interpreter.allocateTensors();

//   // Get segmented cloth region with transparency
//   TensorImage clothSegmentation = await getClothSegmentation(interpreter, img);

//   // Save the result as PNG with transparency
//   File('segmented_cloth_tflite2.png').writeAsBytesSync(
//       TransparentImage.encodePng(clothSegmentation));
// }

// Future<TensorImage> getClothSegmentation(Interpreter interpreter, img.Image image) async {
//   // Resize input image to match the model input size
//   final img.Image resized = img.copyResize(image, width: 256, height: 384);

//   // Normalize and reshape input data
//   final _input = Float32List(256 * 384 * 3);
//   final Iterable<int> inputData = resized.getBytes();
//   for (var i = 0; i < inputData.length; i++) {
//     _input[i] = inputData.elementAt(i) / 255.0 - 0.5;
//   }

//   // Set input tensor
//   interpreter.getInputTensor(0).buffer.asFloat32List()
//     ..setRange(0, 256 * 384 * 3, _input);

//   // Run inference
//   interpreter.invoke();

//   // Get the output tensor
//   final Tensor outputTensor = interpreter.getOutputTensor(0);

//   // Get the output buffer
//   final Float32List outputBuffer = outputTensor.buffer.asFloat32List();

//   // Create a black image with an alpha channel
//   final TensorImage segmentedCloth = TensorImage(256, 384, 4);

//   // Get indices where cloth_mask is True
//   final List<int> clothIndices = [];
//   for (var i = 0; i < 256 * 384; i++) {
//     if (outputBuffer[i] == 3) clothIndices.add(i);
//   }

//   // Set the RGB values for cloth pixels from the resized input image
//   for (var i = 0; i < clothIndices.length; i++) {
//     final int index = clothIndices[i];
//     segmentedCloth.setPixel(index % 256, index ~/ 256, resized.getPixel(index % 256, index ~/ 256));
//   }

//   // Set alpha channel to 255 for cloth pixels
//   for (var i = 0; i < clothIndices.length; i++) {
//     final int index = clothIndices[i];
//     segmentedCloth.data[index * 4 + 3] = 255;
//   }

//   return segmentedCloth;
// }