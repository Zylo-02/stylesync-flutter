import 'dart:io';

import 'package:get/get.dart';

class InferenceController extends GetxController {
  static InferenceController get instance => Get.find();

  final Rx<File?> _imageData = Rx<File?>(null);

  File? get imageData => _imageData.value;

  Future<void> setImageData(File? data) async {
    _imageData.value = data;
  }
}
