import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';


class EstimatedFareAndDistance extends StatelessWidget {
  const EstimatedFareAndDistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          color: Theme.of(context).primaryColor.withOpacity(0.15)
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
         customDistanceItem(context,false,"0.4 km","distance_away"),
         customDistanceItem(context,false,"3 min","estimated_time"),
         customDistanceItem(context,true,"34","fare_price"),
      ],
      ),

    );
  }

  Widget customDistanceItem(BuildContext context,bool isAmount,String title,String subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(isAmount?PriceConverter.convertPrice(context, double.tryParse(title)!):title,style: textBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),

        const SizedBox(height: Dimensions.paddingSizeThree,),

        Text(subTitle.tr,style: textRegular.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeDefault),)
      ],
    );
  }
}
