import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<ConfigController>().removeSharedData();
      // TODO: Auth Login
    }else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
