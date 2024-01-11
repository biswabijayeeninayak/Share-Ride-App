import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/controller/set_map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/widget/suggested_route_card.dart';
import 'package:ride_sharing_user_app/view/widgets/secondery_custom_app_bar.dart';

class SuggestedRouteScreen extends StatelessWidget {
  const SuggestedRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: const SecondaryCustomAppBar(title: 'suggested_route'),
      body: Stack(
        children: [
          GetBuilder<SetMapController>(initState: (context) {
            Get.find<SetMapController>().getSuggestedRouteList();
          }, builder: (setMapController) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: setMapController.suggestedRouteList.length,
                      itemBuilder: (context, index) {
                        return SuggestedRouteCard(
                            suggestedRouteModel:
                                setMapController.suggestedRouteList[index]);
                      }),
                )
              ],
            );
          }),
          Positioned(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                            topLeft:
                                Radius.circular(Dimensions.paddingSizeLarge),
                            topRight:
                                Radius.circular(Dimensions.paddingSizeLarge)),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: .25)),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon(Icons.place, color: Theme.of(context).primaryColor, size: Dimensions.iconSizeExtraLarge,),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                          //   child: Text('find_your_best_way_for_your_destination'.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
                          // ),
                          // Text('you_can_find_your_best_route_for_your'.tr,style: textMedium.copyWith(color: Theme.of(context).hintColor),textAlign: TextAlign.center,),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          //   child: Text('or'.tr,style: textMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),
                          // ),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          //   child: CustomButton(
                          //     radius: 30,
                          //     width: 260,
                          //     buttonText: 'choose_the_efficient_way'.tr,
                          //     fontSize: Dimensions.fontSizeDefault,
                          //     onPressed: (){
                          //       Get.back();
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }
}
