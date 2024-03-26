import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerControllerCamera extends GetxController {
  static ImagePickerControllerCamera get instance => Get.find();

  static final Rx<File?> _image = Rx<File?>(null);

  File? get image => _image.value;

  Future<void> getImageCamera() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      _image.value = File(pickedImage.path);
    }
  }

  void clearImage() {
    _image.value = null;
  }
}
