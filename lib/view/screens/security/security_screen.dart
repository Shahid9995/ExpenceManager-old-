import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/primary_button.dart';
import 'package:expensemanage_app/view/screens/changepassword/changepasswor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/viewModel/Scaffold/AppScafflod.dart';
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  var box =GetStorage();
  final LocalAuthentication auth = LocalAuthentication();
  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        box.write(AppConstants.KEY_LOCAL_AUTH_ENABLED, "true");
        print("authenticated:$authenticated");
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }
  // final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),

    );
  }
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return AppScafflod(
      heading: 'Security',
      body: Container(
        padding: EdgeInsets.only(top: AppSizes.appHorizontalXL),
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_supportState == _SupportState.unknown)
              const CircularProgressIndicator()
            else if (_supportState == _SupportState.supported)
                     InkWell(
        onTap: (){
          _authenticateWithBiometrics();


        },
        // async {
        //
        //   // if (await auth.canCheckBiometrics){
        //   //   // Ask for enable biometric auth
        //   //   showModalBottomSheet<void>(
        //   //     context: context,
        //   //     builder: (BuildContext context) {
        //   //       return EnableLocalAuthModalBottomSheet(action: _onEnableLocalAuth);
        //   //     },
        //   //   );
        //   // }else{
        //   //   showCustomSnackBar("Phone_Not_Supported");
        //   // }
        //   Get.to(()=>const DemoFingerPrint());
        // },
        child: const PrimaryButton(text: "Set Fingerprint"))
            else
              Container(),
            SizedBox(
              height: AppSizes.appHorizontalLg,
            ),
            InkWell(
              onTap: (){

              },
                child: const PrimaryButton(text: "Set Pattern")),
            SizedBox(
              height: AppSizes.appHorizontalLg,
            ),
            InkWell(
              onTap: (){
                Get.to(()=>ChangePasswordScreen());
              },
                child: const PrimaryButton(text: "Change Password")),
          ],
        ),
      ),
    );
  }
  _onEnableLocalAuth() async {
    var box=GetStorage();

    // Save
    await box.write( AppConstants.KEY_LOCAL_AUTH_ENABLED, "true");

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Fingerprint authentication enabled."),
    ));
  }

}
