import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/ride/repository/ride_repo.dart';

enum RideState{initial,riseFare,findingRider,acceptingRider,afterAcceptRider,otpSent,ongoingRide,completeRide}
enum RideType{auto,bike,parcel}


class RideController extends GetxController implements GetxService {
  final RideRepo rideRepo;
  RideController({required this.rideRepo});

  var currentRideState = RideState.initial;
  var selectedCategory = RideType.auto;

  bool isBiddingOn =  true;

  double currentFarePrice =0;

  int rideCategoryIndex=0;

  TextEditingController inputFarePriceController = TextEditingController();

  TextEditingController senderContactController = TextEditingController();

  FocusNode parcelWeightNode = FocusNode();


  @override
  void onInit() {
    super.onInit();
    inputFarePriceController.text = "0.00";
  }


  void updateRideCurrentState(RideState newState){
    currentRideState= newState;
    update();
  }


  void updateSelectedRideType(RideType newType){
    selectedCategory= newType;
    update();
  }
  
  void setRideCategoryIndex(int newIndex){
    rideCategoryIndex = newIndex;
    update();
  }

  void resetControllerValue(){
    currentRideState = RideState.initial;
    selectedCategory = RideType.auto;
    rideCategoryIndex =0;
    update();
  }

  void updateFareValue({bool increment = true}){
    if(increment){
      currentFarePrice++;
    }else{
      if(currentFarePrice>1){
        currentFarePrice--;
      }
    }
    inputFarePriceController.text = currentFarePrice.toString();
    update();
  }
}