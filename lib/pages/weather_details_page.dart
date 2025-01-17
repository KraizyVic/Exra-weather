import 'package:exraweather/models/current_n_days_weather_model.dart';
import 'package:exraweather/models/details_page_model.dart';
import 'package:exraweather/scraper/air_quality_scraper.dart';
import 'package:exraweather/scraper/allegen_details_scraper.dart';
import 'package:exraweather/scraper/current_n_days_weather_scraper.dart';
import 'package:exraweather/scraper/health_n_activities_scraper.dart';
import 'package:exraweather/scraper/weather_details_scraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherDetailsPage extends StatefulWidget {
  const WeatherDetailsPage({super.key});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  late Future<CurrentNDaysWeatherModel> details;
  late Future<void> airQual;
  @override
  void initState() {
    // TODO: implement initState
    details = CurrentNDdaysWeatherScraper().getCurrentNDaysWeatherData("https://www.accuweather.com/en/ke/mombasa/223233/current-weather/223233");
    airQual = AllergenDetailsScraper().getAllergensDetails("https://www.accuweather.com/en/gb/dalavich/pa35-1/allergies-weather/1-2527408_1_al?name=tree-pollen");

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(150),
      appBar: AppBar(backgroundColor: Colors.white.withAlpha(50),),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: (){
                setState(() {
                  details = CurrentNDdaysWeatherScraper().getCurrentNDaysWeatherData("https://www.accuweather.com/en/ke/mombasa/223233/current-weather/223233");
                });
              },
            child: Icon(Icons.restart_alt),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
              onPressed: (){
                setState(() {
                  airQual = HealthNActivitiesScraper().getHealthAndActivitiesDetails("https://www.accuweather.com/en/ke/mombasa/223233/health-activities/223233");
                });
              },
            child: Icon(Icons.air),
          ),
        ],
      ),
      body: FutureBuilder(
          future: details,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Center(child: SvgPicture.network(
                  "https://www.accuweather.com/images/weathericons/1.svg",
                  placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator(),
                  )
                ),
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else{
              print(snapshot.error.toString());
              return Center(child: Text(snapshot.error.toString()),);
            }
          }
        ),
    );
  }
}
