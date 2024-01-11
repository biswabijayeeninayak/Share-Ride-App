import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/view/screens/auth/model/sign_up_body.dart';
import 'package:ride_sharing_user_app/view/screens/auth/repository/auth_repo.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/bottom_menu_controller.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  var isActiveTerms;
  bool? _isLoading = false;
  bool _acceptTerms = false;
  bool? get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;

  final String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;

  XFile? _pickedProfileFile;
  XFile? get pickedProfileFile => _pickedProfileFile;

  XFile? _pickedIdentityImageFront;
  XFile? get pickedIdentityImageFront => _pickedIdentityImageFront;
  XFile? _pickedIdentityImageBack;
  XFile? get pickedIdentityImageBack => _pickedIdentityImageBack;

  TextEditingController userNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();

  TextEditingController signInPhoneController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  TextEditingController forgetPasswordPhoneController = TextEditingController();
  TextEditingController changePasswordPhoneController = TextEditingController();

  FocusNode userNameNode = FocusNode();
  FocusNode signupPhoneNode = FocusNode();
  FocusNode signInPhoneNode = FocusNode();
  FocusNode forgetPasswordPhoneNode = FocusNode();
  FocusNode changePasswordPhoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode signInPasswordNode = FocusNode();
  FocusNode signupConfirmPasswordNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode identityNumberNode = FocusNode();

  String _verificationCode = '';
  String _otp = '';
  String get otp1 => _otp;
  // String get otp2 => _otp;
  // String get otp3 => _otp;
  // String get otp4 => _otp;

  String get verificationCode => _verificationCode;

  void pickImage(bool isBack, bool isProfile) async {
    if (isBack) {
      _pickedIdentityImageBack =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    } else if (isProfile) {
      _pickedProfileFile =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    } else {
      _pickedIdentityImageFront =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    }
    update();
  }

  Future<void> login(String phone) async {
    _isLoading = true;
    update();
    _navigateLogin(phone);
    _isLoading = false;
    update();
  }

  Future<void> Register(SignUpBody signUpBody) async {}

  _navigateLogin(String phone) {
    if (_isActiveRememberMe) {
      saveUserNumber(phone);
    } else {
      clearUserNumber();
    }
    Get.find<BottomMenuController>().resetNavBar();
    Get.to(() => const DashboardScreen());
  }

  Future<void> forgetPassword() async {
    _isLoading = true;
    update();
    Response? response =
        await authRepo.forgetPassword(signupPhoneController.text);
    if (response!.body['response_code'] == 'default_200') {
      _isLoading = false;
      customSnackBar('successfully_sent_otp'.tr, isError: false);
    } else {
      _isLoading = false;
      customSnackBar('invalid_number'.tr);
    }
    update();
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<void> verifyToken(String phoneOrEmail) async {
    //Response? response = await authRepo.verifyToken(phoneOrEmail, _verificationCode);

    _isLoading = false;
    update();
  }

  Future<void> resetPassword(String phoneOrEmail) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(
        _mobileNumber,
        _otp,
        "newPasswordController.value.text",
        "confirmNewPasswordController.value.text");
    if (response!.body['response_code'] == 'default_password_reset_200') {
      customSnackBar('password_change_successfully'.tr, isError: false);
    } else {
      customSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }

  void updateVerificationCode(String query) {
    _verificationCode = query;
    if (_verificationCode.isNotEmpty) {
      _otp = _verificationCode;
    }
    update();
  }

  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void setRememberMe() {
    _isActiveRememberMe = true;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return authRepo.clearSharedData();
  }

  void saveUserNumber(String phone) {
    authRepo.saveUserNumber(phone);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  bool isNotificationActive() {
    return authRepo.isNotificationActive();
  }

  void toggleNotificationSound() {
    authRepo.toggleNotificationSound(!isNotificationActive());
    update();
  }

  Future<bool> clearUserNumber() async {
    return authRepo.clearUserNumber();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  Future<void> setUserToken(String token) async {
    authRepo.saveUserToken(token);
  }

  Future<void> verify(String otp) async {
    var headers = {'Content-Type': 'application/json'};
    var requestBody = {
      'otp1': otp1,
      // 'otp2': otp2,
      // 'otp3': otp3,
      // 'otp4': otp4,
    };

    var request = http.Request(
        'POST', Uri.parse('http://kods.tech/munsride/api/verifyriderotp'));

    request.headers.addAll(headers);
    request.body = jsonEncode(requestBody);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      customSnackBar('Successfully Loged In');
      Get.find<BottomMenuController>().selectHomePage();
      Get.to(DashboardScreen());
    } else {
      customSnackBar('Invalid OTP');
      print('Error Response: ${await response.stream.bytesToString()}');
    }
  }
}
