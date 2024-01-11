import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/convert_point_to_wallet_money.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/my_earn_card_widget.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/point_gained_card.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_amount_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';


class LoyaltyPointScreen extends StatelessWidget {
  const LoyaltyPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Get.find<WalletController>().getMyEarnList();


    return GetBuilder<WalletController>(builder: (walletController){
      return  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

        const WalletMoneyAmountWidget(),

        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child:  Divider(),
        ),
        walletController.isConvert==false?
        Expanded(
          child: ListView.builder(
              itemCount: walletController.myEarnList.length,
              shrinkWrap: true,

              itemBuilder: (context, index){
                return MyEarnCardWidget(myEarnModel: walletController.myEarnList[index]);
              }),
        ): Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: ()=> walletController.toggleConvertCard(false),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                child: Text('back_to_transaction'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, decoration: TextDecoration.underline),),
              ),
            ),
            const ConvertPointToWalletMoney(),
          ],
        )),
        if(walletController.isConvert)
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: CustomButton(
            buttonText: "convert_point".tr,
            onPressed: (){
              walletController.toggleConvertCard(true);

              if(walletController.isConvert && walletController.inputController.text.isNotEmpty){
                Get.off(()=>PointGainedCard(myEarnModel: walletController.myEarnList[0],));
              }
            },
          ),
        )
      ],);
    });
  }
}

