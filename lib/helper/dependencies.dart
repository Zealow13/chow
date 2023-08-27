import 'package:chow/Controller/cart_controller.dart';
import 'package:chow/data/repository/cart_repo.dart';

import '../Controller/popular_product_Controller.dart';
import '../Controller/recommended_product_controller.dart';
import '../data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init()async{

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
//Api Clients
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  
  //Repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo:Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

}