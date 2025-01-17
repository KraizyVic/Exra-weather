import 'package:exraweather/models/details_page_model.dart';

class CurrentNDaysWeatherModel{
  CurrentWeather? currentWeather;
  final List<DayNNightWeather> dayNihgt;
  final List<SunriseSunset> sunriseSunset;
  final TemperaturesHistory tempsHistory;

  CurrentNDaysWeatherModel({
    required this.currentWeather,
    required this.dayNihgt,
    required this.sunriseSunset,
    required this.tempsHistory,
  });
}

class CurrentWeather{
  final String dayAndDate;
  final String timeFrame; // Current, day, night
  final String time;
  final String svgLink;
  final int temperature;
  final List <int> feelsNShadeTemps;
  final List<LabelNValue> labelledValue;

  CurrentWeather({
    required this.dayAndDate,
    required this.timeFrame,
    required this.time,
    required this.svgLink,
    required this.temperature,
    required this.feelsNShadeTemps,
    required this.labelledValue,
  });
}

class DayNNightWeather{
  final String dayAndDate;
  final String timeFrame; // Current, day, night
  final String time;
  final String svgLink;
  final int temperature;
  final List <int> feelsNShadeTemps;
  final List<LabelNValue> labelledValue;

  DayNNightWeather({
    required this.dayAndDate,
    required this.timeFrame,
    required this.time,
    required this.svgLink,
    required this.temperature,
    required this.feelsNShadeTemps,
    required this.labelledValue,
  });
}

class TemperaturesHistory{
  final String date;
  final List<TemperatureHistoryValues> tempsHistory;
  TemperaturesHistory({
    required this.date,
    required this.tempsHistory
  });
}

class TemperatureHistoryValues{
  final String label;
  final String high;
  final String low;
  TemperatureHistoryValues({
    required this.label,
    required this.high,
    required this.low
  });
}
class LabelNValue{
  final String label;
  final String value;
  LabelNValue({
    required this.label,
    required this.value,
  });
}
