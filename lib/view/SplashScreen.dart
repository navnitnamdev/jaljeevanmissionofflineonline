import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/view/Dashboard.dart';
import 'package:jaljeevanmissiondynamic/view/LoginScreen.dart';
import 'package:jaljeevanmissiondynamic/view/OTPScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isoffline = false;
  GetStorage box = GetStorage();

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      //if(box.read('loginBool') == true) {

      if (box.read("UserToken").toString() == "null") {
        //if(box.read('UserToken').toString() == "null") {
        //print("usertoken  >"+box.read('UserToken').toString());
        //Get.off(Dashboard(stateid: box.read("stateid"),userid: box.read("userid"),usertoken: box.read("UserToken").toString()));
       Get.off(const LoginScreen());
       // Get.offAll(OTPScreen());

         //Get.off(LoginScreen());
      } else {
        // Get.off(LoginScreen());
        /*Get.offAll(Dashboard(
          stateid: box.read("stateid"),
          userid: box.read("userid"),
          usertoken: box.read("UserToken").toString(),
        ));*/
        //  Get.offAll(Dashboard(stateid: box.read("stateid"), userid: box.read("userid"), usertoken: box.read("UserToken"), first: true,));
        Get.offAll(Dashboard(stateid: box.read("stateid"), userid: box.read("userid"), usertoken: box.read("UserToken")));
        // Get.offAll(VillageListScreen(totalofflinevillage:box.read("TotalOfflineVillage")));

      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white, child: Image.asset("images/jaljeevanlogo.jpg"));
  }
}
