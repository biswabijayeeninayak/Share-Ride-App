import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class ActivityScreenRiderDetails extends StatelessWidget {
  final RiderDetails riderDetails;
  const ActivityScreenRiderDetails({Key? key, required this.riderDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Text(
          'rider_details'.tr,
          style: textBold.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).primaryColor),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusOverLarge),
                    child: const CustomImage(
                      height: 50,
                      width: 50,
                      image:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    )),
                const SizedBox(
                  width: Dimensions.paddingSizeSmall,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riderDetails.name!,
                        style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Theme.of(context).primaryColorDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text.rich(
                        TextSpan(
                          style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!
                                  .withOpacity(0.8)),
                          children: [
                            WidgetSpan(
                                child: Icon(
                                  Icons.star,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  size: 15,
                                ),
                                alignment: PlaceholderAlignment.middle),
                            TextSpan(
                                text: riderDetails.rating.toString(),
                                style: textRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusOverLarge),
                    child: const CustomImage(
                      height: 50,
                      width: 50,
                      image:
                          'https://images.unsplash.com/photo-1595691403533-7f4a52a5b189?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c3VwZXJiaWtlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                    )),
                const SizedBox(
                  width: Dimensions.paddingSizeSmall,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riderDetails.vehicleName!,
                        style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).primaryColorDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text.rich(
                        TextSpan(
                          style: textRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!
                                  .withOpacity(0.8)),
                          children: [
                            TextSpan(
                                text: "${riderDetails.vehicleType!.tr} : ",
                                style: textRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).primaryColor)),
                            TextSpan(
                                text: riderDetails.vehicleNumber,
                                style: textRegular.copyWith(
                                    fontSize: Dimensions.fontSizeDefault)),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    ]);
  }
}
