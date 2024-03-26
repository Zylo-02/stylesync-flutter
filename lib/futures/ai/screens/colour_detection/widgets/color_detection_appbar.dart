import 'package:flutter/material.dart';
import 'package:stylesync/common/widgets/appbar/appbar.dart';
import 'package:stylesync/utils/constants/colors.dart';

class TColorDetectionAppBar extends StatelessWidget {
  const TColorDetectionAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Text(
        "Colour Detection",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
    );
  }
}
