import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/custom_add_buttom.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/use_voucher_code.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_item_view.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/custom_title.dart';
class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Get.find<WalletController>().getPaymentMethodList();
    Get.find<WalletController>().getVoucherList();
    Get.find<WalletController>().getPromoCodeList();
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: 'hey'.tr),
        body: GetBuilder<WalletController>(
          builder: (walletController) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [


                  CustomTitle(title: 'payment_method'.tr, color: Theme.of(context).textTheme.displayLarge!.color,icon: Images.profileMyWallet,),
                  ListView.builder(itemBuilder: (context,index){
                    return WalletItemView(
                      title: walletController.paymentMethodList[index].title,
                      icon: walletController.paymentMethodList[index].icon,
                    );
                  },itemCount: walletController.paymentMethodList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const CustomAddButton(buttonText: 'add_card',),


                  CustomTitle(title: 'voucher'.tr, color: Theme.of(context).textTheme.displayLarge!.color,icon: Images.voucherIcon,),
                  ListView.builder(itemBuilder: (context,index){
                    return WalletItemView(
                      title: walletController.voucherList[index].title,
                      icon: walletController.voucherList[index].icon,
                    );
                  },itemCount: walletController.voucherList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                   CustomAddButton(buttonText: 'add_voucher_code',onTap: ()=> Get.to(()=> const UseCouponScreen())),


                  CustomTitle(title: 'promo_code'.tr, color: Theme.of(context).textTheme.displayLarge!.color,icon: Images.promoCodeIcon,count: '2',),
                  ListView.builder(itemBuilder: (context,index){
                    return WalletItemView(
                      title: walletController.promoCodeList[index].title,
                      icon: walletController.promoCodeList[index].icon,
                    );
                  },itemCount: walletController.promoCodeList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const CustomAddButton(buttonText: 'add_promo_code',),

                ],),
              ),
            );
          }),
      ),
    );
  }
}

