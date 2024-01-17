import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:jaljeevanmissiondynamic/view/SplashScreen.dart';
import 'package:provider/provider.dart';




final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async{
  runApp(const MyApp());

  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return StreamProvider<InternetConnectionStatus>(
        initialData: InternetConnectionStatus.connected,
        create: (_) {
          return InternetConnectionChecker().onStatusChange;
        },
        child: GetMaterialApp(

         // navigatorObservers: [routeObserver],

          theme: ThemeData(

              primaryColor: Appcolor.COLOR_PRIMARY,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                color: Appcolor.COLOR_PRIMARY, //<-- SEE HERE
              ),
              inputDecorationTheme: const InputDecorationTheme(
                floatingLabelStyle: TextStyle(color: Appcolor.COLOR_PRIMARY),
                iconColor: Appcolor.COLOR_PRIMARY,
                contentPadding: EdgeInsets.all(10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 1, color: Appcolor.COLOR_PRIMARY),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              )),
          home: SplashScreen(),
          //home: Success(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

