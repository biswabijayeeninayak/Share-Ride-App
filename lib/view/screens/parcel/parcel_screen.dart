import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/banner_view.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/dotted_border_card.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_category_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class ParcelScreen extends StatelessWidget {
  const ParcelScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: const CustomAppBar(title: 'parcel_screen',showBackButton: true,),
        body: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(children:  [

            Expanded(child: Column(children: const [
              BannerView(),
              DottedBorderCard(),
              ParcelCategoryView()
            ])
            ),

            CustomButton(
              buttonText: 'add_parcel'.tr,
              onPressed: ()=>Get.to(()=>const MapScreen(fromScreen: 'parcel')),
            )],
          ),
        ),
      ),
    );
  }
}




