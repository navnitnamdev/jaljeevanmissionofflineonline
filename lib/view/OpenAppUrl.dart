import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'LoginScreen.dart';

class OpenAppUrl extends StatefulWidget {
  const OpenAppUrl({Key? key}) : super(key: key);

  @override
  State<OpenAppUrl> createState() => _OpenAppUrlState();
}

class _OpenAppUrlState extends State<OpenAppUrl> {
GetStorage box = GetStorage();

  var url= "https://google.com";
  TextEditingController controller=TextEditingController();


  @override
  void initState() {
    super.initState();
    if(box.read("UserToken").toString() == "null") {
      Get.off(LoginScreen());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please login your token has been expired!")));
    }
  }
  searchURL(){
    setState(() {
      url = "https://www."+controller.text;
      controller.text=url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/header_bg.png'), fit: BoxFit.cover),
      ),
      child: Scaffold());
  }
}


