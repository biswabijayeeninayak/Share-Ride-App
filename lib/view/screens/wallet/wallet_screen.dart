import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/wallet/widget/loyality_point_screen.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/wallet_money_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}
class _WalletScreenState extends State<WalletScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Get.find<WalletController>().getMyEarnList();
    Get.find<WalletController>().getPaymentMethodList();
    Get.find<WalletController>().getVoucherList();
    Get.find<WalletController>().getPromoCodeList();
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: 'wallet'.tr),
        body: GetBuilder<WalletController>(
          builder: (walletController) {
            return Column(children: [


              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: TabBar(
                  controller: tabController,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                  labelStyle: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                  isScrollable: true,
                  indicatorColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(0),
                  tabs:  [
                    SizedBox(height: 30,child: Tab(text: 'Wallet Money'.tr)),
                    // SizedBox(height: 30,child: Tab(text: 'Loyality Point'.tr)),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children:  const [
                    WalletMoneyScreen(),
                    // LoyaltyPointScreen(),
                  ],
                ),
              )
            ],);
          }),
      ),
    );
  }
}
