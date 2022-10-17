import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/AuthRepo.dart';
import '../../../core/viewModel/Scaffold/AppScafflod.dart';
import '../../../core/viewModel/controller/authcontroller/auth_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/app_color.dart';
import '../../../util/app_constants.dart';
import '../../../util/images.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

TextEditingController currentPwd = TextEditingController();
TextEditingController newPwd = TextEditingController();
TextEditingController confirmPwd = TextEditingController();

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void dispose(){
    currentPwd.clear();
    newPwd.clear();
    confirmPwd.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return AppScafflod(
        heading: 'Change Password',
        body: GetBuilder<AuthController>(
          init: AuthController(authRepo: AuthRepo(ApiClient())),
          builder: (authController) {
            return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appHorizontalSm * 2,
                    vertical: AppSizes.appHorizontalSm * 3),
                // alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Current Password",
                        style: TextStyle(
                            color: AppColors.kBlack,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    // SizedBox(
                    //   height: AppSizes.appHorizontalSm,
                    // ),
                    CustomTextField(
                      hintText: "Type Here",
                      isPassword: true,
                      controller: currentPwd,
                      suffixIcon: const Icon(
                        FontAwesomeIcons.eye,
                        color: AppColors.kBlack,
                      ),
                      prefixIcon: Images.lock_icon,
                      // prefixIcon: Icon(FontAwesomeIcons.lock,color: AppColors.kBlack,),
                    ),
                    SizedBox(
                      height: AppSizes.appHorizontalMd * 1,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "New Password",
                        style: TextStyle(
                            color: AppColors.kBlack,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    // SizedBox(
                    //   height: AppSizes.appHorizontalSm,
                    // ),
                    CustomTextField(
                      hintText: "Type Here",
                      isPassword: true,
                      controller: newPwd,
                      suffixIcon: const Icon(
                        FontAwesomeIcons.eye,
                        color: AppColors.kBlack,
                      ),
                      prefixIcon: Images.lock_icon,
                    ),
                    SizedBox(
                      height: AppSizes.appHorizontalMd * 1,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Confirm Password",
                        style: TextStyle(
                            color: AppColors.kBlack,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    // SizedBox(
                    //   height: AppSizes.appHorizontalSm,
                    // ),
                    CustomTextField(
                      hintText: "Type Here",
                      isPassword: true,
                      controller: confirmPwd,
                      suffixIcon: const Icon(
                        FontAwesomeIcons.eye,
                        color: AppColors.kBlack,
                      ),
                      prefixIcon: Images.lock_icon,
                    ),
                    SizedBox(
                      height: AppSizes.appHorizontalXXL * 1.3,
                    ),
                    (!authController.isLoading)?  InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          _rename(authController);
                          // if(newPwd.text!=confirmPwd.text){
                          //   print("password  not match");
                          // }
                        },
                        child: const PrimaryButton(
                          text: "Save",
                        )):const Center(child: CircularProgressIndicator()),
                  ],
                ));
          },
        ));
  }
  void _rename(AuthController authController) async {

    var box=GetStorage();
    String _currentPwd = currentPwd.text.trim();
    String _newPwd = newPwd.text.trim();
    String _confirmPwd = confirmPwd.text.trim();
    String userId=box.read(AppConstants.USERID).toString();
    if (_currentPwd.isEmpty) {
      showCustomSnackBar('enter_old_password'.tr);
    }
    else if (_newPwd.isEmpty) {
      showCustomSnackBar('enter_new_password'.tr);
    }else if (_confirmPwd.isEmpty) {
      showCustomSnackBar('enter_new_password_again'.tr);
    }
    else if (_newPwd!=_confirmPwd) {
      showCustomSnackBar('new_password_should_be_same'.tr);
    }
    else {
      print("===============");
      authController.changePassword(userId,_currentPwd,_newPwd).then((status) async {
        print("=login body=status:${status.isSuccess}==");
        if (status.isSuccess) {
          box.write(AppConstants.USERPASSWORD, _newPwd);
          // if (authController.isActiveRememberMe) {
          //   authController.saveUserNumberAndPassword(_email, _password);
          // } else {
          //   authController.clearUserNumberAndPassword();
          // }
          // await Get.find<AuthController>().getProfile();
          // showCustomSnackBar(status.message);
          Get.offAllNamed(RouteHelper.getDashboardRoute());
        }else {
          showCustomSnackBar(status.message);
        }
      });
    }

    /*print('------------1');
    final _imageData = await Http.get(Uri.parse('https://cdn.dribbble.com/users/1622791/screenshots/11174104/flutter_intro.png'));
    print('------------2');
    String _stringImage = base64Encode(_imageData.bodyBytes);
    print('------------3 {$_stringImage}');
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.setString('image', _stringImage);
    print('------------4');
    Uint8List _uintImage = base64Decode(_sp.getString('image'));
    authController.setImage(_uintImage);
    //await _thetaImage.writeAsBytes(_imageData.bodyBytes);
    print('------------5');*/
  }
}
