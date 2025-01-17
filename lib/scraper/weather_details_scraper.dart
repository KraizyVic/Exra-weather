import 'package:exraweather/models/details_page_model.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

class WeatherDetailsScraper {
  String baseUrl = "https://www.accuweather.com";
  //TODO: Add parameters for location link obtained from location search
  Future<DetailsPageModel> pageDetails() async {
    String timau = "/en/ke/mombasa/223233/weather-forecast/223233?city=mombasa";
    var response = await http.get(Uri.parse("${baseUrl}${timau}"));
    if (response.statusCode == 200) {
      Document document = parse(response.body);
      Element? alert = document.querySelector("div.body-item > p");
      Element? todayWeatherBlock = document.querySelector("div.today-forecast-card.content-module");
      List<TodaysWeatherMetrics> todaysWeatherMetrics = [];
      for(Element element in todayWeatherBlock!.querySelectorAll("div.body > div.body-item")){
        todaysWeatherMetrics.add(
            TodaysWeatherMetrics(
                iconData: element.querySelector("img.icon")?.attributes["src"] ?? "",
                weather: element.querySelector("p") ?.nodes.firstWhere((node) => node.nodeType == dom.Node.TEXT_NODE, orElse: () => dom.Text('')).text?.trim() ?? "",
                value: element.querySelector("p > b")?.text ?? "",
            )
        );
      }
      Element? currentWeatherBlock = document.querySelector("a.cur-con-weather-card.is-desktop.lbar-panel.content-module");
      List<CurrentDetails> todaysDetails= [];
      for(Element element in currentWeatherBlock!.querySelectorAll("div.cur-con-weather-card__body > div.cur-con-weather-card__panel.details-container > div.spaced-content.detail")){
        todaysDetails.add(
          CurrentDetails(
              condition: element.querySelector("span.label")?.text.trim() ?? "",
              value: element.querySelector("span.value")?.text.trim() ?? "",
          )
        );
      }
      Element? lookingAheadLink = document.querySelector("a.local-forecast-summary");
      Element? lookingAhead = document.querySelector("a.local-forecast-summary > p");
      List<HourlyForecast> hourlyForecast = [];
      for(Element element in document.querySelectorAll("div.hourly-list__list > a")){
        hourlyForecast.add(
          HourlyForecast(
              link: "${baseUrl}${element.attributes["href"] ?? ""}",
              time: element.querySelector("span.hourly-list__list__item-time")?.text.trim() ?? "",
              weatherIcon: element.querySelector("img.hourly-list__list__item-icon")?.attributes["src"] ?? "",
              temperature: element.querySelector("span.hourly-list__list__item-temp")?.text.trim() ?? "",
              precipitation: int.parse(element.querySelector("div.hourly-list__list__item-precip > span")?.text.trim().replaceAll("%", "") ?? "0"),
          )
        );
      }
      List<TenDayForecast> tenDayForecast = [];
      for (Element element in document.querySelectorAll("a.daily-list-item")){
        tenDayForecast.add(
          TenDayForecast(
              link: "$baseUrl${element?.attributes["href"] ?? ""}",
              day: element.querySelector("div.date > p.day")?.text.trim() ?? "",
              date: element.querySelectorAll("div.date > p").last?.text.trim() ?? "",
              dayIconImg: element.querySelector("img.icon")?.attributes["src"] ?? "",
              dayWeather: element.querySelector("p.no-wrap")?.text.trim() ?? "",
              highTemperature: element.querySelector("div.temp > span.temp-hi")?.text.trim() ?? "",
              nightIconImg: element.querySelector("img.night-icon")?.attributes["src"] ?? "",
              nightWeather: element.querySelector("span.night > p.no-wrap")?.text.trim() ?? "",
              lowTemperature: element.querySelector("div.temp > span.temp-lo")?.text.trim() ?? "",
              precipitation: int.parse(element.querySelector("div.precip")?.text.trim().replaceAll("%", "") ?? "0"),
          )
        );
      }
      List<SunriseSunset> riseSet = [];
      for(Element element in document.querySelectorAll("div.sunrise-sunset__body > div.sunrise-sunset__item")){
        riseSet.add(
          SunriseSunset(
              icon: "${baseUrl}${element.querySelector("img")?.attributes["src"] ?? ""}",
              phrase: element.querySelector("span.sunrise-sunset__phrase")?.text.trim() ?? "",
              riseValue: element.querySelectorAll("div.sunrise-sunset__times-item")[0].querySelector("span.sunrise-sunset__times-value")?.text.trim() ?? "",
              setValue: element.querySelectorAll("div.sunrise-sunset__times-item")[1].querySelector("span.sunrise-sunset__times-value")?.text.trim() ?? "",
          )
        );
      }
      Element? airQualityBlock = document.querySelector("a.air-quality-module-wrapper");
      //Element? healthNactivitiesLink = document.querySelector("div.health-activities__title > a");
      TodayWeather todayWeather = TodayWeather(
          link: "${baseUrl}${todayWeatherBlock?.querySelector("div.today-forecast-card.content-module > a")?.attributes["href"]}",
          date: todayWeatherBlock?.querySelector("div.card-header.spaced-content > p.sub")?.text.trim() ?? "",
          todayWeatherMetrics: todaysWeatherMetrics
      );
      CurrentWeatherNow currentWeatherNow = CurrentWeatherNow(
          currentWeatherLink: "${baseUrl}${currentWeatherBlock?.attributes["href"] ?? ""}",
          curentWeatherTime: currentWeatherBlock?.querySelector("div.title-container > p.cur-con-weather-card__subtitle")?.text.trim() ?? "00",
          currentWeatherIcon: "${baseUrl}${currentWeatherBlock?.querySelector("div.forecast-container > svg.weather-icon")?.attributes["data-src"]}",
          currentTemperature: currentWeatherBlock?.querySelector("div.temp-container > div.temp")?.text.trim() ?? "",
          currentRealFeelTemperature: currentWeatherBlock?.querySelector("div.temp-container > div.real-feel")?.text.replaceAll("RealFeel®", "").trim() ?? "",
          currentWeather: currentWeatherBlock?.querySelector("span.span.phrase")?.text.trim() ?? "",
          todaysDetails: todaysDetails,
      );
      AirQuality airQuality = AirQuality(
          airQualityLink: "$baseUrl${airQualityBlock?.attributes["href"] ?? ""}",
          airQuality: airQualityBlock?.querySelector("div.air-quality-module__row > span.air-quality-module__row__category")?.text.trim() ?? "",
          airQualityDescroption: airQualityBlock?.querySelector("p.air-quality-module__statement")?.text.trim() ?? "",
      );
      List<AllergyOutlook> allergyOutlook = [];
        for(Element element in document.querySelectorAll("div.health-activities.health-activities-free > a.health-activities__item.show")){
          allergyOutlook.add(
            AllergyOutlook(
              allergenLink: "${baseUrl}${element.attributes["href"]}",
              allergenName: element.querySelector("span.health-activities__item__name")?.text.trim() ?? "",
              allergenValue: element.querySelector("span.health-activities__item__category")?.text.trim() ?? "",
            )
        );
      }
      Alergy allergy = Alergy(
          healthNactivitiesLink: "$baseUrl${document.querySelector("div.health-activities__title > a")?.attributes["href"] ??""}",
          allergensOutlook: allergyOutlook,
      );
      return DetailsPageModel(
          alert: alert?.text.trim() ?? "",
          todayWeather: todayWeather,
          currentWeather: currentWeatherNow,
          lookingAhead: null,
          hourlyForecast: hourlyForecast,
          tenDayForecast: tenDayForecast,
          sunriseSunset: riseSet,
          airQuality: airQuality,
          allergy: allergy,
      );
    } else {
      throw Exception("Error Blyatt");
    }
  }
}
