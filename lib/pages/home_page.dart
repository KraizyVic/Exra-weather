import 'package:exraweather/pages/weather_details_page.dart';
import 'package:exraweather/scraper/weather_details_scraper.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> scraper ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scraper = WeatherDetailsScraper().pageDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: MaterialButton(
          onPressed: ()=> Navigator.push(
            context, MaterialPageRoute(
            builder: (context)=>WeatherDetailsPage()
          )
          ),
          color: Colors.red, child: Text("Press ME"),),),
    );
  }
}
