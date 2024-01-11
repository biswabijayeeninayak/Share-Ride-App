import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/address_model.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/address_repo.dart';


class AddressController extends GetxController implements GetxService {
  final AddressRepo addressRepo;
  AddressController({required this.addressRepo});

  List<AddressModel> addressList =[];

  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;

  Future<void> getAddressList() async {
    Response response = await addressRepo.getAddressList();
    if (response.statusCode == 200) {
      addressList = [];
      addressList.addAll(response.body);
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
