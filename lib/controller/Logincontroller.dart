import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/apiservice/Apiservice.dart';
import 'package:jaljeevanmissiondynamic/utility/Stylefile.dart';


import '../view/Dashboard.dart';


class Logincontroller extends GetxController{
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController entercaptcha = TextEditingController();
  GetStorage box = GetStorage();

  void LoginApi(BuildContext context, String hashpassword, String RandomNumbersalt) {
    Apiservice.Loginapi(context, emailcontroller.text.trim().toString(),
        /*passwordcontroller.text.trim().toString()*/ hashpassword, RandomNumbersalt)
        .then((value) {
      if (value["Status"].toString() == "true") {
        box.write("Status", value["Status"].toString());
        box.write("UserToken", value["Token"].toString());
        box.write("userid", value["Userid"].toString());
        box.write("stateid", value["StateId"].toString());
        box.write("DivisionId", value["DivisionId"].toString());
        print("tokengen"+  value["Token"].toString());
        print("hashpassword"+  hashpassword);
        print("DivisionId-"+  value["DivisionId"].toString());
        box.write('loginBool', true);

       /*
        box.write('loginBool', true);
        box.write('UserId', value["data"]["user"]["User_Id"].toString());*/
       // Stylefile.showmessageapisuccess(context, value["Message"].toString());
       // Get.off(Dashboard(stateid:value["StateId"].toString(), userid:value["Userid"].toString() , usertoken:value["Token"].toString() ));



       // Get.off(Dashboardmain(stateid:value["StateId"].toString(), userid:value["Userid"].toString() , usertoken:value["Token"].toString() ));
        Get.off(Dashboard(stateid:value["StateId"].toString(), userid:value["Userid"].toString() , usertoken:value["Token"].toString() ));

      } else {
        Stylefile.showmessageapierrors(context, value["Message"].toString());

        //Vibration.vibrate(duration: 1000);
      }
    });
  }
}
