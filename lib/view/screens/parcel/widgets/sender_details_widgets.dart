import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class SenderDetailsWidget extends StatefulWidget {

  const SenderDetailsWidget({Key? key}) : super(key: key);

  @override
  State<SenderDetailsWidget> createState() => _SenderDetailsWidgetState();
}

class _SenderDetailsWidgetState extends State<SenderDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(builder: (parcelController){
      return Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('sender_details'.tr,style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const CustomImage(height: 45,width: 46,
                    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcVybh3KjWrKdzfpH6NK6UpVxOrfU1_fJALkk9f9_H&s",
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(parcelController.senderNameController.text,
                      style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorDark),
                      overflow: TextOverflow.ellipsis,
                    ),

                    Text(parcelController.senderContactController.text,
                      style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
