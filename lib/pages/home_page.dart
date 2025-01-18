import 'package:exraweather/constants.dart';
import 'package:exraweather/models/details_page_model.dart';
import 'package:exraweather/pages/weather_details_page.dart';
import 'package:exraweather/scraper/weather_details_scraper.dart';
import 'package:exraweather/utilities/home_page_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/tiles.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<DetailsPageModel> details ;
  int visiblePage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    details = WeatherDetailsScraper().pageDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Mombasa"),
        foregroundColor: tertiaryColor,
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder(
        future: details,
        builder: (context,snapshot){
          if (snapshot.hasData){
            return Column(
              children: [
                CurrentWeatherSummary(
                  currentWeatherNow: snapshot.data!.currentWeather,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      //color: secondaryColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                          child: Text("Hourly Forecast",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: tertiaryColor),),
                        ),
                        SizedBox(
                          height: 200,
                          child: HourlyForecastItem(
                              hourlyForecast: snapshot.data!.hourlyForecast
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ten Day Forecast",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: tertiaryColor),),
                              Text("${visiblePage.toString()} / 10",style: TextStyle(fontSize: 15,),),
                            ],
                          ),
                        ),
                        Expanded(
                          child: PageView.builder(
                              itemCount: snapshot.data!.tenDayForecast.length,
                              scrollDirection: Axis.vertical,
                              onPageChanged: (page){
                                setState(() {
                                  visiblePage = page + 1;
                                });
                              },
                              itemBuilder: (context,index){
                                return TenDayForecastTile(tenDayForecast: snapshot.data!.tenDayForecast[index]);
                              }
                          )
                        )
                      ],
                    ),
                  )
                )
              ],
            );
          }else if(snapshot.hasError){
            return Text("ERROR !!");
          }else{
            return Center(child: CircularProgressIndicator(color: tertiaryColor,));
          }
        },
      ),
    );
  }
}
