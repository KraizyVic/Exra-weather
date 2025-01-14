import 'dart:ui';

import 'package:exraweather/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

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
                  sigmaX: 10,
                  sigmaY: 10
                ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Exra Weather",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage())),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Discover Your surroundings"),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
