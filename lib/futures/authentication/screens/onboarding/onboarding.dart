import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylesync/futures/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:stylesync/futures/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:stylesync/futures/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/image_strings.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';
import 'package:stylesync/utils/device/device_utility.dart';
import 'package:stylesync/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Onboarding'),
        ),
        body: Stack(
          children: [
            /// Horizontal Scrollable Pages
            PageView(
              children: const [
                OnBoardingPage(
                  image: TImages.onBoardingImage1,
                  title: TTexts.onBoardingTitle1,
                  subTitle: TTexts.onBoardingSubTitle1,
                ),
                OnBoardingPage(
                  image: TImages.onBoardingImage2,
                  title: TTexts.onBoardingTitle2,
                  subTitle: TTexts.onBoardingSubTitle2,
                ),
                OnBoardingPage(
                  image: TImages.onBoardingImage3,
                  title: TTexts.onBoardingTitle3,
                  subTitle: TTexts.onBoardingSubTitle3,
                ),
              ],
            ),

            /// Skip Button
            const OnBoardingSkip(),

            /// Dot Navigation SmoothPageIndicator
            const OnBoardingDotNavigation(),

            ///Circular Button
            OnBoardingNextButton()
          ],
        ));
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(context),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? TColors.primary : Colors.black),
        child: Icon(Iconsax.arrow_right3),
      ),
    );
  }
}
