
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:ride_sharing_user_app/data/api_client.dart';
// import 'package:ride_sharing_user_app/view/screens/set_map/model/suggested_route_model.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class SetMapRepo{
//   final ApiClient apiClient;

//   SetMapRepo({required this.apiClient});


//   Future<Response> getSuggestedRouteList() async {
//     List<SuggestedRouteModel> suggestedRouteList = [];
//     try {
//       suggestedRouteList = [
//         SuggestedRouteModel(title: 'Time Squire Marvel, Singapore',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Japan',route1: 'Toronto road',route2: 'Johnson Point', distance: 5454, requiredTime: 24, volume: 'medium'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, India',route1: 'Toronto road',route2: 'Johnson Point', distance: 3456, requiredTime: 43, volume: 'high'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Bangladesh',route1: 'Toronto road',route2: 'Johnson Point', distance: 2344, requiredTime: 56, volume: 'medium'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'high'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Singapore',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Japan',route1: 'Toronto road',route2: 'Johnson Point', distance: 5454, requiredTime: 24, volume: 'medium'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, India',route1: 'Toronto road',route2: 'Johnson Point', distance: 3456, requiredTime: 43, volume: 'high'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Bangladesh',route1: 'Toronto road',route2: 'Johnson Point', distance: 2344, requiredTime: 56, volume: 'medium'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'high'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Singapore',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Japan',route1: 'Toronto road',route2: 'Johnson Point', distance: 5454, requiredTime: 24, volume: 'medium'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, India',route1: 'Toronto road',route2: 'Johnson Point', distance: 3456, requiredTime: 43, volume: 'high'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Bangladesh',route1: 'Toronto road',route2: 'Johnson Point', distance: 2344, requiredTime: 56, volume: 'medium'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'high'),
//         SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),




//       ];


//       Response response = Response(body: suggestedRouteList, statusCode: 200);
//       return response;
//     } catch (e) {
//       return const Response(
//           statusCode: 404, statusText: 'on boarding data not found');
//     }
//   }



// }






import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/model/suggested_route_model.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetMapRepo{
  final ApiClient apiClient;

  SetMapRepo({required this.apiClient});


  Future<Response> getSuggestedRouteList() async {
    List<SuggestedRouteModel> suggestedRouteList = [];
    try {
      suggestedRouteList = [
        SuggestedRouteModel(title: 'Time Squire Marvel, Singapore',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Japan',route1: 'Toronto road',route2: 'Johnson Point', distance: 5454, requiredTime: 24, volume: 'medium'),
        SuggestedRouteModel(title: 'Time Squire Marvel, India',route1: 'Toronto road',route2: 'Johnson Point', distance: 3456, requiredTime: 43, volume: 'high'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Bangladesh',route1: 'Toronto road',route2: 'Johnson Point', distance: 2344, requiredTime: 56, volume: 'medium'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'high'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Singapore',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Japan',route1: 'Toronto road',route2: 'Johnson Point', distance: 5454, requiredTime: 24, volume: 'medium'),
        SuggestedRouteModel(title: 'Time Squire Marvel, India',route1: 'Toronto road',route2: 'Johnson Point', distance: 3456, requiredTime: 43, volume: 'high'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Bangladesh',route1: 'Toronto road',route2: 'Johnson Point', distance: 2344, requiredTime: 56, volume: 'medium'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'high'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Singapore',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Japan',route1: 'Toronto road',route2: 'Johnson Point', distance: 5454, requiredTime: 24, volume: 'medium'),
        SuggestedRouteModel(title: 'Time Squire Marvel, India',route1: 'Toronto road',route2: 'Johnson Point', distance: 3456, requiredTime: 43, volume: 'high'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Bangladesh',route1: 'Toronto road',route2: 'Johnson Point', distance: 2344, requiredTime: 56, volume: 'medium'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'high'),
        SuggestedRouteModel(title: 'Time Squire Marvel, Street 6H',route1: 'Toronto road',route2: 'Johnson Point', distance: 1234, requiredTime: 18, volume: 'low'),




      ];


      Response response = Response(body: suggestedRouteList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }



}