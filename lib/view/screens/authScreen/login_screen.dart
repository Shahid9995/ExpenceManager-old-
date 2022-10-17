
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:expensemanage_app/view/screens/authScreen/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/AuthRepo.dart';
import '../../../core/viewModel/Scaffold/AuthScafflod.dart';
import '../../../core/viewModel/controller/authcontroller/auth_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/circular_button.dart';
import '../../../util/custom_radio.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/primary_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';

enum SingingCharacter { PhoneNumber, emailAddress }

class SignInScreen extends StatefulWidget {
   SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final LocalAuthentication auth = LocalAuthentication();
RxBool isPhoneNumber=false.obs;

  // get onChanged => null;
  SingingCharacter? _character = SingingCharacter.emailAddress;
var box=GetStorage();
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  @override
  void initState(){
    print("==${box.hasData(AppConstants.USEREMAIL)}==");
    if(box.hasData(AppConstants.USEREMAIL)){
      email.text=box.read(AppConstants.USEREMAIL);
    }
    print("==${box.hasData(AppConstants.USERID)}==");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    AppSizes().init(context);
    return AuthScaffold(
      title: "Welcome",
      decs: 'Please login to your account',
      body:Container(
          padding: EdgeInsets.only(
              left: AppSizes.appHorizontalSm * 2,
              right: AppSizes.appHorizontalSm * 2),
          child: GetBuilder<AuthController>(init: AuthController(authRepo: AuthRepo(ApiClient())), builder: (authController){
            return Column(
              children: [
                Container(
                    padding: EdgeInsets.only(left: AppSizes.appHorizontalSm,bottom: AppSizes.appHorizontalSm ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Verify By",
                      style: poppinsRegular.copyWith(
                        fontSize:AppSizes.appHorizontalSm*1.7
                      )
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width:  Dimensions.PADDING_SIZE_SMALL,),
                  CustomRadio(
                    value: SingingCharacter.emailAddress,
                    onChanged: ( SingingCharacter? value) {
                      isPhoneNumber.value=false;
                      setState(() {
                        print("$value");
                        _character = value;
                      });

                    }, groupValue: _character,),
                  const SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                  Text("Email Address",style: poppinsRegular.copyWith(fontSize: AppSizes.appHorizontalSm*1.2),),
                  SizedBox(
                    width: AppSizes.appHorizontalSm * 2,
                  ),
                  CustomRadio(
                    value: SingingCharacter.PhoneNumber,
                    onChanged: ( SingingCharacter? value) {
                    isPhoneNumber.value=true;
                    print("$value");
                    print("${isPhoneNumber.value}");
                    setState(() { _character = value; });

                  }, groupValue: _character,),
                  const SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                  // Radio<SingingCharacter>(
                  //   // fillColor: Colors.black,
                  //   activeColor: AppColors.kPrimary,
                  //   value: SingingCharacter.PhoneNumber,
                  //   groupValue: _character,
                  //   onChanged: (SingingCharacter? value) {
                  //     isPhoneNumber.value=true;
                  //     print("$value");
                  //     print("${isPhoneNumber.value}");
                  //     setState(() { _character = value; });
                  //   },
                  // ),
                   Text("Phone Number",style: poppinsRegular.copyWith(fontSize: AppSizes.appHorizontalSm*1.2)),
                ]),
                SizedBox(
                  height: AppSizes.appHorizontalMd*1.5,
                ),
                Obx(() {
                  return  CustomTextField(
                    isEnabled: (box.read(AppConstants.KEY_LOCAL_AUTH_ENABLED)=="true")?false:true,
                    padding: isPhoneNumber.value?1.2:1.5,
                    hintText: isPhoneNumber.value?"+9200000":"abcd@gmail.com",
                    inputType: isPhoneNumber.value?TextInputType.phone:TextInputType.emailAddress,
                    // isPassword: true,
                    controller: email,
                    // isPhoneNumber.value
                    prefixIcon: !isPhoneNumber.value?Images.mail_icon:Images.authmobile_icon,
                    // suffixIcon: Icon(FontAwesomeIcons.,color: AppColors.kPrimary,),
                    suffixIcon: const Icon(Icons.check_circle,color: AppColors.kPrimary,),
                  );
                }),
                (box.read(AppConstants.KEY_LOCAL_AUTH_ENABLED)=="true")?
                  Container(
                    color: AppColors.kgreyText,
                    width: double.infinity,
                    height: 1,
                  ):Container(),
                SizedBox(
                  height: AppSizes.appHorizontalSm*3,
                ),
                CustomTextField(
                  hintText:"******",
                  inputType: TextInputType.visiblePassword,
                  // inputFormatters:
                  isPassword: true,
                  controller: password,
                  prefixIcon: Images.lock_icon,
                  suffixIcon: const Icon(Icons.check_circle,color: AppColors.kPrimary,),
                ),
                SizedBox(
                  height: AppSizes.appHorizontalSm*1.5,
                ),
                Text("Forgot Password?",style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,color:AppColors. kAppbarColor),),
                SizedBox(
                  height: AppSizes.appVerticalSm*1,
                ),
                  if(box.read(AppConstants.KEY_LOCAL_AUTH_ENABLED)=="true")InkWell(
                    onTap: (){
                      _readFromStorage(authController);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Login with FingerPrint ",style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),),
                        const Icon(Icons.fingerprint_sharp ,)
                      ],
                    ),
                  ),


                SizedBox(height: AppSizes.appVerticalSm*1.5,),
                (!authController.isLoading)? InkWell(
                    onTap: (){
                      print("=======CircularButton pressed============");
                      _login(authController);
                      // Get.to(()=>const DashBoardScreen());
                    },
                    child: const CircularButton(text: "Login",)):const Center(child: CircularProgressIndicator()),
                SizedBox(height: AppSizes.appHorizontalSm*2.5,),
                InkWell(
                    onTap: (){
                      print("======PrimaryButton pressed=============");
                      Get.to(()=>const SignUpScreen());
                    },
                    child: const PrimaryButton(text: 'Create Account',)),
                SizedBox(height: AppSizes.appHorizontalSm*2.5,),
                RichText(text:  TextSpan(
                    text: "By signing in, you are agree with our  ",
                    style: poppinsRegular.copyWith(fontSize: AppSizes.appHorizontalSm*.9,color: AppColors.kGray),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Terms & Conditions", style: poppinsRegular.copyWith(fontSize: AppSizes.appHorizontalSm*.9,
                          color:AppColors.kBlack,
                          decoration: TextDecoration.underline
                      )
                      )
                    ]
                )),
                const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,)
              ],
            );
          },)));
  }

  void _login(AuthController authController) async {
    String _email = email.text.trim();
    String _password = password.text.trim();
    String _emailType = _character.toString();
    box.write(AppConstants.USERPASSWORD, _password);
    if(_emailType=="SingingCharacter.emailAddress"){
     _emailType="email";
    }else{
      _emailType="phone";
    }
    if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    }
    else
      if(_emailType=="email"&&!GetUtils.isEmail(_email)){
        showCustomSnackBar('enter_a_valid_email_address'.tr);
    }
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }
    // else if (_password.length < 6) {
    //   showCustomSnackBar('password_should_be'.tr);
    // }
    else {
      print("===============");
      authController.login(_email, _password,_emailType).then((status) async {
        print("=login body=status:${status.isSuccess}==");
        if (status.isSuccess) {
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
Future<void> _readFromStorage(authController) async {
  String isLocalAuthEnabled = await box.read(
      AppConstants.KEY_LOCAL_AUTH_ENABLED);

  if ("true" == isLocalAuthEnabled) {
    bool authenticated = await auth.authenticate(
      localizedReason:
      'Scan your fingerprint to authenticate',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      ),
    );

    if (authenticated) {
      String _email = email.text.trim();
      String _password = box.read(AppConstants.USERPASSWORD).toString();
      String _emailType = _character.toString();
      box.write(AppConstants.USERPASSWORD, _password);
      if (_emailType == "SingingCharacter.emailAddress") {
        _emailType = "email";
      } else {
        _emailType = "phone";
      }
      if (_email.isEmpty) {
        showCustomSnackBar('enter_email_address'.tr);
      }
      else if (_emailType == "email" && !GetUtils.isEmail(_email)) {
        showCustomSnackBar('enter_a_valid_email_address'.tr);
      }
      else if (_password.isEmpty) {
        showCustomSnackBar('enter_password'.tr);
      }
      // else if (_password.length < 6) {
      //   showCustomSnackBar('password_should_be'.tr);
      // }
      else {
        print("===============");
        authController.login(_email, _password, _emailType).then((
            status) async {
          print("=login body=status:${status.isSuccess}==");
          if (status.isSuccess) {
            // if (authController.isActiveRememberMe) {
            //   authController.saveUserNumberAndPassword(_email, _password);
            // } else {
            //   authController.clearUserNumberAndPassword();
            // }
            // await Get.find<AuthController>().getProfile();
            // showCustomSnackBar(status.message);
            Get.offAllNamed(RouteHelper.getDashboardRoute());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    } else {
      showCustomSnackBar("Try_again");
      // _usernameController.text = await _storage.read(key: KEY_USERNAME) ?? '';
      // _passwordController.text = await _storage.read(key: KEY_PASSWORD) ?? '';
    }
  }
}
}
