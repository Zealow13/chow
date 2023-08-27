import 'package:chow/Controller/cart_controller.dart';
import 'package:chow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';


class PopularProductController extends  GetxController{
 final PopularProductRepo popularProductRepo;

 PopularProductController({required this.popularProductRepo});
 List<dynamic> _popularProductList=[];
 List<dynamic> get popularProductList => _popularProductList;
 late CartController _cart;

 //this is to make the app load faster
 bool _isLoaded = false;
 bool get isLoaded => _isLoaded;

 int _quantity = 0;
 int get quantity => _quantity;

 int _inCartItems = 0;
 int get inCartItems => _inCartItems + _quantity;

 Future<void> getPopularProductList()async {
  Response response = await popularProductRepo.getPopularProductList();
  if(response.statusCode==200){
    //print("Got Products");
    _popularProductList=[];
    _popularProductList.addAll(Product.fromJson(response.body).products);
    //print(_popularProductList);
    _isLoaded = true;
    update();
  }else{
 
  }
 }

 void setQuantity(bool isIncrement){
    if(isIncrement){

      _quantity = checkQuantity(_quantity + 1);
      //print("number of items is " + _quantity.toString());
    }else{

      _quantity = checkQuantity(_quantity - 1);
      //print("Decrement of item is " + _quantity.toString());
    }
    update();
 }
 int checkQuantity(int quantity){
   if((_inCartItems + quantity)<0){
     Get.snackbar("Item Count", "You can't reduce more",
      backgroundColor: AppColors.mainColor,
       colorText: Colors.white
     );
     if(_inCartItems>0){
       _quantity = -_inCartItems;
       return _quantity;
     }
     return 0;
   }else if((_inCartItems + quantity)> 50){
     Get.snackbar("Item Count", "You can't add more",
         backgroundColor: AppColors.mainColor,
         colorText: Colors.white
     );
     return 50;
   }else{
     return quantity;
   }
 }

 void initProduct(ProductModel product, CartController cart){
   _quantity = 0;
   _inCartItems = 0;
   _cart = cart;
   var exist = false;
   exist = _cart.existInCart(product);
   //if exist
   //get from storage
   //print("Exist or not " + exist.toString());
   if(exist){
     _inCartItems = _cart.getQuantity(product);
   }
   //print("The quantity in the cart is " + _inCartItems.toString());
 }

 void addItem(ProductModel product){

     _cart.addItem(product, _quantity);
     _quantity = 0;
     _inCartItems = _cart.getQuantity(product);
     _cart.items.forEach((key, value) {
       print("The id is " + value.id.toString() + " The quantity is " + value.quantity.toString());
     });
    update();
 }

 int get totalItems{
   return _cart.totalItems;
 }

 List<CartModel> get getItems{
   return _cart.getItems;
 }
}
