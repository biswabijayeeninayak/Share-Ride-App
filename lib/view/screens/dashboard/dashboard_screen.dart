import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
// import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/bottom_menu_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageStorageBucket bucket = PageStorageBucket();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<BottomMenuController>().currentTab != 0) {
          Get.find<BottomMenuController>().selectHomePage();
          return false;
        } else {
          showDialog(context: context, builder: (context){
            return ConfirmationDialog(
              icon: Images.profileLogout,
              description: 'do_you_want_to_exit_the_app'.tr,
              onYesPressed:(){
                // Get.to(() => const SignInScreen());
                if (Platform.isAndroid) {
              SystemNavigator.pop();
            }
              },);
          });
        }
        return false;
      },

      child: GetBuilder<BottomMenuController>(builder: (menuController) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              PageStorage(bucket: bucket, child: menuController.currentScreen),
              Positioned(child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Container(height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [BoxShadow(
                        offset: const Offset(0,4),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.3),
                      )]
                  ),



                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomMenuItem(index: 0,name: 'home',activeIcon:  Images.homeActive,inActiveIcon: Images.homeOutline, currentIndex: menuController.currentTab,
                            tap: () => menuController.selectHomePage()),
                      ),
                      Expanded(
                        child: CustomMenuItem(index: 1,name: 'activity',activeIcon:  Images.activityActive,inActiveIcon: Images.activityOutline, currentIndex: menuController.currentTab,
                            tap: () => menuController.selectActivityScreen()),
                      ),
                      Expanded(
                        child: CustomMenuItem(index: 2,name: 'notification',activeIcon:  Images.notificationActive,inActiveIcon: Images.notificationOutline, currentIndex: menuController.currentTab,
                            tap: () => menuController.selectNotificationScreen()),
                      ),
                      Expanded(
                        child: CustomMenuItem(index: 3,name: 'profile',activeIcon:  Images.profileActive,inActiveIcon: Images.profileOutline, currentIndex: menuController.currentTab,
                            tap: () => menuController.selectProfileScreen()),
                      ),

                    ],
                  ),
                ),
              ),))
            ],
          ),

        );
      }),
    );


  }

}

class CustomMenuItem extends StatelessWidget {
  final int index;
  final String name;
  final String activeIcon;
  final String inActiveIcon;
  final int currentIndex;
  final VoidCallback tap;

  const CustomMenuItem(
      {Key? key, required this.index, required this.name, required this.activeIcon, required this.inActiveIcon, required this.currentIndex, required this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: tap,
      child: SizedBox(width: currentIndex == index ? 90 : 50,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                currentIndex == index ? activeIcon : inActiveIcon,
                width: Dimensions.menuIconSize,
                height: Dimensions.menuIconSize,
              ),
              if(currentIndex == index)
                Text(name.tr, maxLines: 1, overflow: TextOverflow.ellipsis,style: textRegular.copyWith(color: Colors.white),)
            ]
        ),
      ),
    );
  }

}