class AirQualityPageModel{
  final CurrentAirQuality currentAirQuality;
  final List<String> polutants;
  final List<DailyForecast> dailyForecast;

  AirQualityPageModel({
    required this.currentAirQuality,
    required this.polutants,
    required this.dailyForecast,
  });
}

class CurrentAirQuality{
  final String day;
  final String date;
  final int aqNumber;
  final String aqUnits;
  final String qualityScore;
  final String description;
  final String basedOn;

  CurrentAirQuality({
    required this.day,
    required this.date,
    required this.aqNumber,
    required this.aqUnits,
    required this.qualityScore,
    required this.description,
    required this.basedOn,
  });
}

class Polutants{
  final String polutantName;
  final String pollutantConditionalValue;
  final String qualityScore;
  final String polutantDescription;
  final int polutantIndex;
  final String polutantConcentration;

  Polutants({
    required this.polutantName,
    required this.pollutantConditionalValue,
    required this.qualityScore,
    required this.polutantDescription,
    required this.polutantIndex,
    required this.polutantConcentration,
  });
}

class DailyForecast{
  final String day;
  final String date;
  final int aqNumber;
  final String aqUnits;
  final String qualityScore;
  final String description;

  DailyForecast({
    required this.day,
    required this.date,
    required this.aqNumber,
    required this.aqUnits,
    required this.qualityScore,
    required this.description,
  });
}