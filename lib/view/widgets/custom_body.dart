import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';

class CustomBody extends StatelessWidget {
  final Widget body;
  final CustomAppBar appBar;
  const CustomBody({Key? key, required this.body, required this.appBar,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        appBar,
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: context.width,
            decoration:  BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                color: Theme.of(context).cardColor
            ),
            child: body,
          ),
        ),
      ],
    );
  }
}
