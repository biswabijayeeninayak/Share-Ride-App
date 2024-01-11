import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/driver_request_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/tolltip_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class FindingRiderWidget extends StatefulWidget {
  final String fromPage;

  const FindingRiderWidget({Key? key, required this.fromPage}) : super(key: key);

  @override
  State<FindingRiderWidget> createState() => _FindingRiderWidgetState();
}

class _FindingRiderWidgetState extends State<FindingRiderWidget> {
  bool showRiderRequest = false;
  double percent = 0.0;
  @override
  void initState() {
    Timer? timer;
    timer = Timer.periodic(const Duration(milliseconds:1000),(_){
      setState(() {
        percent+=50;
        if(percent >= 100){
          timer!.cancel();
          showRiderRequest = true;
        }
      });
    });

   if( Get.find<RideController>().isBiddingOn) {
     Future.delayed(const Duration(seconds: 3),(){
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 500),
        barrierLabel: MaterialLocalizations.of(context).dialogLabel,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (context, _, __) {
          return  DriverRideRequestDialog(fromPage: widget.fromPage,);
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ).drive(Tween<Offset>(
              begin: const Offset(0, -1.0),
              end: Offset.zero,
            )),
            child: child,
          );
        },
      );
    });
   }else{
     Future.delayed(const Duration(seconds: 3),(){
       if(Get.find<RideController>().currentRideState!=RideType.parcel && widget.fromPage=='ride'){
         Get.find<RideController>().updateRideCurrentState(RideState.afterAcceptRider);
       }else{

       }
     });
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController){
      return GetBuilder<ParcelController>(builder: (parcelController){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Column(children: [

            TollTipWidget(title: rideController.selectedCategory==RideType.parcel?'deliveryman' :
            rideController.selectedCategory==RideType.bike?"rider":"driver"),

            const SizedBox(height: Dimensions.paddingSizeExtraLarge,),

            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              animation: true,
              animationDuration: 1000,
              lineHeight: 4.0,
              percent:percent/100,
              progressColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).hintColor,
            ),

            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
                child: Image.asset(Images.findingDeliveryman,width: 70)),

            Text( rideController.selectedCategory==RideType.parcel? 'finding_deliveryman'.tr :
            rideController.selectedCategory==RideType.bike?"finding_rider".tr:"finding_driver".tr,
                style: textMedium.copyWith(fontSize: Dimensions.fontSizeOverLarge,color: Theme.of(context).primaryColor,
                )),

            const SizedBox(height: Dimensions.paddingSizeLarge*2,),
            CustomButton(buttonText: 'cancel_searching'.tr,
              transparent: true,
              borderWidth: 1,
              showBorder: true,
              radius: Dimensions.paddingSizeSmall,
              borderColor: Theme.of(Get.context!).primaryColor,
              onPressed: (){
                if(Get.find<RideController>().currentRideState!=RideType.parcel && widget.fromPage=='ride'){
                  rideController.updateRideCurrentState(RideState.initial);
                }else{
                  Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.initial);
                }

                Get.find<MapController>().notifyMapController();
              },
            )
          ],),
        );
      });
    });
  }
}
