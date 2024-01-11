
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/categoty_model.dart';


class CategoryRepo{
  final ApiClient apiClient;

  CategoryRepo({required this.apiClient});

  Future<Response> getCategoryList() async {
    List<CategoryModel> categoryList = [];
    try {
      categoryList = [
        CategoryModel(categoryImage: Images.auto, categoryTitle:"Auto" ,discountType: "promotional"),
        CategoryModel(categoryImage: Images.bike, categoryTitle:"bike" ,discountType: "promotional"),
        CategoryModel(categoryImage: Images.parcel, categoryTitle:"parcel" ,discountType: "promotional"),
      ];
      Response response = Response(body: categoryList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }

}