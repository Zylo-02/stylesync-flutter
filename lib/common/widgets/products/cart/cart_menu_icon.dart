import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylesync/utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });

  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            )),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: TColors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              '2',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.white, fontSizeFactor: 0.8),
            ),
          ),
        )
      ],
    );
  }
}
