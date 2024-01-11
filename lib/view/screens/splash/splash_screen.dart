import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/onboard/onboarding_screen.dart';
import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();

    bool firstTime = true;
    Connectivity connectivity = Connectivity();
    connectivity.checkConnectivity();
    _onConnectivityChanged = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        if(!isNotConnected) ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }else {
        firstTime = false;
      }
    });

    Get.find<ConfigController>().initSharedData();
    _route();


    Future.delayed(const Duration(milliseconds: 2500), () {
      if(Get.find<AuthController>().isLoggedIn()){
        Get.to(() => const DashboardScreen());
      }else{
        if (Get.find<ConfigController>().showIntro()) {
          Get.to(() => const OnBoardingScreen());
        } else {
          Get.to(() => const SignInScreen());
        }
      }
    });

  }
  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _onConnectivityChanged?.cancel();
  }
  void _route() async {
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, children:  [


              Stack(alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    transform: Matrix4.translationValues(0, 320-(320*double.tryParse(_animation.value.toString())!), 0),
                    child: Column(
                      children: [
                        Opacity(
                          opacity: _animation.value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 120-((120*double.tryParse(_animation.value.toString())!))),
                            child: Image.asset(Images.splashLogo,width: 160),
                          ),
                        ),
                         const SizedBox(height: 50),
                        Image.asset(
                          Images.splashBackgroundOne,
                          width: Get.width,
                          height: Get.height/2,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, 20, 0),
                    child: Padding(
                      padding:EdgeInsets.symmetric(horizontal:(70*double.tryParse(_animation.value.toString())!)),
                      child: Image.asset(Images.splashBackgroundTwo,
                        width: Get.size.width,
                      ),
                    ),
                  ),
                ],
              ),


            ]),
          ),

        ],

      ),
    );
  }
}
