import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class TollTipWidget extends StatefulWidget {
  
  final String title;
  const TollTipWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<TollTipWidget> createState() => _TollTipWidgetState();
}

class _TollTipWidgetState extends State<TollTipWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title.tr,style: textMedium.copyWith(color: Theme.of(context).primaryColor),),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
          child: Row(
            children: [
              Text('insight'.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),
              const SizedBox(width: 3,),
              Icon(Icons.info,color: Theme.of(context).primaryColor.withOpacity(0.6),size: 15,)
            ],
          ),
        )
      ],
    );
  }
}
