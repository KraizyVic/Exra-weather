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
      Element? dayAndDate = document.querySelector("div.today-forecast-card.content-module > div.card-header.spaced-content > p.sub");
      Element? todaysWeatherLink = document.querySelector("div.today-forecast-card.content-module > a");
      List<Element> todaysWeather = document.querySelectorAll("div.body > div.body-item");
      List<TodaysWeather> todaysWeatherList = [];
      for(Element element in todaysWeather){
        todaysWeatherList.add(
            TodaysWeather(
                iconData: element.querySelector("img.icon")?.attributes["src"] ?? "",
                weather: element.querySelector("p") ?.nodes.firstWhere((node) => node.nodeType == dom.Node.TEXT_NODE, orElse: () => dom.Text('')).text?.trim() ?? "",
                value: element.querySelector("p > b")?.text ?? "",
            )
        );
      }
      Element? currentWeatherLink = document.querySelector("a.cur-con-weather-card.is-desktop.lbar-panel.content-module");
      Element? currentWeatherTime = document.querySelector("a.cur-con-weather-card.is-desktop.lbar-panel.content-module > div.title-container > p.cur-con-weather-card__subtitle");
      Element? currentWeatherIcon = document.querySelector("div.forecast-container > svg.weather-icon");
      Element? currentTemperature = document.querySelector("a.cur-con-weather-card.is-desktop.lbar-panel.content-module > div.cur-con-weather-card__body > div.cur-con-weather-card__panel > div.temp-container > div.temp");
      Element? currentRealFeelTemperature = document.querySelector("a.cur-con-weather-card.is-desktop.lbar-panel.content-module > div.cur-con-weather-card__body > div.cur-con-weather-card__panel > div.temp-container > div.real-feel");
      Element? currentWeather = document.querySelector("a.cur-con-weather-card.is-desktop.lbar-panel.content-module > div.cur-con-weather-card__body > div.cur-con-weather-card__panel > span.phrase");
      List<Element> todaysInfo = document.querySelectorAll("a.cur-con-weather-card.is-desktop.lbar-panel.content-module > div.cur-con-weather-card__body > div.cur-con-weather-card__panel.details-container > div.spaced-content.detail");
      List<TodaysDetails> todaysDetails= [];
      for(Element element in todaysInfo){
        todaysDetails.add(
          TodaysDetails(
              condition: element.querySelector("span.label")?.text.trim() ?? "",
              value: element.querySelector("span.value")?.text.trim() ?? "",
          )
        );
      }
      Element? lookingAheadLink = document.querySelector("a.local-forecast-summary");
      Element? lookingAhead = document.querySelector("a.local-forecast-summary > p");
      List<Element> hourly = document.querySelectorAll("div.hourly-list__list > a");
      List<HourlyForecast> hourlyForecast = [];
      for(Element element in hourly){
        hourlyForecast.add(
          HourlyForecast(
              link: element.querySelector("a")?.attributes["href"] ?? "",
              time: element.querySelector("span.hourly-list__list__item-time")?.text.trim() ?? "",
              weatherIcon: element.querySelector("img.hourly-list__list__item-icon")?.attributes["src"] ?? "",
              temperature: element.querySelector("img.hourly-list__list__item-temp")?.text.trim() ?? "",
              precipitation: int.parse(element.querySelector("div.hourly-list__list__item-precip > span")?.text.trim().replaceAll("%", "") ?? "0"),
          )
        );
      }
      List<Element> tenDay = document.querySelectorAll("a.daily-list-item");
      List<TenDayForecast> tenDayForecast = [];
      for (Element element in tenDay){
        tenDayForecast.add(
          TenDayForecast(
              link: element.querySelector("a")?.attributes["href"] ?? "",
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
      List<Element> sunMoon = document.querySelectorAll("div.sunrise-sunset__body > div.sunrise-sunset__item");
      List<SunriseSunset> riseSet = [];
      for(Element element in sunMoon){
        riseSet.add(
          SunriseSunset(
              icon: "${baseUrl}${element.querySelector("img")?.attributes["href"] ?? ""}",
              phrase: element.querySelector("span.sunrise-sunset__phrase")?.text.trim() ?? "",
              riseValue: element.querySelectorAll("div.sunrise-sunset__times-item")[0].querySelector("span.sunrise-sunset__times-value")?.text.trim() ?? "",
              setValue: element.querySelectorAll("div.sunrise-sunset__times-item")[1].querySelector("span.sunrise-sunset__times-value")?.text.trim() ?? "",
          )
        );
      }
      Element? airQualityLink = document.querySelector("a.air-quality-module-wrapper");
      Element? airQuality = document.querySelector("div.air-quality-module__row > span.air-quality-module__row__category");
      Element? airQualityDescription = document.querySelector("p.air-quality-module__statement");
      Element? healthNactivitiesLink = document.querySelector("div.health-activities__title > a");
      List<Element> allergens = document.querySelectorAll("div.health-activities.health-activities-free > a.health-activities__item.show");
      List<AllergyOutlook> allergyOutlook = [];
      for(Element element in allergens){
        allergyOutlook.add(
          AllergyOutlook(
              allergenLink: "${baseUrl}${element.attributes["href"]}",
              allergenName: element.querySelector("span.health-activities__item__name")?.text.trim() ?? "",
              allergenValue: element.querySelector("span.health-activities__item__category")?.text.trim() ?? "",
          )
        );
      }
      //print(currentWeatherIcon?.attributes["data-src"]);
      return DetailsPageModel(
          alert: alert?.text.trim() ?? "Safe",
          dayAndDate: dayAndDate?.text.trim() ?? "",
          todaysWeather: todaysWeatherList,
          todaysWeatherLink: "${baseUrl}${todaysWeatherLink?.attributes["href"]}",
          currentWeatherLink: currentWeatherLink?.attributes["href"] ?? "",
          curentWeatherTime: currentWeatherTime?.text.trim() ?? "00",
          currentWeatherIcon: "${baseUrl}${currentWeatherIcon?.attributes["data-src"]}",
          currentTemperature: currentTemperature?.text.trim() ?? "",
          currentRealFeelTemperature: currentRealFeelTemperature?.text.trim() ?? "",
          currentWeather: currentWeather?.text.trim() ?? "",
          todaysDetails: todaysDetails,
          lookingAheadLink: "${baseUrl}${lookingAheadLink}",
          lookingAhead: lookingAhead?.text.trim() ?? "",
          hourlyForecast: hourlyForecast,
          tenDayForecast: tenDayForecast,
          riseSet: riseSet,
          airQualityLink: airQualityLink?.attributes["href"] ?? "",
          airQuality: airQuality?.text.trim() ?? "",
          airQualityDescroption:airQualityDescription?.text.trim() ?? "",
          healthNactivitiesLink: healthNactivitiesLink?.attributes["href"] ?? "",
          alergyOutlook: allergyOutlook,
      );
    } else {
      throw Exception("Error Blyatt");
    }
  }
}
