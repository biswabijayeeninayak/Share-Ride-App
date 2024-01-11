import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/theme/theme_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/forgot_password/reset_password_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar:  CustomAppBar(title: 'settings'.tr,showBackButton: true,),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            children: [
              ListTile(
                title: Text('notification_sound'.tr,style: textRegular.copyWith(),),
                leading: Icon(Icons.notifications_sharp,color: Theme.of(context).primaryColor,),
                trailing: GetBuilder<AuthController>(
                  builder: (authController){
                    return GestureDetector(
                      onTap: ()=>  authController.toggleNotificationSound(),
                      child: Container(height: 25, width: 45,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).primaryColor
                        ),
                        child: Row(
                          mainAxisAlignment: authController.isNotificationActive()?MainAxisAlignment.start:MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 22,
                              width: 22,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 2),
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.3),
                                  )],
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Padding(
              //   padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           Image.asset(Images.languageSetting,scale: 2,),
              //           const SizedBox(width: Dimensions.paddingSizeLarge,),
              //           Text(
              //             'language'.tr,
              //             style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),
              //         ],
              //       ),
              //       DropdownButton<String>(
              //         isDense: true,
              //         style: textMedium.copyWith(color: Theme.of(context).primaryColor),
              //         value:Get.locale!.languageCode == 'en' ? 'English':'عربي',
              //         underline: const SizedBox(),
              //         icon: const Icon(Icons.keyboard_arrow_down_sharp),

              //         elevation: 1,
              //         selectedItemBuilder: (_) {
              //           return <String>['English','عربي'].map<Widget>((String item) {
              //             return Center(
              //               child: Text(item,style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),),
              //             );
              //           }).toList();
              //         },

              //         items: [
              //           DropdownMenuItem<String>(
              //             value: 'English',
              //             child: Text('English',style: textRegular.copyWith(color:
              //             Get.locale!.languageCode == 'en' ?
              //             Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyLarge!.color),),
              //           ),

              //           DropdownMenuItem<String>(
              //             value: 'عربي',
              //             child: Text('عربي',style: textRegular.copyWith(color:
              //             Get.locale!.languageCode == 'ar' ?
              //             Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyLarge!.color),),
              //           ),
              //         ],

              //         onChanged: (String? newValue) {
              //           if(newValue == 'English'){
              //             Get.find<LocalizationController>().setLanguage(const Locale( 'en','US'));
              //           }else{
              //             Get.find<LocalizationController>().setLanguage(const Locale( 'ar', 'SA'));
              //           }
              //         },
              //       )
              //     ],
              //   ),
              // ),

              ListTile(
                title: Text('theme'.tr,style: textRegular.copyWith(),),
                leading: Image.asset(Images.themeLogo,width: 20,),
              ),
              GetBuilder<ThemeController>(builder: (themeController){
                return Padding(
                  padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()=>themeController.changeThemeSetting(false),
                        child: Row(
                          children: [
                            Container(height: 15, width: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).hintColor.withOpacity(0.2),
                              ),
                              child:  !themeController.darkTheme? const Center(
                                child: Icon(Icons.circle,size: 10,color: Colors.black,),
                              ):const SizedBox.shrink(),
                            ),
                            const SizedBox(width: 7,),
                            Text('light'.tr),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeLarge,),
                      InkWell(
                        onTap: ()=>themeController.changeThemeSetting(true),
                        child: Row(
                          children: [
                            Container(height: 15, width: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).hintColor.withOpacity(0.2),
                              ),
                              child:  themeController.darkTheme? const Center(
                                child: Icon(Icons.circle,size: 10,color: Colors.black,),
                              ):const SizedBox.shrink(),
                            ),
                            const SizedBox(width: 7,),
                            Text('dark'.tr),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              // ListTile(
              //   title: Text('change_password'.tr,style: textMedium.copyWith(),),
              //   leading: Image.asset(Images.password,width: 20,height: 20,color: Theme.of(context).primaryColor),
              //   onTap: (){
              //       Get.to(()=>const ResetPasswordScreen(fromChangePassword: true));
              //   },
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
