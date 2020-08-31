import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:komikcast/data/init_data.dart';
import 'package:komikcast/env.dart';
import 'package:komikcast/services/notification_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
    // NotificationService();
    navigateToHome();
  }

  Future<void> initPlatformState() async {
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE), (String taskId) async {
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      BackgroundFetch.finish(taskId);
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });

    if (!mounted) return;
  }

  void navigateToHome() {
    Future.delayed(Duration(seconds: 3), () {
      KomikcastSystem().initData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Env.primaryColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.black.withOpacity(.3),
              offset: Offset(0, 1),
              spreadRadius: 1,
            )
          ], borderRadius: BorderRadius.circular(10)),
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
