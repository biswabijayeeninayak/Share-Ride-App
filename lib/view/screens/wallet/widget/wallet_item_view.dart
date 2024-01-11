import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class WalletItemView extends StatelessWidget {
  final String? title;
  final String? icon;
  const WalletItemView({Key? key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(
        children: [
          Image.asset(icon??"",height: 20,width: 20,),
          const SizedBox(width: Dimensions.paddingSizeSmall,),
          Text(title.toString().tr,
            style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6),
              fontSize: Dimensions.fontSizeDefault
            ),
          ),
        ],
      ),
    );
  }
}
