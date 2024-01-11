// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/data/api_client.dart';
// // import 'package:ride_sharing_user_app/util/images.dart';
// import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/activity/controller/activity_controller.dart';
import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_calender.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drop_down.dart';
// import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
// import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
// import 'package:ride_sharing_user_app/view/widgets/custom_calender.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityRepo {
  final ApiClient apiClient;
  ActivityRepo({required this.apiClient});

  var isLoading = true.obs;
  var rides = <Map<String, dynamic>>[].obs;
  List<ActivityItemModel> activityItemList = [];

  Future<Response> getActivityList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();

    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse("${Constant().url}rider_orders/$userId"),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("Response : ${response.body}");
        final dynamic responseData = jsonResponse["rides"] ?? [];

        if (responseData is List<dynamic>) {
          activityItemList = responseData
              .map((activityData) => ActivityItemModel(
                    createdAt: activityData["created_at"],
                    vachelType: activityData["ride_type"],
                    pickupLocation: activityData["pickup_location"],
                    dropLocation: activityData["drop_location"],
                  ))
              .toList();
          print("Activity Repo: $activityItemList");
          isLoading(false);
        } else {
          throw Exception('Invalid data format: ${responseData.runtimeType}');
        }

        // Return the response
        return Response();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      isLoading(false);

      // Return an error response
      return Response();
    }
  }
}

class ActivityScreenData extends StatefulWidget {
  @override
  _ActivityScreenDataState createState() => _ActivityScreenDataState();
}

class _ActivityScreenDataState extends State<ActivityScreenData> {
  bool isLoading = true;
  List<Map<String, dynamic>> rideDataList = [];
  String? errorMessage;
  String? initialSelectItem; // Declare initialSelectItem

  @override
  void initState() {
    super.initState();
    initialSelectItem = Get.find<ActivityController>()
        .filterList
        .first; // Initialize initialSelectItem
    getActivityList();
  }

  Future<void> getActivityList() async {
    // print("Entered");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('userId') ?? 'default_user_id';
print("User: $userId");
      final response = await http
          .get( Uri.parse("${Constant().url}rider_orders/$userId"));
print("${Constant().url}rider_orders/$userId");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("Response : ${response.body}");
        print("json : ${jsonResponse}");


        final List<dynamic> rides = jsonResponse['data']['rides'] ?? [];

        setState(() {
          rideDataList = rides.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: 'check_your_all_trip'.tr),       
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: GetBuilder<ActivityController>(builder: (activityController) {
            return Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'your_trips'.tr,
                  style: textSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                activityController.showCustomDate
                    ? InkWell(
                        onTap: () =>
                            activityController.updateShowCustomDateState(false),
                        child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusOverLarge),
                              border: Border.all(
                                width: 1,
                                color: Colors.red.withOpacity(0.2),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall),
                            child: Center(
                              child: Text(
                                "${activityController.filterStartDate} - ${activityController.filterEndDate}",
                                style: textRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.5)),
                              ),
                            )),
                      )
                    : Container(
                        width: 120,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.06),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusOverLarge),
                          border: Border.all(
                            width: 1,
                            color: Colors.red.withOpacity(0.2),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall),
                        child: Center(
                          child: CustomDropDown(
                            icon: Icon(
                              Icons.expand_more,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!
                                  .withOpacity(0.5),
                            ),
                            maxListHeight: 200,
                            items: activityController.filterList
                                .map((item) => CustomDropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item.tr,
                                        style: textRegular.copyWith(
                                            color: item != initialSelectItem
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .color!
                                                    .withOpacity(0.5)
                                                : Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    ))
                                .toList(),
                            hintText: "select".tr,
                            borderRadius: 5,
                            onChanged: (selectedItem) {
                              initialSelectItem = selectedItem ?? 'all';
                              if (initialSelectItem == 'custom') {
                                showDialog(
                                    context: context,
                                    builder: (_) => CustomCalender(
                                          onChanged: (value) {
                                            Get.back();
                                          },
                                        ));
                              }
                              activityController.update();
                            },
                          ),
                        ),
                      ),
              ]),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : errorMessage != null
                        ? Center(child: Text('Error: $errorMessage'))
                        : ListView.builder(
                            itemCount: rideDataList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var ride = rideDataList[index];
                              return ListTile(
                                leading: Icon(Icons.directions_bike),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(ride['pickup_location'] ??
                                    'Unknown Pickup Location'),
                                    Text(ride['drop_location'] ??
                                        'Unknown Drop Location'),
                                    Text(ride['created_at'] ?? 'Unknown time'),
                                  ],
                                ),
                                trailing:
                                    Text(ride['ride_type'] ?? 'No Ride Type'),
                              );
                            },
                          ),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
