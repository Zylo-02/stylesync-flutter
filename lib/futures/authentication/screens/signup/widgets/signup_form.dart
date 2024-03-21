import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylesync/futures/authentication/screens/signup/verify_email.dart';
import 'package:stylesync/futures/authentication/screens/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:stylesync/futures/authentication/screens/signup/widgets/usertype_drowpdown.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';
import 'package:stylesync/utils/helpers/helper_functions.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          /// Email
          TextFormField(
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          /// Phone number
          TextFormField(
            decoration: const InputDecoration(
                labelText: TTexts.phoneNumber, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          /// User type
          const TUsertype_dropdown(),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          /// Password
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
                labelText: TTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          /// Terms&conditions Checkbox
          const TTermsAndConditionCheckBox(),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => Get.to(() => const VerifyEmailScreen()),
                child: const Text(TTexts.createAccount)),
          ),
        ],
      ),
    );
  }
}
