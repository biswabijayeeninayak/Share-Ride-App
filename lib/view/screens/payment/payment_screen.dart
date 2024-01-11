
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/digital_card_payment_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/payment_type_item_widget.dart';
// import 'package:ride_sharing_user_app/view/screens/payment/widget/review_screen.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/tips_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/trip_fare_summery.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PaymentController>(
        builder: (paymentController) {
          return CustomBody(
            appBar: CustomAppBar(title: 'here_is_your_payment'.tr,
             showBackButton: true,
        onBackPressed: () {
          Get.to(() => const DashboardScreen());
        },
            ),
            body: SingleChildScrollView(child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraLarge),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Text('payment'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                  Container(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeThree),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  ),child: Row(children: [
                    Text('cash'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                    SizedBox(width: Dimensions.iconSizeSmall, child: Image.asset(Images.cash))
                  ],))
                ],),


              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Text('this_trip_is'.tr),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                Text('complete'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
              ],),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: Text(PriceConverter.convertPrice(context, 210),style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeOverLarge,color: Theme.of(context).textTheme.bodyMedium!.color)),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('your'.tr, style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                Text('total_fare'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                Text('for_this_trip'.tr, style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),),
              ],),

              Row(crossAxisAlignment: paymentController.paymentTypeSelectedIndex == 2? CrossAxisAlignment.end:CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paymentController.paymentTypeList.length,
                        itemBuilder: (context, index){
                      return PaymentTypeItem(
                          title: paymentController.paymentTypeList[index],
                        index: index,
                        selectedIndex: paymentController.paymentTypeSelectedIndex,
                      );
                    }),
                  ),
                  paymentController.paymentTypeSelectedIndex == 1?
                  GestureDetector(
                    onTap: (){
                      showDialog(context: context, builder: (_)=>const TipsWidget());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Container(decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.35),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                      ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:Dimensions.iconSizeSmall, vertical: Dimensions.paddingSizeSmall),
                            child: Text(paymentController.tipAmount == '0'? 'add_tips'.tr:'${'tips'.tr}-${paymentController.tipAmount}', style: textSemiBold.copyWith(color: Theme.of(context).primaryColorDark),),
                          ),
                        ),),
                    ),
                  ):paymentController.paymentTypeSelectedIndex == 2
                      ? Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(text: 'available'.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                          TextSpan(
                            text: PriceConverter.convertPrice(context, 67),
                            style: textSemiBold.copyWith(color: Theme.of(context).hintColor)
                          ),

                        ],
                    ),
                  ),
                      ):const SizedBox()
                ],
              ),

              paymentController.paymentTypeSelectedIndex == 1?
              Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge),
                child: Stack(
                  children: [
                    SizedBox(height: 160,
                      child: ListView.builder(
                        itemCount: paymentController.digitalPaymentMethodList.length,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                          return DigitalCardPaymentWidget(digitalPaymentModel: paymentController.digitalPaymentMethodList[index], index: index,);

                      }),
                    ),

                  ],
                ),
              ):const SizedBox(),
              Padding(
                padding:  const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.125),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                ),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Text('trip_details'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                   Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor.withOpacity(.75),)
                ],),),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
                child: RouteWidget(),
              ),

              const TripFareSummery(fromPayment: true,),

            ],),),
          );
        }
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
        height: 80,
        child: CustomButton(buttonText: 'pay_now'.tr,
        onPressed: (){
          // Get.off(()=> const ReviewScreen());
          Get.off(()=> const DashboardScreen());
          //  Get.to(FindingRiderWidget(fromPage:"parcel"));
        })),
    );
  }
}






