import 'package:exraweather/models/details_page_model.dart';
import 'package:exraweather/pages/weather_details_page.dart';
import 'package:exraweather/scraper/weather_details_scraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<DetailsPageModel> details ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    details = WeatherDetailsScraper().pageDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: details,
        builder: (context,snapshot){
          if (snapshot.hasData){
            return Column(
              children: [
                Container(
                  height: 200,
                  color: Colors.blue,
                  child: Center(child: Text(snapshot.data!.allergy.allergensOutlook.length.toString(),style: TextStyle(fontSize: 50),)),
                ),
                Expanded(
                    child: Container(
                      color: Colors.yellow,
                      child: Center(
                        child: MaterialButton(
                            onPressed: ()=>details = WeatherDetailsScraper().pageDetails(),
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Reload"),
                          ),
                          color: Colors.red,
                        ),
                      ),
                    )
                )
              ],
            );
          }else if(snapshot.hasError){
            return Text("ERROR !!");
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
