import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/message/widget/message_item.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/search_widget.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: const CustomAppBar(title: "riders_are_saying_to_you",showBackButton: true,),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            children:  [
              const SearchWidget(),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Expanded(
                child: ListView.builder(itemBuilder: (context,index){
                  return  MessageItem(
                    isRead: Random().nextBool(),
                  );
                },
                  itemCount: 10,
                  padding: const EdgeInsets.all(0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
