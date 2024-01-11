import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/banner_model.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/banner_repo.dart';


class BannerController extends GetxController implements GetxService {
  final BannerRepo bannerRepo;
  BannerController({required this.bannerRepo});

  List<BannerModel> banners =[];

  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;

  Future<void> getBannerList() async {
    Response response = await bannerRepo.getBannerList();
    if (response.statusCode == 200) {
      banners = [];
      banners.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if(notify) {
      update();
    }
  }
}
