import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_details_widget.dart';

class RideExpendableBottomSheet extends StatefulWidget {

  const RideExpendableBottomSheet({Key? key}) : super(key: key);

  @override
  State<RideExpendableBottomSheet> createState() => _RideExpendableBottomSheetState();
}

class _RideExpendableBottomSheetState extends State<RideExpendableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
        builder: (carRideController) {
          return Container(
            color: Theme.of(context).canvasColor,
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
                      const BikeRideDetailsWidgets()
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
