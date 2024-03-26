import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class TSegmentedImage extends StatelessWidget {
  const TSegmentedImage({
    super.key,
    required this.imageData,
  });

  final File? imageData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          TTexts.segmentedImage,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: TColors.white),
        ),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
          child: Image.file(imageData!, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
