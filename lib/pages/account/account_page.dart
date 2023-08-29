import 'package:chow/utils/colors.dart';
import 'package:chow/utils/dimensions.dart';
import 'package:chow/widgets/app_icon.dart';
import 'package:chow/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Container(
          // width: double.maxFinite,
          // margin: EdgeInsets.only(left: 150),
          child: BigText(
              text: "Profile",
              size: 24,
              color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            AppIcon(
                icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height45+Dimensions.height30,
              size: Dimensions.height15*10,
            )
          ],
        ),
      ),
    );
  }
}
