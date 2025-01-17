import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import '../models/current_n_days_weather_model.dart';
import '../models/details_page_model.dart';

class CurrentNDdaysWeatherScraper{
  String baseUrl = "https://www.accuweather.com";
  Future <CurrentNDaysWeatherModel> getCurrentNDaysWeatherData(String link) async{
    var response = await http.get(Uri.parse(link));
    if(response.statusCode == 200){
      Document document = parse(response.body);
      Element? currentWeather = document.querySelector("div.page-content.content-module > div.current-weather-card.card-module.content-module ");
      List<int> feelsNShadeTemps = [];

      for(Element element in currentWeather!.querySelectorAll("div.current-weather-extra.no-realfeel-phrase > div")){
        feelsNShadeTemps.add(
          int.parse(RegExp(r'\d+').firstMatch(element.nodes.firstWhere((node) => node.nodeType == 3).text!.trim())?.group(0) ?? "0",)
        );
      }
      print(feelsNShadeTemps.first);

      List<LabelNValue> labelNValue = [];
      for(Element element in currentWeather.querySelectorAll("div.detail-item.spaced-content")){
        labelNValue.add(
          LabelNValue(
              label: element.querySelectorAll("div")[0]?.text.trim() ?? "",
              value: element.querySelectorAll("div")[1]?.text.trim() ?? "",
          )
        );
      }
      CurrentWeather? currentWeatherDetails ;
      if(currentWeather != null){
        currentWeatherDetails = CurrentWeather(
          dayAndDate: currentWeather.querySelector("div.content-module.subnav-pagination > div")?.text.trim() ?? "",
          timeFrame: currentWeather.querySelector("div.card-header spaced-content > h1")?.text.trim() ?? "",
          time: currentWeather.querySelector("div.card-header spaced-content > p.sub")?.text.trim() ?? "",
          svgLink: currentWeather.querySelector("div.current-weather-info > svg.icon")?.attributes["data-src"] ?? "",
          temperature: int.parse(currentWeather.querySelector("div.display-temp")?.text.trim().replaceAll("°C", "")??"0"),
          feelsNShadeTemps: feelsNShadeTemps,
          labelledValue: labelNValue,
        );
      }else{
        currentWeatherDetails = null;
      }

      print(currentWeatherDetails?.temperature);

      List <Element> dayAndNight = document.querySelectorAll("div.half-day-card.content-module");
      print(dayAndNight.length);
      List<DayNNightWeather> dayNhgt = [];
      for(Element element in dayAndNight){
        List<int> feelsNShadeTemps = [];
        List<LabelNValue> labelNValues = [];
        for(Element elementas in element.querySelectorAll("div.real-feel > div")){
          feelsNShadeTemps.add(
              int.parse(RegExp(r'\d+').firstMatch(elementas.nodes.firstWhere((node) => node.nodeType == 3).text!.trim())?.group(0) ?? "0",)
          );
        }
        for(Element elementas in element.querySelectorAll("div.panels > p.panelItem")){
          labelNValue.add(
            LabelNValue(
                label: elementas.querySelector("p.panelItem")?.nodes.first.text?.trim() ?? "",
                value: elementas.querySelector("span.value")?.text.trim() ?? "",
            )
          );
        }
        dayNhgt.add(
          DayNNightWeather(
              dayAndDate: element.querySelector("span.value")?.text.trim() ?? "",
              timeFrame: element.querySelector("span.value")?.text.trim() ?? "",
              time: element.querySelector("span.value")?.text.trim() ?? "",
              svgLink: element.querySelector("span.value")?.text.trim() ?? "",
              temperature: int.parse(RegExp(r'\d+').firstMatch(element.nodes.firstWhere((node) => node.nodeType == 3).text!.trim())?.group(0) ?? "0",),
              feelsNShadeTemps: feelsNShadeTemps,
              labelledValue: labelNValues,
          )
        );
        feelsNShadeTemps = [];
        labelNValues = [];
      }
      print(dayNhgt[0].feelsNShadeTemps[0]);

      List<Element> sunMoon = document.querySelectorAll("div.sunrise-sunset__item");
      List<SunriseSunset> sunriseSunset = [];
      for(Element element in sunMoon){
        sunriseSunset.add(
          SunriseSunset(
            icon: "${baseUrl}${element.querySelector("img")?.attributes["href"] ?? ""}",
            phrase: element.querySelector("span.sunrise-sunset__phrase")?.text.trim() ?? "",
            riseValue: element.querySelectorAll("div.sunrise-sunset__times-item")[0].querySelector("span.sunrise-sunset__times-value")?.text.trim() ?? "",
            setValue: element.querySelectorAll("div.sunrise-sunset__times-item")[1].querySelector("span.sunrise-sunset__times-value")?.text.trim() ?? "",
          ),
        );
      }
      Element? tempHistryContainer = document.querySelector("div.temp-history.content-module");
      List<Element> tempHistry = document.querySelectorAll("div.temp-history.content-module > div.history > div.row ");
      List<TemperatureHistoryValues> tempHistoryValues = [];
      for(Element element in tempHistry){
        tempHistoryValues.add(
          TemperatureHistoryValues(
            label: element.querySelector("div.label")?.text.trim() ?? "",
            high: element.querySelectorAll("div.temperature")[0]?.text.trim() ?? "",
            low: element.querySelectorAll("div.temperature")[1]?.text.trim() ?? "",
          )
        );
      }
      TemperaturesHistory temperaturesHistory = TemperaturesHistory(
          date: tempHistryContainer?.querySelector("div.title-row > span.header-date")?.text.trim() ?? "",
          tempsHistory: tempHistoryValues,
      );

      print(temperaturesHistory.tempsHistory.length);
      print(temperaturesHistory.date);
      return CurrentNDaysWeatherModel(
          currentWeather: currentWeatherDetails,
          dayNihgt: dayNhgt,
          sunriseSunset: sunriseSunset,
          tempsHistory: temperaturesHistory
      );
    }else{
      throw Exception("Failed to load Current Weather Page${response.statusCode}");
    }
  }
}