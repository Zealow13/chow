import 'package:chow/Controller/cart_controller.dart';
import 'package:chow/Controller/popular_product_Controller.dart';
import 'package:chow/pages/cart/cart_page.dart';
import 'package:chow/pages/food/popular_food_details.dart';
import 'package:chow/pages/food/recommended_food_detail.dart';
import 'package:chow/pages/home/food_page_body.dart';
import 'package:chow/pages/home/main_food_page.dart';
import 'package:chow/pages/splash/splash_screen.dart';
import 'package:chow/routes/route_helper.dart';
// import 'package:chow/pages/home/main_food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  Get.find<CartController>().getCartData();
   return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //home: const SplashScreen(),
          // home: MainFoodPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          // const MainFoodPage(),
        );
      });
    },);
  }
}
