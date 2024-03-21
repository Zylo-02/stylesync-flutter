import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stylesync/utils/constants/text_strings.dart';

class TUsertype_dropdown extends StatelessWidget {
  const TUsertype_dropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: TTexts.userType,
        prefixIcon: Icon(Iconsax.user),
      ),
      items: const [
        DropdownMenuItem(
          value: TTexts.userTypeCustomerValue,
          child: Text(TTexts.userTypeCustomer),
        ),
        DropdownMenuItem(
          value: TTexts.userTypeMerchantValue,
          child: Text(TTexts.userTypeMerchant),
        ),
      ],
      onChanged: (value) {
        // Handle the selected value
      },
    );
  }
}
