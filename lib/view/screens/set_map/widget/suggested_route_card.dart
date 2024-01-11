import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/model/suggested_route_model.dart';


class SuggestedRouteCard extends StatelessWidget {
  final SuggestedRouteModel suggestedRouteModel;
  const SuggestedRouteCard({Key? key, required this.suggestedRouteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.off(()=>const MapScreen(fromScreen: 'ride')),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
        child: Container(decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.20),blurRadius: 1,spreadRadius: 1,offset: const Offset(1,1))]

        ),child: Stack(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: SizedBox(height: 90,width: Get.width, child: Image.asset(Images.mapSample,fit: BoxFit.cover,)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.09),
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                      ),
                      height: Dimensions.iconSizeExtraLarge,width: Dimensions.iconSizeExtraLarge,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      child: Image.asset(Images.distanceCalculated),
                    ),),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault,),
                  Expanded(child: Row(
                    children: [
                      Column(children: [
                        Container(width: 5,height: 5,decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(1)
                        ),),
                        Container(height: 15,width: 2,color: Theme.of(context).hintColor.withOpacity(.5)),
                        Container(width: 5,height: 3,decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(1)
                        ),),
                        Container(height: 15,width: 2,color: Theme.of(context).hintColor.withOpacity(.5)),
                        Container(width: 5,height: 5,decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(1)
                        ),),



                      ],),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text(suggestedRouteModel.title!,style: textMedium,),
                          Text(suggestedRouteModel.route1!,style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                          Text(suggestedRouteModel.route2!,style:  textRegular.copyWith(color: Theme.of(context).hintColor)),


                        ],),
                      ),
                    ],
                  )),

                  Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
                    Text('${suggestedRouteModel.requiredTime}', style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),),
                    Text(' ${'min'.tr}',style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                    Row(
                      children: [
                        Text('${suggestedRouteModel.distance}',style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
                        Text(' ${'km'.tr}',style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                      ],
                    )
                  ],)
                ],),
              )
            ],),
            Positioned(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                    color: suggestedRouteModel.volume == 'low'
                        ? Colors.green.withOpacity(.25)
                        :suggestedRouteModel.volume == 'medium'
                        ? Colors.yellow.withOpacity(.25)
                        :Colors.red.withOpacity(.25),

                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeExtraSmall), topRight: Radius.circular(Dimensions.paddingSizeExtraSmall))
                  ),child: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(suggestedRouteModel.volume!.tr,
                          style: textRegular.copyWith(
                              color : suggestedRouteModel.volume == 'low'
                              ? Colors.green
                              :suggestedRouteModel.volume == 'medium'
                              ? Theme.of(context).hintColor
                              :Colors.red.withOpacity(.7))
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      SizedBox(height: Dimensions.iconSizeSmall,
                          child: Image.asset(Images.volume,
                              color : suggestedRouteModel.volume == 'low'? Colors.green
                                  :suggestedRouteModel.volume == 'medium'
                                  ? Theme.of(context).hintColor
                                  :Colors.red.withOpacity(.7)))
                    ],
                  )),
                ),
              ),
            )

          ],
        ),),
      ),
    );
  }
}
