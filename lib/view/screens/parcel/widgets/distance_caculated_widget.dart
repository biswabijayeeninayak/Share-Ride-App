import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class DistanceCalculatedWidget extends StatefulWidget {
  const DistanceCalculatedWidget({Key? key}) : super(key: key);

  @override
  State<DistanceCalculatedWidget> createState() => _DistanceCalculatedWidgetState();
}

class _DistanceCalculatedWidgetState extends State<DistanceCalculatedWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(0.5))
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
            child: Column(children: [
              Text('12km',style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),),
              Text('distance'.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.4)),)
            ],),
          ),
          Container(width: 1,height: 25,color: Theme.of(context).primaryColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
            child: Column(children: [
              Text(PriceConverter.convertPrice(context, 87),style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),),
              Text('price'.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.4)),)
            ],),
          ),

        ],),
      ),
    );
  }
}
