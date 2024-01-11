import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class DottedBorderCard extends StatelessWidget {
  const DottedBorderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
      child: DottedBorder(
        dashPattern: const [5,5],
        borderType: BorderType.RRect,
        color :  Theme.of(context).primaryColor.withOpacity(0.3),
        radius: const Radius.circular(Dimensions.paddingSizeDefault),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeDefault),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('send_or_receive'.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeOverLarge),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                      child: Text('safest_delivery'.tr,style: textMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeDefault),),
                    )
                  ],
                ),
                Image.asset(Images.parcelDeliveryman,height: 60,),
                const SizedBox()
              ],),
            ),),
        ),
      ),
    );
  }
}
