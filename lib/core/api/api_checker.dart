
import 'package:get/get.dart';

import '../../view/base/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {

    }else {
      showCustomSnackBar("");
    }
  }
}
