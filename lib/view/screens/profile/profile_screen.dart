import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/activity/repository/activity_repo.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/review_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
import 'package:ride_sharing_user_app/view/screens/profile/edit_profile_screen.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widgets/profile_item.dart';
import 'package:ride_sharing_user_app/view/screens/settings/setting_screen.dart';
import 'package:ride_sharing_user_app/view/screens/support/support.dart';
import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

@override
void initState() {
  Get.find<UserController>().getUserLevelInfo();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(builder: (userController) {
        return CustomBody(
          appBar: CustomAppBar(
            title: 'make_your_profile_to_earn_point'.tr,
            showBackButton: false,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 140,
                          width: 280,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildColumnItem(
                                    'Total Rides',
                                    Get.find<UserController>().days.toString(),
                                    context,
                                  ),
                                  Container(
                                    width: 1,
                                    height: 40,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  _buildColumnItem(
                                    'Total Days',
                                    Get.find<UserController>()
                                        .count_of_bookings
                                        .toString(),
                                    context,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: -40,
                          left: Get.find<LocalizationController>().isLtr
                              ? -25
                              : null,
                          right: Get.find<LocalizationController>().isLtr
                              ? null
                              : -25,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: const CustomImage(
                                height: 80,
                                width: 80,
                                image:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx1kJPblToIjzrnXLQoV8p85JGixv3ERqouA&usqp=CAU',
                                placeholder: Images.personPlaceholder,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -30,
                          left:
                              Get.find<LocalizationController>().isLtr ? 65 : 0,
                          right:
                              Get.find<LocalizationController>().isLtr ? 0 : 65,
                          child: SizedBox(
                            width: 210,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    Get.find<UserController>().name,
                                    style: textBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraLarge),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ProfileMenuItem(
                    title: 'profile',
                    icon: Images.profileProfile,
                    onTap: () => Get.to(() => const EditProfileScreen()),
                  ),
                  ProfileMenuItem(
                      title: 'My Rides',
                      icon: Images.profileMyTrip,
                      onTap: () => Get.to(() => ActivityScreenData())),
                  ProfileMenuItem(
                    title: 'help_support',
                    icon: Images.profileHelpSupport,
                    onTap: () => Get.to(const HelpAndSupportScreen()),
                  ),
                  ProfileMenuItem(
                    title: 'settings',
                    icon: Images.profileSetting,
                    onTap: () => Get.to(const SettingScreen()),
                  ),
                  ProfileMenuItem(
                    title: 'Ratings',
                    icon: Images.profileSetting,
                    onTap: () => Get.to(const ReviewScreen()),
                  ),
                  ProfileMenuItem(
                    title: 'logout',
                    icon: Images.profileLogout,
                    divider: false,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return ConfirmationDialog(
                              icon: Images.profileLogout,
                              title: 'logout'.tr,
                              description:
                                  'do_you_want_to_log_out_this_account'.tr,
                              onYesPressed: () {
                                Get.find<AuthController>()
                                    .clearSharedData()
                                    .then((condition) {
                                  Get.back();
                                  Get.offAll(const SignInScreen());
                                });
                              },
                            );
                          });
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge * 4,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Column _buildColumnItem(String title, dynamic value, BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: textBold.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeExtraLarge,
          ),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeExtraSmall,
        ),
        Text(
          title.tr,
          style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
        ),
      ],
    );
  }
}
