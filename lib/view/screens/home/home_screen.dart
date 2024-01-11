import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/banner_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/staticlocation.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/banner_view.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/category_view.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/home_map_view.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/home_my_address.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/home_search_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    printDeviceToken();
    super.initState();
    Get.find<BannerController>().getBannerList();
    Get.find<PaymentController>().getDigitalPaymentMethodList();
    _checkPermission(context);
  }

  void printDeviceToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    customPrint('Token: $deviceToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: '${''.tr} ${''}',
          showBackButton: false,
          isHome: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BannerView(),
                CategoryView(),
                HomeSearchWidget(),
                // Container(height:50,color: Colors.red,),
                StaticLocation(),
                HomeMyAddress(
                  fromPage: 'home',
                ),
                HomeMapView(),
                // Container(
                //   height: 500,
                //   width: double.infinity,
                //   child: MapPage(),
                // ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      // showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: true,
      //     onPressed: () async {
      //       Navigator.pop(context);
      //       await Geolocator.requestPermission();
      //
      //     }));
    } else if (permission == LocationPermission.deniedForever) {
      // showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: false,
      //     onPressed: () async {
      //       Navigator.pop(context);
      //       await Geolocator.openAppSettings();
      //
      //     }));
    }
  }
}
