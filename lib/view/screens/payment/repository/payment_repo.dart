

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/digital_payment_model.dart';

class PaymentRepo {
  final ApiClient apiClient;

  PaymentRepo({required this.apiClient});



  Future<Response> getActivityList() async {
    List<DigitalPaymentModel> digitalPaymentMethodList = [];
    try {
      digitalPaymentMethodList = [


        DigitalPaymentModel(name: 'paypal', cardNumber: '76543245678654',expireDate: "4/12", icon: Images.paypal, color: Theme.of(Get.context!).primaryColor),
        DigitalPaymentModel(name: 'paytm', cardNumber: '76543245678677',expireDate: "4/6", icon: Images.paytm, color: Theme.of(Get.context!).colorScheme.secondaryContainer),
        DigitalPaymentModel(name: 'master_card', cardNumber: '76543245678656',expireDate: "4/12", icon: Images.paypal, color: Theme.of(Get.context!).colorScheme.onSecondary),

      ];

      Response response = Response(body: digitalPaymentMethodList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'on boarding data not found');
    }
  }
}