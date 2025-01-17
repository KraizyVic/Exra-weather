import 'package:exraweather/models/health_n_activities_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class HealthNActivitiesScraper{
  String baseUrl = "https://www.accuweather.com";
  Future <HealthNActivitiesModel> getHealthAndActivitiesDetails(String link) async{
    var response = await http.get(Uri.parse(link));
    if(response.statusCode == 200){
      Document document = parse(response.body);
      List<Element> lifestyles = document.querySelectorAll("div.page-content  > div.lifestyle-index-list.unrendered.content-module.lifestyle-hub__list  ");
      List<Lifestyle> lifeStyle = [];
      print(lifestyles.length);
      for(Element element in lifestyles){
        List<Factors> factors = [];
        for(Element elements in element.querySelectorAll("div.index-list-cards-container > a.index-list-card")){
          factors.add(
              Factors(
                  name: elements.querySelector("div.index-name")?.text.trim() ?? "",
                  level: elements.querySelector("div.index-status-text")?.text.trim() ?? "",
              )
          );
        }
        lifeStyle.add(
            Lifestyle(
                title: element.querySelector("div.index-list-title.spaced-content > div")?.text.trim() ?? "",
                inLineToolTip: element.querySelector("div.inline-tooltip-text")?.text.trim() ?? "",
                factors: factors
            )
        );
        factors = [];
      }

      return HealthNActivitiesModel(
          healthNLifestyle: lifeStyle
      );
    }else{
      throw Exception("Failed to load Health and Activities Page");
    }
  }
}
