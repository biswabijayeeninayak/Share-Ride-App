import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';


class ResetPasswordScreen extends StatefulWidget {
  final bool fromChangePassword;
  const ResetPasswordScreen({Key? key,  this.fromChangePassword = false}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode oldPasswordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: widget.fromChangePassword? 'change_password'.tr : 'reset_password'.tr, showBackButton: true,centerTitle: true,),
        body: GetBuilder<AuthController>(builder: (authController){
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.fromChangePassword)
                  TextFieldTitle(title: 'old_password'.tr,),
                if(widget.fromChangePassword)
                  CustomTextField(
                    hintText: 'password_hint'.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.password,
                    isPassword: true,
                    controller: oldPasswordController,
                    focusNode: oldPasswordFocus,
                    nextFocus: passwordFocusNode,
                    inputAction: TextInputAction.next,
                  ),

                TextFieldTitle(title: 'new_password'.tr,),
                CustomTextField(
                  hintText: 'password_hint'.tr,
                  inputType: TextInputType.text,
                  prefixIcon: Images.password,
                  isPassword: true,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  nextFocus: confirmPasswordFocusNode,
                  inputAction: TextInputAction.next,
                ),

                TextFieldTitle(title: 'confirm_new_password'.tr,),
                CustomTextField(
                  hintText: '•••••••••••',
                  inputType: TextInputType.text,
                  prefixIcon: Images.password,
                  controller: confirmPasswordController,
                  focusNode: confirmPasswordFocusNode,
                  inputAction: TextInputAction.done,
                  isPassword: true,
                ),

                const SizedBox(height: Dimensions.paddingSizeDefault*3,),
                CustomButton(
                  buttonText: widget.fromChangePassword? 'update'.tr : 'save'.tr,
                  onPressed: (){

                    String password = passwordController.text;
                    String confirmPassword = confirmPasswordController.text;

                    if(password.isEmpty){
                      showCustomSnackBar('password_is_required'.tr);
                    }else if(password.length<8){
                      showCustomSnackBar('minimum_password_length_is_8'.tr);
                    }else if(confirmPassword.isEmpty){
                      showCustomSnackBar('confirm_password_is_required'.tr);
                    }else if(password != confirmPassword){
                      showCustomSnackBar('password_is_mismatch'.tr);
                    }
                    else{
                      showCustomSnackBar('password_reset_successfully'.tr, isError: false);
                      Get.to(()=> const SignInScreen());
                    }
                  },
                  radius: 50,
                ),
              ],
            ),
          );
        }),

      ),
    );
  }
}
