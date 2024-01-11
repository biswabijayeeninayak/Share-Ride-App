import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/payment/payment_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/widgets/confirmation_trip_dialog.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class FareInputWidget extends StatelessWidget {
  final String fromPage;
  const FareInputWidget({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController){
      return Row(children: [
        Expanded(child: GestureDetector(
          onTap: (){
            if(fromPage=='ride'){
              Get.find<RideController>().updateRideCurrentState(RideState.riseFare);
            }else{
              Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.riseFare);
            }
            Get.find<MapController>().notifyMapController();
          },
          child: Container(height: 45,decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            border: Border.all(color: Theme.of(context).primaryColor,width: 1),
          ),
              child: Center(child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                Expanded(
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                    child: Text('your_fare'.tr,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,

                        color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.9)),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Text(PriceConverter.convertPrice(context, double.tryParse( Get.find<RideController>().inputFarePriceController.text)!,),
                    style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.9)),),),

              ]))),
        )),

        const SizedBox(width: Dimensions.paddingSizeSmall,),
        Expanded(child: CustomButton(
          buttonText: Get.find<RideController>().selectedCategory==RideType.bike?"Book".tr:
          Get.find<RideController>().selectedCategory==RideType.auto||Get.find<RideController>().selectedCategory==RideType.auto?"Book".tr
              : "Book".tr,
          onPressed: () async {
             if(Get.find<RideController>().selectedCategory!=RideType.parcel) {

                // Get.find<RideController>().updateRideCurrentState(RideState.afterAcceptRider);

                // await Future.delayed(const Duration(seconds: 2)).then((value){
                  Get.find<RideController>().updateRideCurrentState(RideState.otpSent);
                //   Get.find<MapController>().notifyMapController();
                // });

                // await Future.delayed(const Duration(seconds: 2)).then((value) async {
                //   Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
                //   await Future.delayed( const Duration(seconds: 5));
                //   Get.find<RideController>().updateRideCurrentState(RideState.ongoingRide);
                //   Get.find<MapController>().notifyMapController();
                //   Get.back();
                // });

                // await Future.delayed(const Duration(seconds: 2)).then((value) async {
                //   Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
                //   await Future.delayed( const Duration(seconds: 2));
                //   Get.find<RideController>().updateRideCurrentState(RideState.completeRide);
                //   //Get.back();
                //   Get.find<MapController>().notifyMapController();
                //   Get.back();


                // });
                // await Future.delayed(const Duration(seconds: 0)).then((value) async {
                //   Get.offAll(()=>const PaymentScreen());


                // });
            }else{
              Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.suggestVehicle);
            }
            Get.find<MapController>().notifyMapController();
          },
          fontSize: Dimensions.fontSizeDefault,)
        ),


//         Expanded(
//   child: CustomButton(
//     buttonText: "Pay & Book".tr,
//     onPressed: () {
//       // Perform any necessary state updates here

//       // Navigate to the PaymentScreen 
//       Get.to(() => PaymentScreen()); // Replace 'PaymentScreen' with the actual name of your payment screen
//     },
//     fontSize: Dimensions.fontSizeDefault,
//   ),
// ),
      ],
      );
    });
  }
}
