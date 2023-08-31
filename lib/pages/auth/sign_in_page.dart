import 'package:chow/base/custom_loader.dart';
import 'package:chow/pages/auth/sign_up_page.dart';
import 'package:chow/routes/route_helper.dart';
import 'package:chow/utils/colors.dart';
import 'package:chow/widgets/app_text_field.dart';
import 'package:chow/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/auth_controller.dart';
import '../../base/show_custom_snackbar.dart';
import '../../utils/dimensions.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    // var nameController = TextEditingController();
    // var phoneController = TextEditingController();
   /* var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];*/
    void _login(AuthController authController){
      // var authController = Get.find<AuthController>();
      // String name = nameController.text.trim();
      // String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type in your email address", title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid Email Address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Your password must be more than 6", title: "Valid Password");
      }else{
       /* showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);*/
        authController.login(email, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
            //Get.toNamed(RouteHelper.getCartPage());

          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }


    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //App Logo
              SizedBox(
                height: Dimensions.screenHeight*0.25,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage("assets/image/chow_icon.png", ),
                  ),
                ),
              ),

              //Hello Field
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Sign into your Account",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //Email Field
              AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height30,),
              //Password Field
              AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.lock,
                isObscure: true,
              ),
              SizedBox(height: Dimensions.height30,),

              //Sign in button
              /* Container(
              //width: Dimensions.screenWidth/2,
              //height: Dimensions.screenHeight/13
              height: 48,
              width: 361,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor
              ),
              child: Center(
                child: BigText(
                  text: "Sign In",
                  size: Dimensions.font20+Dimensions.font20/2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10,),
*/
              //Tagline
              /*  Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: "Sign into your Account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.screenHeight*0.03,),
*/
              // Sign in
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  //width: Dimensions.screenWidth/2,
                  //height: Dimensions.screenHeight/13
                  height: Dimensions.btnSize50,
                  width: Dimensions.btnSizeW360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.03,),

              //Sign in options
              RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(), transition: Transition.fade),
                        text: "  Create",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainBlackColor,
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ]
                ),
              ),

              /* Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      "assets/image/" + signUpImages[index],
                    ),
                  ),
                ))
            )*/


            ],
          ),
        ):const CustomLoader();
      })
    );
  }
}
