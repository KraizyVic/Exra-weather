class DetailsPageModel{
  final String alert;
  final TodayWeather todayWeather;
  final CurrentWeatherNow currentWeather;
  final LookingAhead? lookingAhead;
  final List<HourlyForecast> hourlyForecast;
  final List<TenDayForecast> tenDayForecast;
  final List<SunriseSunset> sunriseSunset;
  final AirQuality airQuality;
  final Alergy allergy;

  DetailsPageModel({
    required this.alert,
    required this.todayWeather,
    required this.currentWeather,
    required this.lookingAhead,
    required this.hourlyForecast,
    required this.tenDayForecast,
    required this.sunriseSunset,
    required this.airQuality,
    required this.allergy,
  });
}
class TodayWeather{
  final String link;
  final String date;
  final List<TodaysWeatherMetrics> todayWeatherMetrics;
  TodayWeather({
    required this.link,
    required this.date,
    required this.todayWeatherMetrics,
  });
}
class TodaysWeatherMetrics{
  final String iconData;
  final String weather;
  final String value;
  TodaysWeatherMetrics({
    required this.iconData,
    required this.weather,
    required this.value,
  });

}


class CurrentWeatherNow{
  final String currentWeatherLink;
  final String curentWeatherTime;
  final String currentWeatherIcon;
  final String currentTemperature;
  final String currentRealFeelTemperature;
  final String currentWeather;
  final List<CurrentDetails> todaysDetails;
  CurrentWeatherNow({
    required this.currentWeatherLink,
    required this.curentWeatherTime,
    required this.currentWeatherIcon,
    required this.currentTemperature,
    required this.currentRealFeelTemperature,
    required this.currentWeather,
    required this.todaysDetails,
  });
}
class CurrentDetails{
  final String condition;
  final String value;
  CurrentDetails({
    required this.condition,
    required this.value,
  });
}

class LookingAhead{
  final String lookingAheadLink;
  final String lookingAhead;

  LookingAhead({
    required this.lookingAheadLink,
    required this.lookingAhead
  });
}


class HourlyForecast{
  final String link;
  final String time;
  final String weatherIcon;
  final String temperature;
  final int precipitation;

  HourlyForecast({
    required this.link,
    required this.time,
    required this.weatherIcon,
    required this.temperature,
    required this.precipitation,
  });
}


class TenDayForecast{
  final String link ;
  final String day;
  final String date;
  final String dayIconImg;
  final String dayWeather;
  final String highTemperature;
  final String nightIconImg;
  final String nightWeather;
  final String lowTemperature;
  final int precipitation;
  TenDayForecast({
    required this.link,
    required this.day,
    required this.date,
    required this.dayIconImg,
    required this.dayWeather,
    required this.highTemperature,
    required this.nightIconImg,
    required this.nightWeather,
    required this.lowTemperature,
    required this.precipitation
  });
}


class SunriseSunset{
  final String icon;
  final String phrase;
  final String riseValue;
  final String setValue;

  SunriseSunset({
    required this.icon,
    required this.phrase,
    required this.riseValue,
    required this.setValue,
  });
}


class AirQuality{
  final String airQualityLink;
  final String airQuality;
  final String airQualityDescroption;
  AirQuality({
    required this.airQualityLink,
    required this.airQuality,
    required this.airQualityDescroption,
  });
}

class Alergy{
  final String healthNactivitiesLink;
  final List<AllergyOutlook> allergensOutlook;

  Alergy({
    required this.healthNactivitiesLink,
    required this.allergensOutlook,
  });
}

class AllergyOutlook{
  final String allergenLink;
  //final String allergenIcon;
  final String allergenName;
  final String allergenValue;
  AllergyOutlook({
    required this.allergenLink,
    //required this.allergenIcon,
    required this.allergenName,
    required this.allergenValue
  });
}
