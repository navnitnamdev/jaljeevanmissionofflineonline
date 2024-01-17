import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/view/Dashboard.dart';
import 'package:jaljeevanmissiondynamic/view/LoginScreen.dart';

import 'Practise.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isoffline = false;
  GetStorage box =  GetStorage();
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      //if(box.read('loginBool') == true) {

      print("sss67"+box.read("UserToken").toString());
     if(box.read("UserToken").toString() == "null") {

      //if(box.read('UserToken').toString() == "null") {
//print("usertoken  >"+box.read('UserToken').toString());
        //Get.off(Dashboard(stateid: box.read("stateid"),userid: box.read("userid"),usertoken: box.read("UserToken").toString()));
        Get.off(LoginScreen());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please login your token has been expired!")));
        // Get.off(LoginScreen());
      } else {
       // Get.off(LoginScreen());
      Get.off(Dashboard(stateid: box.read("stateid"),userid: box.read("userid"),usertoken: box.read("UserToken").toString(),));
      //Get.off(Pracise());
     //Get.off(Dashboard(stateid: box.read("stateid").toString(),userid: box.read("userid").toString(),usertoken: box.read("UserToken").toString(),));
      //Get.off(Practise());

      }
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Image.asset("images/jaljeevanlogo.jpg")
    );
  }
}
