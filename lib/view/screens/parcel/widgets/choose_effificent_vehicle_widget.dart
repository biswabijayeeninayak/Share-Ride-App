import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/payment/payment_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/confirmation_trip_dialog.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class ChooseEfficientVehicleWidget extends StatefulWidget {
  const ChooseEfficientVehicleWidget({Key? key}) : super(key: key);

  @override
  State<ChooseEfficientVehicleWidget> createState() => _ChooseEfficientVehicleWidgetState();
}

class _ChooseEfficientVehicleWidgetState extends State<ChooseEfficientVehicleWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(builder: (parcelController){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: Text('find_your_best_parcel_delivery_vehicles'.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
            ),
            // Text('find_your_best_parcel_delivery_vehicles_hint'.tr,style: textMedium.copyWith(color: Theme.of(context).hintColor),textAlign: TextAlign.center,),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            //   child: Text('or'.tr,style: textMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),
            // ),

            CustomButton(
              buttonText: 'choose_the_efficient_vehicles'.tr,
              fontSize: Dimensions.fontSizeDefault,
              onPressed: ()async{
                // Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.findingRider);
                // Get.find<MapController>().notifyMapController();
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
                  Get.back();
                  Get.find<MapController>().notifyMapController();
                  Get.back();
                });
                await Future.delayed(const Duration(seconds: 0)).then((value) async {
                  Get.offAll(()=>const PaymentScreen());


                });

              }else{
                // Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.acceptRider);

                // await Future.delayed(const Duration(seconds: 10)).then((value){
                  Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.otpSent);
                //   Get.find<MapController>().notifyMapController();
                // });

                // await Future.delayed(const Duration(seconds: 10)).then((value) async {
                //   Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
                //   await Future.delayed( const Duration(seconds: 10));
                //   Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.parcelOngoing);
                //   Get.find<MapController>().notifyMapController();
                //   Get.back();
                // });

                // await Future.delayed(const Duration(seconds: 10)).then((value) async {
                //   Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
                //   await Future.delayed( const Duration(seconds: 10));
                //   Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.parcelComplete);
                //   //Get.back();
                //   Get.find<MapController>().notifyMapController();
                //   Get.back();


                // });
                // await Future.delayed(const Duration(seconds: 0)).then((value) async {
                //   Get.offAll(()=>const PaymentScreen());


                // });
              }
              // if(fromNotification){
              //   Get.back();
              // }
              Get.find<MapController>().notifyMapController();
              },
            ),
          ],
        ),
      );
    });
  }
}
