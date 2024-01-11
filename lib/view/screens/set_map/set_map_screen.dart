import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/home_map.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/controller/set_map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/widget/input_field_for_set_route.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

class SetDestinationScreen extends StatefulWidget {
  final String? address;
  const SetDestinationScreen({Key? key, this.address}) : super(key: key);

  @override
  State<SetDestinationScreen> createState() => _SetDestinationScreenState();
}

class _SetDestinationScreenState extends State<SetDestinationScreen> {
  TextEditingController fromRouteController = TextEditingController();
  TextEditingController toRouteController = TextEditingController();
  TextEditingController extraRouteController = TextEditingController();
  TextEditingController entranceController = TextEditingController();
  FocusNode fromNode = FocusNode();
  FocusNode toNode = FocusNode();
  FocusNode entranceNode = FocusNode();
  FocusNode extraNode = FocusNode();
  @override
  void initState() {
    super.initState();
    fromRouteController.text = widget.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: '${''.tr} ${''}',
          showBackButton: false,
          isHome: true,
        ),
        body: GetBuilder<SetMapController>(builder: (setMapController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 160, 3, 32), // Change color to white
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeSmall),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Dimensions.paddingSizeSmall,
                                  Dimensions.paddingSizeLarge,
                                  Dimensions.paddingSizeSmall,
                                  0),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: Dimensions.iconSizeLarge,
                                      child: Image.asset(Images.currentLocation,
                                          color:
                                              Colors.white.withOpacity(0.7))),
                                  SizedBox(
                                      height: 70,
                                      width: 10,
                                      child: CustomDivider(
                                          height: 5,
                                          dashWidth: .75,
                                          axis: Axis.vertical,
                                          color:
                                              Colors.white.withOpacity(0.7))),
                                  SizedBox(
                                      width: Dimensions.iconSizeLarge,
                                      child: Image.asset(
                                          Images.activityDirection,
                                          color:
                                              Colors.white.withOpacity(0.7))),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeDefault),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputField(
                                      controller: fromRouteController,
                                      node: fromNode,
                                      hint: "Enter Current Location Route",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.paddingSizeExtraSmall),
                                      child: Text('to'.tr,
                                          style: textRegular.copyWith(
                                              color: Colors.white)),
                                    ),
                                    ListView.builder(
                                        itemCount:
                                            setMapController.currentExtraRoute,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: Dimensions
                                                    .paddingSizeDefault),
                                            child: InputField(
                                              controller: extraRouteController,
                                              node: extraNode,
                                              hint: "Enter Extra Route",
                                            ),
                                          );
                                        }),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InputField(
                                            controller: toRouteController,
                                            node: toNode,
                                            hint: 'Enter Destination Route',
                                          ),
                                        ),
                                        const SizedBox(
                                          width: Dimensions.paddingSizeSmall,
                                        ),
                                        // GestureDetector(
                                        //   onTap: () =>
                                        //       setMapController.setExtraRoute(),
                                        //   child: Container(
                                        //       height: 40,
                                        //       width: 40,
                                        //       decoration: BoxDecoration(
                                        //         color: Theme.of(context)
                                        //             .primaryColorDark
                                        //             .withOpacity(.35),
                                        //         borderRadius: BorderRadius
                                        //             .circular(Dimensions
                                        //                 .paddingSizeExtraSmall),
                                        //       ),
                                        //       child: const Icon(Icons.add,
                                        //           color: Colors.white)),
                                        // )
                                      ],
                                    ),
                                    const SizedBox(
                                        height: Dimensions.paddingSizeDefault),
                                    setMapController.addEntrance
                                        ? SizedBox(
                                            width: 200,
                                            child: InputField(
                                              controller: entranceController,
                                              node: entranceNode,
                                              hint: 'Enter Entrance',
                                            ))
                                        : GestureDetector(
                                            onTap: () => setMapController
                                                .setAddEntrance(),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                // Remove the SizedBox with the curved arrow image
                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeSmall),

                                                Container(
                                                  // Adjust the padding to maintain the spacing
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: Dimensions
                                                        .paddingSizeSmall,
                                                    vertical: Dimensions
                                                        .paddingSizeExtraSmall,
                                                  ),
                                                  // decoration: BoxDecoration(
                                                  //   color: Theme.of(context).primaryColorDark.withOpacity(.35),
                                                  //   borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                                  // ),
                                                  // child: const Icon(Icons.add, color: Colors.white),
                                                ),

                                                const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeSmall),
                                                // Text(
                                                //   'add_entrance'.tr,
                                                //   style: textMedium.copyWith(
                                                //     color: Colors.white.withOpacity(.75),
                                                //     fontSize: Dimensions.fontSizeLarge,
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Dimensions.paddingSizeExtraLarge,
                              Dimensions.paddingSizeSmall,
                              Dimensions.paddingSizeExtraLarge,
                              Dimensions.paddingSizeExtraLarge),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text(
                              // 'you_can_add_multiple_route_to'.tr,
                              //   style: textRegular.copyWith(
                              //       fontSize: Dimensions.fontSizeSmall,
                              //       color: Colors.white.withOpacity(.75)),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      const MapScreen(fromScreen: 'ride'));
                                  Get.find<RideController>()
                                      .updateRideCurrentState(
                                          RideState.initial);
                                },
                                child: Text('done'.tr,
                                    style: textRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.paddingSizeDefault,
                      10,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeDefault),
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeMap(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class SavedAndRecentItem extends StatelessWidget {
  final String title;
  final String icon;
  final String subTitle;
  final bool isSeeMore;
  final Function()? onTap;
  const SavedAndRecentItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.subTitle,
      this.isSeeMore = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Text(
            title.tr,
            style: textMedium.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: Dimensions.fontSizeLarge),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimensions.paddingSizeDefault,
                0,
                Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeExtraSmall),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(
                          Dimensions.paddingSizeExtraSmall)),
                  child: SizedBox(
                      width: Dimensions.iconSizeMedium,
                      child: Image.asset(
                        icon,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
                const SizedBox(
                  width: Dimensions.paddingSizeSmall,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subTitle.tr,
                      style: textRegular.copyWith(
                          color: Theme.of(context).primaryColor),
                    ),
                    isSeeMore
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeSmall),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall,
                                  vertical: Dimensions.paddingSizeExtraSmall),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(.125),
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.paddingSizeSeven)),
                              child: Text(
                                'see_more'.tr,
                                style: textRegular.copyWith(
                                    color: Theme.of(context).hintColor),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
