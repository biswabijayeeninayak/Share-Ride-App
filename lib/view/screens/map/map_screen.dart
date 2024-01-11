import 'dart:async';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_expendable_bottom_sheet.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_expendable_bottom_sheet.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class MapScreen extends StatefulWidget {
  final String fromScreen;
  const MapScreen({Key? key, required this.fromScreen}) : super(key: key);
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomBody(
            appBar:CustomAppBar(title: 'the_deliveryman_need_you'.tr),
            body: GetBuilder<MapController>(
              builder: (userMapController) {
                Completer<GoogleMapController> mapCompleter = Completer<GoogleMapController>();
                if(userMapController.mapController != null) {
                  mapCompleter.complete(userMapController.mapController);
                }
                return ExpandableBottomSheet(

                  background: Stack(
                    children: [
                      Animarker(
                        curve: Curves.easeIn,
                        rippleRadius: 0.2,
                        useRotation: true,
                        duration: const Duration(milliseconds: 2300),
                        mapId: mapCompleter.future.then<int>((value) => value.mapId),
                        //markers: {},
                        shouldAnimateCamera: false,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
                          child: GoogleMap(
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            compassEnabled: true,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(target: userMapController.initialPosition, zoom: 16),
                            onMapCreated: (gController) {
                              userMapController.setMapController(gController);
                            },
                            polylines: Set<Polyline>.of(userMapController.polyLines.values),
                          ),
                        ),
                      ),
                      Positioned(top: 0,bottom: 200,left: 0,right: 0,
                          child: Align(alignment: Alignment.center,child: SizedBox(width:120,
                            child: Image.asset(Images.mapLocationIcon),),))
                    ],
                  ),
                  persistentContentHeight: userMapController.persistentContentHeight,

                  expandableContent:
                    widget.fromScreen=='parcel' ?
                    Column(children: [
                      const ParcelExpendableBottomSheet(),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom,),
                    ]) :
                    widget.fromScreen=='ride' ?
                    Column(children: [
                      const RideExpendableBottomSheet(),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom,),
                    ]): const SizedBox(),
                );
              }
            ),
          ),
          if(widget.fromScreen == 'location')
          Positioned(

            child: Align(alignment: Alignment.bottomCenter,
              child: SizedBox(height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: CustomButton(buttonText: 'set_location'.tr,onPressed: (){Get.back();},),
                ),),
            ),
          )
        ],
      ),
    );
  }
}






