import 'package:chow/models/user_model.dart';
import 'package:get/get.dart';

import '../data/repository/user_repo.dart';
import '../models/response_model.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo
  });

  bool _isLoading = false;

  late UserModel _userModel;
  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;


  Future<ResponseModel> getUseInfo() async{


    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode==200){
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      // userRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, "Successfully");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }
/*
  Future<ResponseModel> login(String email, String password) async{
    // authRepo.getUserToken();
    _isLoading = true;
    update();
    Response response = await userRepo.login(email, password);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      userRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async{
    userRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return userRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return userRepo.clearSharedData();
  }*/
}