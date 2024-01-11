// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/images.dart';
// import 'package:ride_sharing_user_app/util/styles.dart';
// import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';
// import 'package:ride_sharing_user_app/view/screens/activity/widgets/rider_details.dart';
// import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/parcel/widgets/contact_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/parcel/widgets/fare_input_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/parcel/widgets/finding_rider_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/parcel/widgets/otp_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/parcel/widgets/tolltip_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/payment/payment_screen.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/widgets/confirmation_trip_dialog.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/widgets/estimated_fare_and_distance.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_category.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/widgets/rider_details_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/widgets/rise_fare_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/widgets/trip_fare_summery.dart';
// import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';
// import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
// import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
//
// class CarRideDetailsWidgets extends StatelessWidget {
//   const CarRideDetailsWidgets({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  GetBuilder<RideController>(builder: (rideController){
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
//         child: Column(children:  [
//
//           if(rideController.currentCarRideView == CarRidePageState.initial)
//             Column(children:  [
//               const RideCategoryWidget(),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               const RouteWidget(),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               const TripFareSummery(),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               CustomTextField(
//                 prefix: false,
//                 borderRadius: Dimensions.radiusSmall,
//                 hintText: "add_note".tr,
//               ),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               rideController.isBiddingOn ? const FareInputWidget(fromPage: 'car',): CustomButton(
//                 buttonText: "find_driver".tr,onPressed: (){
//                   rideController.updateCarRideCurrentView(CarRidePageState.findingRider);
//                   Get.find<MapController>().notifyMapController();
//               }),
//             ],),
//
//
//           if(rideController.currentCarRideView == CarRidePageState.riseFare)
//             Column(children: [
//               TollTipWidget(title: 'trip_details'.tr),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               const RouteWidget(),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               const RiseFareWidget(fromPage: 'car',),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//             ]),
//
//
//           if(rideController.currentCarRideView == CarRidePageState.findingRider)
//             Column(children: const [
//               FindingWidget(type: 'car'),
//             ]),
//
//
//           if(rideController.currentCarRideView == CarRidePageState.acceptingRider)
//             Column(children: const [
//               RiderDetailsWidget(fromPage: 'car',fromNotification: false,),
//               SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               RiseFareWidget(fromPage: 'car',),
//               SizedBox(height: Dimensions.paddingSizeDefault,),
//             ]),
//
//
//           if(rideController.currentCarRideView == CarRidePageState.afterAcceptRider)
//             Column(children: [
//               TollTipWidget(title: 'rider_details'.tr),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               const ContactWidget(),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               ActivityScreenRiderDetails(
//                 riderDetails: RiderDetails(
//                     name: "mostafizur",
//                     vehicleNumber: "DH-1234",
//                     rating: 5,
//                     vehicleType: "bike",
//                     vehicleName: "Pulser-150",
//                     image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
//                 ),
//               ),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               const EstimatedFareAndDistance(),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               const RouteWidget(),
//               const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//               CustomButton(buttonText: 'cancel_ride'.tr,
//                 transparent: true,
//                 borderWidth: 1,
//                 showBorder: true,
//                 radius: Dimensions.paddingSizeSmall,
//                 borderColor: Theme.of(Get.context!).primaryColor,
//                 onPressed: (){
//                   rideController.updateCarRideCurrentView(CarRidePageState.initial);
//                   Get.find<MapController>().notifyMapController();
//                 },
//               )
//             ]),
//
//           if(rideController.currentCarRideView == CarRidePageState.otpSent)
//             GestureDetector(
//               onTap: () async {
//                 Get.dialog(const ConfirmationTripDialog(isStartedTrip: true,), barrierDismissible: false);
//                 await Future.delayed( const Duration(seconds: 5));
//                 rideController.updateCarRideCurrentView(CarRidePageState.ongoingRide);
//                 Get.find<MapController>().notifyMapController();
//                 Get.back();
//
//               },
//               child: Column(children: [
//                 TollTipWidget(title: 'rider_details'.tr),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 const OtpWidget(fromPage: 'car',),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 const ContactWidget(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 ActivityScreenRiderDetails(
//                   riderDetails: RiderDetails(
//                       name: "mostafizur",
//                       vehicleNumber: "DH-1234",
//                       rating: 5,
//                       vehicleType: "bike",
//                       vehicleName: "Pulser-150",
//                       image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
//                   ),
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 const EstimatedFareAndDistance(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//
//                 const RouteWidget(),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//                 CustomButton(buttonText: 'cancel_ride'.tr,
//                   transparent: true,
//                   borderWidth: 1,
//                   showBorder: true,
//                   radius: Dimensions.paddingSizeSmall,
//                   borderColor: Theme.of(Get.context!).primaryColor,
//                   onPressed: (){
//                     rideController.updateCarRideCurrentView(CarRidePageState.initial);
//                     Get.find<MapController>().notifyMapController();
//                   },
//                 )
//               ]),
//             ),
//
//           if(rideController.currentCarRideView == CarRidePageState.ongoingRide)
//             GestureDetector(
//               onTap: () {
//                 showDialog(context: context, builder: (_){
//                   return ConfirmationDialog(icon: Images.endTrip,
//                     description: 'end_this_trip_at_your_destination'.tr, onYesPressed: () async {
//                      Get.back();
//                      Get.dialog(const ConfirmationTripDialog(isStartedTrip: false,), barrierDismissible: false);
//                      await Future.delayed( const Duration(seconds: 5));
//                      rideController.updateCarRideCurrentView(CarRidePageState.ongoingRide);
//                      Get.find<MapController>().notifyMapController();
//                      Get.back();
//                      Get.off(()=>const PaymentScreen());
//                     },);
//                 });
//               },
//               child: Column(children: [
//                 TollTipWidget(title: 'trip_is_ongoing'.tr),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
//                   child: Text.rich(TextSpan(
//                     style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
//                         color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)
//                     ),
//                     children:  [
//                       TextSpan(text: "the_car_just_arrived_at".tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
//                       TextSpan(text: " ".tr),
//                       TextSpan(text: "your_destination".tr,style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor)),
//                     ],
//                   ),
//                   ),
//                 ),
//
//                 ActivityScreenRiderDetails(
//                   riderDetails: RiderDetails(
//                       name: "mostafizur",
//                       vehicleNumber: "DH-1234",
//                       rating: 5,
//                       vehicleType: "bike",
//                       vehicleName: "Pulser-150",
//                       image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
//                   ),
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeDefault,),
//               ]),
//             )
//         ]),
//       );
//     });
//   }
// }
