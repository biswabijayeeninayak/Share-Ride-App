import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ride_sharing_user_app/view/screens/activity/controller/activity_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/bottom_menu_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/address_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/banner_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/category_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/address_repo.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/banner_repo.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/category_repo.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/notification/controller/notification_controller.dart';
import 'package:ride_sharing_user_app/view/screens/activity/repository/activity_repo.dart';
import 'package:ride_sharing_user_app/view/screens/auth/repository/auth_repo.dart';
import 'package:ride_sharing_user_app/view/screens/notification/repository/notification_repo.dart';
import 'package:ride_sharing_user_app/view/screens/message/controller/message_controller.dart';
import 'package:ride_sharing_user_app/view/screens/message/repository/message_repo.dart';
import 'package:ride_sharing_user_app/view/screens/offer/controller/offer_controller.dart';
import 'package:ride_sharing_user_app/view/screens/offer/repository/offer_repo.dart';
import 'package:ride_sharing_user_app/view/screens/onboard/controller/on_board_page_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/repository/parcel_repo.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';
import 'package:ride_sharing_user_app/view/screens/payment/repository/payment_repo.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/repository/uer_repo.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/controller/set_map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/repository/set_map_repo.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/repository/ride_repo.dart';
import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';
import 'package:ride_sharing_user_app/view/screens/splash/repo/config_repo.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/localization/language_model.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/theme/theme_controller.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/repository/wallet_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => ConfigRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find()));
  Get.lazyPut(() => ActivityRepo(apiClient: Get.find()));
  Get.lazyPut(() => WalletRepo(apiClient: Get.find()));
  Get.lazyPut(() => OfferRepo(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => AddressRepo(apiClient: Get.find()));
  Get.lazyPut(() => ParcelRepo(apiClient: Get.find()));
  Get.lazyPut(() => RideRepo(apiClient: Get.find()));
  Get.lazyPut(() => SetMapRepo(apiClient: Get.find()));
  Get.lazyPut(() => PaymentRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => ConfigController(configRepo: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => OnBoardController());
  Get.lazyPut(() => AuthController(
      authRepo:
          AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() =>
      NotificationController(notificationRepo: Get.find<NotificationRepo>()));

  Get.lazyPut(() =>
      ActivityController(activityRepo: ActivityRepo(apiClient: Get.find())));
  Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
  Get.lazyPut(
      () => MessageController(messageRepo: MessageRepo(apiClient: Get.find())));
  Get.lazyPut(() => WalletController(walletRepo: Get.find()));
  Get.lazyPut(() => OfferController(offerRepo: Get.find()));
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => AddressController(addressRepo: Get.find()));
  Get.lazyPut(() => MapController());
  Get.lazyPut(() => ParcelController(parcelRepo: Get.find()));
  Get.lazyPut(() => SetMapController(setMapRepo: Get.find()));
  Get.lazyPut(() => RideController(rideRepo: Get.find()));
  Get.lazyPut(() => PaymentController(paymentRepo: Get.find()));
  Get.lazyPut(() => BottomMenuController());

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> languageJson = {};
    mappedJson.forEach((key, value) {
      languageJson[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        languageJson;
  }
  return languages;
}
