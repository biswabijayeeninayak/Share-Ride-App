import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/banner_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    Get.find<BannerController>().getBannerList();
    return GetBuilder<BannerController>(
      builder: (bannerController) {
        return  SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 130,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1,
              disableCenter: true,
              autoPlayInterval: const Duration(seconds: 7),
              onPageChanged: (index, reason) {
              },
            ),
            itemCount: bannerController.banners.length,
            itemBuilder: (context, index, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
                child:  const CustomImage(
                  image:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwEiTPdPj7KH96gItBJ46uZBwkWNnviMQG5Q&usqp=CAU", //good one
                  fit: BoxFit.cover,
                ),
              );
            },
          )
        );
      },
    );
  }
}
