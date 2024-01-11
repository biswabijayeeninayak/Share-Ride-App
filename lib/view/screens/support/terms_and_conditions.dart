import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String data = "terms_and_condition".tr;
    return Column(
      children: [
        const SizedBox(height: Dimensions.paddingSizeDefault,),
        Html(
          data: data,
          style: {
            "p": Style(
              fontSize: FontSize.medium,
            ),
          },
        ),
      ],
    );
  }
}
