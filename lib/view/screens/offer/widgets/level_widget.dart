import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/offer/model/level_model.dart';

class UserLevelWidget extends StatelessWidget {
  final UserModel userLevelModel;
  const UserLevelWidget({Key? key, required this.userLevelModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int needToEarnPoint = userLevelModel.userLevelModel!.targetPoint! - userLevelModel.userLevelModel!.earnedPoint!;

    double progressValue = (userLevelModel.userLevelModel!.earnedPoint!.toDouble())/(userLevelModel.userLevelModel!.targetPoint!.toDouble());

    return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('your_level'.tr,style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).textTheme.displayLarge!.color),),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  border: Border.all(color:Theme.of(context).primaryColor.withOpacity(0.4),width:0.5),
                  borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge)
                ),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
                child: Row(children: [
                  Text("${'level'.tr} ${userLevelModel.userLevelModel?.currentLevel}"),
                  const SizedBox(width: 5,),
                  Image.asset(
                    userLevelModel.userLevelModel?.currentLevel=="1"? Images.level1:
                    userLevelModel.userLevelModel?.currentLevel=="2"? Images.level2:
                    userLevelModel.userLevelModel?.currentLevel=="3"? Images.level3:
                    userLevelModel.userLevelModel?.currentLevel=="4"? Images.level4: Images.level5,
                    width: 25,
                  )],
                ),
              )
            ],
          ),
        ),
       Padding(
        padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child:  Divider(color: Theme.of(context).primaryColor.withOpacity(0.3),height: 0.5,),
      ),

      const SizedBox(height: Dimensions.paddingSizeSmall,),

      Text.rich(TextSpan(
        style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
          children:  [
            TextSpan(text: 'you_are_level'.tr,),
            TextSpan(text: '${userLevelModel.userLevelModel?.currentLevel}'.tr),
            TextSpan(text: 'customer'.tr),
          ],
        ),
      ),

      const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'total'.tr,
              style: DefaultTextStyle.of(context).style,
              children:  <TextSpan>[
                TextSpan(text: ' ${userLevelModel.userLevelModel?.earnedPoint} ', style: textRegular.copyWith(color: Theme.of(context).primaryColor)),
                TextSpan(text: 'point'.tr.toLowerCase()),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            child: Icon(Icons.circle,size: 3,),
          ),

          RichText(
            text: TextSpan(
              text: 'earn_more'.tr,
              style: DefaultTextStyle.of(context).style,
              children:  <TextSpan>[
                TextSpan(text: ' ${needToEarnPoint.toString()} '),
                TextSpan(text: 'point'.tr),
              ],
            ),
          ),

        ],
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault,),
      LinearPercentIndicator(
        percent: progressValue,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
        progressColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.zero,
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault,),

      RichText(
        text: TextSpan(
          text: 'your_next_level_is'.tr,
          style: DefaultTextStyle.of(context).style,
          children:  <TextSpan>[
             TextSpan(text: '${'level'.tr} ${userLevelModel.userLevelModel?.currentLevel}'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      ],
    );
  }
}
