import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/util/constant.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileAccountInfo extends StatelessWidget {
  const EditProfileAccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    // Initialize TextEditingController with the current values
    TextEditingController nameController =
        TextEditingController(text: userController.name);
    TextEditingController phoneController =
        TextEditingController(text: userController.phone.toString());
    TextEditingController emailController =
        TextEditingController(text: userController.email);

    @override
    void initState() {
      Get.find<UserController>().getUserLevelInfo();
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldTitle(title: 'name'.tr, textOpacity: 0.8),
                CustomTextField(
                  prefixIcon: Images.editProfileName,
                  borderRadius: 10,
                  showBorder: false,
                  controller:
                      nameController, // Use controller instead of hintText
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
                ),
                TextFieldTitle(title: 'phone'.tr, textOpacity: 0.8),
                CustomTextField(
                  prefixIcon: Images.editProfilePhone,
                  borderRadius: 10,
                  showBorder: false,
                  controller:
                      phoneController, // Use controller instead of hintText
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
                ),
                TextFieldTitle(title: 'email'.tr, textOpacity: 0.8),
                CustomTextField(
                  prefixIcon: Images.editProfileEmail,
                  borderRadius: 10,
                  showBorder: false,
                  controller:
                      emailController,
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        CustomButton(
          buttonText: "update_profile".tr,
          onPressed: () async {
            try {
              String userName = nameController.text;
              String phone = phoneController.text;
              String email = emailController.text;

              await update(userName, email, phone);
            } catch (e) {
              print('Error during button click: $e');
            }
          },
        ),
      ],
    );
  }

  Future<void> update(String userName, String email, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse('${Constant().url}rider_update_profile/$userId'));
    String phoneNumberWithoutCode =
        phone.startsWith('+91') ? phone.substring(3) : phone;
    request.body = json.encode({
      "user_name": userName,
      "phone": phoneNumberWithoutCode,
      "email": email,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.back();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<PickedFile?> showImagePickerDialog(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take Photo'),
                onTap: () async {
                  Navigator.pop(context, await pickImage(ImageSource.camera));
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context, await pickImage(ImageSource.gallery));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<PickedFile?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    return await picker.getImage(source: source);
  }
}
