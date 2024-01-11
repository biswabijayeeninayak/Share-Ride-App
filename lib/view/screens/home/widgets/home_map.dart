import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';

import 'dart:ui' as ui;

const kStartPosition = LatLng(18.488213, -69.959186);
const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 15);
const kMarkerId = MarkerId('MarkerId1');
const kMarkerId2 = MarkerId('MarkerId2');
const kDuration = Duration(seconds: 2);
const kLocations = [
  kStartPosition, LatLng(23.837689, 90.370076),


];

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  HomeMapState createState() => HomeMapState();
}

class HomeMapState
    extends State<HomeMap> {
  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();
  final stream = Stream.periodic(kDuration, (count) => kLocations[count]).take(kLocations.length);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
  }




  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
      child: Container(height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3))
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          child: Animarker(
            curve: Curves.bounceOut,
            rippleRadius: 0.2,
            useRotation: false,
            duration: const Duration(milliseconds: 2300),
            mapId: controller.future
                .then<int>((value) => value.mapId), //Grab Google Map Id
            markers: markers.values.toSet(),
            child: GoogleMap(
                mapType: MapType.terrain,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,
                initialCameraPosition: kSantoDomingo,
                onMapCreated: (gController) {
                  stream.forEach((value) => newLocationUpdate(value));
                  controller.complete(gController);
                  //Complete the future GoogleMapController
                }),
          ),
        ),
      ),
    );
  }

  void newLocationUpdate(LatLng latLng) async{
    var marker = RippleMarker(
        markerId: kMarkerId,
        position: latLng,
        ripple: false,
        icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(Images.autoIcon, 100)),
        onTap: () {

        });
    var marker2 = RippleMarker(
        markerId: kMarkerId2,
        position: const LatLng(23.836982, 90.374282),
        ripple: false,
        icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(Images.autoIcon, 100)),
        onTap: () {
        });
    setState((){
      markers[kMarkerId] = marker;
      markers[kMarkerId2] = marker2;
    });

  }
}
