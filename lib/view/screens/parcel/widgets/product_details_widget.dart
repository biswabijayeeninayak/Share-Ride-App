import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({Key? key}) : super(key: key);

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(builder: (parcelController){
      return Column(
        children: [Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1)),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              Row(children: [
                Image.asset(Images.parcelDetails,width: Dimensions.iconSizeSmall,),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Text('product_details'.tr),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                InkWell(onTap: (){
                    parcelController.updateParcelState(ParcelDeliveryState.addOtherParcelDetails);
                    Get.find<MapController>().notifyMapController();
                    },
                  child: Image.asset(Images.editIcon,width: 15,height: 15,)
             )]),

              Icon(Icons.keyboard_arrow_down_rounded,color: Theme.of(context).textTheme.displayLarge!.color,size: 25,),
            ]),

            RowText(title: 'dimensions', leadingText: parcelController.parcelDimensionController.text),
            RowText(title: 'weight', leadingText: parcelController.parcelWeightController.text),
            RowText(title: 'type', leadingText: parcelController.parcelTypeController.text)

          ]),
        ),
          const SizedBox(height: Dimensions.paddingSizeDefault,),
        ],
      );
    });
  }
}

class RowText extends StatelessWidget {
  final String title;
  final String? leadingText;
  const RowText({Key? key, required this.title, required this.leadingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.tr,style: textMedium.copyWith(color: Theme.of(context).textTheme.displayLarge!.color,fontSize: Dimensions.fontSizeSmall),),
          Text(leadingText??'',style: textMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeSmall),),
        ],
      ),
    );
  }
}
