import 'dart:io';

import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/UserRepo.dart';
import '../../../core/viewModel/Scaffold/AppScafflod.dart';
import '../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_constants.dart';
import '../../../util/primary_button.dart';
import '../../base/custom_snackbar.dart';

class AddProductDetails extends StatefulWidget {
  final File? img;
  const AddProductDetails({Key? key,required this.img}) : super(key: key);

  @override
  State<AddProductDetails> createState() => _AddProductDetailsState();
}

TextEditingController tittle = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController price = TextEditingController();
TextEditingController currency = TextEditingController();
UserDataController userDataController = UserDataController(userRepo: UserRepo(ApiClient()));
RxBool loading=false.obs;

class _AddProductDetailsState extends State<AddProductDetails> {
  @override
  void dispose() {
    tittle.clear();
    description.clear();
    price.clear();
    currency.clear();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
      heading: 'Product Details',
      body: Expanded(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.appHorizontalSm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: AppSizes.appHorizontalSm * 2,
                ),
                const Text("Product Tittle"),
                SizedBox(
                  height: AppSizes.appHorizontalSm,
                ),
                CustomTextField(
                    hintText: "Tittle",
                    isSuffixIcon: false,
                    isprefixIcon: false,
                    controller: tittle,
                    prefixIcon:"null",
                    suffixIcon: const Icon(Icons.contact_phone_sharp)),
                SizedBox(
                  height: AppSizes.appHorizontalSm * 2,
                ),
                const Text("Product Description"),
                SizedBox(
                  height: AppSizes.appHorizontalSm,
                ),
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
                    hintText: "Description",
                    fillColor: AppColors.kWhite,
                    // fillColor: Theme.of(context).cardColor,
                    // hintStyle: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).hintColor),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: AppSizes.appHorizontalSm * 2,
                ),
                const Text("Product Price"),
                SizedBox(
                  height: AppSizes.appHorizontalSm,
                ),
                CustomTextField(
                    hintText:"Price",
                    inputType: TextInputType.number,
                    isSuffixIcon: false,
                    isprefixIcon: false,
                    controller: price,
                    prefixIcon: "null",
                    suffixIcon: const Icon(Icons.contact_phone_sharp)),
                SizedBox(
                  height: AppSizes.appHorizontalSm * 2,
                ),
                const Text("Price Currency"),
                SizedBox(
                  height: AppSizes.appHorizontalSm,
                ),
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
                Obx(() {
                  return  ( !loading.value)?Container(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: (){
                            _saveReceipt(userDataController);
                          },
                          child: const PrimaryButton(text: 'Save',))):Center(child: CircularProgressIndicator());
                })

              ],
            ),
          ),
        ),
      ),
    );
  }
  void _saveReceipt(UserDataController userDataController) async {
    String Tittle = tittle.text.trim();
    String Desc = description.text.trim();
    String Price = price.text.trim();
    String Currency = currency.text.trim();
    var box = GetStorage();
    String userId = box.read(AppConstants.USERID).toString();

    if (userId.isEmpty) {
      // Get.offAllNamed(RouteHelper.getSignInRoute());
      showCustomSnackBar('Login Again'.tr);
    } else if (widget.img == null) {
      showCustomSnackBar('Image_Not_Selected'.tr);
    } else {
      loading.value=true;
      userDataController.postProductData( widget.img,userId,AppConstants.SAVEPRODUCT_URI,Tittle,Desc,Price,Currency).then((status) async {
        loading.value=false;
        print("=Dashboard=status:${status}=========");

        // if (status.isSuccess) {
        Get.back();
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
