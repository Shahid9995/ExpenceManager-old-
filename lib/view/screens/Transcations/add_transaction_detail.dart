import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/view/base/custom_text_field.dart';
import 'package:expensemanage_app/view/screens/Transcations/widgets/TranctionTypeDropDown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/UserRepo.dart';
import '../../../core/viewModel/Scaffold/AppScafflod.dart';
import '../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_constants.dart';
import '../../../util/primary_button.dart';
import '../../base/custom_snackbar.dart';

class AddTransactionDetails extends StatefulWidget {

  const AddTransactionDetails({Key? key,}) : super(key: key);

  @override
  State<AddTransactionDetails> createState() => _AddTransactionDetailsState();
}

TextEditingController amount = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController date = TextEditingController();
TextEditingController currency = TextEditingController();
UserDataController userDataController = UserDataController(userRepo: UserRepo(ApiClient()));
// String _date=DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));
String _date=DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString()));

class _AddTransactionDetailsState extends State<AddTransactionDetails> {
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
  RxBool loading=false.obs;
  @override
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
      heading: 'Transaction Details',
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

                const Text("Transaction Type"),
                SizedBox(
                  height: AppSizes.appHorizontalSm,
                ),
                const TransTypeDropDown(),
                SizedBox(
                  height: AppSizes.appHorizontalSm,
                ),
                const Text("Transaction Amount"),
                SizedBox(
                  height: AppSizes.appHorizontalSm,
                ),
                CustomTextField(
                    hintText: "Amount",
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
                const Text("Date"),
                SizedBox(
                  height: AppSizes.appHorizontalSm,
                ),
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
                  return  (!loading.value)? Container(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: (){
                            _saveReceipt(userDataController);
                          },
                          child: const PrimaryButton(text: 'Save',))):const Center(child: Center(child: CircularProgressIndicator()));
                })

              ],
            ),
          ),
        ),
      ),
    );
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
    }
    else {
      loading.value=true;
      userDataController.transaction( userId,_amount,_transId,_desc,_date,_currency).then((status) async {
        loading.value=false;
        print("=Dashboard=status:${status}=========");
        if (status.isSuccess) {
        Get.back();
        //   // if (authController.isActiveRememberMe) {
        //   //   authController.saveUserNumberAndPassword(_email, _password);
        //   // } else {
        //   //   authController.clearUserNumberAndPassword();
        //   // }
        //   // await Get.find<AuthController>().getProfile();
        //   // showCustomSnackBar(status.message);
        //   // Get.offAllNamed(RouteHelper.getDashboardRoute());
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }

}
