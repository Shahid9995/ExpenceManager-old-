import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/app_constants.dart';
import '../api/api_client.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo(this.apiClient);

  Future<Response> userData(String userID) async {
    return await apiClient.getData(AppConstants.USERDATA_URI + userID);}
  Future<Response> deleteReceipt(String receiptID) async {
    return await apiClient.getData(AppConstants.DeleteReciept_URI + receiptID);}
  Future<Response> deleteCard(String cardID) async {
    return await apiClient.getData(AppConstants.DeleteCARD_URI + cardID);}
  Future<Response> googleData(String tittle) async {
    return await apiClient.postData(AppConstants.GoogleSearch_URI,{"name":tittle,});
  }
  Future<Response> transaction(String transID, String amount,  String userID,String currency,String date,String desc ) async {
    return await apiClient.postData(
        AppConstants.TRANSSAVE_URI, {"user_id":userID,"transaction_type_id": transID,
      "transaction_amount": amount,"amount_currency":currency,"transaction_date":date,"transaction_description":desc});
  }
  Future<Response> transType() async {
    return await apiClient.getData(AppConstants.TRANSTYPE_URI);}
  Future<Response> saveReceipt(String userId,File? image,) async {
    return await apiClient.postData(
        AppConstants.SAVERECEIPT_URI, {"receipt_image": image,"user_id":userId});
  }
  Future<Response> updateReceipt( userID, XFile image,) async {
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      'user_id': userID,
    });
    return apiClient.postMultipartData(
      AppConstants.SAVERECEIPT_URI, _fields, [ MultipartBody('receipt_image', image)],
    );
  }
}
