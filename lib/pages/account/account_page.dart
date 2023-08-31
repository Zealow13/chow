import 'package:chow/Controller/auth_controller.dart';
import 'package:chow/Controller/cart_controller.dart';
import 'package:chow/Controller/user_controller.dart';
import 'package:chow/base/custom_loader.dart';
import 'package:chow/routes/route_helper.dart';
import 'package:chow/utils/colors.dart';
import 'package:chow/utils/dimensions.dart';
import 'package:chow/widgets/account_widget.dart';
import 'package:chow/widgets/app_icon.dart';
import 'package:chow/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {

    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUseInfo();
    }
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
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(userController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //Profile Icon
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,
              ),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(
                        appIcon: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text: userController.userModel.name),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //phone
                      AccountWidget(
                        appIcon: AppIcon(
                            icon: Icons.phone,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text: userController.userModel.phone),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //email
                      AccountWidget(
                        appIcon: AppIcon(
                            icon: Icons.email,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text: userController.userModel.email),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //Address
                      AccountWidget(
                        appIcon: AppIcon(
                            icon: Icons.location_on,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text: "Fill in your address"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //messages
                      AccountWidget(
                        appIcon: AppIcon(
                            icon: Icons.message_outlined,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text: "Messages"),
                      ),
                      /*   SizedBox(height: Dimensions.height20,),
                    AccountWidget(
                      appIcon: AppIcon(
                          icon: Icons.message_outlined,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5),
                      bigText: BigText(text: "Zealow"),
                    ),*/
                      SizedBox(height: Dimensions.height20,),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: AccountWidget(
                          appIcon: AppIcon(
                              icon: Icons.logout,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: "Logout"),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ):const CustomLoader()):Container(child: const Center(child: Text("You must Login"),
        ),
        );
      })
    );
  }
}
