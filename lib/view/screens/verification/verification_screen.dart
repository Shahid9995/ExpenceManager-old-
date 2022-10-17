import 'dart:async';

import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/dimensions.dart';
import 'package:expensemanage_app/view/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/AuthRepo.dart';
import '../../../core/viewModel/controller/authcontroller/auth_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/circular_button.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/custom_snackbar.dart';
import '../userName_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String number;
  final String email;
  final String password;
  final bool isupdate;


  const VerificationScreen(
      {Key? key,
        this.isupdate=false,
      required this.number,
      required this.password,
      required this.email})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

TextEditingController verification = TextEditingController();

class _VerificationScreenState extends State<VerificationScreen> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    verification.clear();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: GetBuilder<AuthController>(
            init: AuthController(authRepo: AuthRepo(ApiClient())),
            builder: (authController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSizes.appHorizontalSm * 2,
                        horizontal: AppSizes.appHorizontalSm * 1.5),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.kGray.withOpacity(0.3),
                        radius: 15,
                        child: const Icon(
                          FontAwesomeIcons.angleLeft,
                          color: AppColors.kBlack,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.appHorizontalSm * 2.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Verify It’s You",
                          style: poppinsSemiBold.copyWith(
                            fontSize:AppSizes.appHorizontalSm*2
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.appHorizontalSm * 1,
                        ),
                         Text(
                          "Enter the verification code we sent to",
                          style:poppinsLight.copyWith(fontSize: AppSizes.appHorizontalSm*1.3,color: AppColors.kgreyText),
                        ),
                        SizedBox(
                          height: AppSizes.appHorizontalSm * 0.5,
                        ),
                        Text(
                          widget.number,
                          style:poppinsLight.copyWith(fontSize: AppSizes.appHorizontalSm*1.3,color: AppColors.kgreyText),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalLg * 1.5,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(Images.verification_img)),
                  SizedBox(
                    height: AppSizes.appVerticalLg * .5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text("Time Remaining : ",style: poppinsRegular.copyWith(fontSize:Dimensions.FONT_SIZE_DEFAULT ),),
                      Text(
                        "$_seconds Sec",
                        style:  poppinsMedium.copyWith(fontSize:Dimensions.FONT_SIZE_EXTRA_LARGE )
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.appVerticalLg * .5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.appHorizontalSm * 3),
                    child: CustomTextField(
                        hintText: "Enter 4 Digit Code",
                        isVerification: true,
                        inputType: TextInputType.phone,
                        controller: verification,
                        prefixIcon:Images.verifiLoock_icon,
                        // const Icon(
                        //   FontAwesomeIcons.lock,
                        //   color: AppColors.black,
                        // ),
                        suffixIcon: const Icon(Icons.add_circle)),
                  ),
                  SizedBox(
                    height: AppSizes.appHorizontalLg * 1,
                  ),
                  (!authController.isLoading)?  Container(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            _verification(authController);
                            // Get.to(() => const UserNameScreen());
                          },
                          child: const CircularButton(
                            text: 'Verify Code',
                          ))):const Center(child:  const CircularProgressIndicator()),
                  SizedBox(
                    height: AppSizes.appHorizontalLg * 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "Didn’t Receive Code?",
                        style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      ),
                      InkWell(
                        onTap: (){
                          if(_seconds >= 0 ){
                            print("=====================");
                            _resendCode(authController);
                          }
                        },
                        child: Text(
                          " ${'resend'.tr}${_seconds > 0 ? ' ($_seconds)' : ''}",
                          style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,color: AppColors.kTextColor),
                        ),
                      )
                    ],
                  )
                ],
              );
            }),
      ),
    ));
  }

  void _verification(AuthController authController) async {

    String _verification = verification.text.trim();
    if (_verification.isEmpty) {
      showCustomSnackBar('enter_verification_code'.tr);
    } else if (_verification.length < 4) {
      showCustomSnackBar('_verification_should_be 4'.tr);
    } else if (_verification!=MyRepo.verificationCodeModel.value.data!.verificationCode) {
      showCustomSnackBar('_verification_is_invalid'.tr);
    }else if(widget.isupdate) {
      var box=GetStorage();
      String _userID=box.read(AppConstants.USERID).toString();
      authController.updatePhone(_userID, widget.number,).then((status) async {
        // authController.signup(_email, _phone,_password).then((status) async {
        print("==status:${status.isSuccess}==");
        if (status.isSuccess) {
          Get.offAllNamed(RouteHelper.getDashboardRoute());
        }else {
          showCustomSnackBar(status.message);
        }
      });

    }else{
      authController.signup(widget.email, widget.number,widget.password).then((status) async {
        print("==status:${status.isSuccess}==");
        if (status.isSuccess) {
          Get.to(()=>const UserNameScreen());
          // Get.offAllNamed(RouteHelper.getDashboardRoute());
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
  void _resendCode(AuthController authController) async {

      authController.verifydata(widget.email, widget.number,).then((status) async {
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
              showCustomSnackBar(status.message);
          //   }
          // });
          // Get.to(()=>VerificationScreen(number: _phone,email:_email,password: _password,));

          // Get.offAllNamed(RouteHelper.VerificationScreen(_phone));
        }else {
          showCustomSnackBar(status.message);
        }
      });

  }
}
