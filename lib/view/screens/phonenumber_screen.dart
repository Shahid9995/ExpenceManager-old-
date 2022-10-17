import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/dimensions.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:expensemanage_app/view/base/custom_text_field.dart';
import 'package:expensemanage_app/view/screens/verification/verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../core/viewModel/Scaffold/AppScafflod.dart';
import '../../util/images.dart';
import '../../util/primary_button.dart';
import '../base/custom_snackbar.dart';


class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}
TextEditingController userPhone =TextEditingController();
class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  @override
  void dispose(){
    userPhone.clear();
  }
  @override
  Widget build(BuildContext context) {
    return AppScafflod(heading: "Enter Phone Number",
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*2.5,vertical: AppSizes.appHorizontalSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  const EdgeInsets.only(left: 10),
              child: Text("Enter Phone Number",style:poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),),
            ),
            SizedBox(
              height: AppSizes.appHorizontalSm*1.5,
            ),
            CustomTextField(
              hintText: "+92000000",
                inputType: TextInputType.phone,
                isVerification: true,
                controller: userPhone,
                // isPassword: true,
                prefixIcon:Images.mobile_icon, suffixIcon:const Icon(FontAwesomeIcons.eye )),
            SizedBox(
              height: AppSizes.appHorizontalXXL*3,
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: (){
                  _update();
                  // Get.to(()=>ChangePasswordScreen());
                },
                child: const PrimaryButton(text: 'Save',
                width: 250,),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _update() async {

    String _userPhone = userPhone.text.trim();
    if (_userPhone.isEmpty) {
      showCustomSnackBar('enter_Phone_Number'.tr);
    }
    else {
      Get.to(()=>VerificationScreen(number: userPhone.text,email:"",password: "",isupdate: true,));
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
