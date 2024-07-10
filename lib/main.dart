import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:jaljeevanmissiondynamic/view/SplashScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


void main() async {

  WidgetsFlutterBinding
      .ensureInitialized();

  await GetStorage.init(); // Initialize GetStorage (if needed)

  runApp(const MyApp());

  // Wait for the app to be fully loaded before clearing the cache
  WidgetsBinding.instance.addPostFrameCallback((_) {
    clearCache();
    _deleteCacheDir();
    _deleteAppDir();
    // Clear the cache after the app is loaded
  });
}
void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

Future<void> clearCache() async {
  try {
    var cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }

    print("Cache cleared successfully.");
  } catch (e) {
    print("Error clearing cache: $e");
  }
}

Future<void> _deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

Future<void> _deleteAppDir() async {
  final appDir = await getApplicationSupportDirectory();
  print("gggggg$appDir");

  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
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
              appBarTheme: const AppBarTheme(
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
          home: const SplashScreen(),
          //home: Success(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
