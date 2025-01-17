class DetailsPageModel{
  final String alert;

  final String dayAndDate;
  final List<TodaysWeather> todaysWeather;
  final String todaysWeatherLink;

  final String currentWeatherLink;
  final String curentWeatherTime;
  final String currentWeatherIcon;
  final String currentTemperature;
  final String currentRealFeelTemperature;
  final String currentWeather;
  final List<TodaysDetails> todaysDetails;

  final String lookingAheadLink;
  final String lookingAhead;

  final List<HourlyForecast> hourlyForecast;

  final List<TenDayForecast> tenDayForecast;

  final List<SunriseSunset> riseSet;
  final String airQualityLink;
  final String airQuality;
  final String airQualityDescroption;

  final String healthNactivitiesLink;
  final List<AllergyOutlook> alergyOutlook;

  DetailsPageModel({
    required this.alert,
    required this.dayAndDate,
    required this.todaysWeather,
    required this.todaysWeatherLink,
    required this.currentWeatherLink,
    required this.curentWeatherTime,
    required this.currentWeatherIcon,
    required this.currentTemperature,
    required this.currentRealFeelTemperature,
    required this.currentWeather,
    required this.todaysDetails,
    required this.lookingAheadLink,
    required this.lookingAhead,
    required this.hourlyForecast,
    required this.tenDayForecast,
    required this.riseSet,
    required this.airQuality,
    required this.airQualityLink,
    required this.airQualityDescroption,
    required this.healthNactivitiesLink,
    required this.alergyOutlook
  });

}
class TodaysWeather{
  final String iconData;
  final String weather;
  final String value;

  TodaysWeather({
    required this.iconData,
    required this.weather,
    required this.value,
  });

}
class TodaysDetails{
  final String condition;
  final String value;
  TodaysDetails({
    required this.condition,
    required this.value,
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
