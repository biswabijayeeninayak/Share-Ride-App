
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/model/suggested_route_model.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/repository/set_map_repo.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetMapController extends GetxController implements GetxService{
  final SetMapRepo setMapRepo;

  SetMapController({required this.setMapRepo});

  List<SuggestedRouteModel> suggestedRouteList = [];
  int currentExtraRoute = 0;
  void setExtraRoute(){
    if(currentExtraRoute < 2){
      currentExtraRoute = currentExtraRoute + 1;
    }

    update();
  }

  bool addEntrance = false;
  void setAddEntrance(){
    addEntrance = !addEntrance;
    update();
  }

  void getSuggestedRouteList() async {
    Response response = await setMapRepo.getSuggestedRouteList();
    if (response.statusCode == 200) {
      suggestedRouteList = [];
      suggestedRouteList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }





}