import 'package:flutter/material.dart';
import 'package:stylesync/common/widgets/appbar/appbar.dart';
import 'package:stylesync/utils/constants/colors.dart';

class TInferenceAppBar extends StatelessWidget {
  const TInferenceAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Text(
        "Inference",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
    );
  }
}
