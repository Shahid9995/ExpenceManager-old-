import 'package:get/get_connect/http/src/response/response.dart';

import '../../util/app_constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;

  AuthRepo(this.apiClient);

  Future<Response> login(String email, String password,  String emailType) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URI, {"login_type":emailType,"email": email, "password": password,});
  }


  Future<Response> changePassword(String userID, String oldPassword,  String newPassword) async {
    return await apiClient.postData(
        AppConstants.ChangePasswor_URI, {"user_id":userID,"old_password": oldPassword, "new_password": newPassword,});
  }
  Future<Response> signup(String email, String password,  String phone) async {
    return await apiClient.postData(
        AppConstants.SIGNUP_URI,{"phone":phone,"email": email, "password": password,});
  }
  Future<Response> verifydata(String email,  String phone) async {
    return await apiClient.postData(
        AppConstants.VERIFYDATA_URI, {"phone":phone,"email": email});
  }
  Future<Response> updatedata(String userId,String userName,  String phone,String fingerPrint,String pattern) async {
    return await apiClient.postData(
        AppConstants.VERIFYDATA_URI, {"phone":phone,"username": userName,"user_id":userId,"fingerprint":fingerPrint,"pattern":pattern});
  }
  Future<Response> updateName(String userId,String userName,) async {
    return await apiClient.postData(
        AppConstants.UPDATEPROFILE_URI, {"username": userName,"user_id":userId});
  }
  Future<Response> updatePhone(String userId,String userPhone,) async {
    return await apiClient.postData(
        AppConstants.UPDATEPROFILE_URI, {"phone": userPhone,"user_id":userId});
  }
}
