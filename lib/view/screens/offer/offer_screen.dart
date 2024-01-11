import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/offer/offer_details_screen.dart';
import 'package:ride_sharing_user_app/view/screens/offer/widgets/level_widget.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';


class OfferScreen extends StatelessWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: 'here_lots_of_offer_for_you'.tr),
        body: GetBuilder<UserController>(
          initState: (_){
            Get.find<UserController>().getUserLevelInfo();
          },
          builder: (userController) {
            return SingleChildScrollView(
              child: Padding(
                padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:  [
                  
                  if(userController.userModel!=null)
                  UserLevelWidget(userLevelModel: userController.userModel!),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),

                  ListView.builder(itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSeven),
                      child: InkWell(
                        onTap: ()=>Get.to(()=>const OfferDetailsScreen()),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                          child: CustomImage(
                            height: 140,
                            width: Get.width,
                            image: 'https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg',
                          ),
                        ),
                      ),
                    );
                  },itemCount: 2,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                ],),
              ),
            );
          }
        ),
      ),
    );
  }
}
