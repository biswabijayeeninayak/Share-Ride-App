import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';


class HtmlViewerScreen extends StatelessWidget {
  final bool isPolicy;
  const HtmlViewerScreen({Key? key, this.isPolicy = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String data = isPolicy ?
    'Legal Conditions Your access and use of the Hexa Ride Services constitutes your agreement to be bound by these Hexa Ride Terms, which establishes a contractual relationship between you and Hexa Ride. If you do not agree to these Hexa Ride Terms, you may not access or use the Hexa Ride Services. These Hexa Ride Terms expressly supersede prior agreements or arrangements with you. Start Trip Conditions Supplemental terms may apply to certain Hexa Ride Services, such as policies for a particular event, activity or promotion, or a particular category of Hexa Ride Services. Supplemental terms will be provided to you in connection with the applicable Hexa Ride Services.Any supplemental terms are in addition to, and shall be deemed a part of, the Hexa Ride Terms for the purposes of the applicable Hexa Ride Services. Supplemental terms shall prevail over these Hexa Ride Terms in the event of a conflict with respect to the applicable Hexa Ride Services.Payment & review Rules Hexa Ride may amend the Hexa Ride Terms, any supplemental terms or policies (including the "Community Guidelines", available at Hexa Ride Legal) related to the Hexa Ride Services from time to time. Hexa Ride will provide you with at least 07 days’ notice in the event of a material change to any Hexa Ride Terms, policies or supplemental terms that detrimentally affects your rights under these Hexa Ride Terms. Amendments will be effective upon posting of such updated Hexa Ride Terms at this location or the amended supplemental terms or policies on the applicable Hexa Ride Service or at this location (as the case may be). Your continued access or use of the Hexa Ride Services after such posting, or after ' :
    'Policy Conditions \nYour access and use of the Hexa Ride Services constitutes your agreement to be bound by these Hexa Ride Terms, which establishes a contractual relationship between you and Hexa Ride. If you do not agree to these Hexa Ride Terms, you may not access or use the Hexa Ride Services. These Hexa Ride Terms expressly supersede prior agreements or arrangements with you. Start Trip Conditions Supplemental terms may apply to certain Hexa Ride Services, such as policies for a particular event, activity or promotion, or a particular category of Hexa Ride Services. Supplemental terms will be provided to you in connection with the applicable Hexa Ride Services.Any supplemental terms are in addition to, and shall be deemed a part of, the Hexa Ride Terms for the purposes of the applicable Hexa Ride Services. Supplemental terms shall prevail over these Hexa Ride Terms in the event of a conflict with respect to the applicable Hexa Ride Services.Payment & review Rules Hexa Ride may amend the Hexa Ride Terms, any supplemental terms or policies (including the "Community Guidelines", available at Hexa Ride Legal) related to the Hexa Ride Services from time to time. Hexa Ride will provide you with at least 07 days’ notice in the event of a material change to any Hexa Ride Terms, policies or supplemental terms that detrimentally affects your rights under these Hexa Ride Terms. Amendments will be effective upon posting of such updated Hexa Ride Terms at this location or the amended supplemental terms or policies on the applicable Hexa Ride Service or at this location (as the case may be). Your continued access or use of the Hexa Ride Services after such posting, or after ';

    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: isPolicy? 'privacy_policy'.tr : 'terms_and_condition'.tr ,showBackButton: true),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            physics: const BouncingScrollPhysics(),
            child: HtmlWidget(data,
              key: Key(isPolicy ? 'privacy_policy' : 'terms_and_condition'),

            ),
          ),
        ),
      ),
    );
  }
}