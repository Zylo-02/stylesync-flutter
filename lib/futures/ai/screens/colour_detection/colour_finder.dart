import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylesync/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:stylesync/futures/ai/controllers/api.controllers/api_controller.dart';
import 'package:stylesync/futures/ai/controllers/inference.controllers/inference_controller.dart';
import 'package:stylesync/futures/ai/screens/colour_detection/widgets/color_detection_appbar.dart';
import 'package:stylesync/futures/ai/screens/colour_detection/widgets/colour_api_processing.dart';
import 'package:stylesync/futures/ai/screens/colour_detection/widgets/segmented_image.dart';
import 'package:stylesync/futures/ai/screens/user_image/get_userimage.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class ColorFinder extends StatelessWidget {
  ColorFinder({super.key, required this.imageData});

  final String imageData;
  final ApiController apiController = Get.put(ApiController());
  final InferenceController _controller = Get.put(InferenceController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool result) {
        if (result) {
          () => Get.to(() => const GetUserImageScreen());
        }
      },
      child: Scaffold(
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
            TColourAPI(
                controller: _controller,
                imageData: imageData,
                apiController: apiController),
          ],
        ),
      ),
    );
  }
}
