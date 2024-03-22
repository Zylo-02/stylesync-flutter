import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylesync/common/widgets/buttons/outlined_button.dart';
import 'package:stylesync/futures/ai/screens/user_image/widgets/selected_image.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class CameraImage extends StatefulWidget {
  const CameraImage({Key? key}) : super(key: key);

  @override
  State<CameraImage> createState() => _CameraImageState();
}

class _CameraImageState extends State<CameraImage> {
  File? _image;

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera); // Change source to ImageSource.camera

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TTexts.getCameraImageTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)

              ///  Show the selected Image
              TShowSelectedImage(
                image: _image,
                onPressed: () {},
              ),
            const SizedBox(height: TSizes.sm),

            ///  Show the button to change the image
            if (_image != null)
              TOutlinedButton(
                onPressed: _getImage,
                text: TTexts.changePicture,
                padding: TSizes.padding,
                backgroundColor: TColors.buttonPrimary,
                textColor: TColors.black,
              ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// If no image is selected, show the button to get the image
            if (_image == null)
              Column(
                children: [
                  const Text(TTexts.noImageSelected),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TOutlinedButton(
                    onPressed: _getImage,
                    text: TTexts.getCameraImage,
                    padding: TSizes.padding,
                    backgroundColor: TColors.buttonPrimary,
                    textColor: TColors.white,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
