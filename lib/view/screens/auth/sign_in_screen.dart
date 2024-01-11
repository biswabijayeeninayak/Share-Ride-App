import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_up_screen.dart';
import 'package:ride_sharing_user_app/view/screens/forgot_password/verification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/html/html_viewer_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  final bool fromSignIn;

  const SignInScreen({Key? key, this.fromSignIn = false}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;

  @override
  void initState() {
    if (Get.find<AuthController>().getUserNumber().isNotEmpty) {
      phoneController.text = Get.find<AuthController>().getUserNumber();
    } else {
      phoneController.text = countryDialCode;
    }
    passwordController.text = Get.find<AuthController>().getUserPassword();

    if (passwordController.text != '') {
      Get.find<AuthController>().setRememberMe();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        Images.icon,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Text(
                    'log_in'.tr,
                    style: textBold.copyWith(
                      color: Color.fromARGB(255, 160, 3, 32),
                      fontSize: Dimensions.fontSizeOverLarge,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    'log_in_message'.tr,
                    style: textMedium.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: Dimensions.fontSizeDefault),
                    maxLines: 2,
                  ),
                  CustomTextField(
                    hintText: 'phone',
                    inputType: TextInputType.number,
                    countryDialCode: "+91",
                    prefixHeight: 70,
                    controller: phoneController,
                    focusNode: phoneNode,
                    onCountryChanged: (CountryCode countryCode) {
                      countryDialCode = countryCode.dialCode!;
                      phoneController.text = countryDialCode;
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          onTap: () => authController.toggleRememberMe(),
                          title: Row(
                            children: [
                              SizedBox(
                                width: 20.0,
                                child: Checkbox(
                                  value: authController.isActiveRememberMe,
                                  onChanged: (bool? isChecked) =>
                                      authController.toggleRememberMe(),
                                ),
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeExtraSmall,
                              ),
                              Text(
                                'remember me'.tr,
                                style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                ),
                              )
                            ],
                          ),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          horizontalTitleGap: 0,
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                    ],
                  ),
                  CustomButton(
                    buttonText: 'send_otp'.tr,
                    backgroundColor: Color.fromARGB(255, 160, 3, 32),
                    onPressed: () async {
                      String phone = phoneController.text;

                      if (phone.length < 8) {
                        showCustomSnackBar('phone_number_is_not_valid'.tr);
                      } else {
                        // Call _login function before navigating to VerificationScreen
                        await _login(phone);
                        // authController.setUserToken('signUpBody').then((value) {
                        //   Get.to(() => const VerificationScreen(number: '',));
                        // });
                      }
                    },
                    radius: 50,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${'do_not_have_an_account'.tr} ',
                        style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignUpScreen());
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text('sign_up'.tr,
                            style: textMedium.copyWith(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 160, 3, 32),
                              fontSize: Dimensions.fontSizeSmall,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  InkWell(
                    onTap: () => Get.to(() => const HtmlViewerScreen()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("terms_and_condition".tr,
                            style: textMedium.copyWith(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 160, 3, 32),
                              fontSize: Dimensions.fontSizeSmall,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

// Default value, change it according to your needs

  int userId = 0;
  String userType = '';
  String userName = '';
  String email = '';
  int userPhone = 0;

  Future<void> _login(String phone) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('${Constant().url}rider_login'));

    String phoneNumberWithoutCode =
        phone.startsWith('+91') ? phone.substring(3) : phone;

    request.body = json.encode({
      "phone": phoneNumberWithoutCode,
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      try {
        // Parse the response data
        var responseData = json.decode(await response.stream.bytesToString());

        // Check if the 'data' key exists in the response
        if (responseData.containsKey('data')) {
          // Save data to shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // Use null-aware operators to handle null values
          userId = responseData['data']['id'] ?? 0;
          userType = responseData['data']['user_type'] ?? '';
          userName = responseData['data']['user_name'] ?? '';
          email = responseData['data']['email'] ?? '';
          userPhone = responseData['data']['phone'] ?? 0;

          prefs.setString('userId', userId.toString());
          prefs.setString('userType', userType);
          prefs.setString('userName', userName);
          prefs.setString('email', email);
          prefs.setInt('phone', userPhone);

          // Navigate to the VerificationScreen
          Get.to(() => const VerificationScreen(number: ''));
        } else {
          customSnackBar('Invalid response format');
        }
      } catch (e) {
        customSnackBar('Error parsing response data: $e');
        print('Error parsing response data: $e');
      }
    } else {
      customSnackBar('Number not registered');
      print('Error: ${response.reasonPhrase}');
      print('Response Body: ${await response.stream.bytesToString()}');
      // You may want to handle the error more appropriately here.
    }
  }
}
