import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jaljeevanmissiondynamic/model/SSGeotagmodal.dart';
import 'package:jaljeevanmissiondynamic/view/SS/ZoomImage.dart';
import 'package:photo_view/photo_view.dart';
import '../../apiservice/Apiservice.dart';
import '../../utility/Appcolor.dart';

class Storagestructurependingapproved extends StatefulWidget {
  String villageid;
  String stateid;
  String token;
  String statusapproved;

  Storagestructurependingapproved(
      {required this.villageid,
      required this.stateid,
      required this.token,
      required this.statusapproved,
      super.key});

  @override
  State<Storagestructurependingapproved> createState() =>
      _StoragestructurependingapprovedState();
}

class _StoragestructurependingapprovedState
    extends State<Storagestructurependingapproved> {
  GetStorage box = GetStorage();
  String village = "";
  String message = "";
  String Panchayat = "";
  String Block = "";
  String district = "";

  String gettoken = "";
  bool _loading = false;
  late SsGeotagmodal ssGeotagmodal;

  // List<Result> pwspendinglistresult=[];
  List<Result> ssgeotahpendingapprovelist = [];
  String getstateid = "";
  String getvillageid = "";
  String getstatusapproved = "";
  String statusforapproveornot = "";
  String statusforapproveornot_message = "";

  @override
  void initState() {
    // TODO: implement initState
    getvillageid = widget.villageid;
    getstateid = widget.stateid;
    gettoken = widget.token;
    getstatusapproved = widget.statusapproved;

    ssGeotagmodal = SsGeotagmodal(
        status: true,
        message: "ff",
        district: "",
        block: "",
        panchayat: "",
        headingMessage: "",
        result: []);

    /*StoragestructurePendingandApprovedAPI(getvillageid, getstateid,
        box.read("userid"), getstatusapproved, gettoken)
        .then((value) {});*/

    if (getstatusapproved == "0") {
      StoragestructurePendingandApprovedAPI(getvillageid, getstateid,
              box.read("userid"), getstatusapproved, gettoken)
          .then((value) {});
    } else {
      StoragestructurePendingandApprovedAPI(getvillageid, getstateid,
              box.read("userid"), getstatusapproved, gettoken)
          .then((value) {
        setState(() {});
      });
    }
    super.initState();
  }

  Future StoragestructurePendingandApprovedAPI(String villageid, String stateid,
      String userid, String status, String token) async {
    setState(() {
      _loading = true;
    });
    var response = await http.get(
      Uri.parse(
          "${Apiservice.baseurl}JJM_Mobile/GetGeotaggedStorageStructure?VillageId=" +
              villageid +
              "&StateId=" +
              stateid +
              "&UserId=" +
              userid +
              "&Status=" +
              status),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    try {
      if (response.statusCode == 200) {
        //  print("Firebase_Token_res: " + box.read("firebase_token").toString());
        ssGeotagmodal = SsGeotagmodal.fromJson(jsonDecode(response.body));
        district = ssGeotagmodal.district;
        Block = ssGeotagmodal.block;
        Panchayat = ssGeotagmodal.panchayat;
        message = ssGeotagmodal.message;

        setState(() {
          ssgeotahpendingapprovelist = ssGeotagmodal!.result;

          // print("dataof" + pwspendinglistresult.toString());
          // return jsonDecode(response.body);
        });
        //  print("responselogin: " + responsede["Token"]);
        // print("Status code shiping address submit: " + response.statusCode.toString());
      }
    } catch (e) {
      // e.printError();
    } finally {
      _loading = false;
    }
  }


  // remove geo tagged from SS source
  Future RemovegeotaggedSSAPI(String villageid , String stateid , String userid,String token,String taggedid , int index) async {

    var response = await http.get(
      Uri.parse(
          "${Apiservice.baseurl}JJM_Mobile/RemoveGeoTaggedStorageStructure?VillageId="+villageid+"&StateId="+stateid+"&UserId="+userid+"&TaggedId="+taggedid),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    try{
      if (response.statusCode == 200) {
        var responseof = jsonDecode(response.body);
        var message =responseof["Message"].toString();
        var Status =responseof["Status"].toString();
        if(Status=="true")

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message.toString()),


          ));
        //  print("Firebase_Token_res: " + box.read("firebase_token").toString());

      }
    }catch (e){
     // e.printError();

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Color(0xFF0D3A98),
        iconTheme: const IconThemeData(
          color: Appcolor.white,
        ),
        title: Text("Geo-tagged Storage Structure (Pending)",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/header_bg.png'), fit: BoxFit.cover),
          ),
          child: _loading == true
              ? Center(
                  child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset("images/loading.gif")),
                  /*child: CircularProgressIndicator(
                      strokeWidth: 2,))*/
                  //  Image.asset("images/loader.gif")
                )
              : /*statusforapproveornot=="0" ?*/
              SingleChildScrollView(
                  child: getstatusapproved == "0"
                      ? Container(
//width: MediaQuery.of(context).size.width,//
//height: MediaQuery.of(context).size.height,

                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            //4b0082
                            color: const Color(0xFFC2C2C2).withOpacity(0.3),
                            border: Border.all(
                              color: Colors.green,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ), //                 <--- border radius here
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Village : ${getvillageid}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Appcolor.headingcolor),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                height: 10,
                                color: Appcolor.lightgrey,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          "District",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolor.black),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          district,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Appcolor.black),
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          "Block",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolor.black),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          Block,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Appcolor.black),
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          "Panchayat",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolor.black),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          Panchayat,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Appcolor.black),
                                        )),
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    //4b0082
                                    color: const Color(0xFFC2C2C2)
                                        .withOpacity(0.3),
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ), //                 <--- border radius here
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            "Geo-tagged PWS Water Source (Pending for approval)"),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        height: 10,
                                        color: Appcolor.lightgrey,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              ssgeotahpendingapprovelist.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, int index) {
                                            statusforapproveornot =
                                                ssgeotahpendingapprovelist[
                                                        index]
                                                    .status
                                                    .toString();
                                            statusforapproveornot_message =
                                                ssgeotahpendingapprovelist[
                                                        index]
                                                    .message
                                                    .toString();

                                            return Container(
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10,
                                                    top: 0),
                                                decoration: BoxDecoration(
                                                  //4b0082
                                                  color: const Color(0xFFC2C2C2)
                                                      .withOpacity(0.3),
                                                  border: Border.all(
                                                    color: Colors.green,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      10.0,
                                                    ), //                 <--- border radius here
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Scheme Name : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                maxLines: 3,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .schemeName
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Habitation Name : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              child: Text(
                                                            ssgeotahpendingapprovelist[
                                                                    index]
                                                                .habitationName
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Appcolor
                                                                    .black),
                                                          )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Location/landmark : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                            index]
                                                                        .latitude
                                                                        .toString() +
                                                                    " , " +
                                                                    ssgeotahpendingapprovelist[
                                                                            index]
                                                                        .latitude
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Source Category : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .sourceCatogery
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Source Type : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .sourcetype
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Latitude : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .latitude
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Longitude : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .longitude
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Status : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .message
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        Appcolor
                                                                            .red),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      height: 10,
                                                      color: Appcolor.lightgrey,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            ElevatedButton.icon(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary: Appcolor
                                                                    .lightgrey,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                              onPressed: () {

                                                                Get.to( ZoomImage(imgurl:ssgeotahpendingapprovelist[index].imageUrl));


                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .remove_red_eye_outlined,size:18,
                                                                color: Appcolor
                                                                    .white,
                                                              ),
                                                              label: const Text(
                                                                "View",
                                                                style: TextStyle(
                                                                    color: Appcolor
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            ElevatedButton.icon(
                                                              style: ElevatedButton
                                                                      .styleFrom(
                                                                primary:
                                                                    Appcolor
                                                                        .pink,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                              ),
                                                              onPressed: () {

                                                                showuntagedalertbox(ssgeotahpendingapprovelist[index].villageId.toString() ,ssgeotahpendingapprovelist[index].stateId.toString() ,
                                                                    box.read("userid").toString() ,gettoken,
                                                                    ssgeotahpendingapprovelist[index].taggedId.toString(), index).then((value) {

                                                                  setState(() {

                                                                  });
                                                                });
                                                              },
                                                              icon: const Icon(size: 18.0,
                                                                Icons
                                                                    .delete_outline_outlined,
                                                                color: Appcolor
                                                                    .white,
                                                              ),
                                                              label: const Text(
                                                                "Untag Geo-location",
                                                                style: TextStyle(
                                                                    color: Appcolor
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            )
                                                          ]),
                                                    )
                                                  ],
                                                ));
                                          }

/* ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(

                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                ),
                                ),
                                onPressed: () {},
                                icon: const Icon(Icons.filter_list),
                                label: const Text("s"),
                                )*/
                                          ),
                                    ],
                                  )),
                            ],
                          ),
                        )
                      : Container(
//width: MediaQuery.of(context).size.width,//
//height: MediaQuery.of(context).size.height,

                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            //4b0082
                            color: const Color(0xFFC2C2C2).withOpacity(0.3),
                            border: Border.all(
                              color: Colors.green,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ), //                 <--- border radius here
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Village : ${getvillageid}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Appcolor.headingcolor),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                height: 10,
                                color: Appcolor.lightgrey,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          "District",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolor.black),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          district,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Appcolor.black),
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          "Block",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolor.black),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          Block,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Appcolor.black),
                                        )),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          "Panchayat",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Appcolor.black),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          Panchayat,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Appcolor.black),
                                        )),
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    //4b0082
                                    color: const Color(0xFFC2C2C2)
                                        .withOpacity(0.3),
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ), //                 <--- border radius here
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            "Geo-tagged PWS Water Source (Pending for approval)"),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        height: 10,
                                        color: Appcolor.lightgrey,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              ssgeotahpendingapprovelist.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, int index) {
                                            statusforapproveornot =
                                                ssgeotahpendingapprovelist[
                                                        index]
                                                    .status
                                                    .toString();
                                            statusforapproveornot_message =
                                                ssgeotahpendingapprovelist[
                                                        index]
                                                    .message
                                                    .toString();


                                            print(ssgeotahpendingapprovelist[
                                                    index]
                                                .panchayatName);
                                            return Container(
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10,
                                                    top: 0),
                                                decoration: BoxDecoration(
                                                  //4b0082
                                                  color: const Color(0xFFC2C2C2)
                                                      .withOpacity(0.3),
                                                  border: Border.all(
                                                    color: Colors.green,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      10.0,
                                                    ), //                 <--- border radius here
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Scheme Name : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 130,
                                                              child: Text(
                                                                maxLines: 3,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .schemeName
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Habitation Name : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              child: Text(
                                                            ssgeotahpendingapprovelist[
                                                                    index]
                                                                .habitationName
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Appcolor
                                                                    .black),
                                                          )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Location/landmark : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                            index]
                                                                        .latitude
                                                                        .toString() +
                                                                    " , " +
                                                                    ssgeotahpendingapprovelist[
                                                                            index]
                                                                        .latitude
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Source Category : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .sourceCatogery
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Source Type : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .sourcetype
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Latitude : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .latitude
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Longitude : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .longitude
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 140,
                                                              child: Text(
                                                                "Status : ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .black),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  bottom: 5,
                                                                  top: 5),
                                                          child: SizedBox(
                                                              width: 100,
                                                              child: Text(
                                                                maxLines: 10,
                                                                ssgeotahpendingapprovelist[
                                                                        index]
                                                                    .message
                                                                    .toString()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        Appcolor
                                                                            .red),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      height: 10,
                                                      color: Appcolor.lightgrey,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                          children: [
                                                            ElevatedButton.icon(
                                                              style:
                                                              ElevatedButton
                                                                  .styleFrom(
                                                                primary: Appcolor
                                                                    .lightgrey,
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                ),
                                                              ),
                                                              onPressed: () {

                                                                Get.to( ZoomImage(imgurl:ssgeotahpendingapprovelist[index].imageUrl));

                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .remove_red_eye_outlined,size:18,
                                                                color: Appcolor
                                                                    .white,
                                                              ),
                                                              label: const Text(
                                                                "View",
                                                                style: TextStyle(
                                                                    color: Appcolor
                                                                        .white,
                                                                    fontSize:
                                                                    12,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                              ),
                                                            ),

                                                          ]),
                                                    )
                                                  ],
                                                ));
                                          }),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                ) /* :Center(child: Text("No record found"),*/),
    );
  }



  Future<bool> showuntagedalertbox(String villageid , String stateid , String userid, String token,String taggedid , int index) async {
    return await showDialog(
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.all(30),
        child: AlertDialog(
          titlePadding: EdgeInsets.only(top: 20, left: 0, right: 5),
          contentPadding:
          EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 20),
          insetPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Padding(
            padding: const EdgeInsets.only(left: 25, right: 20),
            child: Text('ejalshakti.gov.in says', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          content: Padding(
            padding: const EdgeInsets.only(left: 25, right: 20),
            child: Text('Are you sure want to Untag Geo-location ?' ,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 ),),
          ),
          actions: [
            Container(
              height: 40,
              //color: Appcolor.btncolor,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //backgroundColor: Appcolor.btncolor,
                        shape:
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Appcolor.btncolor)

                        ),
                      ),
                      onPressed: () {


                        Navigator.pop(context);

                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Appcolor.btncolor),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.btncolor,
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              side: BorderSide(color: Appcolor.btncolor))
                      ),
                      onPressed: () {

                        RemovegeotaggedSSAPI(villageid , stateid ,  userid, token, taggedid , index).then((value) {

                          ssgeotahpendingapprovelist.removeAt(index);
                          //Get.back();
                          Navigator.of(context).pop(false);


                        });

                      },
                      child: Text('Ok',
                          style: TextStyle(color: Appcolor.white)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ) ??
        false;
  }

}
