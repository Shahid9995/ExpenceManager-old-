import 'package:camera/camera.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'helper/route_helper.dart';
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
List<CameraDescription> cameras = [];
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.instance.getToken().then((deviceToken) {
    // fbDeviceToken = deviceToken;
    print("==  deviceToken:=$deviceToken==");});
  cameras = await availableCameras();


  runApp( const MyApp());
}
  // runApp( const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: AppConstants.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      initialRoute: RouteHelper.splash,
      getPages: RouteHelper.routes,
      // home: Container(),
    );
  }
}
