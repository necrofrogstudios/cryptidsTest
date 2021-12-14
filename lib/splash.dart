import 'package:splashscreen/splashscreen.dart';

import 'package:flutter/material.dart';
import 'settings.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: MyApp(),
        title: new Text(
          'Necrofrog Studios',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Hind',
              fontSize: 35.0,
              color: Colors.white),
        ),
        image: new Image.network(
            'https://purepng.com/public/uploads/large/purepng.com-moonmoonastronomical-bodyfifth-largest-natural-satellitenatural-satellitemoon-light-1411527067328btskq.png'),
        photoSize: 150.0,
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(
          fontSize: 15,
        ),
        loaderColor: Colors.white);
  }
}
