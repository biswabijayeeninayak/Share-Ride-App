import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/activity/controller/activity_controller.dart';
import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/activity/widgets/activity_details_map_view.dart';
import 'package:ride_sharing_user_app/view/screens/activity/widgets/activity_item_view.dart';
import 'package:ride_sharing_user_app/view/screens/activity/widgets/rider_details.dart';
import 'package:ride_sharing_user_app/view/screens/activity/widgets/trip_details.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';

class ActivityDetailsScreen extends StatefulWidget {
  final ActivityItemModel activityItemModel;
  const ActivityDetailsScreen({Key? key, required this.activityItemModel})
      : super(key: key);

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: 'check_your_all_trip'.tr,
          showBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: GetBuilder<ActivityController>(builder: (activityController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('your_trip_details'.tr,
                    style: textSemiBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                Divider(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                ActivityItemView(
                  activityItemModel: widget.activityItemModel,
                  isDetailsScreen: true,
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                const ActivityScreenMapView(),
                if (widget.activityItemModel.tripDetails != null)
                  ActivityScreenTripDetails(
                      tripDetails: widget.activityItemModel.tripDetails!),
                if (widget.activityItemModel.tripDetails != null)
                  ActivityScreenRiderDetails(
                      riderDetails: widget.activityItemModel.riderDetails!),
              ],
            );
          }),
        ),
      ),
    );
  }
}
