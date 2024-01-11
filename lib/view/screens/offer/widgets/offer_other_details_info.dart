import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class OfferOtherInfoView extends StatelessWidget {
  const OfferOtherInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
        color: Theme.of(context).hintColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('other_details'.tr,style: textMedium.copyWith(color: Theme.of(context).textTheme.displayLarge!.color,fontSize: Dimensions.fontSizeDefault),),
          const SizedBox(height: Dimensions.paddingSizeSeven,),
          const RowText(title: 'total_ride_limit', leadingText: '50',),
           RowText(title: 'total_spend_money_limit', leadingText: PriceConverter.convertPrice(context, 45),),
          const RowText(title: 'total_cancellation_rate_limit', leadingText: '20%',),
          const RowText(title: 'total_review_limit', leadingText: '40',),

        ],
      ),
    );
  }
}

class RowText extends StatelessWidget {
  final String title;
  final String? leadingText;
  const RowText({Key? key, required this.title, required this.leadingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall-2,vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.tr,style: textMedium.copyWith(color: Theme.of(context).textTheme.displayLarge!.color,fontSize: Dimensions.fontSizeSmall),),
          Text(leadingText??'',style: textMedium.copyWith(color: Theme.of(context).textTheme.displayLarge!.color,fontSize: Dimensions.fontSizeSmall),),
        ],
      ),
    );
  }
}

