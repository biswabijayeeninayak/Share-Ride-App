import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/rider_details_widget.dart';


class DriverRideRequestDialog extends StatelessWidget {
  final String fromPage;
  const DriverRideRequestDialog({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeExtraLarge*2,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  [
          Material(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
            child: Material(
              borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              child:  const Padding(
                padding: EdgeInsets.all(8.0),
                child: RiderDetailsWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
