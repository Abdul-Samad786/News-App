//import 'dart:ffi';
//import 'dart:js';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui/Home_screen.dart';

//import 'package:google_fonts/google_fonts.dart';
class Splash_screen extends StatefulWidget {
  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * .8,
            child: const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/news.png')),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Top Headlines',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
