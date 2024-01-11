// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/images.dart';
// import 'package:ride_sharing_user_app/util/styles.dart';
// import 'package:ride_sharing_user_app/view/screens/notification/controller/notification_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/notification/widgets/notification_shimmer.dart';
// import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
// import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
// import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
// import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   void initState() {
//     Get.find<UserController>().init(); // Initialize UserController first
//     Get.find<NotificationController>().getNotification();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomBody(
//         appBar: CustomAppBar(
//           title: 'you_have_lots_of_notification'.tr,
//           showBackButton: false,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: Dimensions.paddingSizeExtraSmall,
//                 ),
//                 child: Text(
//                   'your_notification'.tr,
//                   style: textBold.copyWith(
//                     color: Colors.red,
//                     fontSize: Dimensions.fontSizeExtraLarge,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: Dimensions.paddingSizeDefault,
//               ),
//               Expanded(
//                 child: GetBuilder<NotificationController>(
//                   builder: (notificationController) {
//                     return notificationController.notificationList != null
//                         ? ListView.builder(
//                             itemCount:
//                                 notificationController.notificationList!.length,
//                             itemBuilder: (context, item) {
//                               var notification =
//                                   notificationController.notificationList?[item];
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.red.withOpacity(0.07),
//                                   borderRadius: const BorderRadius.all(
//                                     Radius.circular(Dimensions.radiusLarge),
//                                   ),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: Dimensions.paddingSizeDefault,
//                                   vertical: Dimensions.paddingSizeLarge,
//                                 ),
//                                 margin:
//                                     const EdgeInsets.symmetric(vertical: 2),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     IntrinsicHeight(
//                                       child: Row(
//                                         children: [
//                                           const CustomImage(
//                                             image: '',
//                                             radius: Dimensions.radiusDefault,
//                                             height: 35,
//                                             width: 35,
//                                             placeholder: Images.autoPlaceholder,
//                                           ),
//                                           const SizedBox(
//                                             width: Dimensions.paddingSizeSmall,
//                                           ),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 notification?.type ?? '',
//                                                 style: textBold.copyWith(
//                                                   fontSize:
//                                                       Dimensions.fontSizeLarge,
//                                                 ),
//                                               ),
//                                               Text(notification?.data ?? ''),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical:
//                                             Dimensions.paddingSizeExtraSmall,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           const Text('30 min ago'),
//                                           const SizedBox(
//                                             width:
//                                                 Dimensions.paddingSizeExtraSmall,
//                                           ),
//                                           Icon(
//                                             Icons.alarm,
//                                             size: Dimensions.fontSizeLarge,
//                                             color: Theme.of(context)
//                                                 .hintColor
//                                                 .withOpacity(0.5),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           )
//                         : const NotificationShimmer();
//                   },
//                 ),
//               ),
//               Container(height: 70),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/notification/controller/notification_controller.dart';
import 'package:ride_sharing_user_app/view/screens/notification/widgets/notification_shimmer.dart';
import 'package:ride_sharing_user_app/view/screens/profile/controller/user_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    Get.find<UserController>().init();
    Get.find<NotificationController>().getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: ''.tr,
          showBackButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                ),
                child: Text(
                  'your_notification'.tr,
                  style: textBold.copyWith(
                    color: Colors.red,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Expanded(
                child: GetBuilder<NotificationController>(
                  builder: (notificationController) {
                    return notificationController.notificationList != null
                        ? ListView.builder(
                            itemCount:
                                notificationController.notificationList!.length,
                            itemBuilder: (context, item) {
                              var notification =
                                  notificationController.notificationList?[item];

                              List<String> lines = [];
                              String notificationData = notification?.data ?? '';
                              if (notificationData.length > 35) {
                                lines = [
                                  notificationData.substring(0, 34),
                                  notificationData.substring(34),
                                ];
                              } else {
                                lines = [notificationData];
                              }

                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.07),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(Dimensions.radiusLarge),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault,
                                  vertical: Dimensions.paddingSizeLarge,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          const CustomImage(
                                            image: '',
                                            radius: Dimensions.radiusDefault,
                                            height: 35,
                                            width: 35,
                                            placeholder: Images.autoPlaceholder,
                                          ),
                                          const SizedBox(
                                            width: Dimensions.paddingSizeSmall,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notification?.type ?? '',
                                                style: textBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                ),
                                              ),
                                              for (String line in lines)
                                                Text(
                                                  line,
                                                  style: textRegular.copyWith(
                                                    fontSize:
                                                        Dimensions.fontSizeSmall,
                                                  ),
                                                ),
                                                  Text(
                                                formatStringDateTime(  notification!.createdAt ),
                                              
                                                style: TextStyle(
                                                  fontSize:
                                                  15
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical:
                                            Dimensions.paddingSizeExtraSmall,
                                      ),
                                      child: Row(
                                        children: [
                                          // const Text('30 min ago'),
                                            
                                          const SizedBox(
                                            width:
                                                Dimensions.paddingSizeExtraSmall,
                                          ),
                                          Icon(
                                            Icons.alarm,
                                            size: Dimensions.fontSizeLarge,
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const NotificationShimmer();
                  },
                ),
              ),
              Container(height: 70),
            ],
          ),
        ),
      ),
    );
  }
  String formatStringDateTime(String dateTimeString) {
  if (dateTimeString != null) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      print('Error parsing DateTime string: $e');
    }
  }
  return 'N/A'; // or any default value you prefer
}
}
