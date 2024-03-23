import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylesync/common/widgets/appbar/appbar.dart';
import 'package:stylesync/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:stylesync/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:stylesync/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:stylesync/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:stylesync/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:stylesync/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:stylesync/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:stylesync/common/widgets/texts/section_heading.dart';
import 'package:stylesync/futures/shop/screens/home/widgets/home_appbar.dart';
import 'package:stylesync/futures/shop/screens/home/widgets/home_categories.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/image_strings.dart';
import 'package:stylesync/utils/constants/sizes.dart';
import 'package:stylesync/utils/constants/text_strings.dart';
import 'package:stylesync/utils/device/device_utility.dart';
import 'package:stylesync/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Search bar
                  TSearchContainer(
                    text: "Search in stores",
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// heading
                        TSectionHeading(
                          title: "Popular categories",
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        /// Categories list
                        THomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
