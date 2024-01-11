import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/categoty_model.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/repository/parcel_repo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum ParcelDeliveryState {
  initial,
  parcelInfoDetails,
  addOtherParcelDetails,
  riseFare,
  findingRider,
  suggestVehicle,
  acceptRider,
  otpSent,
  parcelOngoing,
  parcelComplete
}

class ParcelController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements GetxService {
  final ParcelRepo parcelRepo;
  ParcelController({required this.parcelRepo});

  var currentParcelState = ParcelDeliveryState.initial;
  late TabController tabController;

  RxString selectedPackageSize = RxString('');

  

 @override
void onInit() {
  super.onInit();
  tabController = TabController(length: 2, vsync: this);
  parcelTypeController.text =
      parcelCategoryList[selectedParcelCategory].categoryTitle.toString().tr;

  // Set default values or leave them empty
  senderAddressController.text = ""; // Default or empty value
  receiverAddressController.text = ""; // Default or empty value
}

// Add a method to update addresses during runtime
void updateAddresses(String senderAddress, String receiverAddress) {
  senderAddressController.text = senderAddress;
  receiverAddressController.text = receiverAddress;
}

  List<CategoryModel> parcelCategoryList = [
    CategoryModel(
      categoryImage: Images.parcelGift,
      categoryTitle: "gift",
    ),
    CategoryModel(
        categoryImage: Images.parcelFragile, categoryTitle: "fragile"),
    CategoryModel(
        categoryImage: Images.parcelDocument, categoryTitle: "document"),
        CategoryModel(categoryImage: Images.food, categoryTitle: "Food"),
        CategoryModel(categoryImage: Images.grocery, categoryTitle: "Grocery"),
        CategoryModel(categoryImage: Images.electronics, categoryTitle: "Electronics"),
    CategoryModel(categoryImage: Images.parcelBox, categoryTitle: "General"),
  ];

  bool parcelDetailsAvailable = false;
  int selectedParcelCategory = 0;
  int selectedSenderAddressIndex = -1;
  int selectedReceiverAddressIndex = -1;
  bool payReceiver = true;

  TextEditingController senderContactController = TextEditingController();
  TextEditingController senderNameController = TextEditingController();
  TextEditingController senderAddressController = TextEditingController();

  TextEditingController receiverContactController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverAddressController = TextEditingController();

  TextEditingController parcelDescriptionController = TextEditingController();
  TextEditingController parcelDimensionController = TextEditingController();
  TextEditingController parcelWeightController = TextEditingController();
  TextEditingController parcelTypeController = TextEditingController();
  TextEditingController parcelitemsController = TextEditingController();

  FocusNode senderContactNode = FocusNode();
  FocusNode senderNameNode = FocusNode();
  FocusNode senderAddressNode = FocusNode();

  FocusNode receiverContactNode = FocusNode();
  FocusNode receiverNameNode = FocusNode();
  FocusNode receiverAddressNode = FocusNode();

  FocusNode parcelDimensionNode = FocusNode();
  FocusNode sizeOfPackageNode = FocusNode();
  FocusNode parcelWeightNode = FocusNode();
  FocusNode parcelitemsNode = FocusNode();

  void updateParcelCategoryIndex(int newIndex) {
    selectedParcelCategory = newIndex;
    parcelTypeController.text =
        parcelCategoryList[selectedParcelCategory].categoryTitle.toString().tr;
    update();
  }

  void updateTabControllerIndex(int newIndex) {
    tabController.index = newIndex;
    update();
  }

  void setParcelAddress(String address) {
    if (tabController.index == 0) {
      senderAddressController.text = address;
    } else {
      receiverAddressController.text = address;
    }
    update();
  }

  void updateParcelDetailsStatus() {
    if (parcelWeightController.text.isNotEmpty &&
        parcelDimensionController.text.isNotEmpty) {
      parcelDetailsAvailable = true;
    } else {
      parcelDetailsAvailable = false;
    }
    update();
  }

  void updateParcelState(ParcelDeliveryState newState) {
    currentParcelState = newState;
    update();
  }

  void updatePaymentPerson(bool newValue) {
    payReceiver = newValue;
    update();
  }

  Future<void> sendDataToApi() async {
    
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    
print("user id: $userId");
    if (userId != null) {
      var url = Uri.parse('${Constant().url}rider/add_all_details/$userId');
      var headers = {'Content-Type': 'application/json'};

      var data = {
        "sender_name": senderNameController.text,
        "sender_phone": senderContactController.text,
        "sender_address": senderAddressController.text,
        "sender_landmark": "",
        "receiver_name": receiverNameController.text,
        "receiver_phone": receiverContactController.text,
        "receiver_address": receiverAddressController.text,
        "receiver_landmark": "",
      };

      var response = await http.post(url, headers: headers, body: json.encode(data));

      if (response.statusCode == 200) {
        // Handle the API response here if needed
        print('API Response: ${response.body}');
    
      } else {
        print('API Request failed with status ${response.statusCode}');
      }
    } else {
      print('User ID is null. Unable to send data to API.');
    }
  } catch (e) {
    print('Error sending data to API: $e');
  }
}



}
