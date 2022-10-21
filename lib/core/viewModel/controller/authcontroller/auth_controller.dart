

import 'package:expensemanage_app/core/repository/AuthRepo.dart';
import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/core/viewModel/DataModel/login_data_model.dart';
import 'package:expensemanage_app/core/viewModel/DataModel/verificatio_code_model.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../response/response_model.dart';
class AuthController extends GetxController implements GetxService {
  var box=GetStorage();
   final AuthRepo authRepo;
  AuthController( {required this.authRepo});
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> login(String email, String password,String emailType) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password,emailType);
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        // debugPrint("after=response:${response.body}========");
        MyRepo.loginDataModel.value=LoginDataModel.fromJson(response.body);
        // debugPrint("before=response:${MyRepo.loginDataModel.value.message}========");
        box.write(AppConstants.USERID, MyRepo.loginDataModel.value.data!.id);
        box.write(AppConstants.USERNAME, MyRepo.loginDataModel.value.data!.username);
        box.write(AppConstants.USEREMAIL, MyRepo.loginDataModel.value.data!.email);
        box.write(AppConstants.USERPHONE, MyRepo.loginDataModel.value.data!.phone);
        box.write(AppConstants.PRICEALERT, MyRepo.loginDataModel.value.data!.priceAlert.toString());
        box.write(AppConstants.new_transaction_alert, MyRepo.loginDataModel.value.data!.newTransactionAlert.toString());
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        // debugPrint("=else=response:${response.body}========");
        responseModel = ResponseModel(false, response.body['message']);
      }

      // debugPrint("=Controller=response:${response.body}========");
      // authRepo.saveUserToken(response.body['token'], response.body['zone_wise_topic']);
      // await authRepo.updateToken();

    } else {
      debugPrint("==response:${response.body}========");
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> changePassword(String userID, String oldPassword,String newPassword) async {
    _isLoading = true;
    update();
    Response response = await authRepo.changePassword(userID, oldPassword,newPassword);
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        // debugPrint("after=response:${response.body}========");
        MyRepo.loginDataModel.value=LoginDataModel.fromJson(response.body);
        // debugPrint("before=response:${MyRepo.loginDataModel.value.message}========");
        box.write(AppConstants.USERID, MyRepo.loginDataModel.value.data!.id);
        box.write(AppConstants.USERNAME, MyRepo.loginDataModel.value.data!.username);
        box.write(AppConstants.USEREMAIL, MyRepo.loginDataModel.value.data!.email);
        box.write(AppConstants.USERPHONE, MyRepo.loginDataModel.value.data!.phone);
        box.write(AppConstants.PRICEALERT, MyRepo.loginDataModel.value.data!.priceAlert.toString());
        box.write(AppConstants.new_transaction_alert, MyRepo.loginDataModel.value.data!.newTransactionAlert.toString());
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        // debugPrint("=else=response:${response.body}========");
        responseModel = ResponseModel(false, response.body['message']);
      }

      // debugPrint("=Controller=response:${response.body}========");
      // authRepo.saveUserToken(response.body['token'], response.body['zone_wise_topic']);
      // await authRepo.updateToken();

    } else {
      debugPrint("==response:${response.body}========");
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> signup(String email, String number,String password) async {

    _isLoading = true;
    update();
    Response response = await authRepo.signup(email,password,number);
    print("==response:${response.statusCode==200}=======");
    ResponseModel responseModel;

    if (response.statusCode == 200) {
      if(response.body['status']){
        // debugPrint("=if=response:${response.body}========");
        MyRepo.loginDataModel.value=LoginDataModel.fromJson(response.body);
        box.write(AppConstants.USERID, MyRepo.loginDataModel.value.data!.id);
        box.write(AppConstants.USERNAME, MyRepo.loginDataModel.value.data!.username);
        box.write(AppConstants.USEREMAIL, MyRepo.loginDataModel.value.data!.email);
        box.write(AppConstants.USERPHONE, MyRepo.loginDataModel.value.data!.phone);
        box.write(AppConstants.PRICEALERT, MyRepo.loginDataModel.value.data!.priceAlert.toString());
        box.write(AppConstants.new_transaction_alert, MyRepo.loginDataModel.value.data!.newTransactionAlert.toString());
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        // debugPrint("=else=response:${response.body}========");
        responseModel = ResponseModel(false, response.body['message']);
      }
      // debugPrint("==response:${response.body}========");
      // authRepo.saveUserToken(response.body['token'], response.body['zone_wise_topic']);
      // await authRepo.updateToken();
      // responseModel = ResponseModel(true, 'successful');
    } else {
      debugPrint("==response:${response.body}========");
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> verifydata(String email, String number,) async {

    _isLoading = true;
    update();
    Response response = await authRepo.verifydata(email, number);
    print("=Controller =response:${response.status}=======");
    ResponseModel responseModel;

    if (response.statusCode == 200) {
      if(response.body['status']){
        debugPrint("=if=response:${response.body}========");
        MyRepo.verificationCodeModel.value=VerificationCodeModel.fromJson(response.body);
        responseModel = ResponseModel(true, "Successfully");

      }else{
        debugPrint("=else=response:${response.body}========");
        responseModel = ResponseModel(false, response.body['message']);
      }
      // authRepo.saveUserToken(response.body['token'], response.body['zone_wise_topic']);
      // await authRepo.updateToken();

    } else {
      debugPrint("=after=response:${response.body}========");
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> updateName(String userId, String userName,) async {

    _isLoading = true;
    update();
    Response response = await authRepo.updateName(userId, userName);
    print("=Controller =response:${response.status}=======");
    ResponseModel responseModel;

    if (response.statusCode == 200) {
      if(response.body['status']){
        debugPrint("=if=response:${response.body}========");
        MyRepo.loginDataModel.value=LoginDataModel.fromJson(response.body);
        box.write(AppConstants.USERID, MyRepo.loginDataModel.value.data!.id);
        box.write(AppConstants.USERNAME, MyRepo.loginDataModel.value.data!.username);
        box.write(AppConstants.USEREMAIL, MyRepo.loginDataModel.value.data!.email);
        box.write(AppConstants.USERPHONE, MyRepo.loginDataModel.value.data!.phone);
        box.write(AppConstants.PRICEALERT, MyRepo.loginDataModel.value.data!.priceAlert.toString());
        box.write(AppConstants.new_transaction_alert, MyRepo.loginDataModel.value.data!.newTransactionAlert.toString());
        responseModel = ResponseModel(true, "Successfully");

      }else{
        debugPrint("=else=response:${response.body}========");
        responseModel = ResponseModel(false, response.body['message']);
      }
      // authRepo.saveUserToken(response.body['token'], response.body['zone_wise_topic']);
      // await authRepo.updateToken();

    } else {
      debugPrint("=after=response:${response.body}========");
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> updatePhone(String userId, String userPhone,) async {

    _isLoading = true;
    update();
    Response response = await authRepo.updatePhone(userId, userPhone);
    print("=Controller =response:${response.status}=======");
    ResponseModel responseModel;

    if (response.statusCode == 200) {
      if(response.body['status']){
        debugPrint("=if=response:${response.body}========");
        MyRepo.loginDataModel.value=LoginDataModel.fromJson(response.body);
        box.write(AppConstants.USERID, MyRepo.loginDataModel.value.data!.id);
        box.write(AppConstants.USERNAME, MyRepo.loginDataModel.value.data!.username);
        box.write(AppConstants.USEREMAIL, MyRepo.loginDataModel.value.data!.email);
        box.write(AppConstants.USERPHONE, MyRepo.loginDataModel.value.data!.phone);
        box.write(AppConstants.PRICEALERT, MyRepo.loginDataModel.value.data!.priceAlert.toString());
        box.write(AppConstants.new_transaction_alert, MyRepo.loginDataModel.value.data!.newTransactionAlert.toString());
        responseModel = ResponseModel(true, "Successfully");

      }else{
        debugPrint("=else=response:${response.body}========");
        responseModel = ResponseModel(false, response.body['message']);
      }
      // authRepo.saveUserToken(response.body['token'], response.body['zone_wise_topic']);
      // await authRepo.updateToken();

    } else {
      debugPrint("=after=response:${response.body}========");
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }


  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }


}