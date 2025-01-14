import 'package:exraweather/scraper/accu_weather_scraper.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  AccuWeatherScraper scraper = AccuWeatherScraper();
  void initState() {
    // TODO: implement initState
    super.initState();
    scraper.pageDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
    );
  }
}
