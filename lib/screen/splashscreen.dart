import 'package:expensetracker/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
@override
void initState() {
  super.initState();
  Future.delayed(const  Duration(seconds: 2),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),)),);
  
}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width  : MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(child: LottieBuilder.asset("assets/lotties/splash.json",fit: BoxFit.cover,))
    );
  }
}