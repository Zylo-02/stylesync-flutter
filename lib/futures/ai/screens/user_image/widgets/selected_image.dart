import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stylesync/common/widgets/buttons/outlined_button.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class TShowSelectedImage extends StatelessWidget {
  const TShowSelectedImage({
    super.key,
    required File? image,
    required this.onPressed,
  }) : _image = image;

  final File? _image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: _image != null
              ? Image.file(_image!, fit: BoxFit.cover)
              : const Center(child: Text(TTexts.noImageSelected)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        TOutlinedButton(
          onPressed: onPressed,
          text: TTexts.tContinue,
          backgroundColor: TColors.buttonPrimary,
          textColor: TColors.white,
          padding: TSizes.padding,
        ),
      ],
    );
  }
}
