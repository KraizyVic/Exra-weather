import 'package:exraweather/constants.dart';
import 'package:exraweather/models/details_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HourlyForecastTile extends StatelessWidget {
  final HourlyForecast hourlyForecast;
  const HourlyForecastTile({super.key,required this.hourlyForecast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  hourlyForecast.time,
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
              ),
              SvgPicture.network(hourlyForecast.weatherIcon,width: 70,height: 70,),
              Text(
                  hourlyForecast.temperature,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              Row(
                children: [
                  Icon(Icons.water_drop_outlined),
                  Text("${hourlyForecast.precipitation.toString()} %")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TenDayForecastTile extends StatelessWidget {
  final TenDayForecast tenDayForecast;
  const TenDayForecastTile({super.key,required this.tenDayForecast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        color: secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 10),
        onPressed: (){},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tenDayForecast.day.toUpperCase(),style: TextStyle(color: tertiaryColor,fontSize: 15),),
                  Text(tenDayForecast.date)
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height:40,width:40,child: SvgPicture.network(tenDayForecast.dayIconImg)),
                            SizedBox(width: 10,),
                            Expanded(child: Text(tenDayForecast.dayWeather,overflow: TextOverflow.ellipsis,)),
                            Text("HI: ${tenDayForecast.highTemperature}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        tenDayForecast.nightWeather!=""?Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height:40,width:40,child: SvgPicture.network(tenDayForecast.nightIconImg)),
                            SizedBox(width: 10,),
                            Expanded(child: Text(tenDayForecast.nightWeather,overflow: TextOverflow.ellipsis,)),
                            Text("LO: ${tenDayForecast.lowTemperature}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                          ],
                        ):SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Icon(Icons.water_drop_outlined,size: 15,),
                  Text("${tenDayForecast.precipitation.toString()} %")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

