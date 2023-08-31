import 'package:chow/Controller/auth_controller.dart';
import 'package:chow/base/custom_loader.dart';
import 'package:chow/base/show_custom_snackbar.dart';
import 'package:chow/models/signup_body_model.dart';
import 'package:chow/routes/route_helper.dart';
import 'package:chow/utils/colors.dart';
import 'package:chow/widgets/app_text_field.dart';
import 'package:chow/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _registration(AuthController authController){
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "Phone Number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address", title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid Email Address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Your password must be more than 6", title: "Valid Password");
      }else{
        showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Registration successful!");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
              //Email Field
              AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              //Password Field
              AppTextField(
                  textController: passwordController,
                  hintText: "Password",
                  icon: Icons.lock,
                  isObscure: true,
              ),
              SizedBox(height: Dimensions.height20,),
              //Name Field
              AppTextField(
                  textController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              //Phone Field
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),
              GestureDetector(
                onTap: (){
                  _registration(_authController);
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
                      text: "Sign Up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "Have an account already?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    )
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.03,),
              RichText(
                text: TextSpan(
                    text: "Or Sign Up using?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16,
                    )
                ),
              ),

              Wrap(
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
              )


            ],
          ),
        ):const CustomLoader();
      },)
    );


  }
}
