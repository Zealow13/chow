import 'package:get/get.dart';

class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight/2.58;
  static double pageViewController = screenHeight/3.76;
  static double pageViewTextController = screenHeight/6.89;

  //Dynamic height for padding and margin
  static double height10 = screenHeight/82.69;
  static double height15 = screenHeight/55.18;
  static double height20 = screenHeight/41.35;
  static double height30 = screenHeight/27.56;
  static double height50 = screenHeight/16.54;
  static double height45 = screenHeight/18.38;
  static double height60 = screenHeight/13.78;
  static double height70 = screenHeight/11.81;

  //Dynamic width for padding and margin
  static double width10 = screenHeight/82.69;
  static double width15 = screenHeight/55.18;
  static double width20 = screenHeight/41.35;
  static double width30 = screenHeight/27.56;
  static double width5 = screenHeight/165.38;

  //font size
  static double font16 = screenHeight/51.68;
  static double font20 = screenHeight/41.35;
  static double font26 = screenHeight/31.80;


  //radius
  static double radius20 = screenHeight/41.35;
  static double radius30 = screenHeight/27.56;
  static double radius15 = screenHeight/55.18;

  //icons size
  static double iconSize24 = screenHeight/34.45;
  static double iconSize16 = screenHeight/51.68;


  //ListView Size
  static double listViewImgSize = screenWidth/3.27;
  static double listViewTextContSize = screenWidth/3.93;

  //Popular Food Details
  static double popularFoodImgSize = screenHeight/2.36;

  //For the bottomNavigation
  static double bottomHeightBar = screenHeight/6.89;

  //For splash Screen
  static double splashImg = screenHeight/3.308;
}