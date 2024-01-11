import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/address_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/address_item_card.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/custom_title.dart';

class HomeMyAddress extends StatelessWidget {
  final String? title;
  final String? fromPage;
  
  const HomeMyAddress({Key? key, this.title, this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      initState: (_) {
        Get.find<AddressController>().getAddressList();
      },
      builder: (addressController) {
        return Column(
          children: [
            CustomTitle(
              title: title ?? 'my_address'.tr,
              color: Theme.of(context).textTheme.displayLarge!.color,
            ),
            SizedBox(
              height: 35,
              child: ListView.builder(
                itemCount: addressController.addressList.length,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemExtent: 130.0,
                itemBuilder: (context, index) {
                  return AddressItemCard(
                    addressModel: addressController.addressList[index],
                    fromPage: fromPage!,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
