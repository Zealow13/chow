import 'package:chow/Controller/popular_product_Controller.dart';
import 'package:chow/Controller/recommended_product_controller.dart';
import 'package:chow/pages/cart/cart_page.dart';
import 'package:chow/routes/route_helper.dart';
import 'package:chow/utils/colors.dart';
import 'package:chow/utils/dimensions.dart';
import 'package:chow/widgets/app_icon.dart';
import 'package:chow/widgets/big_text.dart';
import 'package:chow/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/cart_controller.dart';
import '../../utils/app_constants.dart';

class RecommendedFoodDetail extends StatelessWidget {
 final int pageId;
 final String page;
  const RecommendedFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {

    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(

      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
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
                    child: AppIcon(icon: Icons.clear)),
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
                        Get.find<PopularProductController>().totalItems >= 1 ?
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
                //AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(child: BigText(size: Dimensions.font26,text: product.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
             children: [
               Container(
                 margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                 child: ExpandableTextWidget(text: product.description!),
               ),
             ],
            ), ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20*2.5,
                right: Dimensions.width20*2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.remove),
                  ),
                  BigText(text: "\$ ${product.price!} X  ${controller.inCartItems}", color: AppColors.mainBlackColor, size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.add),
                  )
                ],
              ),
            ),
            Container(
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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                     onTap: (){
                      controller.addItem(product);
                     },
                     child: Container(
                       padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20-7, left: Dimensions.width20, right: Dimensions.width20),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(Dimensions.radius20),
                         color: AppColors.mainColor,
                       ),
                       child: BigText(text: "\$${product.price!} | Add to Cart", color: Colors.white,),
                     ),
                    )
                  ],
                )
            ),
          ],
        );
      })
    );
  }
}
