import 'package:exraweather/constants.dart';
import 'package:exraweather/models/details_page_model.dart';
import 'package:exraweather/utilities/buttons.dart';
import 'package:exraweather/utilities/tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrentWeatherSummary extends StatelessWidget {
  final CurrentWeatherNow currentWeatherNow;
  const CurrentWeatherSummary({
    super.key,
    required this.currentWeatherNow
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.network(
                currentWeatherNow.currentWeatherIcon,placeholderBuilder: (context) => SizedBox(
                  height:100,
                  width:100,
                  child: Center(
                      child: LinearProgressIndicator(
                        color: tertiaryColor,
                      ),
                  )
                ),
                height: 100,width: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(currentWeatherNow.curentWeatherTime,style: TextStyle(color: tertiaryColor),),
                    Row(
                      children: [
                        Text("Current Temp"),
                        Spacer(),
                        Text(currentWeatherNow.currentTemperature.replaceAll("C", ""),style: TextStyle(fontSize: 36),),
                        Text("c",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      children: [
                        Text("Current Temp"),
                        Spacer(),
                        Text(currentWeatherNow.currentRealFeelTemperature,style: TextStyle(fontSize: 36),),
                        Text("c",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ],
                )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentWeatherNow.currentWeather,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
              ),
              NamedWithTrailingIconButton(
                  onPressed: (){},
                  buttonName: "More details",
                  iconData: Icons.chevron_right,
              )
            ],
          )
        ],
      ),
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final List<HourlyForecast> hourlyForecast;
  const HourlyForecastItem({
    super.key,
    required this.hourlyForecast,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hourlyForecast.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index){
        return HourlyForecastTile(hourlyForecast: hourlyForecast[index]);
        }
      );
  }
}

class TenDayForecastItems extends StatefulWidget {
  final List<TenDayForecast> tenDayForecast;
  final ValueNotifier<int> pager;
  final VoidCallback callback;
  const TenDayForecastItems({
    super.key,
    required this.tenDayForecast,
    required this.pager,
    required this.callback
  });


  @override
  State<TenDayForecastItems> createState() => _TenDayForecastItemsState();
}

class _TenDayForecastItemsState extends State<TenDayForecastItems> {
  int pageNO = 1;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: widget.tenDayForecast.length,
        scrollDirection: Axis.vertical,
        onPageChanged: (page){
          setState(() {
          });
        },
        itemBuilder: (context,index){
          return TenDayForecastTile(tenDayForecast: widget.tenDayForecast[index]);
        }
    );
  }
}


