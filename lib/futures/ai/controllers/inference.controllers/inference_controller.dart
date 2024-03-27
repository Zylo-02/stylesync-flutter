import 'dart:io';

import 'package:get/get.dart';

// class InferenceController extends GetxController {
//   static InferenceController get instance => Get.find();

//   final Rx<File?> _imageData = Rx<File?>(null);

//   File? get imagePath => _imageData.value;

//   Future<void> setImageData(File? data) async {
//     _imageData.value = data;
//   }
// }

class InferenceController extends GetxController {
  static InferenceController get instance => Get.find();

  final Rx<String?> _imagePath = Rx<String?>(null);

  String? get imagePath => _imagePath.value;

  Future<void> setImagePath(String? path) async {
    _imagePath.value = path;
  }
}
