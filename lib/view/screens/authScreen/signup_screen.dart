import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/AuthRepo.dart';
import '../../../core/viewModel/Scaffold/AuthScafflod.dart';
import '../../../core/viewModel/controller/authcontroller/auth_controller.dart';
import '../../../util/circular_button.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/primary_button.dart';
import '../../../util/styles.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../verification/verification_screen.dart';

enum SingingCharacter { PhoneNumber, emailAddress }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

int emailValue = 1;

class _SignUpScreenState extends State<SignUpScreen> {
  // get onChanged => null;

  SingingCharacter? _character = SingingCharacter.emailAddress;
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cnfrmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return AuthScaffold(
      title: "Create Account",
      decs: 'Please enter details to create your account',
      body: Container(
          padding: EdgeInsets.only(
            top: AppSizes.appHorizontalSm * 3,
              left: AppSizes.appHorizontalSm * 2,
              right: AppSizes.appHorizontalSm * 2),
          child: GetBuilder<AuthController>(init: AuthController(authRepo: AuthRepo(ApiClient())), builder: (authController){
            return Column(
              children: [
                CustomTextField(
                  hintText: "Enter Email Address",
                  inputType: TextInputType.emailAddress,
                  // isPassword: true,
                  controller: email,
                  prefixIcon: Images.mail_icon,
                  // Icon(
                  //   FontAwesomeIcons.envelope,
                  //   // Icons.email_outlined,
                  //   color: AppColors.kBlack.withOpacity(0.6),
                  //   size: 25,
                  // ),
                  // suffixIcon: Icon(FontAwesomeIcons.,color: AppColors.kPrimary,),
                  suffixIcon: Icon(Icons.check_circle,color: AppColors.kPrimary,),
                ),
                SizedBox(
                  height: AppSizes.appHorizontalSm*3,
                ),
                CustomTextField(
                  padding: 1.2,
                  hintText: "+9200000",
                  inputType: TextInputType.phone,
                  // isPassword: true,
                  controller: phoneNumber,
                  prefixIcon:Images.authmobile_icon,
                  // Icon(
                  //   FontAwesomeIcons.mobile,
                  //   // Icons.email_outlined,
                  //   color: AppColors.kBlack.withOpacity(0.6),
                  //   size: 25,
                  // ),
                  // suffixIcon: Icon(FontAwesomeIcons.,color: AppColors.kPrimary,),
                  suffixIcon: Icon(Icons.check_circle,color: AppColors.kPrimary,),
                ),
                SizedBox(
                  height: AppSizes.appHorizontalSm*3,
                ),
                CustomTextField(
                  hintText:"Password",
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: password,
                  prefixIcon: Images.lock_icon,
                  suffixIcon: Icon(Icons.check_circle,color: AppColors.kPrimary,),
                ),
                SizedBox(
                  height: AppSizes.appHorizontalSm*3,
                ),
                CustomTextField(
                  hintText:"Confirm Password",
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: cnfrmPassword,
                  prefixIcon:Images.lock_icon,
                  suffixIcon: Icon(Icons.check_circle,color: AppColors.kPrimary,),
                ),
                // SizedBox(
                //   height: AppSizes.appHorizontalSm*3,
                // ),
                // Text("Forgot Password?",style: TextStyle(color: AppColors.kTextColor),),
                SizedBox(height: AppSizes.appHorizontalSm*3,),
                (!authController.isLoading)? InkWell(
                    onTap: (){
                      print("===========");
                     _signup(authController);
                    },
                    child: CircularButton(text: "Sign Up",)):Center(child: CircularProgressIndicator()),
                SizedBox(height: AppSizes.appHorizontalSm*2.5,),
                InkWell(
                    onTap: (){
                      Get.back();
                      print("======Login pressed=============");
                    },
                    child: PrimaryButton(text: 'Login',)),
                SizedBox(height: AppSizes.appHorizontalSm*2.5,),
                RichText(text:  TextSpan(
                    text: "By signing up, you are agree with our  ",
                    style: poppinsRegular.copyWith(fontSize: 11,color: AppColors.kGray),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Terms & Conditions",style: poppinsRegular.copyWith(fontSize: 11,
                          color:AppColors.kBlack,
                          decoration: TextDecoration.underline
                      )
                      )
                    ]
                )),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,)
              ],
            );
          }),
    ));
  }
  void _signup(AuthController authController) async {
    String _email = email.text.trim();
    String _phone = phoneNumber.text.trim();
    String _password = password.text.trim();
    String _cnfpassword = cnfrmPassword.text.trim();
    if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    }
    else if(!GetUtils.isEmail(_email)){
        showCustomSnackBar('enter_a_valid_email_address'.tr);
    }
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }
    else if (_password!=_cnfpassword) {
      showCustomSnackBar('confirm password not same'.tr);
    }
    else {
      authController.verifydata(_email, _phone,).then((status) async {
      // authController.signup(_email, _phone,_password).then((status) async {
        print("==status:${status.isSuccess}==");
        if (status.isSuccess) {


          // authController.signup(_email, _phone,_password).then((status) async {
          //   print("==status:${status.isSuccess}==");
          //   if (status.isSuccess) {
          //     // if (authController.isActiveRememberMe) {
          //     //   authController.saveUserNumberAndPassword(_email, _password);
          //     // } else {
          //     //   authController.clearUserNumberAndPassword();
          //     // }
          //     // await Get.find<AuthController>().getProfile();
          //     Get.offAllNamed(RouteHelper.getDashboardRoute());
          //   }else {
          //     showCustomSnackBar(status.message);
          //   }
          // });
          Get.to(()=>VerificationScreen(number: _phone,email:_email,password: _password,));

          // Get.offAllNamed(RouteHelper.VerificationScreen(_phone));
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
