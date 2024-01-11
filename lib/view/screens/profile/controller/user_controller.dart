// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:ride_sharing_user_app/data/api_checker.dart';
// import 'package:http/http.dart' as http;
// import 'package:ride_sharing_user_app/util/constant.dart';
// import 'package:ride_sharing_user_app/view/screens/offer/model/level_model.dart';
// import 'package:ride_sharing_user_app/view/screens/profile/repository/uer_repo.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserController extends GetxController implements GetxService {
//   final UserRepo userRepo;
//   UserController({required this.userRepo});

//   XFile? _pickedProfileFile ;
//   XFile? get pickedProfileFile => _pickedProfileFile;

//   XFile? _pickedIdentityImageFront ;
//   XFile? get pickedIdentityImageFront => _pickedIdentityImageFront;
//   XFile? _pickedIdentityImageBack ;
//   XFile? get pickedIdentityImageBack => _pickedIdentityImageBack;

//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//     TextEditingController imageController = TextEditingController();

//   TextEditingController addressController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();

//   TextEditingController identityNumberController = TextEditingController();

//   FocusNode fNameNode = FocusNode();
//   FocusNode lNameNode = FocusNode();
//   FocusNode signupPhoneNode = FocusNode();
//   FocusNode signInPhoneNode = FocusNode();
//   FocusNode forgetPasswordPhoneNode = FocusNode();
//   FocusNode changePasswordPhoneNode = FocusNode();

//   UserModel? userModel;

//   @override
//   void onInit() {
//     super.onInit();
//     getUserLevelInfo();
//   }

// String name = '';
// String email = '';
// String phone = '';

// // Function to fetch the data
// Future<void> getUserLevelInfo() async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userId = prefs.getString('userId').toString();
//     final response = await http.get(Uri.parse('http://kods.tech/munsride/api/rider_profile/$userId'));

//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonResponse = json.decode(response.body);
//       Map<String, dynamic> riderData = jsonResponse['data']['rider'];

//       // Update the variables with the retrieved data
//       name = riderData['user_name'];
//       email = riderData['email'];
//       phone = riderData['phone'];

//       // Now, update the controllers if needed
//       nameController.text = name;
//       emailController.text = email;
//       phoneController.text = phone;

//       // Print the variables or use them as needed
//       print('Name: $name');
//       print('Email: $email');
//       print('Phone: $phone');
//     } else {
//       print('Error: ${response.statusCode}, ${response.reasonPhrase}');
//     }
//   } catch (error) {
//     print('Error: $error');
//   }
// }

//   void pickImage(bool isBack, bool isProfile) async {
//     if(isBack){
//       _pickedIdentityImageBack = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
//     }else if(isProfile){
//       _pickedProfileFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
//     } else{
//       _pickedIdentityImageFront = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
//     }
//     update();
//   }

//      void init() {
//     // Add your initialization logic here
//     print('UserController initialized');
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/view/screens/offer/model/level_model.dart';
import 'package:ride_sharing_user_app/view/screens/profile/repository/uer_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  XFile? _pickedProfileFile;
  XFile? get pickedProfileFile => _pickedProfileFile;

  XFile? _pickedIdentityImageFront;
  XFile? get pickedIdentityImageFront => _pickedIdentityImageFront;
  XFile? _pickedIdentityImageBack;
  XFile? get pickedIdentityImageBack => _pickedIdentityImageBack;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode identityNumberNode = FocusNode();

  UserModel? userModel;

  @override
  void onInit() {
    super.onInit();
    getUserLevelInfo();
  }

  String name = '';
  String email = '';
  String phone = '';
  int count_of_bookings = 0;
  int days = 0;
  // Function to fetch the data
  Future<void> getUserLevelInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('userId').toString();
      final response = await http.get(
          Uri.parse('${Constant().url}rider_profile/$userId'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Map<String, dynamic> riderData = jsonResponse['data']['rider'];

        // Update the variables with the retrieved data
        name = riderData['user_name'];
        email = riderData['email'];
        phone = riderData['phone'].toString();
        days = jsonResponse['days'];
        count_of_bookings = jsonResponse['count_of_bookings'];

        // Now, update the controllers if needed
        nameController.text = name;
        emailController.text = email;
        phoneController.text = phone;

        // Print the variables or use them as needed
        print('Name: $name');
        print('Email: $email');
        print('Phone: $phone');
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void pickImage(bool isBack, bool isProfile) async {
    if (isBack) {
      _pickedIdentityImageBack =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    } else if (isProfile) {
      _pickedProfileFile =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    } else {
      _pickedIdentityImageFront =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    }
    update();
  }

  @override
  void onClose() {
    // Dispose of your controllers and focus nodes when the controller is closed
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    imageController.dispose();
    nameNode.dispose();
    phoneNode.dispose();
    emailNode.dispose();
    addressNode.dispose();
    confirmPasswordNode.dispose();
    identityNumberNode.dispose();
    super.onClose();
  }

  void init() {
    print('UserController initialized');
  }
}
