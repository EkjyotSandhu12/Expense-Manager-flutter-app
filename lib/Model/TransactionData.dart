import 'package:flutter/material.dart';


class TransactionData {
  String id;
  String title;
  double amount;
  DateTime date;

  TransactionData({required this.id,required this.title, required this.amount,required this.date});
}
