import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylesync/common/widgets/buttons/elevated_button.dart';
import 'package:stylesync/common/widgets/buttons/outlined_button.dart';
import 'package:stylesync/futures/authentication/screens/password_configuration/forget_password.dart';
import 'package:stylesync/futures/authentication/screens/signup/signup.dart';
import 'package:stylesync/navigation_menu.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Remember Me & Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                  ],
                ),
                const Text(TTexts.rememberMe),
              ],
            ),

            /// Forget Password
            TextButton(
                onPressed: () => Get.to(() => const ForgetPassword()),
                child: const Text(TTexts.forgotPassword)),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: TElevatedButton(
                onPressed: () => Get.to(() => const NavigationMenu()),
                text: TTexts.signIn,
                backgroundColor: TColors.buttonPrimary,
                textColor: TColors.white,
                padding: const EdgeInsets.all(0),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Create Account Button
            SizedBox(
              width: double.infinity,
              child: TOutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                text: TTexts.createAccount,
                backgroundColor: TColors.buttonPrimary,
                textColor: TColors.black,
                padding: const EdgeInsets.all(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
