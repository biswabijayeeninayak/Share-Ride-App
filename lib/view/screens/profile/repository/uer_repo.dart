import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/offer/model/level_model.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserLevelInfo() async {
    UserModel userLevelModel = UserModel();
    try {
      userLevelModel = UserModel(
          userName: "Norman bell",
          totalRide: 120,
          totalPoint: 580,
          userLevelModel: UserLevelModel(
            targetPoint: 1000,
            earnedPoint: 400,
            nextLevel: "2",
            currentLevel: "1"
          )
      );
      Response response = Response(body: userLevelModel, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }
}