import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/activity/activity_details_screen.dart';
import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';

class ActivityItemView extends StatelessWidget {
  final ActivityItemModel activityItemModel;
  final bool? isDetailsScreen;

  const ActivityItemView({
    Key? key,
    required this.activityItemModel,
    this.isDetailsScreen,
  }) : super(key: key);

 @override
  Widget build(BuildContext context) {
    try {
      return InkWell(
        onTap: () => Get.to(() => ActivityDetailsScreen(activityItemModel: activityItemModel)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
              width: 80,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(0.02),
              ),
              child: Center(
                child: Column(
                  children: [
                    // Image.asset(
                    //   activityItemModel
                    //       .image, // Ensure that the image path is not null
                    //   height: 40,
                    //   width: 40,
                    // ),
                    Text(
                      activityItemModel.vachelType.tr,
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraLarge),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activityItemModel.title ?? '',
                    style: textMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    'Pickup Location: ${activityItemModel.pickupLocation}',
                    style: textRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    'Drop Location: ${activityItemModel.dropLocation}',
                    style: textRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    'Created Date: ${_formatCreatedDate()}',
                    style: textRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.4),
                    ),
                  ),
                  if (activityItemModel.orderAmount != null)
                    Text(
                      PriceConverter.convertPrice(
                          context, activityItemModel.orderAmount ?? 0),
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (activityItemModel.orderAmount == null)
                    Text(
                      "canceled",
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                isDetailsScreen!
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.arrow_forward_ios_outlined,
                size: isDetailsScreen! ? 30 : 18,
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(0.2),
              ),
            )
          ],
        ),
      ),
        );
  } catch (e) {
    print('Error building UI: $e');
    return Container(); // Or some default widget when there's an error
  }
}


  String _formatCreatedDate() {
    try {
      // ignore: unnecessary_null_comparison
      if (activityItemModel.createdAt != null) {
        DateTime createdDate = DateTime.parse(activityItemModel.createdAt);
        return 'Created Date: ${DateConverter.localToIsoString(createdDate)}';
      } else {
        return 'Created Date: N/A'; // Or any default value you prefer
      }
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid Created Date';
    }
  }
}
