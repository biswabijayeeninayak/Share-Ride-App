import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widgets/edit_profile_account_info.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    super.initState();
    getUserLevelInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: const CustomAppBar(
          title: 'make_your_profile_to_earn_point',
          showBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
          child: Column(
            children: [
              GetBuilder<UserController>(builder: (userController) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => userController.pickImage(false, true),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor, width: 2)),
                        child: Stack(clipBehavior: Clip.none, children: [
                          userController.pickedProfileFile == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: const CustomImage(
                                    height: 70,
                                    width: 70,
                                    image:
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1kJPblToIjzrnXLQoV8p85JGixv3ERqouA&usqp=CAU',
                                    placeholder: Images.personPlaceholder,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 35,
                                  backgroundImage: FileImage(File(
                                      userController.pickedProfileFile!.path))),
                          Positioned(
                              right: 5,
                              bottom: -3,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(
                                  Icons.camera_enhance_rounded,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ))
                        ]),
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              Get.find<UserController>().name,
                              style: textBold.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'account_info'.tr,
                  style: textSemiBold.copyWith(
                    color: Get.isDarkMode
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeSmall,
              ),
              Expanded(
                child: EditProfileAccountInfo(),
              )
            ],
          ),
        ),
      ),
    );
  }

  int count_of_bookings = 0;
  int days = 0;

  String name = '';
  String email = '';
  String phone = '';
  Future<void> getUserLevelInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('userId').toString();
      final response = await http.get(
          Uri.parse('http://kods.tech/munsride/api/rider_profile/$userId'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Map<String, dynamic> riderData = jsonResponse['data']['rider'];

        setState(() {
          name = riderData['user_name'];
          email = riderData['email'];
          phone = riderData['phone']
              .toString(); // Only convert if 'phone' is a string in the API
          days = jsonResponse['days'];
          count_of_bookings = jsonResponse['count_of_bookings'];
        });
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
}
