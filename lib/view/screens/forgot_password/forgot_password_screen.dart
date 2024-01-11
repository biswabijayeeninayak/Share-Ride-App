import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/forgot_password/reset_password_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';



class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String countryDialCode = CountryCode.fromCountryCode("BD").dialCode!;
  @override
  void initState() {
    Get.find<AuthController>().forgetPasswordPhoneController.text = countryDialCode;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomBody(
        appBar: CustomAppBar(title: 'forget_password'.tr),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeLarge),
            child: GetBuilder<AuthController>(builder: (authController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.verification,
                    width: 120,
                  ),

                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                  Text('enter_verification_code'.tr,style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
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
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                        selectedFillColor: Get.isDarkMode?Colors.grey.withOpacity(0.6):Colors.white,
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

                      pastedTextStyle: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('did_not_receive_the_code'.tr,style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.6)),),
                        TextButton(
                          onPressed: (){
                            showCustomSnackBar('otp_sent_successfully'.tr, isError: false);
                          },
                          child: Text(
                            'resend_it'.tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.end,),),
                      ]) ,

                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

                  authController.verificationCode.length == 4 ? !authController.isLoading! ? Padding(
                    padding:  const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge,),
                    child: CustomButton(
                      buttonText: 'send'.tr,
                      radius: 50,
                      onPressed: () {
                        Get.to(()=>const ResetPasswordScreen());

                      },
                    ),
                  ) : const Center(child: CircularProgressIndicator()) : const SizedBox.shrink(),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                ],);
            }),
          ),
        ),
      ),
    );
  }
}
