import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/offer/widgets/level_widget.dart';
import 'package:ride_sharing_user_app/view/screens/offer/widgets/offer_other_details_info.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';


class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: 'here_lots_of_offer_for_you'.tr),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return SingleChildScrollView(
              child: Padding(
                padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:  [

                  if(userController.userModel!=null)
                  UserLevelWidget(userLevelModel: userController.userModel!),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSeven),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                      child: CustomImage(
                        height: 140,
                        width: Get.width,
                        image: 'https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg',
                      ),
                    ),
                  ),

                  const OfferOtherInfoView()

                ],),
              ),
            );
          }
        ),
      ),
    );
  }
}
