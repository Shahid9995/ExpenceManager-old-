import 'dart:io';

import 'package:expensemanage_app/core/viewModel/Scaffold/AppScafflod.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/view/screens/scanReceipt/scan_receipt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/MyRepo.dart';
import '../../../core/repository/UserRepo.dart';
import '../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/primary_button.dart';
import '../../../util/styles.dart';
import '../../base/custom_nofificationbar.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../Transcations/widgets/TranctionTypeDropDown.dart';

class AddNewReciept extends StatefulWidget {
  const AddNewReciept({Key? key}) : super(key: key);

  @override
  State<AddNewReciept> createState() => _AddNewRecieptState();
}

class _AddNewRecieptState extends State<AddNewReciept> {
  TextEditingController amount=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController date=TextEditingController();
  TextEditingController currency=TextEditingController();
  String _date=DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));

  UserDataController userDataController = UserDataController(userRepo: UserRepo(ApiClient()));
    File? _image;
    RxBool loading=false.obs;
    RxBool addDetails=false.obs;
  @override
  void initState() {
    userDataController.transType();
    // TODO: implement initState
    super.initState();
  }
  void dispose() {
    MyRepo.transtypeName.value="Select Transaction type";
    MyRepo.transtypeID.value="-1";
    amount.clear();
    description.clear();
    date.clear();
    currency.clear();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
        heading: "Scan Receipt",
        body: Expanded(
          child: Container(
            color: AppColors.kAppbarColor,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      // height: double.infinity,
                      // width: double.infinity,
                      margin: EdgeInsets.only(top: AppSizes.appHorizontalSm),
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
                              width: 100,
                            ),
                            SizedBox(
                              height: AppSizes.appHorizontalSm * 2,
                            ),
                            Obx((){
                              return (addDetails.value)?
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalMd),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: AppSizes.appHorizontalSm * 2,
                                            ),

                                            const Text("Transaction Type"),
                                            SizedBox(
                                              height: AppSizes.appHorizontalSm,
                                            ),
                                            const TransTypeDropDown(),
                                            SizedBox(
                                              height: AppSizes.appHorizontalSm,
                                            ),
                                            const Text("Transaction Amount"),

                                            CustomTextField(
                                                hintText: "Type here",
                                                inputType: TextInputType.number,
                                                isSuffixIcon: false,
                                                isprefixIcon: false,
                                                controller: amount,
                                                prefixIcon:"null",
                                                suffixIcon: const Icon(Icons.contact_phone_sharp)),
                                            SizedBox(
                                              height: AppSizes.appHorizontalSm * 2,
                                            ),
                                            const Text("Transaction Description"),

                                            TextField(
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              controller: description,
                                              decoration:  InputDecoration(
                                                // focusedBorder :Border(),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: AppColors.kBlack.withOpacity(0.2)),
                                                ),
                                                focusedBorder: const UnderlineInputBorder(
                                                  borderSide: BorderSide(color: AppColors.kPrimary),
                                                ),
                                                isDense: true,
                                                hintText: "Type here",
                                                fillColor: AppColors.kWhite,
                                                // fillColor: Theme.of(context).cardColor,
                                                // hintStyle: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).hintColor),
                                                filled: true,
                                              ),
                                            ),
                                            SizedBox(
                                              height: AppSizes.appHorizontalSm * 2,
                                            ),
                                            const Text("Date"),

                                            InkWell(
                                              onTap: (){
                                                show_DatePicker(context);
                                              },
                                              child: CustomTextField(
                                                  isEnabled: false,
                                                  hintText:"Price",
                                                  inputType: TextInputType.number,
                                                  isSuffixIcon: false,
                                                  isprefixIcon: false,
                                                  controller: date..text="$_date",
                                                  prefixIcon: "null",
                                                  suffixIcon: const Icon(Icons.contact_phone_sharp)),

                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 1,
                                              color: AppColors.kBlack.withOpacity(0.2),
                                            ),
                                            SizedBox(
                                              height: AppSizes.appHorizontalSm * 2,
                                            ),
                                            const Text("Price Currency"),
                                            CustomTextField(
                                                hintText:"\$",
                                                // inputType: TextInputType.number,
                                                isSuffixIcon: false,
                                                isprefixIcon: false,
                                                controller: currency..text="\$",
                                                prefixIcon: "null",
                                                suffixIcon: const Icon(Icons.contact_phone_sharp)),
                                            SizedBox(
                                              height: AppSizes.appHorizontalMd*2,
                                            ),
                                            (!loading.value)? Container(
                                              padding: const EdgeInsets.only(bottom: 15),
                                                alignment: Alignment.center,
                                                child: InkWell(
                                                    onTap: (){
                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                      // print("======${ MyRepo.transtypeID.value}=======");
                                                      _saveReceipt(userDataController);
                                                    },
                                                    child: const
                                                    PrimaryButton(text: 'Save',))):
                                            const Center(child: Center(child: CircularProgressIndicator()))
                                          ],
                                        ),
                                        // Container(child: Image.file(File(_image!.path)),),

                                      ],
                                    ),
                                  ),
                                ),
                              ):
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Scan Receipt",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: AppSizes.appHorizontalSm * 2),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal:  AppSizes.appHorizontalMd,vertical: AppSizes.appHorizontalSm),
                                          child: Text(
                                            "Place the recipts inside the frame to scan please avoid shake to get result quickly",textAlign: TextAlign.center,
                                            style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,color: AppColors.kgreyText),
                                          ),
                                        ),
                                      ],
                                    ),

                                    if (_image != null) Expanded(
                                      child: SingleChildScrollView(
                                        child: SizedBox(
                                            height: 350,
                                            child: Image.file(_image!)),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(bottom: AppSizes.appHorizontalMd*3,top: AppSizes.appHorizontalSm),
                                      child: InkWell(
                                          onTap: () {
                                            (_image != null)
                                                ? addDetails.value=true
                                                : showModalBottomSheet(
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
                                          },
                                          child: PrimaryButton(
                                            text: (_image != null)
                                                ? "Save"
                                                : 'Scan',
                                          )),
                                    )
                                    // Container(child: Image.file(File(_image!.path)),),

                                  ],
                                ),
                              );
                            })

                          ],
                        )

                  ),
                ),
              ],
            ),
          ),
        ));
  }
  Future pickImage(ImageSource source) async {
    // final InputImage inputImage;
    final image = await ImagePicker().pickImage(source: source,maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50);
    if (image != null) {
      // inputImage=InputImage.fromFilePath(image.path);
      // final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      // final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      // String text = recognizedText.text;
      // for (TextBlock block in recognizedText.blocks) {
      //   final Rect rect = block.rect;
      //   final List<Offset> cornerPoints = block.cornerPoints;
      //   final String text = block.text;
      //   final List<String> languages = block.recognizedLanguages;
      //
      //   for (TextLine line in block.lines) {
      //     // Same getters as TextBlock
      //     for (TextElement element in line.elements) {
      //       // Same getters as TextBlock
      //     }
      //   }
      // }
      print("=Image=${image.path}==============");
      // print("=text=${text}==============");
      setState(() {
        this._image = File(image.path);

      });
    } else {}
  }

  void _saveReceipt(UserDataController userDataController) async {
    String _amount = amount.text.trim();
    String _desc = description.text.trim();
    String _date = date.text.trim();
    String _currency = currency.text.trim();
    String _transId = MyRepo.transtypeID.value;

    var box = GetStorage();
    String userId = box.read(AppConstants.USERID).toString();

    if (userId.isEmpty) {
      // Get.offAllNamed(RouteHelper.getSignInRoute());
      showCustomSnackBar('Login Again'.tr);
    }
    else if (_amount.isEmpty) {
      showCustomSnackBar('amount_isEmpty'.tr);
    }else if (_desc.isEmpty) {
      showCustomSnackBar('transaction_description_not_added '.tr);
    }else if (_transId=="-1") {
      showCustomSnackBar('transaction_type_not_selected '.tr);
    } else {
      loading.value=true;
      userDataController.postImageData( _image,userId,AppConstants.TRANSSAVE_URI,_transId,_amount,_currency,_date,_desc).then((status) async {
        // Get.back();
        loading.value=false;
        print("=Dashboard=status:${status}=========");
        if(box.read(AppConstants.transaction_alert)!="false"){
          showCustomNotificationBar("Transaction Added Successfully");
        }

        Get.off(const ScaneReceipts());
        // if (status.isSuccess) {

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
  void show_DatePicker(BuildContext context,)async {
    String date=DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025)
    );
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != date) {
      date = DateFormat('yyyy-MM-dd').format(DateTime.parse(picked.toString()));
      _date=date;
      setState(() {
      });
    }
  }
}
