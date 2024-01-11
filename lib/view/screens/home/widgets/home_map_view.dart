// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_animarker/core/ripple_marker.dart';
// import 'package:flutter_animarker/widgets/animarker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/images.dart';

// import 'dart:ui' as ui;

// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_animarker/core/ripple_marker.dart';
// import 'package:flutter_animarker/widgets/animarker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/images.dart';

// const kDuration = Duration(seconds: 2);

// class HomeMapView extends StatefulWidget {
//   const HomeMapView({super.key});

//   @override
//   HomeMapViewState createState() => HomeMapViewState();
// }

// class HomeMapViewState extends State<HomeMapView> {
//   final markers = <MarkerId, Marker>{};
//   final controller = Completer<GoogleMapController>();
//   final stream = Stream.periodic(kDuration, (count) => LatLng(23.837689, 90.370076))
//       .take(1); // Changed to take only one location for simplicity
//   BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

//   @override
//   void initState() {
//     super.initState();
//     // loadMarkerIcons();
//   }

//   Future<void> loadMarkerIcons() async {
//     markerIcon = BitmapDescriptor.fromBytes(await getBytesFromAsset(Images.autoIcon, 100));
//   }

//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
//       child: Container(
//         height: 255,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
//             border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3))),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
//           child:
          
//            Animarker(
//             curve: Curves.bounceOut,
//             rippleRadius: 0.2,
//             useRotation: false,
//             duration: const Duration(milliseconds: 2300),
//             mapId: controller.future
//                 .then<int>((value) => value.mapId), //Grab Google Map Id
//             markers: markers.values.toSet(),
//             child: GoogleMap(
//               mapType: MapType.normal,
//               myLocationEnabled: true,
//               zoomControlsEnabled: false,
//               myLocationButtonEnabled: true,
              
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(23.837689, 90.370076), // Set your default location here
//                 zoom: 15,
//               ),
//               onMapCreated: (gController) {
//                 stream.forEach((value) => newLocationUpdate(value));
//                 controller.complete(gController);
//               },
//             ),
//           ),
      
//         ),
//       ),
//     );
//   }

//   void newLocationUpdate(LatLng latLng) async {
//     var marker = RippleMarker(
//       markerId: MarkerId('MarkerId1'),
//       position: latLng,
//       ripple: false,
//       icon: markerIcon,
//       onTap: () {
//         // Handle marker tap
//       },
//     );

//     setState(() {
//       markers[MarkerId('MarkerId1')] = marker;
//     });
//   }
// }


// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   late GoogleMapController mapController;
//   late LocationData currentLocation;
//   Location location = Location();

//   @override
//   void initState() {
//     super.initState();
//     _initLocation();
//   }

//   // Initialize location plugin
//   Future<void> _initLocation() async {
//     var serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     // var permissionGranted = await location.hasPermission();
//     // if (permissionGranted == PermissionStatus.denied) {
//     //   permissionGranted = await location.requestPermission();
//     //   if (permissionGranted != PermissionStatus.granted) {
//     //     return;
//     //   }
//     // }

//     location.onLocationChanged.listen((LocationData result) {
//       setState(() {
//         currentLocation = result;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(0, 0),
//           zoom: 15.0,
//         ),
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//       );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }
// }





//Biswa code

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
class HomeMapView extends StatefulWidget {
  const HomeMapView({super.key});

  @override
  HomeMapViewState createState() => HomeMapViewState();
}

class HomeMapViewState extends State<HomeMapView> {
  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();
  final stream = Stream.periodic(kDuration, (count) => kLocations[count]).take(kLocations.length);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    loadMarkerIcons();
  }

  Future<void> loadMarkerIcons() async {
    markerIcon = BitmapDescriptor.fromBytes(await getBytesFromAsset(Images.autoIcon, 100));
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
      child: Container(height: 255,
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

   void newLocationUpdate(LatLng latLng) async {
    var marker = RippleMarker(
      markerId: kMarkerId,
      position: latLng,
      ripple: false,
      icon: markerIcon, // Use the preloaded markerIcon
      onTap: () {
        // Handle marker tap
      },
    );

    var marker2 = RippleMarker(
      markerId: kMarkerId2,
      position: const LatLng(23.836982, 90.374282),
      ripple: false,
      icon: markerIcon, // Use the preloaded markerIcon
      onTap: () {
        // Handle marker tap
      },
    );

    setState(() {
      markers[kMarkerId] = marker;
      markers[kMarkerId2] = marker2;
    });
  }
}