import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:expensemanage_app/core/repository/UserRepo.dart';
import 'package:expensemanage_app/core/viewModel/DataModel/googleDataModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../helper/route_helper.dart';
import '../../../../util/app_constants.dart';
import '../../../../view/base/custom_snackbar.dart';
import '../../../../view/screens/price_lookup/product_list.dart';
import '../../../repository/MyRepo.dart';
import '../../../response/response_model.dart';
import '../../DataModel/transType_model.dart';
import '../../DataModel/user_data_model.dart';
class UserDataController extends GetxController implements GetxService {
  var box=GetStorage();
  final UserRepo userRepo;
  UserDataController( {required this.userRepo});
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> userData(String userID) async {
    _isLoading = true;
    update();
    Response response = await userRepo.userData(userID);
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        // debugPrint("if=response:${response.body}========");
        MyRepo.userDataModel.value=UserDataModel.fromJson(response.body);
        debugPrint("before=response:${MyRepo.userDataModel.value.message}========");
        box.write(AppConstants.TodaySpent, MyRepo.userDataModel.value.data!.todaySpent);
        // box.write(AppConstants.TodaySpent, MyRepo.userDataModel.value.data!.todaySpent);
        print("==TodaySpent:${MyRepo.userDataModel.value.data!.monthSpent})}=======");
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        debugPrint("=else=response:${response.body}========");
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
  Future<ResponseModel> deleteReceipt(String receiptID) async {
    _isLoading = true;
    update();
    Response response = await userRepo.deleteReceipt(receiptID);
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        // debugPrint("if=response:${response.body}========");
        // MyRepo.userDataModel.value=UserDataModel.fromJson(response.body);
        // debugPrint("before=response:${MyRepo.userDataModel.value.message}========");
        // box.write(AppConstants.TodaySpent, MyRepo.userDataModel.value.data!.todaySpent);
        // // box.write(AppConstants.TodaySpent, MyRepo.userDataModel.value.data!.todaySpent);
        // print("==TodaySpent:${MyRepo.userDataModel.value.data!.monthSpent})}=======");
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        debugPrint("=else=response:${response.body}========");
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
  Future<ResponseModel> deleteCard(String cardID) async {
    _isLoading = true;
    update();
    Response response = await userRepo.deleteCard(cardID);
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        // debugPrint("if=response:${response.body}========");
        // MyRepo.userDataModel.value=UserDataModel.fromJson(response.body);
        // debugPrint("before=response:${MyRepo.userDataModel.value.message}========");
        // box.write(AppConstants.TodaySpent, MyRepo.userDataModel.value.data!.todaySpent);
        // // box.write(AppConstants.TodaySpent, MyRepo.userDataModel.value.data!.todaySpent);
        // print("==TodaySpent:${MyRepo.userDataModel.value.data!.monthSpent})}=======");
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        debugPrint("=else=response:${response.body}========");
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

  Future<ResponseModel> transaction(String userID,String amount,String tID,String desc,String date,String currency) async {
    _isLoading = true;
    update();
    Response response = await userRepo.transaction(tID,amount,userID,currency,date,desc);
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        // debugPrint("if=response:${response.body}========");
        // MyRepo.userDataModel.value=UserDataModel.fromJson(response.body);
        // debugPrint("before=response:${MyRepo.userDataModel.value.message}========");
        // box.write(AppConstants.TodaySpent, MyRepo.userDataModel.value.data!.todaySpent);
        // print("==TodaySpent:${box.read(AppConstants.TodaySpent)}=======");
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        debugPrint("=else=response:${response.body}========");
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

  Future<ResponseModel> transType() async {
    _isLoading = true;
    update();
    Response response = await userRepo.transType();
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        // debugPrint("if=response:${response.body}========");
        MyRepo.transTypeModel.value=TransTypeModel.fromJson(response.body);
        debugPrint("before=response:${MyRepo.userDataModel.value.message}========");
        print("==TodaySpent:${box.read(AppConstants.TodaySpent)}=======");
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        debugPrint("=else=response:${response.body}========");
        responseModel = ResponseModel(false, response.body['message']);
      }
    } else {
      debugPrint("==response:${response.body}========");
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> saveReceipt(String userID,XFile image) async {
    _isLoading = true;
    update();
    Response response = await userRepo.updateReceipt(userID,image);
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        debugPrint("if=response:${response.body}========");
        // MyRepo.userDataModel.value=UserDataModel.fromJson(response.body);
        // debugPrint("before=response:${MyRepo.userDataModel.value.message}========");
        // box.write(AppConstants.TodaySpent, MyRepo.userDataModel.value.data!.todaySpent);
        // print("==TodaySpent:${box.read(AppConstants.TodaySpent)}=======");
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        debugPrint("=else=response:${response.body}========");
        responseModel = ResponseModel(false, response.body['message']);
      }
    } else {
      debugPrint("==response:${response.body}========");
      responseModel = ResponseModel(false, response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future postImageData( File? image, String userID,String uri,String transType,String amount,String currency,String date,String desc) async {
    // var stream = new http.ByteStream(DelegatingStream.typed(image!.openRead()));
    var responseModel;
    _isLoading = true;
    update();
    var f =image;
    try {
      var request =await http.MultipartRequest("POST", Uri.parse(AppConstants.BASE_URL+uri));
      request.fields["user_id"] = userID;
      request.fields["transaction_type_id"] = transType;
      request.fields["transaction_amount"] = amount;
      request.fields["amount_currency"] = currency;
      request.fields["transaction_date"] = date;
      request.fields["transaction_description"] = desc;
      print("=userID:$userID======$f=====");
      if(f!=null){
        var pic = await http.MultipartFile.fromPath("transaction_image",f.path);
        request.files.add(pic);
      }else{
        request.fields["transaction_image"] ='';
      }
      var response = await request.send();
    await  response.stream.transform(utf8.decoder).listen((value) async {
        print("=Controller=value:$value=============");
        if (json.decode(value)['status'].toString() == 'true') {

          // responseModel = ResponseModel(true, json.decode(value)['message']);
          // showCustomSnackBar(json.decode(value)['message'],isError: false);
         await getUserData();
          print("===before=======");
          // Get.offNamed();
          // Get.back();
            update();

        }else{
          // responseModel = ResponseModel(false, json.decode(value)['message']);
          showCustomSnackBar(json.decode(value)['message']);
        }
      });
    } catch(e) {
      print(e);
      // responseModel = ResponseModel(false, "NO INTERNET CONNECTION");
      return const Response(statusCode: 1, statusText:"NO INTERNET CONNECTION");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> googleSearch(String tittle, ) async {
    _isLoading = true;
    update();
    Response response = await userRepo.googleData(tittle);
    // print("=Controller=response:${response.body['status']}=======");
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if(response.body['status']){
        debugPrint("Google Search response:${response.body}========");
        MyRepo.googleDataModel.value=GoogleDataModel.fromJson(response.body);
        debugPrint("Google repo:${MyRepo.googleDataModel.value.data![1].title}========");
        // MyRepo.loginDataModel.value=LoginDataModel.fromJson(response.body);
        // // debugPrint("before=response:${MyRepo.loginDataModel.value.message}========");
        // box.write(AppConstants.USERID, MyRepo.loginDataModel.value.data!.id);
        // box.write(AppConstants.USERNAME, MyRepo.loginDataModel.value.data!.username);
        // box.write(AppConstants.USEREMAIL, MyRepo.loginDataModel.value.data!.email);
        // box.write(AppConstants.USERPHONE, MyRepo.loginDataModel.value.data!.phone);
        // box.write(AppConstants.PRICEALERT, MyRepo.loginDataModel.value.data!.priceAlert.toString());
        // box.write(AppConstants.new_transaction_alert, MyRepo.loginDataModel.value.data!.newTransactionAlert.toString());
        responseModel = ResponseModel(true, response.body['message']);
      }else{
        debugPrint("=else=response:${response.body}========");
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
  Future postProductData( File? image, String userID,String uri,String tittle,String dec,String price,String currency) async {
    // var stream = new http.ByteStream(DelegatingStream.typed(image!.openRead()));
    var responseModel;
    _isLoading = true;
    update();
    var f =image;
    print("====f:$f=====");
    try {
      var request =await http.MultipartRequest("POST", Uri.parse(AppConstants.BASE_URL+uri));
      request.fields["user_id"] = userID;
      request.fields["product_title"] = tittle;
      request.fields["product_description"] = dec;
      request.fields["price"] = price;
      request.fields["price_currency"] = currency;
      print("=userID:$userID======$f=====");
      // if(f!=null){
        var pic = await http.MultipartFile.fromPath("product_image",f!.path);
        request.files.add(pic);
      // }else{
      //   request.fields["receipt_image"] ='';
      // }
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print("=Controller=value:$value=============");
        if (json.decode(value)['status'].toString() == 'true') {

          // responseModel = ResponseModel(true, json.decode(value)['message']);
          showCustomSnackBar(json.decode(value)['message'],isError: false);
          getUserData();
          Get.off(ProductsList());
          update();
        }else{
          // responseModel = ResponseModel(false, json.decode(value)['message']);
          showCustomSnackBar(json.decode(value)['message']);
        }
      });
    } catch(e) {
      print(e);
      // responseModel = ResponseModel(false, "NO INTERNET CONNECTION");
      return const Response(statusCode: 1, statusText:"NO INTERNET CONNECTION");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future postCardData( File? image, String userID,String uri,String name,String number,String expDate,String cvv) async {
    // var stream = new http.ByteStream(DelegatingStream.typed(image!.openRead()));
    var responseModel;
    _isLoading = true;
    update();
    var f =image;
    print("====f:$f=====");
    try {
      var request =await http.MultipartRequest("POST", Uri.parse(AppConstants.BASE_URL+uri));
      request.fields["user_id"] = userID;
      request.fields["name_on_card"] = name;
      request.fields["card_number"] = number;
      request.fields["expiry_date"] = expDate;
      request.fields["cvv"] = cvv;
      print("=userID:$userID======$f=====");
      // if(f!=null){
        var pic = await http.MultipartFile.fromPath("card_image",f!.path);
        request.files.add(pic);
      // }else{
      //   request.fields["receipt_image"] ='';
      // }
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print("=Controller=value:$value=============");
        if (json.decode(value)['status'].toString() == 'true') {
          // responseModel = ResponseModel(true, json.decode(value)['message']);
          // showCustomSnackBar(json.decode(value)['message'],isError: false);
          getUserData();
          // Get.off(ProductsList());
          update();
        }else{
          // responseModel = ResponseModel(false, json.decode(value)['message']);
          showCustomSnackBar(json.decode(value)['message']);
        }
      });
    } catch(e) {
      print(e);
      // responseModel = ResponseModel(false, "NO INTERNET CONNECTION");
      return const Response(statusCode: 1, statusText:"NO INTERNET CONNECTION");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future getUserData() async {
    print("======After============");
    var box=GetStorage();
    String userId=box.read(AppConstants.USERID).toString();
    if (userId.isEmpty) {
      Get.offAllNamed(RouteHelper.getSignInRoute());
      // showCustomSnackBar('enter_email_address'.tr);
    }
    else {
     await userData(userId,).then((status) async {
        print("=Dashboard=status:${status.isSuccess}==");
        if (status.isSuccess) {
          // if (authController.isActiveRememberMe) {
          //   authController.saveUserNumberAndPassword(_email, _password);
          // } else {
          //   authController.clearUserNumberAndPassword();
          // }
          // await Get.find<AuthController>().getProfile();
          // showCustomSnackBar(status.message);
          // Get.offAllNamed(RouteHelper.getDashboardRoute());
        }else {
          showCustomSnackBar(status.message);
        }
      });
    }
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