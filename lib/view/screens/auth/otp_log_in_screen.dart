import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
// import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_up_screen.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/forgot_password/verification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/html/html_viewer_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

class OtpLoginScreen extends StatefulWidget {
  final bool fromSignIn;
  const OtpLoginScreen({Key? key, this.fromSignIn = false}) : super(key: key);

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  @override
  void initState() {
    phoneController.text = countryDialCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String countryDialCode = CountryCode.fromCountryCode("IN").dialCode!;
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: GetBuilder(builder: (authController) {
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
                      Image.asset(
                        Images.logo,
                        width: 150,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeLarge,
                      ),

                      // Image.asset(Images.otpScreenLogo, width: 150,),
                      // const SizedBox(height: Dimensions.paddingSizeLarge,),
                      Row()
                    ],
                  ),
                  Text(
                    'otp_login'.tr,
                    style: textBold.copyWith(
                      color: Colors.red,
                      fontSize: Dimensions.fontSizeExtraLarge,
                    ),
                  ),
                  Text(
                    'enter_your_phone_number'.tr,
                    style: textRegular.copyWith(
                        color: Theme.of(context).hintColor),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  CustomTextField(
                    hintText: 'phone',
                    inputType: TextInputType.number,
                    countryDialCode: "+91",
                    prefixHeight: 70,
                    controller: phoneController,
                    focusNode: phoneNode,
                    inputAction: TextInputAction.done,
                    onCountryChanged: (CountryCode countryCode) {
                      countryDialCode = countryCode.dialCode!;
                      // authController.forgetPasswordPhoneController.text = countryDialCode;
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  CustomButton(
                    buttonText: 'send_otp'.tr,
                    onPressed: () {
                      String phone = phoneController.text;

                      if (phone.length < 8) {
                        showCustomSnackBar('phone_number_is_not_valid'.tr);
                      } else {
                        Get.to(() => VerificationScreen(
                            number: phone, fromOtpLogin: widget.fromSignIn));
                      }
                    },
                    radius: 50,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall,
                            vertical: 8),
                        child: Text(
                          'or'.tr,
                          style: textRegular.copyWith(
                              color: Theme.of(context).hintColor),
                        ),
                      ),
                      const Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  CustomButton(
                    showBorder: true,
                    borderWidth: 1,
                    transparent: true,
                    buttonText: 'log_in'.tr,
                    onPressed: () {
                      Get.to(() => const SignInScreen());
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
                          // authController.signInPhoneController.clear();
                          // authController.signInPasswordController.clear();
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
                              color: Colors.red,
                              fontSize: Dimensions.fontSizeSmall,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () => Get.to(() => const HtmlViewerScreen()),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Text("terms_and_condition".tr,
                            style: textMedium.copyWith(
                              decoration: TextDecoration.underline,
                              color: Colors.red,
                              fontSize: Dimensions.fontSizeSmall,
                            )),
                      ),
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
}
