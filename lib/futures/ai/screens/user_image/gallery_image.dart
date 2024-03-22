import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylesync/common/widgets/buttons/elevated_button.dart';
import 'package:stylesync/common/widgets/buttons/outlined_button.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class GalleryImage extends StatefulWidget {
  const GalleryImage({super.key});

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  File? _image;

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

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
        title: const Text(TTexts.getGalleryImageTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(_image!)
            else
              const Text(TTexts.noImageSelected),
            TOutlinedButton(
              onPressed: _getImage,
              text: TTexts.getGalleryImage,
              padding: TSizes.padding,
              backgroundColor: TColors.buttonPrimary,
              textColor: TColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
