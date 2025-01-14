import 'package:exraweather/models/scraper_models.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/html_escape.dart' as html;
import 'package:html/parser.dart' show parse;

class AccuWeatherScraper{
  String baseUrl = "https://www.accuweather.com";
  String timau = "/en/ke/timau/225734/weather-forecast/225734?city=timau";

  void pageDetails() async{
    var response = await http.get(Uri.parse("${baseUrl}${timau}"));
    if(response.statusCode == 200){
      Document document = parse(response.body);
      Element? currentCondition = document.querySelector("div.body-item > p");


      String currentConditiontxt = currentCondition?.text ?? "Null";
      print(currentConditiontxt);
    }else{
      throw Exception("Error Bratt");
    }
  }

}