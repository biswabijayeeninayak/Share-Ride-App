import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/images.dart';
// import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/activity/widgets/rider_details.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/contact_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/fare_input_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/finding_rider_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/otp_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/tolltip_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/payment_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/confirmation_trip_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/estimated_fare_and_distance.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_category.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/rider_details_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/rise_fare_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/trip_fare_summery.dart';
// import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

class BikeRideDetailsWidgets extends StatelessWidget {
  const BikeRideDetailsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<RideController>(builder: (rideController){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Column(children:  [

          if(rideController.currentRideState == RideState.initial)
            Column(children:  [
              const RideCategoryWidget(),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              const RouteWidget(),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              const TripFareSummery(),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              CustomTextField(
                prefix: false,
                borderRadius: Dimensions.radiusSmall,
                hintText: "add_note".tr,
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              rideController.isBiddingOn ? const FareInputWidget(fromPage: 'ride',): CustomButton(
                buttonText: "Pay & Book".tr, onPressed: (){
                  rideController.updateRideCurrentState(RideState.afterAcceptRider);
              }),
            ],),



          if(rideController.currentRideState == RideState.riseFare)
            Column(children: [
              TollTipWidget(title: 'trip_details'.tr),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              const RouteWidget(),
              const SizedBox(height: Dimensions.paddingSizeDefault,),

              const RiseFareWidget(fromPage: 'ride',),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
            ]),



          if(rideController.currentRideState == RideState.findingRider)
            Column(children: const [
              FindingRiderWidget(fromPage: 'ride',),
            ]),



          if(rideController.currentRideState == RideState.acceptingRider)
            Column(children: const [
              RiderDetailsWidget(fromNotification: false,),
              SizedBox(height: Dimensions.paddingSizeDefault,),

               RiseFareWidget(fromPage: 'ride',),
               SizedBox(height: Dimensions.paddingSizeDefault,),
            ]),


          if(rideController.currentRideState == RideState.afterAcceptRider)
            GestureDetector(
              onTap: ()=> Get.find<RideController>().updateRideCurrentState(RideState.otpSent),
              child: Column(children: [
                TollTipWidget(title: 'rider_details'.tr),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                ContactWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                ActivityScreenRiderDetails(
                  riderDetails: RiderDetails(
                      name: "mostafizur",
                      vehicleNumber: "DH-1234",
                      rating: 5,
                      vehicleType: "bike",
                      vehicleName: "Pulser-150",
                      image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                const EstimatedFareAndDistance(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                const RouteWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                CustomButton(buttonText: 'continue'.tr,
                  transparent: true,
                  borderWidth: 1,
                  showBorder: true,
                  radius: Dimensions.paddingSizeSmall,
                  borderColor: Theme.of(Get.context!).primaryColor,
                  onPressed: () async {
                    // rideController.updateRideCurrentState(RideState.initial);
                    // Get.find<MapController>().notifyMapController();

                    await Future.delayed(const Duration(seconds: 2)).then((value){
                  Get.find<RideController>().updateRideCurrentState(RideState.otpSent);
                  Get.find<MapController>().notifyMapController();
              


                });
                  },
                )
              ]),
            ),

          if(rideController.currentRideState == RideState.otpSent)
            GestureDetector(
              onTap: () async {
                Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
                await Future.delayed( const Duration(seconds: 5));
                rideController.updateRideCurrentState(RideState.completeRide);
                Get.find<MapController>().notifyMapController();
                Get.back();

              },
              child: Column(children: [
                // TollTipWidget(title: 'rider_details'.tr),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                const OtpWidget(fromPage: 'bike',),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                ContactWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                ActivityScreenRiderDetails(
                  riderDetails: RiderDetails(
                      name: "mostafizur",
                      vehicleNumber: "DH-1234",
                      rating: 5,
                      vehicleType: "bike",
                      vehicleName: "Pulser-150",
                      image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                const EstimatedFareAndDistance(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),

                const RouteWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                CustomButton(buttonText: 'Continue to Pay'.tr,
                  transparent: true,
                  borderWidth: 1,
                  showBorder: true,
                  radius: Dimensions.paddingSizeSmall,
                  borderColor: Theme.of(Get.context!).primaryColor,
                  onPressed: () async {
                    // rideController.updateRideCurrentState(RideState.initial);
                    // Get.find<MapController>().notifyMapController();
                 

                          await Future.delayed(const Duration(seconds: 1)).then((value) async {
                  // Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
                  await Future.delayed( const Duration(seconds: 1));
                  Get.find<RideController>().updateRideCurrentState(RideState.completeRide);
                  Get.find<MapController>().notifyMapController();
                   Get.offAll(()=>const PaymentScreen());
                });
                          
                  },
                )
              ]),
            ),

          // if(rideController.currentRideState == RideState.completeRide)
          //   GestureDetector(
          //     onTap: () {
          //       showDialog(context: context, builder: (_){
          //         return ConfirmationDialog(icon: Images.endTrip,
          //           description: 'Continue'.tr, onYesPressed: () async {
                      // Get.back();
                      // Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
                      // await Future.delayed( const Duration(seconds: 5));
                      // rideController.updateRideCurrentState(RideState.completeRide);
                      // //Get.back();
                      // Get.find<MapController>().notifyMapController();
                      // Get.off(()=>const PaymentScreen());

                //       await Future.delayed(const Duration(seconds: 2)).then((value) async {
                //   Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
                //   await Future.delayed( const Duration(seconds: 5));
                //   Get.find<RideController>().updateRideCurrentState(RideState.ongoingRide);
                //   Get.find<MapController>().notifyMapController();
                //   Get.back();
                // });

                // await Future.delayed(const Duration(seconds: 2)).then((value) async {
                  // Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
                  // await Future.delayed( const Duration(seconds: 2));
                  // Get.find<RideController>().updateRideCurrentState(RideState.completeRide);
                  //Get.back();
                  // Get.find<MapController>().notifyMapController();
                  // Get.back();


              //   });
              //   await Future.delayed(const Duration(seconds: 0)).then((value) async {
              //     Get.offAll(()=>const PaymentScreen());


              //   });
              //       },);
              //   });
              // },
              // child: Column(children: [
              //   TollTipWidget(title: 'Continue'.tr),
              //   const SizedBox(height: Dimensions.paddingSizeDefault,),
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              //     child: Text.rich(TextSpan(
              //       style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
              //           color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)
              //       ),
              //       children:  [
              //         TextSpan(text: "The ride just arrived at".tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
              //         TextSpan(text: " ".tr),
              //         TextSpan(text: "your_destination".tr,style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor)),
              //       ],
              //     ),
              //     ),
              //   ),

              //   ActivityScreenRiderDetails(
              //     riderDetails: RiderDetails(
              //         name: "mostafizur",
              //         vehicleNumber: "DH-1234",
              //         rating: 5,
              //         vehicleType: "bike",
              //         vehicleName: "Pulser-150",
              //         image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
              //     ),
              //   ),
              //   const SizedBox(height: Dimensions.paddingSizeDefault,),
              // ]),
          //   )
          ],
        ),
      );
    });
  }
}
