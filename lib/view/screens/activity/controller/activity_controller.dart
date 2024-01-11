import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/activity/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/activity/repository/activity_repo.dart';

class ActivityController extends GetxController implements GetxService {
  final ActivityRepo activityRepo;
  ActivityController({required this.activityRepo});

  final List<String> _filterList = ['all', 'today', 'yesterday', 'custom'];

  List<String> get filterList => _filterList;

  List<ActivityItemModel> activityItemList = [];

  bool _showCustomDate = false;
  bool get showCustomDate => _showCustomDate;
  String _filterStartDate = '';
  String get filterStartDate => _filterStartDate;

  String _filterEndDate = '';
  String get filterEndDate => _filterEndDate;

  final LatLng _initialPosition = const LatLng(23.83721, 90.363715);
  LatLng get initialPosition => _initialPosition;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  Map<PolylineId, Polyline> polyLines = {};

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void getRewardList() async {
    Response response = await activityRepo.getActivityList();
    if (response.statusCode == 200) {
      activityItemList = [];
      activityItemList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void updateShowCustomDateState(bool state) {
    _showCustomDate = state;
    update();
  }

  void setFilterDateRangeValue({String? start, String? end}) {
    _filterStartDate = start ?? "";
    _filterEndDate = end ?? "";
    update();
  }

  
}
