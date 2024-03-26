import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stylesync/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:stylesync/futures/ai/screens/colour_detection/widgets/color_detection_appbar.dart';
import 'package:stylesync/futures/ai/screens/colour_detection/widgets/segmented_image.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class ColorFinder extends StatelessWidget {
  const ColorFinder({super.key, required this.imageData});

  final String imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              const TColorDetectionAppBar(),
              const SizedBox(height: TSizes.lg),
              TSegmentedImage(imageData: File(imageData)),
            ],
          )),
          const Text(TTexts.identifyingColor),
        ],
      ),
    );
  }
}
