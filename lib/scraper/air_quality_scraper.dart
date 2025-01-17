import 'package:exraweather/models/air_quality_page_model.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
class AirQualityScraper{
  String baseUrl = "";
  Future <void> airQualityScraper(String link) async{
    var response = await http.get(Uri.parse(link));
    if(response.statusCode == 200){
      Document document = parse(response.body);
      Element? currAirQuality = document.querySelector("div.air-quality-card.content-module");
      CurrentAirQuality currentAirQuality = CurrentAirQuality(
          day: currAirQuality?.querySelector("div.date-wrapper > p.day-of-week")?.text.trim() ?? "",
          date: currAirQuality?.querySelector("div.date-wrapper > p.date")?.text.trim() ?? "",
          aqNumber: int.parse(currAirQuality?.querySelector("div.aq-number")?.text.trim() ?? "0"),
          aqUnits: currAirQuality?.querySelector("div.aq-unit")?.text.trim() ?? "",
          qualityScore: currAirQuality?.querySelector("p.category-text")?.text.trim() ?? "",
          description: currAirQuality?.querySelector("p.statement")?.text.trim() ?? "",
          basedOn: currAirQuality?.querySelector("p.based-on")?.text.trim() ?? "",
      );
      List<Element> polutes = document.querySelectorAll("div.tab-content.pollutants > div.air-quality-pollutant.new-colors");
      List<Polutants> pollutants = [];
      for(Element element in polutes){
        pollutants.add(
          Polutants(
              polutantName: element.querySelector("div.display-type")?.nodes.firstWhere((node) => node.nodeType == 3).text?.trim() ?? "",
              pollutantConditionalValue: element.querySelector("div.display-type > sub")?.text.trim() ?? "",
              qualityScore: element.querySelector("div.category")?.text.trim() ?? "",
              polutantDescription: element.querySelector("div.statement")?.text.replaceAll(RegExp(r'\s+'), ' ') ?? "",
              polutantIndex: int.parse(element.querySelector("div.pollutant-index")?.text.trim() ?? "0"),
              polutantConcentration: element.querySelector("div.pollutant-concentration")?.text.trim() ?? "",
          )
        );
      }
      List<Element> daily = document.querySelectorAll("div.air-quality-daily-list > div.air-quality-content");
      List<DailyForecast> dailyForecast = [];
      for(Element element in daily){
        dailyForecast.add(
          DailyForecast(
            day: element.querySelector("div.date-wrapper > p.day-of-week")?.text.trim() ?? "",
            date: element.querySelector("div.date-wrapper > p.date")?.text.trim() ?? "",
            aqNumber: int.parse(element.querySelector("div.aq-number")?.text.trim() ?? "0"),
            aqUnits: element.querySelector("div.aq-unit")?.text.trim() ?? "",
            qualityScore: element.querySelector("p.category-text")?.text.trim() ?? "",
            description: element.querySelector("p.statement")?.text.trim() ?? "",
          )
        );
      }
      print(daily.length);
      print(dailyForecast.last.aqNumber);
      //print(currentAirQuality.aqUnits);
    }else{
      throw Exception("Failed to load Air quality data");
    }
  }
}