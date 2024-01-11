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
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

class TextFieldTitle extends StatelessWidget {
  final String title;
  final bool showAsterisk;

  const TextFieldTitle(
      {Key? key, required this.title, this.showAsterisk = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
      child: Row(
        children: [
          Text(
            '$title ',
            style: textMedium.copyWith(
              color: Theme.of(context).hintColor, // Change to grey color
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
          if (showAsterisk)
            Text(
              '*',
              style: TextStyle(
                color: Color.fromARGB(255, 160, 3, 32),
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
        ],
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _acceptTerms = false;

  String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;
  @override
  void initState() {
    Get.find<AuthController>().signupPhoneController.text = countryDialCode;
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Images.logo,
                          width: 120,
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'sign_up'.tr,
                      style: textBold.copyWith(
                        color: Color.fromARGB(255, 160, 3, 32),
                        fontSize: Dimensions.fontSizeOverLarge,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraSmall,
                  ),
                  Text(
                    'sign_up_message'.tr,
                    style: textMedium.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldTitle(
                              title: 'User Name'.tr,
                            ),
                            CustomTextField(
                              hintText: 'Enter your user name'.tr,
                              inputType: TextInputType.name,
                              prefixIcon: Images.person,
                              controller: authController.userNameController,
                              focusNode: authController.userNameNode,
                              inputAction: TextInputAction.next,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  TextFieldTitle(
                    title: 'Mobile Number'.tr,
                  ),
                  CustomTextField(
                    hintText: 'Enter your mobile number',
                    inputType: TextInputType.number,
                    countryDialCode: "+91",
                    controller: authController.signupPhoneController,
                    focusNode: authController.signupPhoneNode,
                    inputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  TextFieldTitle(
                    title: 'Email'.tr,
                    showAsterisk: false,
                  ),
                  CustomTextField(
                    hintText: 'Enter your email'.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.email,
                    controller: authController.emailController,
                    focusNode: authController.emailNode,
                    inputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault * 3,
                  ),
                  CheckboxListTile(
                    title: Text(
                      'I accept the terms and conditions',
                      style: TextStyle(fontSize: Dimensions.fontSizeDefault),
                    ),
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CustomButton(
                    buttonText: 'Register'.tr,
                    backgroundColor: Color.fromARGB(255, 160, 3, 32),
                    onPressed: () async {
                      String userName = authController.userNameController.text;
                      String phone = authController.signupPhoneController.text;
                      String email = authController.emailController.text;
                      print(userName);
                      print(phone);
                      print(email);

                      if (userName.isEmpty) {
                        showCustomSnackBar('User name is required'.tr);
                      } else if (phone.isEmpty) {
                        showCustomSnackBar('phone_is_required'.tr);
                      } else if (!_acceptTerms) {
                        showCustomSnackBar(
                            'Please accept the terms and conditions to register.');
                      } else {
                        // Validate phone number
                        String digitsOnly =
                            phone.replaceAll(RegExp(r'[^0-9]'), '');
                        if (digitsOnly.length != 12) {
                          showCustomSnackBar(
                              'Please enter a valid 10-digit phone number.');
                          return;
                        }

                        // Call the Register function with user data
                        await Register("rider", userName, email, phone);

                        // Continue with your existing logic
                        // authController.setUserToken('signUpBody').then((value) {
                        //   Get.to(() => const SignInScreen());
                        // });
                      }
                    },
                    radius: 50,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> Register(
      String userType, String userName, String email, String phone) async {
    print(userType);

    try {
      var url = Uri.parse('${Constant().url}rider_register');

      String phoneNumberWithoutCode =
          phone.startsWith('+91') ? phone.substring(3) : phone;

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "user_type": userType,
          "user_name": userName,
          "email": email,
          "phone": phoneNumberWithoutCode,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Get.to(() => const SignInScreen());
      } else {
        customSnackBar('Registration failed,Number already exist');
        print('Registration failed with status code: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error during registration: $error');
    }
  }
}
