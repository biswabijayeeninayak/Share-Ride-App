import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/category_controller.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/set_map_screen.dart';


class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      initState: (_)=> Get.find<CategoryController>().getCategoryList(),
      builder: (categoryController){
      return SizedBox(height: 130, width: Get.width,
        child: ListView.builder(
          itemCount: categoryController.categoryList.length,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return  GestureDetector(
              onTap: (){
                if(index==2) {
                  Get.find<RideController>().updateSelectedRideType(RideType.parcel);
                  Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.initial);
                  Get.to((const MapScreen(fromScreen: 'parcel',)));
                }else{
                  Get.to(()=> const SetDestinationScreen());
                }
              },
              child: SizedBox(height: 100, width: 125,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(height: 80, width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      color:  Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Image.asset(categoryController.categoryList[index].categoryImage!),
                  ),

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  Text(categoryController.categoryList[index].categoryTitle!.tr,
                    style: textSemiBold.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                        fontSize: Dimensions.fontSizeSmall
                    ),
                  )],
                ),
              ),
            );
          }
        ),
      );
    });
  }
}
