import 'package:exraweather/models/details_page_model.dart';
import 'package:exraweather/scraper/weather_details_scraper.dart';
import 'package:flutter/material.dart';

class WeatherDetailsPage extends StatefulWidget {
  const WeatherDetailsPage({super.key});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  late Future<DetailsPageModel> details;
  @override
  void initState() {
    // TODO: implement initState
    details = WeatherDetailsScraper().pageDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(150),
      appBar: AppBar(),
      body: FutureBuilder(
          future: details,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Center(child: Icon(Icons.sports_basketball,size: 100,color: Colors.deepOrange,),);
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
