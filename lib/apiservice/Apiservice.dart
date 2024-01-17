import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/model/PWSPendingapprovalmodal.dart';
import 'package:jaljeevanmissiondynamic/model/Schemelistmodal.dart';
import 'package:jaljeevanmissiondynamic/model/Villagelistmodal.dart';

import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';


class Apiservice {
  static String baseurl = "https://ejalshakti.gov.in/krcpwa/api/";

//https://ejalshakti.gov.in/krcpwa/api/JJM_Mobile/GetUsermenu?UserId=0&StateId=0
  static GetStorage box = GetStorage();



  static Future Loginapi(
    BuildContext context,
    String userid,
    String password,
    String randomsalt,
  ) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              //CircularProgressIndicator()
            SizedBox(
                height: 40,
                width: 40,
                child: Image.asset("images/loading.gif")),


            ],
          );
        });

    //print("Firebase_token_sending:" + box.read("firebase_token").toString());
    var response = await http.post(
      Uri.parse('${baseurl}' + "JJM_Mobile/Login"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "LoginId": userid,
        //"LoginId": "fu_admin",
        "Password": password,
        //  "Password": "nic@123",txtSaltedHash
        "txtSaltedHash": randomsalt

      }),
    );
    Get.back();
    print("LoginId  > " + password);
    print("password > " + password);
    print("txtSaltedHash > " + randomsalt);
    if (response.statusCode == 200) {
      print("response_Login: " + response.body);
      var responsede = jsonDecode(response.body);
      print("randomsalt_0"+randomsalt);

    }
    return jsonDecode(response.body);
  }


  static Future PWSSourceSavetaggingapi(
    BuildContext context,
      String token,
    String UserId,
    String VillageId,
    String AssetTagging,
      String StateId,
      String SchemeId,
      String SourceId,
      String DivisionId,
      String HabitationId,
      String SourceTypeId,
      String SourceCategoryId,
      String Landmark,
      String Latitude,
      String Longitude,
      String Accuracy,
      String Photo,

  ) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              //CircularProgressIndicator()
            SizedBox(
                height: 40,
                width: 40,
                child: Image.asset("images/loading.gif")),


            ],
          );
        });

    //print("Firebase_token_sending:" + box.read("firebase_token").toString());
    var response = await http.post(
      Uri.parse('${baseurl}' + "JJM_Mobile/SaveTagWaterSource"),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
      body: jsonEncode({
        "UserId": box.read("userid"),
        //"LoginId": "fu_admin",
        "VillageId": VillageId,
        //  "Password": "nic@123",
        "AssetTagging": AssetTagging,
        "StateId": StateId,
        "SchemeId": SchemeId,
        "SourceId": SourceId,
        "DivisionId": DivisionId, "HabitationId": HabitationId, "SourceTypeId": SourceTypeId,
        "SourceCategoryId": SourceCategoryId,   "Landmark": Landmark,   "Latitude": Latitude, "Longitude": Longitude,
        "Accuracy": Accuracy,
        "Photo":Photo
      }),
    );
    Get.back();
    if (response.statusCode == 200) {
      var responsede = response.body;


      print("responsede"+responsede);
      print("UserId"+UserId);
      print("VillageId"+VillageId);
      print("AssetTagging"+AssetTagging);
      print("StateId"+StateId);
      print("SchemeId"+SchemeId);
      print("SourceId"+SourceId);
      print("DivisionId"+DivisionId);
      print("HabitationId"+HabitationId);
      print("SourceTypeId"+SourceTypeId);
      print("SourceCategoryId"+SourceCategoryId);
      print("Landmark"+Landmark);
      print("Latitude"+Latitude);
      print("Longitude"+Longitude);
      print("Photo"+Photo);
      print("Accuracy"+Accuracy);


   /*   var responsede = jsonDecode(response.body);
     print("responsede"+ " " +jsonDecode(response.body));*/

    }
    return jsonDecode(response.body);
  }

  static Future SIBSavetaggingapi(
    BuildContext context,
      String token,
      String UserId,
      String VillageId,
      String CapturePointTypeId,
      String StateId,
      String SchemeId,
      String SourceId,
      String DivisionId,
      String HabitationId,
      String Landmark,
      String Latitude,
      String Longitude,
      String Accuracy,
      String Photo,





  ) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              //CircularProgressIndicator()
            SizedBox(
                height: 40,
                width: 40,
                child: Image.asset("images/loading.gif")),


            ],
          );
        });

    //print("Firebase_token_sending:" + box.read("firebase_token").toString());
    var response = await http.post(
      Uri.parse('${baseurl}' + "JJM_Mobile/SaveInformationBoard"),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
      body: jsonEncode({
        "UserId": box.read("userid"),
        "VillageId": VillageId,
       "CapturePointTypeId" :CapturePointTypeId,
        "StateId": StateId,
        "SchemeId": SchemeId,
        "SourceId": SourceId,
        "DivisionId": DivisionId,
        "HabitationId": HabitationId,
         "Landmark": Landmark,
        "Latitude": Latitude,
        "Longitude": Longitude,
        "Accuracy": Accuracy,
        "Photo":Photo
      }),
    );
    Get.back();
    if (response.statusCode == 200) {
      var responsede = response.body;


      print("responsede"+responsede);
      print("UserId"+UserId);
      print("VillageId"+VillageId);

      print("StateId"+StateId);
      print("SchemeId"+SchemeId);
      print("SourceId"+SourceId);
      print("DivisionId"+DivisionId);
      print("HabitationId"+HabitationId);
      print("Landmark"+Landmark);
      print("Latitude"+Latitude);
      print("Longitude"+Longitude);
      print("Photo"+Photo);
      print("Accuracy"+Accuracy);


   /*   var responsede = jsonDecode(response.body);
     print("responsede"+ " " +jsonDecode(response.body));*/

    }
    return jsonDecode(response.body);
  }












  static Future getuserprofile(
    BuildContext context,
    String userid,
    String stateid,
    String token,
  ) async {
    //print("Firebase_token_sending:" + box.read("firebase_token").toString());
    var response = await http.post(
      Uri.parse('${baseurl}' + "JJM_Mobile/User_profile"),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
      body: jsonEncode({
        "Userid": userid,
        "StateId": stateid,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<void> fetchData( BuildContext context,String userid, String stateid,String villageid,
      String token,
      ) async {
    final String baseUrl = 'https://ejalshakti.gov.in/krcpwa/api/JJM_Mobile/GetSourceScheme';
    final Map<String, dynamic> queryParams = {
      'UserId': userid,
      'StateId': stateid,
      'villageid': villageid,
    };
    final Uri uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    try {
      final http.Response response = await http.get(uri
      ,headers: {
          'Content-Type': 'application/json',
          'APIKey': token ?? 'DEFAULT_API_KEY'
        },
      );
    if (response.statusCode == 200) {
        // Handle the successful response
      //  print('Response: ${response.body}');
      print('Response_success: ${response.body}');
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    }
    catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }







  static Future PWSPendingapprovalAPI(String villageid , String stateid , String userid, String token,String status ) async {


    var response = await http.get(
      Uri.parse(
          "${baseurl}JJM_Mobile/GetGeotaggedWaterSource?VillageId="+villageid+"&StateId="+stateid+"&UserId="+userid+"&Status="+status),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    //Get.back();
    if (response.statusCode == 200) {
   //   late PwsPendingapprovalmodal pwsPendingapprovalmodal;
      //  print("Firebase_Token_res: " + box.read("firebase_token").toString());


  }

  //return PwsPendingapprovalmodal.fromJson(jsonDecode(response.body));
  }

// village list

static Future getvillagelistapi(String userid , String stateid , String token) async{
  List<Villagelistmodal> list=[];

  try{
    var response = await http.get(
      Uri.parse('${baseurl}'+"JJM_Mobile/GetAssignedVillages?StateId="+stateid+"&UserId="+userid),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
      /*body: jsonEncode({
        "Userid": userid,
        "StateId": stateid,
      }),*/
    );
    if (response.statusCode == 200) {
      var  mapResponse = jsonDecode(response.body);


      List<dynamic> ListResponse = mapResponse['Villagelist_Datas'];

    } else {
      print("Failed");
    }
    return jsonDecode(response.body);
  }catch (e){
    return list;
  }

}


// village details
static Future getvillagedetailsApi( BuildContext context ,  String villageid , String stateid ,  String userid ,String token) async{

    try{

    var response = await http.get(
      Uri.parse('${baseurl}' + "JJM_Mobile/GetVillageGeoTaggingDetails?VillageId="+villageid+"&StateId="+stateid+"&UserId="+userid),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
      /*body: jsonEncode({
        "Userid": userid,
        "StateId": stateid,
      }),*/
    );
    if (response.statusCode == 200) {
      var  mapResponse = jsonDecode(response.body);
      return mapResponse;
    } else {
      print("Failed");
    }
    return jsonDecode(response.body);
  }catch (e){
    }
  }


// pws source details
static Future pandingfor_getpwssource( String villageid , String stateid ,  String userid ,String token , String Status) async{
    try{
    var response = await http.get(
      Uri.parse('${baseurl}' + "JJM_Mobile/GetGeotaggedWaterSource?VillageId="+villageid+"&StateId="+stateid+"&UserId="+userid+"&Status="+Status),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
      /*body: jsonEncode({
        "Userid": userid,
        "StateId": stateid,
      }),*/
    );
    if (response.statusCode == 200) {
      var  mapResponse = jsonDecode(response.body);
      return mapResponse;
    } else {
      print("Failed");
    }
    return jsonDecode(response.body);
  }catch (e){
    }
  }
}
