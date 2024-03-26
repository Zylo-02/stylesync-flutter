import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stylesync/common/widgets/buttons/outlined_button.dart';
import 'package:stylesync/futures/ai/controllers/image.controllers/image_gallery_controller.dart';
import 'package:stylesync/futures/ai/screens/infearence/inference.dart';
import 'package:stylesync/futures/ai/screens/user_image/widgets/selected_image.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class GalleryImage extends StatefulWidget {
  const GalleryImage({super.key});

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  final ImagePickerControllerGallery controller =
      Get.put(ImagePickerControllerGallery());
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool result) {
        if (result) {
          controller.clearImage();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(TTexts.getGalleryImageTitle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// Show the selected Image
              Obx(() {
                if (controller.image != null) {
                  return TShowSelectedImage(
                    image: controller.image!,
                    onPressed: () =>
                        Get.to(() => Inference(), arguments: controller.image!),
                  );
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(height: TSizes.sm),

              ///  Show the button to change the image
              Obx(() {
                if (controller.image != null) {
                  return TOutlinedButton(
                    onPressed: controller.getImageGallery,
                    text: TTexts.changePicture,
                    padding: TSizes.padding,
                    backgroundColor: TColors.buttonPrimary,
                    textColor: TColors.black,
                  );
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// If no image is selected, show the button to get the image
              Obx(() {
                if (controller.image == null) {
                  return Column(
                    children: [
                      const Text(TTexts.noImageSelected),
                      const SizedBox(height: 16.0),
                      TOutlinedButton(
                        onPressed: controller.getImageGallery,
                        text: TTexts.getGalleryImage,
                        padding: TSizes.padding,
                        backgroundColor: TColors.buttonPrimary,
                        textColor: TColors.white,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
