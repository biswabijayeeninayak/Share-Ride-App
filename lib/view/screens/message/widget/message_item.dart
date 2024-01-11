import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/screens/message/message_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class MessageItem extends StatelessWidget {
  final bool isRead;
  const MessageItem({Key? key, required this.isRead}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()=> Get.to(()=>const MessageScreen()),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
          color: isRead ? Theme.of(context).colorScheme.primary.withOpacity(.1) : Theme.of(context).cardColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const SizedBox(width: Dimensions.paddingSizeSmall,),
            ClipRRect(borderRadius: BorderRadius.circular(50),
              child: const CustomImage(height: 35, width: 35,
                  image: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall,),

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Jhon doe', style: textBold.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color:Theme.of(context).primaryColor,
              )),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Text("It is a long established fact that a reader will be distracted by the", style: textMedium.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color:isRead? Theme.of(context).textTheme.bodyMedium!.color :Theme.of(context).hintColor,
                  ),overflow: TextOverflow.ellipsis,),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Text( "12.30 pm",
                  textDirection: TextDirection.ltr,
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                    color: Theme.of(context).primaryColor,
                  ),
                )],
              )])
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall,),
          ],
        ),
      ),
    );
  }
}
