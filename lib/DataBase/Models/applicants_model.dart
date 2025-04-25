import 'package:flutter/foundation.dart';

class ApplicantsModel {
  late int? applicantsID;
  late String applicantsName;
  late String applicantsDate;
  late String applicantsStatus;
  final int userId;
  late String userAddres;
  late Uint8List? userNationalImage;
  late String userPhone;
  late String applicantsDescription;
  ApplicantsModel({
    required this.userId,
    required this.userAddres,
    required this.userNationalImage,
    required this.applicantsDescription,
    required this.userPhone,
    this.applicantsID,
    required this.applicantsName,
    required this.applicantsDate,
    required this.applicantsStatus,
  });
  factory ApplicantsModel.fromMap(Map<String, dynamic> maps) => ApplicantsModel(
        applicantsID: maps['applicants_id'],
        userId: maps['user_id'],
        userAddres: maps['user_address'],
        userNationalImage: maps['user_national_Image'],
        applicantsDescription: maps['user_email'],
        userPhone: maps['user_phone'],
        applicantsName: maps['applicants_name'],
        applicantsDate: maps['application_date'],
        applicantsStatus: maps['applicants_status'],
      );
  Map<String, dynamic> toMap() => {
    'applicants_id':applicantsID,
    'user_id':userId,
    'user_address':userAddres,
    'user_national_Image':userNationalImage,
    'user_email':applicantsDescription,
    'user_phone':userPhone,
    'applicants_name':applicantsName,
    'application_date':applicantsDate,
    'applicants_status':applicantsStatus,
  };
}
