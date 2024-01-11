import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/address_model.dart';


class AddressRepo{
  final ApiClient apiClient;

  AddressRepo({required this.apiClient});

  Future<Response> getAddressList() async {
    List<AddressModel> addressList = [];
    try {
      addressList = [
        AddressModel(addressType: 'office',addressIcon: Images.addressOffice,address: "25/8 Madartek, Adarshapara Rd"),
        AddressModel(addressType: 'home',addressIcon: Images.addressHome,address: "Plot-688, Road-9 Main Road, Dhaka 1216"),
        AddressModel(addressType: 'Others',addressIcon: Images.addressOthers,address: "House# 99, Apt# B2, Road# 4/25, Block# A, Dhaka 1213"),
        // AddressModel(addressType: 'shopping',addressIcon: Images.addressShopping,address: "R95V+C8, Dhaka"),
      ];
      Response response = Response(body: addressList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }

}