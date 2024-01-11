
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/successfully_reviewed_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PaymentController>(
          builder: (paymentController) {
            return CustomBody(
              appBar: CustomAppBar(title: 'how_was_your_feeling'.tr,),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeOverLarge),
                      // child: Center(child: Text('payment_successful'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor))),
                    ),



                    Text('review'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor),),
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Text('share_your_feeling_with_us'.tr,
                          style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: Dimensions.fontSizeSmall
                      ),)),


                    SizedBox(height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                          itemCount: paymentController.reviewTypeList.length,
                          itemBuilder: (context, index){
                        return  ReviewItem(index: index, selectedIndex: paymentController.reviewTypeSelectedIndex,
                          reviewModel: paymentController.reviewTypeList[index],);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 45, bottom: Dimensions.paddingSizeSmall),
                      child: Text('leave_us_a_comment'.tr, style: textRegular.copyWith(),),
                    ),
                    TextFormField(
                      controller: reviewController,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).hintColor.withOpacity(.1),
                        hintText: 'your_feedback'.tr,
                        hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(.5)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          borderSide:  BorderSide(width: 0.5,
                              color: Theme.of(context).hintColor.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          borderSide:  BorderSide(width: 0.5,
                              color: Theme.of(context).primaryColor.withOpacity(0.5)),
                        ),


                      ),

                    ),


              ],),
                ),),
            );
          }
      ),

      bottomNavigationBar: Container(height: 80,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: CustomButton(buttonText: 'submit'.tr, onPressed: (){
            Get.to(()=> const SuccessfullyReviewedScreen());
          },),
        ),),

    );
  }
}


class ReviewItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final ReviewModel reviewModel;
  const ReviewItem({Key? key, required this.index, required this.selectedIndex, required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.find<PaymentController>().setReviewType(index),
      child: SizedBox(width: 80,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
          index == selectedIndex ?
              Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.125),
                  borderRadius: BorderRadius.circular(100)
              ),child: SizedBox(width: 50,child: Image.asset(reviewModel.icon!))):
          SizedBox(width: 30,child: Image.asset(reviewModel.icon!)),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
          Text(reviewModel.title!.tr,
            style: index==selectedIndex
                ? textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color)
                :textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),)
        ],),
      ),
    );
  }
}




