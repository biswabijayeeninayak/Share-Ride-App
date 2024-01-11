import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class RiseFareWidget extends StatelessWidget {
  final String fromPage;
  const RiseFareWidget({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (riderController){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
            child: Text('current_fare'.tr,style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor.withOpacity(0.6)),),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            GestureDetector(
              onTap: ()=> Get.find<RideController>().updateFareValue(increment: false),
              child: Container(height: 30, width: 40, decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  border: Border.all(color: Theme.of(context).primaryColor)
              ),
                child: const Center(child: Icon(Icons.remove,size: Dimensions.iconSizeSmall,),),
              ),
            ),

            Text(PriceConverter.convertPrice(context, Get.find<RideController>().currentFarePrice),
                style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Theme.of(context).primaryColor)),

            GestureDetector(
              onTap: ()=> Get.find<RideController>().updateFareValue(increment: true),
              child: Container(height: 30, width: 40, decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Theme.of(context).primaryColor
              ),
                child: const Center(child: Icon(Icons.add,color: Colors.white,size: Dimensions.iconSizeSmall,),),
              ),
            ),
          ],),
          const SizedBox(height: Dimensions.paddingSizeDefault,),
          CustomButton(buttonText: 'rise_fare'.tr,onPressed: (){

            if(fromPage=='ride'){
              Get.find<RideController>().updateRideCurrentState(RideState.initial);
            }else{
              Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.parcelInfoDetails);
            }
            Get.find<MapController>().notifyMapController();
          },),

          const SizedBox(height: Dimensions.paddingSizeDefault,),
          CustomButton(buttonText: 'cancel'.tr,
            transparent: true,
            borderWidth: 1,
            showBorder: true,
            radius: Dimensions.paddingSizeSmall,
            borderColor: Theme.of(Get.context!).primaryColor,
            onPressed: (){
              if(fromPage=="ride") {
                Get.find<RideController>().updateRideCurrentState(RideState.initial);
              }else{
                Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.parcelInfoDetails);
              }

              Get.find<MapController>().notifyMapController();
            },
          )
        ],
      );
    });
  }
}
