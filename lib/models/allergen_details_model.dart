import 'package:exraweather/models/health_n_activities_model.dart';

class AllergenDetailsModel{
  final String allergenName;
  final String allergenDescription;
  final String safteyTip;
  final String healthNactivitiesLink;
  final List<Factors> relatedHealthActivities;

  AllergenDetailsModel({
    required this.allergenName,
    required this.allergenDescription,
    required this.safteyTip,
    required this.healthNactivitiesLink,
    required this.relatedHealthActivities,
  });
}