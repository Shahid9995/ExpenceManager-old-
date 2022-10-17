

import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:expensemanage_app/view/base/custom_text_field.dart';
import 'package:expensemanage_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/api/api_client.dart';
import '../../core/repository/AuthRepo.dart';
import '../../core/repository/MyRepo.dart';
import '../../core/viewModel/Scaffold/AppScafflod.dart';
import '../../core/viewModel/controller/authcontroller/auth_controller.dart';
import '../../helper/route_helper.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';
import '../../util/primary_button.dart';
import '../base/custom_snackbar.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({Key? key}) : super(key: key);

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

TextEditingController userName = TextEditingController();

class _UserNameScreenState extends State<UserNameScreen> {
  @override
  void dispose(){
    userName.clear();
  }
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
        heading: "Enter Username",
        body: GetBuilder<AuthController>(
            init: AuthController(authRepo: AuthRepo(ApiClient())),
            builder: (authController) {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appHorizontalSm * 2.5,
                    vertical: AppSizes.appHorizontalMd*2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: AppSizes.appHorizontalSm),
                      child: Text(
                        "Enter New Username",
                        style: poppinsMedium.copyWith(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.appHorizontalSm * 1.5,
                    ),
                    CustomTextField(
                      padding: 1.5,
                      isPassword: true,
                      // isSuffixIcon: false,
                        hintText: "Type Here",
                        controller: userName,
                        // isUserName: true,
                        prefixIcon:Images.user_icon,
                        suffixIcon: Icon(Icons.check_circle)),
                    SizedBox(
                      height: AppSizes.appHorizontalXXL * 3,
                    ),
                    (!authController.isLoading)? Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          _update(authController);
                          // Get.to(()=>DashBoardScreen());
                          // Get.offAllNamed(RouteHelper.getDashboardRoute());
                          // Get.to(() => const PhoneNumberScreen());
                        },
                        child: PrimaryButton(
                          text: 'Save',
                          // width: 250,
                        ),
                      ),
                    ):Center(child: CircularProgressIndicator())
                  ],
                ),
              );
            }));
  }
  void _update(AuthController authController) async {
    var box=GetStorage();
    print("===_userID:${box.read(AppConstants.USERID)}========");


    String _userID=box.read(AppConstants.USERID).toString();

    String _userName = userName.text.trim();
    if (_userName.isEmpty) {
      showCustomSnackBar('enter_userName'.tr);
    }
    else {
      print("=_userID:$_userID====_userName:$_userName======");
      authController.updateName(_userID, _userName,).then((status) async {
        // authController.signup(_email, _phone,_password).then((status) async {
        print("==status:${status.isSuccess}==");
        if (status.isSuccess) {
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
