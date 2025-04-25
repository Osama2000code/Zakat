import 'package:flutter/foundation.dart';

class PaymentModel {
  late int? payID;
  late String paymentName;
  late String paymentDate;
  late Uint8List? paymentImage;
  late int? userID;
  PaymentModel({
    this.payID,
    required this.paymentDate,
    required this.paymentName,
    required this.paymentImage,
    this.userID,
  });
  factory PaymentModel.fromMap(Map<String, dynamic> maos) => PaymentModel(
        payID: maos['payment_id'],
        paymentDate: maos['payment_Date'],
        paymentName: maos['payment_Name'],
        paymentImage: maos['payment_Image'],
        userID: maos['user_id'],
      );
  Map<String, dynamic> toMap() => {
        'payment_id': payID,
        'payment_Date':paymentDate,
        'payment_Name': paymentName,
        'payment_Image': paymentImage,
        'user_id': userID,
      };
}
