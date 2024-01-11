import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';


class ConfirmationTripDialog extends StatelessWidget {
  final bool isStartedTrip;

  const ConfirmationTripDialog({Key? key, required this.isStartedTrip}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        isStartedTrip?
        Text('on_the_way_to_your_destination'.tr,textAlign: TextAlign.center,
            style: textMedium.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Theme.of(context).cardColor,)):
        Text('calculating_fare'.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Theme.of(context).cardColor)),
        const SizedBox(height: Dimensions.paddingSizeDefault),

         const LoadingOverlayPro(isLoading: true,backgroundColor: Colors.transparent, child: SizedBox(),)

      ])),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/styles.dart';
// import 'package:loading_overlay_pro/loading_overlay_pro.dart';
// import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';

// class ConfirmationTripDialog extends StatelessWidget {
//   final bool isStartedTrip;

//   const ConfirmationTripDialog({Key? key, required this.isStartedTrip}) : super(key: key);

//   void continueButtonPressed() {
//     // Replace this with your logic when the "Continue" button is pressed
//     Get.find<RideController>().updateRideCurrentState(RideState.completeRide);
//     Get.find<MapController>().notifyMapController();
//     Get.back();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black.withOpacity(0.5),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             isStartedTrip
//                 ? Text(
//                     'on_the_way_to_your_destination'.tr,
//                     textAlign: TextAlign.center,
//                     style: textMedium.copyWith(
//                       fontSize: Dimensions.fontSizeOverLarge,
//                       color: Theme.of(context).cardColor,
//                     ),
//                   )
//                 : Text(
//                     'calculating_fare'.tr,
//                     style: textMedium.copyWith(
//                       fontSize: Dimensions.fontSizeOverLarge,
//                       color: Theme.of(context).cardColor,
//                     ),
//                   ),
//             const SizedBox(height: Dimensions.paddingSizeDefault),
//             // LoadingOverlayPro widget
//             LoadingOverlayPro(
//               isLoading: true,
//               backgroundColor: Colors.transparent,
//               child: SizedBox(),
//             ),
//             if (isStartedTrip)
//               // Continue button
//               ElevatedButton(
//                 onPressed: continueButtonPressed,
//                 child: Text('Continue'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
