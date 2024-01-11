import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/banner_model.dart';


class BannerRepo{
  final ApiClient apiClient;

  BannerRepo({required this.apiClient});

  Future<Response> getBannerList() async {
    List<BannerModel> bannerList = [];
    try {
      bannerList = [
        BannerModel(bannerImage: "https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg", bannerTitle:""),
        BannerModel(bannerImage: "https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg", bannerTitle:"" ,),
        BannerModel(bannerImage: "https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg", bannerTitle:"" ,),
        BannerModel(bannerImage: "https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg", bannerTitle:"" ,)
      ];
      Response response = Response(body: bannerList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }

}