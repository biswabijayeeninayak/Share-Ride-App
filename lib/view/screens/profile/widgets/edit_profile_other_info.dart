import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

class EditProfileOtherInfo extends StatelessWidget {
  const EditProfileOtherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController){
      return Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              const SizedBox(height: Dimensions.paddingSizeSmall,),

              Text('saved_address'.tr,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color:Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: TextFieldTitle(title: 'home'.tr),
              ),
              CustomTextField(
                  prefixIcon: Images.editProfileHome,
                  borderRadius: 10,
                  showBorder: false,
                  hintText: 'enter_your_address'.tr,
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.04)
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                child: TextFieldTitle(title: 'office'.tr),
              ),
              CustomTextField(
                  prefixIcon: Images.editProfilePhone,
                  borderRadius: 10,
                  showBorder: false,
                  hintText: 'enter_your_address'.tr,
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.04)
              ),

              TextFieldTitle(title: 'identification_number'.tr,textOpacity: 0.8,),
              CustomTextField(
                  prefixIcon: Images.editProfileIdentity,
                  borderRadius: 10,
                  showBorder: false,
                  hintText: 'enter_your_identification_number'.tr,
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.04)
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  GestureDetector(
                    onTap: ()=> userController.pickImage(false, false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                      child: Align(alignment: Alignment.center, child:
                      DottedBorder(
                        color: Theme.of(context).hintColor,
                        dashPattern: const [3,4],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(Dimensions.paddingSizeSmall),
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                            child: userController.pickedIdentityImageFront != null ?  Image.file(File(userController.pickedIdentityImageFront!.path),
                              width: Dimensions.identityImageWidth, height: Dimensions.identityImageHeight, fit: BoxFit.cover,
                            ) :SizedBox(height: Dimensions.identityImageHeight,
                              width: Dimensions.identityImageWidth,
                              child: Image.asset(Images.cameraPlaceholder,width: 50),
                            ),
                          ),
                          Positioned(
                            bottom: 0, right: 0, top: 0, left: 0,
                            child: InkWell(
                              // onTap: () => authProvider.pickImage(true,false, false),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                ),

                              ),
                            ),
                          ),
                        ]),
                      )),
                    ),
                  ),

                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  GestureDetector(
                    onTap: ()=> userController.pickImage(true, false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                      child: Align(alignment: Alignment.center, child:
                      DottedBorder(
                        color: Theme.of(context).hintColor,
                        dashPattern: const [3,4],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(Dimensions.paddingSizeSmall),
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                            child: userController.pickedIdentityImageBack != null ?  Image.file(File(userController.pickedIdentityImageBack!.path),
                              width: Dimensions.identityImageWidth, height: Dimensions.identityImageHeight, fit: BoxFit.cover,
                            ) :SizedBox(height: Dimensions.identityImageHeight,
                              width: Dimensions.identityImageWidth,
                              child: Image.asset(Images.cameraPlaceholder,width: 50,),
                            ),
                          ),
                          Positioned(
                            bottom: 0, right: 0, top: 0, left: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                              ),

                            ),
                          ),
                        ]),
                      )),
                    ),
                  ),
                ],),
              ),
            ]),
          )),

          const SizedBox(height:30),
          CustomButton (
            buttonText:"update_profile".tr,
            onPressed: ()=> Get.back(),
          )
        ],
      );
    });
  }
}
