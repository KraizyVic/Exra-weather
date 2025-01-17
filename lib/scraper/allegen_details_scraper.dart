import 'package:exraweather/models/allergen_details_model.dart';
import 'package:exraweather/models/health_n_activities_model.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class AllergenDetailsScraper{
  String baseUrl = "https://www.accuweather.com";
  Future<void> getAllergensDetails(String link) async{
    var response = await http.get(Uri.parse(link));
    if(response.statusCode == 200){
      Document document = parse(response.body);
      Element? allergenName = document.querySelector("h2.dropdown__header-text");
      Element? allergenDescription = document.querySelector("div.lifestyle-index-chart-container__description.content-module > p.index-description");
      Element? safetyTip = document.querySelector("div.safety-description.content-module > div.safety-description__items > div");
      Element? healthNactivitiesLink = document.querySelector("div.index-list-title.spaced-content > a.cta-link.cta-header");
      List<Element> related = document.querySelectorAll("div.index-list-cards-container > a.index-list-card");
      List<Factors> relatedHealthActivities = [];
      print(related.length);
      for(Element element in related){
        relatedHealthActivities.add(
          Factors(
              name: element.querySelector("div.index-name")?.text.trim() ?? "",
              level: element.querySelector("div.index-status-text")?.text.trim() ?? ""
          )
        );
      }
      print(relatedHealthActivities.length);
      AllergenDetailsModel detailsModel = AllergenDetailsModel(
          allergenName: allergenName?.text.trim() ?? "",
          allergenDescription: allergenDescription?.text.trim() ?? "",
          safteyTip: safetyTip?.text.trim() ?? "",
          healthNactivitiesLink: "${baseUrl}${healthNactivitiesLink?.attributes["href"] ?? ""}",
          relatedHealthActivities: relatedHealthActivities,
      );
      print(detailsModel.healthNactivitiesLink);
    }
  }
}
