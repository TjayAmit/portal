import 'package:zcmc_portal/src/authentication/model/area_assigned_model.dart';
import 'package:zcmc_portal/src/authentication/model/job_position_model.dart';

class DesignationModel {
  final JobPositionModel jobPosition;
  final AreaAssignedModel area;

  DesignationModel({
    required this.jobPosition,
    required this.area,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) {
    return DesignationModel(
      jobPosition: JobPositionModel.fromJson(json['position']),
      area: AreaAssignedModel.fromJson(json['area']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': jobPosition.toJson(),
      'area': area.toJson(),
    };
  }
} 