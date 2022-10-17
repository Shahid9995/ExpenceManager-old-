import 'package:get/get.dart';

import '../viewModel/DataModel/googleDataModel.dart';
import '../viewModel/DataModel/login_data_model.dart';
import '../viewModel/DataModel/transType_model.dart';
import '../viewModel/DataModel/user_data_model.dart';
import '../viewModel/DataModel/verificatio_code_model.dart';

class MyRepo{
  static Rx<LoginDataModel> loginDataModel=LoginDataModel().obs;
  static Rx<UserDataModel> userDataModel=UserDataModel().obs;
  static Rx<GoogleDataModel> googleDataModel=GoogleDataModel().obs;
  static Rx<VerificationCodeModel> verificationCodeModel=VerificationCodeModel().obs;
  static Rx<TransTypeModel> transTypeModel=TransTypeModel().obs;
  static RxString transtypeName="Select Transaction type".obs;
  static RxString transtypeID="-1".obs;
  static RxBool isFingerPrint=false.obs;
  static RxString tittle="".obs;
}