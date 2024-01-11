import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapController extends GetxController implements GetxService {

  
  String fromPage = 'parcel';
  
  final double _persistentContentHeight = 550;
  double get persistentContentHeight => _persistentContentHeight;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _checkIsRideAccept = false;
  bool get checkIsRideAccept => _checkIsRideAccept;

  double infoContainerHeight = 200;

  bool clickedAssistant = false;
  void toggleAssistant(){
    clickedAssistant = !clickedAssistant;
    update();
  }

  bool isExpanded = false;
  void toggleExpanded(){
    isExpanded = !isExpanded;
    if(isExpanded){
      infoContainerHeight = 500;
    }
    update();
  }
  

  bool activatedPack = false;
  void toggleActivatedPack(){
    activatedPack = !activatedPack;
    update();
  }

  void notifyMapController(){
    update();
  }


  int _stayOnlineTypeIndex = 0;
  int get stayOnlineTypeIndex => _stayOnlineTypeIndex;
  void setStayOnlineTypeIndex(int index){
    _stayOnlineTypeIndex = index;
    update();
  }


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }




  final List<LatLng> _latLngList = [const LatLng(23.8376661, 90.3701626),];
  List<LatLng> toTatLngList = [const LatLng(23.8376661, 90.3701626),];

  List<LatLng> get latLngList => _latLngList;
  final double _distance = 0;
  double get distance => _distance;

  late Position _position;
  Position get position => _position;

  LatLng _initialPosition = const LatLng(23.83721, 90.363715);
  LatLng get initialPosition => _initialPosition;

  final LatLng _customerPosition = const LatLng(12,12);//Get.find<AuthController>().currentLocation;
  late LatLng _destinationPosition;
  LatLng get customerInitialPosition => _customerPosition;
  LatLng get destinationPosition => _destinationPosition;

  var markers = <MarkerId, Marker>{};
   GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  Map<PolylineId, Polyline> polyLines = {

  };
  List<LatLng> polylineCoordinates = [];
  LatLng carLocation = const LatLng(23.835856, 90.363715);
  final int _reload = 0;
  int get reload => _reload;
  MarkerId myMarkerId = const MarkerId('myMarker');
  MarkerId customerMarkerId = const MarkerId('customerMarker');


  void initializeData() {
    getCurrentLocation();
    markers = {};
    polyLines = {};
    _isLoading = false;
  }


  void acceptedRideRequest(){
    _checkIsRideAccept = !_checkIsRideAccept;
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  
  Future<Position> getCurrentLocation({bool isAnimate = true}) async {
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _position = newLocalData;
      _initialPosition = LatLng(_position.latitude, _position.longitude);
      if(isAnimate) {
        _mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _initialPosition, zoom: 16)));
      }
    }catch(e){
      if (kDebugMode) {
        print('');
      }
    }

    return _position;
  }

}





// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'dart:ui' as ui show instantiateImageCodec, ImageByteFormat;



// class MapController extends GetxController implements GetxService {
//   String fromPage = 'parcel';

//   final double _persistentContentHeight = 550;
//   double get persistentContentHeight => _persistentContentHeight;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   bool _checkIsRideAccept = false;
//   bool get checkIsRideAccept => _checkIsRideAccept;

//   double infoContainerHeight = 200;

//   bool clickedAssistant = false;
//   void toggleAssistant() {
//     clickedAssistant = !clickedAssistant;
//     update();
//   }

//   bool isExpanded = false;
//   void toggleExpanded() {
//     isExpanded = !isExpanded;
//     if (isExpanded) {
//       infoContainerHeight = 500;
//     }
//     update();
//   }

//   bool activatedPack = false;
//   void toggleActivatedPack() {
//     activatedPack = !activatedPack;
//     update();
//   }

//   void notifyMapController() {
//     update();
//   }

//   int _stayOnlineTypeIndex = 0;
//   int get stayOnlineTypeIndex => _stayOnlineTypeIndex;
//   void setStayOnlineTypeIndex(int index) {
//     _stayOnlineTypeIndex = index;
//     update();
//   }

//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec =
//         await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }

//   final List<LatLng> _latLngList = [const LatLng(23.8376661, 90.3701626)];
//   List<LatLng> toTatLngList = [const LatLng(23.8376661, 90.3701626)];

//   List<LatLng> get latLngList => _latLngList;
//   final double _distance = 0;
//   double get distance => _distance;

//   late Position _position;
//   Position get position => _position;

//   LatLng _initialPosition = const LatLng(23.83721, 90.363715);
//   LatLng get initialPosition => _initialPosition;

//   final LatLng _customerPosition = const LatLng(12, 12);
//   late LatLng _destinationPosition;
//   LatLng get customerInitialPosition => _customerPosition;
//   LatLng get destinationPosition => _destinationPosition;

//   var markers = <MarkerId, Marker>{};
//   GoogleMapController? _mapController;
//   GoogleMapController? get mapController => _mapController;
//   Map<PolylineId, Polyline> polyLines = {};

//   void initializeData() {
//     getCurrentLocation();
//     markers = {};
//     polyLines = {};
//     _isLoading = false;
//   }

//   void acceptedRideRequest() {
//     _checkIsRideAccept = !_checkIsRideAccept;
//   }

//   void setMapController(GoogleMapController mapController) {
//     _mapController = mapController;
//   }

//   Future<Position> getCurrentLocation({bool isAnimate = true}) async {
//     try {
//       Position newLocalData =
//           await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       _position = newLocalData;
//       _initialPosition = LatLng(_position.latitude, _position.longitude);
//       if (isAnimate) {
//         _mapController?.animateCamera(
//             CameraUpdate.newCameraPosition(CameraPosition(target: _initialPosition, zoom: 16)));
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('');
//       }
//     }

//     return _position;
//   }
// }
