import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/services/notification_service.dart';
import 'package:path_provider/path_provider.dart';
import 'app/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..openBox('komikcast');

  runApp(ModularApp(module: AppModule()));

  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

void backgroundFetchHeadlessTask(String taskId) async {
  NotificationService();
  BackgroundFetch.finish(taskId);
}
