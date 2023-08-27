import 'dart:async';
import 'package:chow/routes/route_helper.dart';
import 'package:chow/utils/colors.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../Controller/popular_product_Controller.dart';
import '../../Controller/recommended_product_controller.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();

  }

  @override
  void initState(){
    super.initState();
    _loadResource();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn);
    
    Timer(
        const Duration(seconds: 4),
        () => Get.offNamed(RouteHelper.getInitial()
        ),
    );
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/image/logo.png", width: Dimensions.splashImg,)))
        ],
      ),
    );
  }
}
