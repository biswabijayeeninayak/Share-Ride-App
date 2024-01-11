import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/payment/payment_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/confirmation_trip_dialog.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class RiderDetailsWidget extends StatelessWidget {
  final bool fromNotification;
    const RiderDetailsWidget({Key? key,this.fromNotification = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(children: [
      Row(children: [
        const ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radiusOverLarge,),bottomLeft: Radius.circular(Dimensions.radiusOverLarge,),
            bottomRight: Radius.circular(Dimensions.radiusSmall,),topRight: Radius.circular(Dimensions.radiusSmall,)
          ),
          child: CustomImage(height: 50, width: 50,
            image: '',
        )),

        const SizedBox(width: Dimensions.paddingSizeSmall,),
        Expanded(child: GestureDetector(
          onTap: (){
            if(Get.find<RideController>().selectedCategory!=RideType.parcel){
              Get.find<RideController>().updateRideCurrentState(RideState.acceptingRider);
            }else{
              Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.acceptRider);
            }
            Get.back();
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text.rich(TextSpan(
                style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
                children:  [
                  TextSpan(text: 'Jhone Doe'.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColorDark,fontSize: Dimensions.fontSizeDefault)),

                  WidgetSpan(child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                    child: Image.asset(Images.bikeSmall,height: Dimensions.iconSizeSmall,),),
                    alignment: PlaceholderAlignment.middle,
                  ),

                  TextSpan(text: 'Bajaj 150 CC'.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColorDark,fontSize: Dimensions.fontSizeDefault)),
                  const TextSpan(text: " "),

                  WidgetSpan(child: Icon(Icons.star,color: Theme.of(context).colorScheme.primaryContainer,size: 15,), alignment: PlaceholderAlignment.middle),
                  TextSpan(text: '5',style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))
                ])
              ),

              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Text("distance_from_you".tr,
                style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorDark.withOpacity(0.6)),
                overflow: TextOverflow.ellipsis,
              ),
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(PriceConverter.convertPrice(context, 160),
                  style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
                ),

                Text("4 min",
                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorDark.withOpacity(0.6)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ]),
        ))]),
      const SizedBox(height: Dimensions.paddingSizeDefault,),
      Row(
        children: [
          Expanded(child: CustomButton(
            buttonText: 'decline'.tr,
            borderWidth: 0.1,
            radius: Dimensions.radiusLarge,
            fontSize: Dimensions.fontSizeDefault,
            borderColor: Theme.of(Get.context!).colorScheme.error,
            textColor: Theme.of(context).colorScheme.error.withOpacity(0.9),
            backgroundColor: Theme.of(context).hintColor.withOpacity(0.2),
            boldText: false,
            onPressed: (){
              if(Get.find<RideController>().selectedCategory!=RideType.parcel) {
                Get.find<RideController>().updateRideCurrentState(RideState.initial);
              } else{
                Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.initial);
              }
              if(fromNotification){
                Get.back();
              }
              Get.find<MapController>().notifyMapController();
            },
          )),
          const SizedBox(width: Dimensions.paddingSizeDefault,),
          Expanded(child: CustomButton(
            radius: Dimensions.radiusLarge,
            buttonText: 'accept'.tr,
            fontSize: Dimensions.fontSizeDefault,
            onPressed: () async{

              if(fromNotification){
                Get.back();
              }
              if(Get.find<RideController>().selectedCategory!=RideType.parcel) {

                Get.find<RideController>().updateRideCurrentState(RideState.afterAcceptRider);

                await Future.delayed(const Duration(seconds: 2)).then((value){
                  Get.find<RideController>().updateRideCurrentState(RideState.otpSent);
                  Get.find<MapController>().notifyMapController();
                });

                await Future.delayed(const Duration(seconds: 2)).then((value) async {
                  Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
                  await Future.delayed( const Duration(seconds: 5));
                  Get.find<RideController>().updateRideCurrentState(RideState.ongoingRide);
                  Get.find<MapController>().notifyMapController();
                  Get.back();
                });

                await Future.delayed(const Duration(seconds: 2)).then((value) async {
                  Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
                  await Future.delayed( const Duration(seconds: 2));
                  Get.find<RideController>().updateRideCurrentState(RideState.completeRide);
                  //Get.back();
                  Get.find<MapController>().notifyMapController();
                  Get.back();


                });
                await Future.delayed(const Duration(seconds: 0)).then((value) async {
                  Get.offAll(()=>const PaymentScreen());


                });

              }else{
                Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.acceptRider);

                await Future.delayed(const Duration(seconds: 2)).then((value){
                  Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.otpSent);
                  Get.find<MapController>().notifyMapController();
                });

                await Future.delayed(const Duration(seconds: 2)).then((value) async {
                  Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
                  await Future.delayed( const Duration(seconds: 5));
                  Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.parcelOngoing);
                  Get.find<MapController>().notifyMapController();
                  Get.back();
                });

                await Future.delayed(const Duration(seconds: 2)).then((value) async {
                  Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
                  await Future.delayed( const Duration(seconds: 2));
                  Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.parcelComplete);
                  //Get.back();
                  Get.find<MapController>().notifyMapController();
                  Get.back();


                });
                await Future.delayed(const Duration(seconds: 0)).then((value) async {
                  Get.offAll(()=>const PaymentScreen());


                });
              }
              if(fromNotification){
                Get.back();
              }
              Get.find<MapController>().notifyMapController();
            },
          )),
        ],
      )
    ],);
  }
}
