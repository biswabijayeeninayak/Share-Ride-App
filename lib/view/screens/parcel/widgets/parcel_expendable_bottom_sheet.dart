import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_details_widget.dart';

class ParcelExpendableBottomSheet extends StatefulWidget {

  const ParcelExpendableBottomSheet({Key? key}) : super(key: key);

  @override
  State<ParcelExpendableBottomSheet> createState() => _ParcelExpendableBottomSheetState();
}

class _ParcelExpendableBottomSheetState extends State<ParcelExpendableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(
      builder: (parcelController) {
        return Container(
          color: Theme.of(context).cardColor,
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [

            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Theme.of(context).canvasColor,
                borderRadius : const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeDefault), topRight : Radius.circular(Dimensions.paddingSizeDefault)),
                boxShadow: [BoxShadow(color: Theme.of(context).hintColor, blurRadius: 5, spreadRadius: 1, offset: const Offset(0,2))],
              ),

              child: Padding(padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child : Column(children: [
                    Container(height: 7, width: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      ),),

                    Padding(
                      padding:  const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                      const ParcelDetailsWidgets(),
                  ])
              ),
            ),
          ],
          ),
        );
      }
    );
  }
}
