import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/onboard/controller/on_board_page_controller.dart';
import 'package:ride_sharing_user_app/view/screens/onboard/widget/pager_content.dart';
import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.onPrimary,
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          child:Stack(
            children: [
              GetBuilder<OnBoardController>(builder: (onBoardController){
                return Column(children: [
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) {
                        if(value==4){
                          Get.find<ConfigController>().disableIntro();
                          Get.offAll(()=>const SignInScreen());
                        }else{
                          onBoardController.onPageChanged(value);
                        }
                      },
                      itemCount: AppConstants.onBoardPagerData.length,
                      itemBuilder: (context, index) => PagerContent(
                        image: AppConstants.onBoardPagerData[onBoardController.pageIndex]["image"]!,
                        text: AppConstants.onBoardPagerData[onBoardController.pageIndex]["text"]!,
                        index: onBoardController.pageIndex,
                      ),
                    )
                  ),

                    GetBuilder<OnBoardController>(
                      builder: (onBoardController) {
                        return Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              const SizedBox(width: Dimensions.paddingSizeDefault,),
                              IconButton(
                                onPressed: (){
                                  if(AppConstants.onBoardPagerData.length-1==onBoardController.pageIndex){
                                    Get.find<ConfigController>().disableIntro();
                                    Get.offAll(()=> const SignInScreen());
                                  }else{
                                    onBoardController.onPageIncrement();

                                  }
                                },
                                icon: const Icon(Icons.arrow_forward,color: Colors.white60,),
                              ),
                              SizedBox(width: Get.width*0.2,),
                              TextButton(
                                onPressed:(){
                                  Get.find<ConfigController>().disableIntro();
                                  Get.offAll(()=> const SignInScreen());
                                },
                                child: Text('skip'.tr, style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeLarge, color: Colors.white60,
                                )),
                              ),
                              const SizedBox(width: Dimensions.paddingSizeDefault,)
                            ],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeDefault,)
                          ],
                        );
                      },
                    ),
                  ],
                );
              })
            ],
          ),
        )],
      ),
    );
  }
}
