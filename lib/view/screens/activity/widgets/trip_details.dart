import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

class ActivityScreenTripDetails extends StatelessWidget {
  final TripDetails tripDetails;
  const ActivityScreenTripDetails({Key? key, required this.tripDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'trip_details'.tr,
                style: textBold.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeSmall,
              ),
              Row(
                children: [
                  Column(children: [
                    Image.asset(
                      Images.currentLocation,
                      height: 15,
                    ),
                    const SizedBox(
                        height: 20,
                        width: 10,
                        child: CustomDivider(
                          height: 2,
                          dashWidth: 1,
                          axis: Axis.vertical,
                        )),
                    Image.asset(
                      Images.activityDirection,
                      height: 15,
                    ),
                  ]),
                  const SizedBox(
                    width: Dimensions.paddingSizeSmall,
                  ),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tripDetails.pickLocation!,
                            style: textRegular.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!
                                  .withOpacity(0.8),
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            tripDetails.destination!,
                            style: textRegular.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!
                                  .withOpacity(0.8),
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeSmall),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Image.asset(
                          Images.profileMyWallet,
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: Dimensions.paddingSizeSmall,
                        ),
                        Text(
                          'total_distance'.tr,
                          style: textRegular.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .color!
                                .withOpacity(0.8),
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                        ),
                      ]),
                      Text(
                        tripDetails.totalDistance!.toString(),
                        style: textRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(0.8),
                          fontSize: Dimensions.fontSizeSmall,
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
              color: Theme.of(context).primaryColor.withOpacity(0.15)),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Image.asset(
                    Images.profileMyWallet,
                    height: 15,
                    width: 15,
                  ),
                  const SizedBox(
                    width: Dimensions.paddingSizeSmall,
                  ),
                  Text(
                    'fare_price'.tr,
                    style: textRegular.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeSmall),
                  ),
                ]),
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                      color: Theme.of(context).primaryColor.withOpacity(0.2)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall,
                      vertical: Dimensions.paddingSizeExtraSmall),
                  child: Text(
                    tripDetails.farePrice!.toString(),
                    style: textBold.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ]),
              const SizedBox(
                height: Dimensions.paddingSizeExtraSmall,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Image.asset(
                    Images.profileMyWallet,
                    height: 15,
                    width: 15,
                  ),
                  const SizedBox(
                    width: Dimensions.paddingSizeSmall,
                  ),
                  Text(
                    'payment'.tr,
                    style: textRegular.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeSmall),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    tripDetails.paymentMethod!.tr,
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ])
            ],
          ),
        )
      ],
    );
  }
}
