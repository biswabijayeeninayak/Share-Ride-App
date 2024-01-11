import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/my_earn_model.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

class MyEarnCardWidget extends StatelessWidget {
  final MyEarnModel myEarnModel;
  const MyEarnCardWidget({Key? key, required this.myEarnModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
      child: GetBuilder<WalletController>(
        builder: (walletController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                child: Row(children: [
                  Expanded(child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(width: Dimensions.iconSizeLarge,
                      //     child: Image.asset(Images.myEarnIcon)),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('${'XID'}# ${myEarnModel.xID!}', style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                          child: Text(DateConverter.isoStringToDateTimeString(myEarnModel.createdAt!),
                            style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                        ),
                        Text('${'trip_id'.tr} : ${myEarnModel.id}', style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),)
                      ],),
                    ],
                  )),
                  Container(
                    padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColor.withOpacity(.15)),
                    child: Text(PriceConverter.convertPrice(context, myEarnModel.amount!),
                      style: textBold.copyWith(color: Theme.of(context).primaryColor)))
                ],),
              ),
              CustomDivider(height: .5,color: Theme.of(context).hintColor.withOpacity(.75),)
            ],
          );
        }
      ),
    );
  }
}
