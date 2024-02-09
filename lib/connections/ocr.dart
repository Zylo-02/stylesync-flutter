import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

final textRecognizer = GoogleMlKit.vision.textRecognizer();

void disposeTextRecognizer() {
  textRecognizer.close();
}

Future<void> scanImageFromFile(BuildContext context, File imageFile) async {
  try {
    final inputImage = InputImage.fromFile(imageFile);

    final recognizedText = await textRecognizer.processImage(inputImage);

    if (recognizedText.blocks.isEmpty) {
      throw Exception('No text found in the image');
    }

    // Display the recognized text with confidence scores
    String text = '';
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        text += '${line.text} (Confidence: ${line.confidence})\n';
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Recognized Text'),
          content: SingleChildScrollView(
            child: Text(text),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred when scanning text: $e'),
      ),
    );
  }
}
