import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/activity/repository/activity_repo.dart';
import 'package:ride_sharing_user_app/view/screens/home/home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/notification/notification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/profile_screen.dart';


class BottomMenuController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;
  final List<Widget> screen = [
    const HomeScreen(),
    // const ActivityScreen(fromPage: "home",),
    ActivityScreenData(),
    const NotificationScreen(),
     ProfileScreen(),
  ];
  Widget _currentScreen = const HomeScreen();
  Widget get currentScreen => _currentScreen;

  resetNavBar(){
    _currentScreen = const HomeScreen();
    _currentTab = 0;
  }

  selectHomePage() {
    _currentScreen = const HomeScreen();
    _currentTab = 0;
     update();
  }

  selectActivityScreen() {
    // _currentScreen = const ActivityScreen(fromPage: "home",);
    _currentScreen = ActivityScreenData();

    _currentTab = 1;
    update();
  }

  selectNotificationScreen() {
    _currentScreen = const NotificationScreen();
    _currentTab = 2;
    update();
  }

  selectProfileScreen() {
    _currentScreen =  ProfileScreen();
    _currentTab = 3;
    update();
  }
}
