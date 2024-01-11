import 'package:flutter/material.dart';

class DigitalPaymentModel{
  String? name;
  String? cardNumber;
  String? expireDate;
  String? icon;
  Color? color;
  bool isSelected;

  DigitalPaymentModel(
      {this.name, this.cardNumber, this.expireDate, this.icon, this.color, this.isSelected = false});
}