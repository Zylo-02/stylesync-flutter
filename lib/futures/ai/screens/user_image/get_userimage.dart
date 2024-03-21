import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylesync/common/widgets/buttons/outlined_button.dart';
import 'package:stylesync/futures/ai/screens/user_image/camera_image.dart';
import 'package:stylesync/futures/ai/screens/user_image/gallery_image.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class GetUserImageScreen extends StatelessWidget {
  const GetUserImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text(
              TTexts.getUserInputTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .apply(color: TColors.black),
            ),
          ),
          const SizedBox(height: TSizes.lg),
          TOutlinedButton(
            onPressed: () => Get.to(() => const GalleryImage()),
            backgroundColor: Colors.red,
            textColor: TColors.white,
            text: TTexts.getGalleryImage,
            padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          TOutlinedButton(
            onPressed: () => Get.to(() => const CameraImage()),
            backgroundColor: Colors.red,
            textColor: TColors.white,
            text: TTexts.getCameraImage,
            padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          ),
        ],
      ),
    );
  }
}
