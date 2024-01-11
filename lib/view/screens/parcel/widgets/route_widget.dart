import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

class RouteWidget extends StatefulWidget {

  const RouteWidget({Key? key}) : super(key: key);

  @override
  State<RouteWidget> createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(
      builder: (parcelController) {
        return Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Column(children:  [
                    SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.currentLocation)),
                    SizedBox(height:45 ,width: 10,child: CustomDivider(height: 2,dashWidth: 1,axis: Axis.vertical,color: Theme.of(context).primaryColor,)),
                    SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.activityDirection)),
                  ],),
                ),

                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(parcelController.senderAddressController.text, style: textRegular.copyWith(),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text('to'.tr,style: textRegular.copyWith(color: Theme.of(context).primaryColor),),

                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Text(parcelController.receiverAddressController.text),
                  ],
                )),
              ],),
            const SizedBox(height: Dimensions.paddingSizeDefault,),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(
                  children: [
                    SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.distanceCalculated)),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text("total_distance".tr, style: textRegular.copyWith(),),
                  ],
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                const Text('12 km'),
              ],),
            )
          ],
        );
      }
    );
  }
}
