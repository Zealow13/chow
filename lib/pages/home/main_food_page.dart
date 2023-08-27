import 'package:chow/home/food_page_body.dart';
import 'package:chow/utils/colors.dart';
import 'package:chow/utils/dimensions.dart';
import 'package:chow/widgets/big_text.dart';
import 'package:chow/widgets/small_text.dart';
import 'package:flutter/material.dart';


import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    //print("The current size is " + MediaQuery.of(context).size.height.toString());
    // print("The current size is " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          //Showing the header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height50, bottom: Dimensions.height15),
              padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Ghana", color: AppColors.mainColor,),
                      Row(
                        children: [
                          SmallText(text: "Cape Coast", color: Colors.black54,),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24,),
                    ),
                  )
                ],
              ),
            ),
          ),

          //Showing the body
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          ),
          ),
        ],
      ),
    );
  }
}
