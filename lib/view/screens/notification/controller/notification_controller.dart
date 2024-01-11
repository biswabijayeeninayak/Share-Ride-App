import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/view/screens/auth/model/notification_model.dart';
import 'package:ride_sharing_user_app/view/screens/notification/repository/notification_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  final NotificationRepo notificationRepo;

  NotificationController({required this.notificationRepo});
  // final NotificationRepo notificationRepo;
  // NotificationController({required this.notificationRepo});
    var isLoading = true.obs;
  var notifications = <Map<String, dynamic>>[].obs;
  
 List<NotificationModel>? _notificationList = [];

  List<NotificationModel>? get notificationList => _notificationList;

Future<void> getNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId').toString();

  try {
    isLoading(true);

    final response = await http.get(
      Uri.parse("${Constant().url}rider/notification/$userId"),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> notificationsList = jsonResponse["data"];

      _notificationList = notificationsList
          .map((notificationData) => NotificationModel(
                id: notificationData["id"],
                type: notificationData["type"],
                notifiableType: notificationData["notifiable_type"],
                notifiableId: notificationData["notifiable_id"],
                data: notificationData["data"],
                readAt: notificationData["read_at"],
                createdAt: notificationData["created_at"],
                updatedAt: notificationData["updated_at"],
              ))
          .toList();

      isLoading(false);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
    isLoading(false);
  }
  update();
}





}