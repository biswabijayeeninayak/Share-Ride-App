import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/custom_title.dart';

class ParcelCategoryView extends StatelessWidget {
  const ParcelCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParcelController>(
      builder: (parcelController){
        return Column(
          children: [
            CustomTitle(title: "select_your_parcel_type",color: Theme.of(context).primaryColor,),
            SizedBox(
              height: 130,
              child: ListView.builder(
                itemCount: parcelController.parcelCategoryList.length,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return  SizedBox(height: 100, width: 100,
                    child: InkWell(
                      onTap: ()=>parcelController.updateParcelCategoryIndex(index),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

                        Container(height: 80, width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            color: parcelController.selectedParcelCategory==index ?
                            Theme.of(context).primaryColor.withOpacity(0.2):
                            Theme.of(context).hintColor.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                          child: Image.asset(parcelController.parcelCategoryList[index].categoryImage!),
                        ),

                        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                        Text(parcelController.parcelCategoryList[index].categoryTitle!.tr,
                          style: textSemiBold.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                              fontSize: Dimensions.fontSizeSmall
                          ),
                        )],
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        );
      }
    );
  }
}
