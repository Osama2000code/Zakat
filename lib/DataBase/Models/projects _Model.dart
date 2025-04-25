import 'package:flutter/foundation.dart';

class ProjectModel {
  late int? projectID;
  final String projectName;
  late String projectDescription;
  late Uint8List? projectImage;
  late String projectTargetAmount;
  late String projectTargetRaised;
  late String? projectStartDate;
  late String projectEndDate;
  late String? projectStatus;
  ProjectModel({
    this.projectID,
    required this.projectName,
    required this.projectDescription,
    this.projectImage,
    required this.projectTargetAmount,
    required this.projectTargetRaised,
    this.projectStartDate,
    required this.projectEndDate,
    this.projectStatus,
  });
  factory ProjectModel.fromMap(Map<String, dynamic> maps) => ProjectModel(
        projectID: maps['project_id'],
        projectName: maps['project_name'],
        projectDescription: maps['project_description'],
        projectImage: maps['project_image'],
        projectTargetAmount: maps['project_arget_amount'],
        projectTargetRaised: maps['project_target_raised'],
        projectStartDate: maps['project_start_date'],
        projectEndDate: maps['project_end_date'],
        projectStatus: maps['project_status'],
      );
  Map<String, dynamic> toMap() => {
        'project_id': projectID,
        'project_name': projectName,
        'project_description': projectDescription,
        'project_image': projectImage,
        'project_arget_amount': projectTargetAmount,
        'project_target_raised': projectTargetRaised,
        'project_start_date': projectStartDate,
        'project_end_date': projectEndDate,
        'project_status': projectStatus,
      };
}
