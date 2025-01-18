import 'dart:ui';

import 'package:exraweather/constants.dart';
import 'package:exraweather/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool checkBoxVAlue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/assets/197662.jpg",
            fit: BoxFit.cover,
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5
                ),
              child: Container(
                color: primaryColor.withAlpha(150),
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Exra Weather",
                              style: TextStyle(
                                color: tertiaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text(
                              "A Wather app made entirely with flutter \n-> With Knowledge \n-> With Purpose \n-> Ambition for a job \n-> And a LOAD of ... ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 50,),
                            Text(
                              //"SO USE IT WISELY",
                              "Have fun using it ",
                              style: TextStyle(
                                fontSize: 18,
                                color: tertiaryColor
                              ),
                            ),
                            Text(
                              "(Or we are gonna have a problem)",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey
                              ),
                            ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                    value: checkBoxVAlue,
                                    onChanged: (value){
                                      setState(() {
                                        checkBoxVAlue = value!;
                                      });
                                    },
                                  activeColor: tertiaryColor,
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                    onTap:(){
                                      setState(() {
                                        checkBoxVAlue = !checkBoxVAlue;
                                      });
                                    },
                                    child: Text("Skip This page next time ? \n( ${checkBoxVAlue==true ? "Nooo! Please I'm begging you 😭 " :"Please don't, I'm a pretty page 😣 "})"))
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Credit: ACCUWEATHER.COM",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                            ),
                          ),
                          SizedBox(height: 20,),
                          MaterialButton(
                            onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage())),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("Discover Your surroundings"),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            color: secondaryColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
