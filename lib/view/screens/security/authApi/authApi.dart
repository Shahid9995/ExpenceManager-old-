import 'package:local_auth/local_auth.dart';

class AuthApiClass {
  final LocalAuthentication auth = LocalAuthentication();
  // _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  Future<bool> checkBio(){
    return
    auth.isDeviceSupported();
  }

}