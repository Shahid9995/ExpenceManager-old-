
import 'dart:io';

import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:expensemanage_app/view/screens/ScanCard/scaned_cards.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/UserRepo.dart';
import '../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/primary_button.dart';
import '../../base/custom_nofificationbar.dart';
import '../../base/custom_snackbar.dart';
import '../../base/my_text_field.dart';

class AddNewCards extends StatefulWidget {
  const AddNewCards({Key? key}) : super(key: key);

  @override
  State<AddNewCards> createState() => _AddNewCardsState();
}

class _AddNewCardsState extends State<AddNewCards> {
  UserDataController userDataController = UserDataController(userRepo: UserRepo(ApiClient()));
  TextEditingController name=TextEditingController();
  TextEditingController cardNumber=TextEditingController();
  TextEditingController cvv=TextEditingController();
  TextEditingController date=TextEditingController();
  RxBool toVerifyData=false.obs;
  RxBool loading=false.obs;
  String _date='MM-yy';
  void show_DatePicker(BuildContext context,)async {
    // String date=DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );
    // ignore: unrelated_type_equality_checks
    if (selected != null ) {
     String date = DateFormat('MM-yy').format(DateTime.parse(selected.toString()));
      _date=date;
      setState(() {
      });
    }
  }
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: AppSizes.appHorizontalMd*2.2,left: AppSizes.appHorizontalSm*1.2,),
              height: 100,
              decoration: const BoxDecoration(
                  color: AppColors.kAppbarColor
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Icon(FontAwesomeIcons.angleLeft,color: AppColors.kWhite))),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text((toVerifyData.value)?"Verify Your Info":"Add Card",style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE+2,color: AppColors.kWhite),),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: AppSizes.appHorizontalSm*5,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.kAppbarColor,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        // height: double.infinity,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: AppSizes.appHorizontalSm*2),
                          decoration: const BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: AppSizes.appHorizontalMd,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.kGrayText,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 4,
                                width: 80,
                              ),
                              SizedBox(
                                height: AppSizes.appHorizontalSm * 2,
                              ),
                              Expanded(
                                child:(!toVerifyData.value)?
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: AppSizes.appHorizontalMd,
                                        ),
                                        Text(
                                          "Scan Your Card",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: AppSizes.appHorizontalSm * 2),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalMd*2.5,vertical: AppSizes.appHorizontalSm),
                                          child: Text(
                                            "Place the card inside the frame to scan please avoid shake to get result quickly",textAlign: TextAlign.center,
                                            style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,color: AppColors.kgreyText),
                                          ),
                                        ),
                                      ],
                                    ),
                                    (_image != null)?
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: SizedBox(
                                            height: 350,
                                            child: Image.file(_image!)),
                                      ),
                                    ):Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalMd*1.5),
                                          child: Image.asset(Images.card_img),
                                        ),
                                    // Container(child: Image.file(File(_image!.path)),),
                                     Padding(
                                      padding:  EdgeInsets.only(bottom: AppSizes.appHorizontalMd*2,top: AppSizes.appHorizontalSm),
                                      child: Column(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                if(_image != null){toVerifyData.value=true;
                                                setState(() {

                                                });
                                                }else{
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext
                                                      context) {
                                                        return Wrap(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                pickImage(ImageSource.gallery);
                                                                Navigator.pop(
                                                                    context);
                                                                print("=====gallery============");
                                                              },
                                                              child:
                                                              const ListTile(
                                                                leading: Icon(
                                                                    FontAwesomeIcons
                                                                        .images),
                                                                title: Text(
                                                                    "Gallery"),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: ()  {
                                                                pickImage(ImageSource.camera);
                                                                Navigator.pop(context);
                                                                print(
                                                                    "=====camera============");
                                                              },
                                                              child:
                                                              const ListTile(
                                                                leading: Icon(
                                                                    FontAwesomeIcons
                                                                        .camera),
                                                                title: Text(
                                                                    "Camera"),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }

                                              },
                                              child: PrimaryButton(
                                                text: (_image != null)
                                                    ? "Save"
                                                    : 'Scan',
                                              )),
                                          SizedBox(
                                            height: Dimensions.FONT_SIZE_DEFAULT+1,
                                          ),
                                          TextButton(onPressed: (){
                                            Get.off(const ScanCards());
                                          },
                                              child: Text("View All Scanned Card",style: poppinsMedium.copyWith(fontSize: 14,color: AppColors.kBlack),))
                                        ],
                                      ),
                                    )

                                  ],
                                ):
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalMd*1.5,vertical: AppSizes.appHorizontalSm ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (_image != null) Center(
                                                child: SizedBox(
                                                    height: 200,
                                                    child: Image.file(_image!)),
                                              ),
                                              const SizedBox(
                                                height: Dimensions.PADDING_SIZE_DEFAULT*2,
                                              ),
                                              Text(
                                                "Name on card",
                                                style: poppinsRegular.copyWith(
                                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,color: AppColors.kBlack
                                                ),
                                              ),
                                              MyTextField(
                                                hintText: "Type here",
                                                controller: name,
                                                // suffixIcon: "null",
                                                suffixIcon: Images.card_user,
                                                prefixIcon: "null",
                                              ),
                                              const SizedBox(
                                                height: Dimensions.PADDING_SIZE_DEFAULT*2,
                                              ),
                                              Text(
                                                "Card Number",
                                                style: poppinsRegular.copyWith(
                                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,color: AppColors.kBlack
                                                ),
                                              ),
                                              MyTextField(
                                                padding: 1.5,
                                                inputType: TextInputType.number,
                                                hintText: "Type here",
                                                controller: cardNumber,
                                                // suffixIcon: "null",
                                                suffixIcon: Images.credit_card,
                                                prefixIcon: "null",
                                              ),
                                              const SizedBox(
                                                height: Dimensions.PADDING_SIZE_DEFAULT*2,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Expiry date",
                                                            style: poppinsRegular.copyWith(
                                                                fontSize: Dimensions.FONT_SIZE_DEFAULT,color: AppColors.kBlack
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: (){
                                                              show_DatePicker(context);
                                                            },
                                                            child: MyTextField(
                                                              padding: 1.7,
                                                              isEnabled: false,
                                                              hintText: "",
                                                              controller: date..text="$_date",
                                                              // suffixIcon: "null",
                                                              suffixIcon: Images.calander,
                                                              prefixIcon: "null",
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 1,
                                                            color: AppColors.kBlack.withOpacity(0.2),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: Dimensions.PADDING_SIZE_DEFAULT*2
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "CVV",
                                                            style: poppinsRegular.copyWith(
                                                                fontSize: Dimensions.FONT_SIZE_DEFAULT,color: AppColors.kBlack
                                                            ),
                                                          ),
                                                          MyTextField(
                                                            padding: 1.7,
                                                            hintText: "000",
                                                            inputType: TextInputType.number,
                                                            controller: cvv,
                                                            // suffixIcon: "null",
                                                            suffixIcon: Images.card_lock,
                                                            prefixIcon: "null",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                                // crossAxisAlignment: ,
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Container(child: Image.file(File(_image!.path)),),
                                    (!loading.value) ? Padding(
                                      padding:  EdgeInsets.only(bottom: AppSizes.appHorizontalMd*2.5),
                                      child: InkWell(
                                          onTap: () {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            _saveCard(userDataController);
                                            },
                                          child: const PrimaryButton(
                                            text: "Confirm",
                                          )),
                                    )
                                        :  Center(
                                        child: Padding(
                                          padding:  EdgeInsets.only(bottom: AppSizes.appHorizontalMd*2.5),
                                          child: const CircularProgressIndicator(),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future pickImage(ImageSource source) async {
    // final InputImage inputImage;
    final image = await ImagePicker().pickImage(source: source,maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50);
    if (image != null) {
      print("=Image=${image.path}==============");
      // print("=text=${text}==============");
      setState(() {
        this._image = File(image.path);

      });
    } else {}
  }

  void _saveCard(UserDataController userDataController) async {
    String _name = name.text.trim();
    String _number =cardNumber.text.trim();
    String _date = date.text.trim();
    String _cvv = cvv.text.trim();


    var box = GetStorage();
    String userId = box.read(AppConstants.USERID).toString();
    if (userId.isEmpty) {
      Get.offAllNamed(RouteHelper.getSignInRoute());
      // showCustomSnackBar('enter_email_address'.tr);
    } else if (_image == null) {
      showCustomSnackBar('Image_Not_Selected'.tr);
    } else if (_name.isEmpty) {
      showCustomSnackBar('enter_name_on_card'.tr);
    }
    else if (_number.isEmpty) {
      showCustomSnackBar('enter_card_number'.tr);
    }
    else if (_date.isEmpty) {
      showCustomSnackBar('select_expire_date'.tr);
    }
    else if (_cvv.isEmpty) {
      showCustomSnackBar('enter_cvv_number'.tr);
    }
    else {
      loading.value=true;
      userDataController.postCardData( _image,userId,AppConstants.SaveCard_URI,_name,_number,_date,_cvv).then((status) async {
        print("=Dashboard=status:${status}=========");
        loading.value=false;
        if(box.read(AppConstants.transaction_alert)!="false"){
          showCustomNotificationBar("Transaction Added Successfully ");
        }
        Get.off(const ScanCards());
        // if (status.isSuccess) {
        // Get.back();
        //   // if (authController.isActiveRememberMe) {
        //   //   authController.saveUserNumberAndPassword(_email, _password);
        //   // } else {
        //   //   authController.clearUserNumberAndPassword();
        //   // }
        //   // await Get.find<AuthController>().getProfile();
        //   // showCustomSnackBar(status.message);
        //   // Get.offAllNamed(RouteHelper.getDashboardRoute());
        // } else {
        //   showCustomSnackBar(status.message);
        // }
      });
    }
  }
}
