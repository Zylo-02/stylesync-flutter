import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stylesync/futures/ai/controllers/inference.controllers/inference_controller.dart';
import 'package:stylesync/utils/helpers/environment_helper.dart';
import 'package:http_parser/http_parser.dart';

class ApiController extends GetxController {
  final TEnvironmentHelperFunctions enHelperFunctions =
      TEnvironmentHelperFunctions();

  final InferenceController _controller = Get.put(InferenceController());
  late String apiUrl;
  final _responseData = ''.obs;
  String get responseData => _responseData.value;

  @override
  void onInit() {
    super.onInit();
    _fetchApiUrlAndData();
  }

  void updateResponseData(String newData) {
    _responseData.value = newData;
  }

  Future<void> _fetchApiUrlAndData() async {
    debugPrint("hello");
    apiUrl = await enHelperFunctions.getFlaskApiUrl() ?? '';
    if (apiUrl.isNotEmpty) {
      getDominantColorsFromPath(_controller.imagePath!);
    } else {
      debugPrint('API URL is empty');
    }
  }

  Future<void> getDominantColorsFromPath(String imagePath) async {
    // Replace with your Flask app's URL
    final String analyzeEndpoint = '$apiUrl/dominant_colors';

    final url = Uri.parse(analyzeEndpoint);

    try {
      // Validate image path existence
      if (!await File(imagePath).exists()) {
        throw Exception("Image file not found at path: $imagePath");
      }

      // Read image file as bytes
      final imageBytes = await File(imagePath).readAsBytes();

      // Create a multipart request
      final request = http.MultipartRequest('POST', url);

      // Add image file to request
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'image.jpg',
          contentType: MediaType.parse('image/jpeg'),
        ),
      );

      /// Send the request
      final streamedResponse = await request.send();

      /// Check response status
      if (streamedResponse.statusCode == 200) {
        /// Decode response data
        final responseData = await streamedResponse.stream.bytesToString();
        final dominantColors = jsonDecode(responseData)['dominant_colors'];
        final dominantColorsJson = jsonEncode(dominantColors);
        updateResponseData(dominantColorsJson);
        debugPrint("Dominant colors: $dominantColors");

        /// Process the dominant colors here
      } else {
        debugPrint("Error: ${streamedResponse.statusCode}");
        debugPrint(await streamedResponse.stream.bytesToString());
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
