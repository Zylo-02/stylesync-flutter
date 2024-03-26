import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylesync/common/widgets/buttons/outlined_button.dart';
import 'package:stylesync/futures/ai/controllers/image/image_camera_controller.dart';
import 'package:stylesync/futures/ai/controllers/image/image_gallery_controller.dart';
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
  final ImagePickerControllerCamera controller =
      Get.put(ImagePickerControllerCamera());

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
          title: const Text(TTexts.getCameraImageTitle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Obx(() {
                if (controller.image != null) {
                  return TShowSelectedImage(
                    image: controller.image!,
                    onPressed: () {},
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
                    onPressed: controller.getImageCamera,
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
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TOutlinedButton(
                        onPressed: controller.getImageCamera,
                        text: TTexts.getCameraImage,
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
