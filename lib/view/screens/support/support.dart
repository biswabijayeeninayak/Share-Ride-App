import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/support/terms_and_conditions.dart';
import 'package:ride_sharing_user_app/view/screens/support/widgets/help_and_support.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;
  late int currentPage;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: 'do_you_need_help'.tr,centerTitle: true,showBackButton: true,),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault),
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                unselectedLabelColor: Colors.grey,
                labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                labelStyle: textSemiBold.copyWith(),
                isScrollable: true,
                indicatorPadding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  tabs:  [
                    Tab(text: 'help_support'.tr),
                    Tab(text: 'terms_and_conditions'.tr),
                  ],
              ),
              Expanded(child: TabBarView(
                controller: tabController,
                children:  [
                  ContactUsPage(),
                  const TermsAndConditions(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
