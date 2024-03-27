import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylesync/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:stylesync/futures/ai/controllers/inference.controllers/inference_controller.dart';
import 'package:stylesync/futures/ai/screens/infearence/widgets/image_processing.dart';
import 'package:stylesync/futures/ai/screens/infearence/widgets/inference_appbar.dart';
import 'package:stylesync/futures/ai/screens/infearence/widgets/selected_object_image.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';
import 'package:stylesync/utils/helpers/image_helper.dart';

class Inference extends StatelessWidget {
  Inference({super.key});

  final File? imageData = Get.arguments;
  final TImageInferenceHelperFunctions helperFunctions =
      TImageInferenceHelperFunctions();

  final InferenceController _controller = Get.put(InferenceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              const TInferenceAppBar(),
              const SizedBox(height: TSizes.lg),
              TSelectedObjectImage(imageData: imageData),
            ],
          )),
          const Text(TTexts.imageProcessingInference),
          ImageProcessingWidget(
            processImageFuture: () => helperFunctions.processImage(imageData!),
            onDataReceived: (data) {
              Future.delayed(const Duration(seconds: 0), () {
                helperFunctions.handleDataReceived(data);
              });
            },
          ),

          // Obx(() {
          //   if (_controller.imageData == null) {
          //     // Preprocess image and update _controller.imageData
          //     helperFunctions.processImage(imageData!);
          //     return CircularProgressIndicator();
          //   } else {
          //     // If imageData is not null, display the text
          //     return Text(
          //         _controller.imageData!.path); // Display the processed text
          //   }
          // }),
        ],
      ),
    );
  }
}
