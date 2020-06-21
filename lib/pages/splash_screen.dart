import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatefulWidget {
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  void navigateToHome(){
    Future.delayed(Duration(seconds: 4) , () {
      Modular.to.pushNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Colors.black.withOpacity(.3),
                offset: Offset(0, 1),
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.circular(10)
          ),
          child: Image.asset(
            'assets/images/logo-app.png',
            width: width * .3,
            height: width * .3,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
