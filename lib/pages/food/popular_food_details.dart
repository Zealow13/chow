import 'package:chow/Controller/cart_controller.dart';
import 'package:chow/Controller/popular_product_Controller.dart';
import 'package:chow/pages/cart/cart_page.dart';
import 'package:chow/pages/home/main_food_page.dart';
import 'package:chow/utils/app_constants.dart';
import 'package:chow/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:chow/utils/dimensions.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetails extends StatelessWidget {

  final int pageId;
  final String page;
  const PopularFoodDetails({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    //print("The current size is " + MediaQuery.of(context).size.width.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Background Image
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!
                    )
                  )
                ),
          ),
          ),
          //Icons widget
          Positioned(
            top: Dimensions.height60,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(page == "cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                    ),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems>=1)
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                          ),
                          controller.totalItems >= 1 ?
                          Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(
                              icon: Icons.circle,
                              size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
                            ),
                          ):
                            Container(),
                          Get.find<PopularProductController>().totalItems >= 1 ?
                          Positioned(
                            right: 4,
                            top: 4,

                            child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12,
                              color: Colors.white,
                            ),
                          ):
                          Container()
                        ],
                      ),
                    );
                  })
                ],
              ),),
          //Introduction of Food
          Positioned(
            left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20)
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    //Expandable Text Widget
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!))),
                  ],
                ),
              ),),
          
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgrroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20-7, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(Icons.remove, color: AppColors.signColor),),
                      //Icon(Icons.remove, color: AppColors.signColor),
                      SizedBox(width: Dimensions.width10/2),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(width: Dimensions.width10/2),
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(Icons.add, color: AppColors.signColor,)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20-7, left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(text: "\$ ${product.price!} | Add to Cart", color: Colors.white,),
                  ),
                )
              ],
            )
        );
      },),
    );
  }
}




//Height = 826.91
//Width = 392.73