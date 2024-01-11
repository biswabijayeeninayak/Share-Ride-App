// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/util/dimensions.dart';
// import 'package:ride_sharing_user_app/util/styles.dart';
// import 'package:ride_sharing_user_app/view/screens/home/controller/category_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';

// class RideCategoryWidget extends StatelessWidget {

//   const RideCategoryWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RideController>(
//       initState: (_)=> Get.find<CategoryController>().getCategoryList(),
//       builder: (rideController){
//         return SizedBox(height: 110, width: Get.width,
//           child: ListView.builder(
//             itemCount: Get.find<CategoryController>().categoryList.length-1,
//             padding: EdgeInsets.zero,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context,index){

//               return  SizedBox(height: 100, width: 100,
//                 child: InkWell(onTap:(){
//                   if(index==0){
//                     rideController.updateSelectedRideType(RideType.auto);
//                   }
//                   else if(index==1){
//                     rideController.updateSelectedRideType(RideType.bike);
//                   }
//                   rideController.setRideCategoryIndex(index);
//                   },
//                   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//                     Container(height: 80, width: 90,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                         color: rideController.rideCategoryIndex==index
//                             ? Theme.of(context).primaryColor.withOpacity(0.8)
//                             : Theme.of(context).hintColor.withOpacity(0.1),
//                       ),
//                       padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                       child: Image.asset(Get.find<CategoryController>().categoryList[index].categoryImage!),
//                     ),

//                     const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
//                     Text(Get.find<CategoryController>().categoryList[index].categoryTitle!.tr,
//                       style: textSemiBold.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
//                           fontSize: Dimensions.fontSizeSmall
//                       ),
//                     )],
//                   ),
//                 ),
//               );
//             }
//           ),
//         );
//       }
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/category_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/categoty_model.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';

class RideCategoryWidget extends StatelessWidget {
  const RideCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(
      initState: (_) => Get.find<CategoryController>().getCategoryList(),
      builder: (rideController) {
        var categoryController = Get.find<CategoryController>();
        var categories = categoryController.categoryList;

        // Assuming the first two categories are 'auto' and 'bike'
        if (categories.length >= 2) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryItem(context, rideController, categories[0], 0),
                SizedBox(width: Dimensions.paddingSizeDefault), // Space between the buttons
                _buildCategoryItem(context, rideController, categories[1], 1),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('Not enough categories'),
          );
        }
      },
    );
  }

  Widget _buildCategoryItem(BuildContext context, RideController rideController, CategoryModel category, int index) {
    return InkWell(
      onTap: () {
        if (index == 0) {
          rideController.updateSelectedRideType(RideType.auto);
        } else if (index == 1) {
          rideController.updateSelectedRideType(RideType.bike);
        }
        rideController.setRideCategoryIndex(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              color: rideController.rideCategoryIndex == index
                  ? Theme.of(context).primaryColor.withOpacity(0.8)
                  : Theme.of(context).hintColor.withOpacity(0.1),
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Image.asset(category.categoryImage!),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            category.categoryTitle!.tr,
            style: textSemiBold.copyWith(
              color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
              fontSize: Dimensions.fontSizeSmall,
            ),
          ),
        ],
      ),
    );
  }
}