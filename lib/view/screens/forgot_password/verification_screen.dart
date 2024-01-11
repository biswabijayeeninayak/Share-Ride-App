import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/dashboard/bottom_menu_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  final String number;
  final bool fromOtpLogin;
  const VerificationScreen(
      {super.key, required this.number, this.fromOtpLogin = false});

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  Timer? _timer;
  int? _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds! - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: 'verification'.tr,
          showBackButton: true,
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge),
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.verification,
                    width: 120,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  Text(
                    'enter_verification_code'.tr,
                    style: textSemiBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  SizedBox(
                    width: 240,
                    child: PinCodeTextField(
                      length: 4,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.slide,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        fieldHeight: 40,
                        fieldWidth: 40,
                        borderWidth: 1,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusDefault),
                        selectedColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        selectedFillColor: Get.isDarkMode
                            ? Colors.grey.withOpacity(0.6)
                            : Colors.white,
                        inactiveFillColor: Theme.of(context).cardColor,
                        inactiveColor: Theme.of(context).hintColor,
                        activeColor: Theme.of(context).hintColor,
                        activeFillColor: Theme.of(context).cardColor,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      onChanged: authController.updateVerificationCode,
                      beforeTextPaste: (text) => true,
                      textStyle: textSemiBold.copyWith(),
                      pastedTextStyle: textRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'did_not_receive_the_code'.tr,
                          style: textMedium.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!
                                  .withOpacity(.6)),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.find<AuthController>().forgetPassword();
                          },
                          child: Text(
                            'resend_it'.tr,
                            style: textMedium.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(.6)),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  authController.verificationCode.length == 4
                      ? !authController.isLoading!
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeExtraLarge,
                              ),
                              child: CustomButton(
                                buttonText: 'continue'.tr,
                                radius: 50,
                                onPressed: () async {
                                  authController
                                      .verify(authController.verificationCode);
                                },
                              ),
                            )
                          : const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  // Future<void> verify() async {
  // String otp = authController.verificationCode;
  // // Validate if the OTP is not empty and has a length of 4 before making the API call
  // if (otp.length == 4) {
  //   try {
  //     // Make the API call to verify the OTP
  //     await authController.verify(otp);
  //     // If successful, navigate to the DashboardScreen
  //     Get.find<BottomMenuController>().selectHomePage();
  //     Get.to(DashboardScreen());
  //   } catch (error) {
  //     // Handle errors, show error message or log the error
  //     print('Error: $error');
  //   }
  // } else {
  //   // Show an error message indicating that the OTP is invalid
  //   print('Invalid OTP');
  // }
}
