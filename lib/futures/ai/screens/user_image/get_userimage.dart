import 'package:flutter/material.dart';
import 'package:stylesync/common/widgets/buttons/outlined_button.dart';
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
          TOutlinedButton(
            onPressed: () {},
            backgroundColor: Colors.red,
            textColor: TColors.white,
            text: TTexts.getGalleryImage,
            padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          TOutlinedButton(
            onPressed: () {},
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
