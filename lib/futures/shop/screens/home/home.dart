import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylesync/common/widgets/appbar/appbar.dart';
import 'package:stylesync/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:stylesync/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:stylesync/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:stylesync/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:stylesync/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:stylesync/futures/shop/screens/home/widgets/home_appbar.dart';
import 'package:stylesync/utils/constants/colors.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
