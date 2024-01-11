import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/activity/controller/activity_controller.dart';
import 'package:ride_sharing_user_app/view/screens/activity/repository/activity_repo.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_calender.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drop_down.dart';

class ActivityScreen extends StatefulWidget {
  final String fromPage;
  const ActivityScreen({Key? key, required this.fromPage}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String initialSelectItem = Get.find<ActivityController>().filterList.first;

  @override
  void initState() {
    super.initState();
    Get.find<ActivityController>().getRewardList();
    Get.find<ActivityRepo>().getActivityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: 'check_your_all_trip'.tr,
          showBackButton: widget.fromPage == "profile" ? true : false,
        ),
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

              Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              ActivityScreenData(), // Use the shared widget here
            ]);
          }),
        ),
      ),
    );
  }
}
