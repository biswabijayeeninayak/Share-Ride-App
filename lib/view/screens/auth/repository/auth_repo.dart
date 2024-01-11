import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> login({required String phone}) async {
    return await apiClient.postData(AppConstants.loginUri, {"phone": phone});
  }

  Future<Response?> updateToken() async {
    String? deviceToken;
    if (GetPlatform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        deviceToken = await _saveDeviceToken();
      }
    } else {
      deviceToken = await _saveDeviceToken();
    }

    if (!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
    }
    return await apiClient.postData(
        AppConstants.configUri, {"_method": "put", "fcm_token": deviceToken});
  }

  Future<String?> _saveDeviceToken() async {
    String? deviceToken = '@';
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      if (kDebugMode) {
        print('--------Device Token---------- $deviceToken');
      }
    }
    if (deviceToken != null) {
      if (kDebugMode) {
        print('--------Device Token---------- $deviceToken');
      }
    }
    return deviceToken;
  }

  Future<Response?> forgetPassword(String? phone) async {
    return await apiClient
        .postData(AppConstants.configUri, {"phone_or_email": phone});
  }

  Future<Response?> verifyToken(String phone, String otp) async {
    return await apiClient.postData(AppConstants.configUri,
        {"phone_or_email": phone.substring(1, phone.length - 1), "otp": otp});
  }

  Future<Response?> resetPassword(String phoneOrEmail, String otp,
      String password, String confirmPassword) async {
    return await apiClient.postData(
      AppConstants.configUri,
      {
        "_method": "put",
        "phone_or_email": phoneOrEmail,
        "otp": otp,
        "password": password,
        "confirm_password": confirmPassword
      },
    );
  }

  Future<Response?> checkEmail(String email) async {
    return await apiClient.postData(AppConstants.configUri, {"email": email});
  }

  Future<Response?> verifyEmail(String email, String token) async {
    return await apiClient
        .postData(AppConstants.configUri, {"email": email, "token": token});
  }

  Future<Response?> updateZone() async {
    return await apiClient.getData(AppConstants.configUri);
  }

  Future<Response?> verifyPhone(String phone, String otp) async {
    return await apiClient
        .postData(AppConstants.configUri, {"phone": phone, "otp": otp});
  }

  Future<bool?> saveUserToken(String token) async {
    apiClient.token = token;
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    return true;
  }

  Future<void> saveUserNumber(String number) async {
    try {
      // await sharedPreferences.setString(AppConstants.userPassword, password);
      await sharedPreferences.setString(AppConstants.userNumber, number);
    } catch (e) {
      rethrow;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.userNumber) ?? "";
  }

  String getUserCountryCode() {
    // return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
    return "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.userPassword) ?? "";
  }

  toggleNotificationSound(bool isNotification) {
    sharedPreferences.setBool(AppConstants.notification, isNotification);
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.notification) ?? true;
  }

  Future<bool> clearUserNumber() async {
    await sharedPreferences.remove(AppConstants.userPassword);
    return await sharedPreferences.remove(AppConstants.userNumber);
  }

  bool clearSharedAddress() {
    //sharedPreferences.remove(AppConstants.USER_ADDRESS);
    return true;
  }
}
