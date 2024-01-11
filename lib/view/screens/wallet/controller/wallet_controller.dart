import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/my_earn_model.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/model/wallet_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/repository/wallet_repo.dart';

class WalletController extends GetxController implements GetxService{
  final WalletRepo walletRepo;

  WalletController({required this.walletRepo});

  TextEditingController inputController = TextEditingController();
  FocusNode inputNode = FocusNode();

  List<MyEarnModel> myEarnList =[];
  List<WalletItem> paymentMethodList =[];
  List<WalletItem> promoCodeList =[];
  List<WalletItem> voucherList =[];


  bool isConvert = false;
  void toggleConvertCard(bool value){
    isConvert = value;
    update();
  }


  void getMyEarnList() async {
    Response response = await walletRepo.getMyEarnList();
    if (response.statusCode == 200) {
      myEarnList = [];
      myEarnList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getPaymentMethodList() async {
    Response response = await walletRepo.getPaymentMethodList();
    if (response.statusCode == 200) {
      paymentMethodList = [];
      paymentMethodList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getVoucherList() async {
    Response response = await walletRepo.getVoucherList();
    if (response.statusCode == 200) {
      voucherList = [];
      voucherList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void getPromoCodeList() async {
    Response response = await walletRepo.getPromoCodeList();
    if (response.statusCode == 200) {
      promoCodeList = [];
      promoCodeList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}