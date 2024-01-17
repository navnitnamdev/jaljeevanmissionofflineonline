import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/apiservice/Apiservice.dart';
import 'package:jaljeevanmissiondynamic/model/PWSPendingapprovalmodal.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utility/Appcolor.dart';
import '../SS/ZoomImage.dart';

class PWSPendingapproval extends StatefulWidget {
  String villageid = "";
  String villagename = "";
  String stateid = "";
  String token = "";
  String statusapproved = "";

  PWSPendingapproval(
      {required this.villageid,
      required this.villagename,
      required this.stateid,
      required this.token,
      required this.statusapproved,
      super.key});

  @override
  State<PWSPendingapproval> createState() => _PWSPendingapprovalState();
}

class _PWSPendingapprovalState extends State<PWSPendingapproval> {
  GetStorage box = GetStorage();
  var statusforapproveornot;
  var statusforapproveornot_message;
  var village = "";
  var message = "";
  var Headingmessage;
  var Panchayat;
  var Block;
  var district;
  var getvillageid;
  var getstateid;
  var messageres;
  var gettoken;
  var getstatusapproved;
  var villagename;
  bool _loading = false;
  late PwsPendingapprovalmodal pwsPendingapprovalmodal;
  List<Result> pwspendinglistresult = [];
  var one = "";

  @override
  void initState() {
    villagename = widget.villagename;
    getvillageid = widget.villageid;
    getstateid = widget.stateid;
    gettoken = widget.token;
    getstatusapproved = widget.statusapproved;
    pwsPendingapprovalmodal = PwsPendingapprovalmodal(
        status: true,
        message: "ff",
        district: "",
        block: "",
        panchayat: "",
        headingMessage: "",
        result: []);

    if (getstatusapproved == "0") {
      PWSPendingapprovalAPI(getvillageid, getstateid, box.read("userid"),
              getstatusapproved, gettoken)
          .then((value) {
        setState(() {});
      });
    } else {
      PWSPendingapprovalAPI(getvillageid, getstateid, box.read("userid"),
              getstatusapproved, gettoken)
          .then((value) {
        setState(() {});
      });
    }
    super.initState();
  }

  Future PWSPendingapprovalAPI(String villageid, String stateid, String userid,
      String status, String token) async {
    setState(() {
      _loading = true;
    });
    var response = await http.get(
      Uri.parse(
          "${Apiservice.baseurl}JJM_Mobile/GetGeotaggedWaterSource?VillageId=" +
              villageid +
              "&StateId=" +
              stateid +
              "&UserId=" +
              userid +
              "&Status=" +
              status),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token
      },
    );
    try {
      if (response.statusCode == 200) {
        pwsPendingapprovalmodal =
            PwsPendingapprovalmodal.fromJson(jsonDecode(response.body));
        district = pwsPendingapprovalmodal.district;
        Block = pwsPendingapprovalmodal.block;
        Panchayat = pwsPendingapprovalmodal.panchayat;
        message = pwsPendingapprovalmodal.message;
        Headingmessage = pwsPendingapprovalmodal.headingMessage;
        setState(() {
          if (pwsPendingapprovalmodal.result.isEmpty) {
            pwspendinglistresult.clear();
          } else {
            pwspendinglistresult = pwsPendingapprovalmodal.result;
          }
        });
      }
    } catch (e) {
      e.printError();
    } finally {
      _loading = false;
    }
  }

  Future RemovegeotaggedPWSAPI(String villageid, String stateid, String userid,
      String token, String taggedid, int index) async {
    var response = await http.get(
      Uri.parse(
          "${Apiservice.baseurl}JJM_Mobile/RemoveGeoTaggedWaterSource?VillageId=$villageid&StateId=$stateid&UserId=$userid&TaggedId=$taggedid"),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token
      },
    );
    try {
      if (response.statusCode == 200) {
        var responseof = jsonDecode(response.body);
        var message = responseof["Message"].toString();
        var Status = responseof["Status"].toString();
        if (Status == "true") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message.toString()),
          ));
        }
      }
    } catch (e) {
      e.printError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onVisibilityGained: () {
        /*  if(getstatusapproved=="0") {
          PWSPendingapprovalAPI(
              getvillageid, getstateid, box.read("userid"), getstatusapproved,
              gettoken).then((value) {

          });
        }else{
          PWSPendingapprovalAPI(
              getvillageid, getstateid, box.read("userid"), getstatusapproved,
              gettoken).then((value) {
            setState(() {

            });
          });
        }*/
        setState(() {});
      },
      child:  GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: const Color(0xFF0D3A98),
              iconTheme: const IconThemeData(
                color: Appcolor.white,
              ),
              title: const Text("Geo-tagged PWS Water Source(Pending)",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/header_bg.png'),
                      fit: BoxFit.cover),
                ),
                child: _loading == true
                    ? Center(
                        child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.asset("images/loading.gif")),

                      )
                    :
                    SingleChildScrollView(
                        child: getstatusapproved == "0"
                            ? Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  //4b0082
                                  // color: const Color(0xFFC2C2C2).withOpacity(0.3),
                                  color:
                                      const Color(0xFFFFFFFF).withOpacity(0.3),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
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
                                            'Village : ${widget.villagename}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Appcolor.headingcolor),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: SizedBox(
                                              width: 100,
                                              child: Text(
                                                "District :",
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
                                                district.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Appcolor.black),
                                              )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: SizedBox(
                                              width: 100,
                                              child: Text(
                                                "Block :",
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
                                                Block.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Appcolor.black),
                                              )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 5),
                                          child: SizedBox(
                                              width: 100,
                                              child: Text(
                                                "Panchayat :",
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
                                                Panchayat.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Appcolor.black),
                                              )),
                                        )
                                      ],
                                    ),
                                    Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          //4b0082
                                          // color: const Color(0xFFC2C2C2).withOpacity(0.3),
                                          color: const Color(0xFFFFFFFF)
                                              .withOpacity(0.3),
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              10.0,
                                            ), //                 <--- border radius here
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    Headingmessage.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Appcolor.black),
                                                  )),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              height: 10,
                                              color: Appcolor.lightgrey,
                                            ),
                                            pwspendinglistresult.isEmpty
                                                ? const Padding(
                                                    padding:
                                                        EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      "Alert! Record remove successfully",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Appcolor.black),
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        pwspendinglistresult
                                                            .length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, int index) {
                                                      villagename =
                                                          pwspendinglistresult[
                                                                  index]
                                                              .villageName
                                                              .toString();
                                                      statusforapproveornot =
                                                          pwspendinglistresult[
                                                                  index]
                                                              .status
                                                              .toString();
                                                      statusforapproveornot_message =
                                                          pwspendinglistresult[
                                                                  index]
                                                              .message
                                                              .toString();

                                                      return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width:
                                                              double.infinity,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Material(
                                                            child: InkWell(
                                                              splashColor:
                                                                  Appcolor
                                                                      .lightyello,
                                                              onTap: () {},
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 140,
                                                                            child: Text(
                                                                              "Scheme Name : ",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.black),
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 120,
                                                                            child: Text(
                                                                              maxLines: 2,
                                                                              pwspendinglistresult[index].schemeName.toString(),
                                                                              style: const TextStyle(fontWeight: FontWeight.w400, color: Appcolor.black),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 140,
                                                                            child: Text(
                                                                              "Habitation Name : ",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.black),
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            child: Text(
                                                                          pwspendinglistresult[index]
                                                                              .habitationName
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 140,
                                                                            child: Text(
                                                                              "Location/landmark : ",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.black),
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 100,
                                                                            child: Text(
                                                                              maxLines: 10,
                                                                              pwspendinglistresult[index].latitude.toString() + " , " + pwspendinglistresult[index].latitude.toString(),
                                                                              style: const TextStyle(fontWeight: FontWeight.w400, color: Appcolor.black),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 140,
                                                                            child: Text(
                                                                              "Source Category : ",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.black),
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 100,
                                                                            child: Text(
                                                                              maxLines: 10,
                                                                              pwspendinglistresult[index].sourceCatogery.toString().toString(),
                                                                              style: const TextStyle(fontWeight: FontWeight.w400, color: Appcolor.black),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 140,
                                                                            child: Text(
                                                                              "Source Type : ",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.black),
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 100,
                                                                            child: Text(
                                                                              maxLines: 10,
                                                                              pwspendinglistresult[index].sourcetype.toString().toString(),
                                                                              style: const TextStyle(fontWeight: FontWeight.w400, color: Appcolor.black),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 140,
                                                                            child: Text(
                                                                              "Latitude : ",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.black),
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 100,
                                                                            child: Text(
                                                                              maxLines: 10,
                                                                              pwspendinglistresult[index].latitude.toString().toString(),
                                                                              style: const TextStyle(fontWeight: FontWeight.w400, color: Appcolor.black),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 140,
                                                                            child: Text(
                                                                              "Longitude : ",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.black),
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 100,
                                                                            child: Text(
                                                                              maxLines: 10,
                                                                              pwspendinglistresult[index].longitude.toString().toString(),
                                                                              style: const TextStyle(fontWeight: FontWeight.w400, color: Appcolor.black),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 140,
                                                                            child: Text(
                                                                              "Status : ",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Appcolor.black),
                                                                            )),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        child: SizedBox(
                                                                            width: 100,
                                                                            child: Text(
                                                                              maxLines: 10,
                                                                              pwspendinglistresult[index].message.toString().toString(),
                                                                              style: const TextStyle(fontWeight: FontWeight.w400, color: Appcolor.red),
                                                                            )),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 10,
                                                                    color: Appcolor
                                                                        .lightgrey,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .end,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          ElevatedButton
                                                                              .icon(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              primary: Appcolor.lightgrey,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Get.to(ZoomImage(imgurl: pwspendinglistresult[index].imageUrl));
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.remove_red_eye_outlined,
                                                                              size: 18,
                                                                              color: Appcolor.white,
                                                                            ),
                                                                            label:
                                                                                const Text(
                                                                              "View",
                                                                              style: TextStyle(color: Appcolor.white, fontSize: 12, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          ElevatedButton
                                                                              .icon(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              primary: Appcolor.pink,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              showuntagedalertbox(pwspendinglistresult[index].villageId.toString(), pwspendinglistresult[index].stateId.toString(), box.read("userid").toString(), gettoken, pwspendinglistresult[index].taggedId.toString(), index).then((value) {
                                                                                setState(() {});
                                                                              });
                                                                            },
                                                                            icon:
                                                                                const Icon(
                                                                              size: 18.0,
                                                                              Icons.delete_outline_outlined,
                                                                              color: Appcolor.white,
                                                                            ),
                                                                            label:
                                                                                const Text(
                                                                              "Untag Geo-location",
                                                                              style: TextStyle(color: Appcolor.white, fontSize: 12, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          )
                                                                        ]),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    }),
                                          ],
                                        )),
                                  ],
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  //4b0082
                                  // color: const Color(0xFFC2C2C2).withOpacity(0.3),
                                  color:
                                      const Color(0xFFFFFFFF).withOpacity(0.3),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
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
                                            'Village : ${widget.villagename}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Appcolor.headingcolor),
                                          )),
                                    ),
                                    //   SizedBox(height: 10,),
                                    /*  Divider(
                      thickness: 1,
                      height: 10,
                      color: Appcolor.lightgrey,
                    ),*/
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
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
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Appcolor.black),
                                              )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
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
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Appcolor.black),
                                              )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
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
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Appcolor.black),
                                              )),
                                        )
                                      ],
                                    ),
                                    Container(
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          //4b0082
                                          // color: const Color(0xFFC2C2C2).withOpacity(0.3),
                                          color: const Color(0xFFFFFFFF)
                                              .withOpacity(0.3),
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              10.0,
                                            ), //                 <--- border radius here
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(Headingmessage),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              height: 10,
                                              color: Appcolor.lightgrey,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            pwspendinglistresult.isEmpty
                                                ? const Padding(
                                                    padding:
                                                        EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      "Alert! Record remove successfully",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Appcolor.black),
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        pwspendinglistresult
                                                            .length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, int index) {
                                                      villagename =
                                                          pwspendinglistresult[
                                                                  index]
                                                              .villageName
                                                              .toString();
                                                      statusforapproveornot =
                                                          pwspendinglistresult[
                                                                  index]
                                                              .status
                                                              .toString();
                                                      statusforapproveornot_message =
                                                          pwspendinglistresult[
                                                                  index]
                                                              .message
                                                              .toString();

                                                      return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5,
                                                                  right: 5,
                                                                  bottom: 5,
                                                                  top: 0),
                                                          decoration:
                                                              BoxDecoration(
                                                            //4b0082
                                                            // color: const Color(0xFFC2C2C2).withOpacity(0.3),
                                                            color: const Color(
                                                                    0xFFFFFFFF)
                                                                .withOpacity(
                                                                    0.3),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.green,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                10.0,
                                                              ), //                 <--- border radius here
                                                            ),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top:
                                                                            10),
                                                                    child: SizedBox(
                                                                        width: 140,
                                                                        child: Text(
                                                                          "Scheme Name : ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 120,
                                                                        child: Text(
                                                                          maxLines:
                                                                              2,
                                                                          pwspendinglistresult[index]
                                                                              .schemeName
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 140,
                                                                        child: Text(
                                                                          "Habitation Name : ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        child: Text(
                                                                      pwspendinglistresult[
                                                                              index]
                                                                          .habitationName
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              Appcolor.black),
                                                                    )),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 140,
                                                                        child: Text(
                                                                          "Location/landmark : ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 100,
                                                                        child: Text(
                                                                          maxLines:
                                                                              10,
                                                                          "${pwspendinglistresult[index].latitude} , ${pwspendinglistresult[index].latitude}",
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 140,
                                                                        child: Text(
                                                                          "Source Category : ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 100,
                                                                        child: Text(
                                                                          maxLines:
                                                                              10,
                                                                          pwspendinglistresult[index]
                                                                              .sourceCatogery
                                                                              .toString()
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 140,
                                                                        child: Text(
                                                                          "Source Type : ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 100,
                                                                        child: Text(
                                                                          maxLines:
                                                                              10,
                                                                          pwspendinglistresult[index]
                                                                              .sourcetype
                                                                              .toString()
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 140,
                                                                        child: Text(
                                                                          "Latitude : ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 100,
                                                                        child: Text(
                                                                          maxLines:
                                                                              10,
                                                                          pwspendinglistresult[index]
                                                                              .latitude
                                                                              .toString()
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 140,
                                                                        child: Text(
                                                                          "Longitude : ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 100,
                                                                        child: Text(
                                                                          maxLines:
                                                                              10,
                                                                          pwspendinglistresult[index]
                                                                              .longitude
                                                                              .toString()
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 140,
                                                                        child: Text(
                                                                          "Status : ",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Appcolor.black),
                                                                        )),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            5,
                                                                        top: 5),
                                                                    child: SizedBox(
                                                                        width: 100,
                                                                        child: Text(
                                                                          maxLines:
                                                                              10,
                                                                          pwspendinglistresult[index]
                                                                              .message
                                                                              .toString()
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Appcolor.red),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              const Divider(
                                                                thickness: 1,
                                                                height: 10,
                                                                color: Appcolor
                                                                    .lightgrey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      ElevatedButton
                                                                          .icon(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          primary:
                                                                              Appcolor.lightgrey,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0),
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Get.to(
                                                                              ZoomImage(imgurl: pwspendinglistresult[index].imageUrl));
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .remove_red_eye_outlined,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Appcolor.white,
                                                                        ),
                                                                        label:
                                                                            const Text(
                                                                          "View",
                                                                          style: TextStyle(
                                                                              color: Appcolor.white,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w400),
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
                      ))),
      ),
    );
  }

  //return PwsPendingapprovalmodal.fromJson(jsonDecode(response.body));

  Future<bool> showuntagedalertbox(String villageid, String stateid,
      String userid, String token, String taggedid, int index) async {
    return await showDialog(
          context: context,
          builder: (context) => Container(
            margin: const EdgeInsets.all(30),
            child: AlertDialog(
              titlePadding: const EdgeInsets.only(top: 20, left: 0, right: 5),
              contentPadding:
                  const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 20),
              insetPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: const Padding(
                padding: EdgeInsets.only(left: 25, right: 20),
                child: Text(
                  'ejalshakti.gov.in says',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              content: const Padding(
                padding: EdgeInsets.only(left: 25, right: 20),
                child: Text(
                  'Are you sure want to Untag Geo-location ?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              actions: [
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            //backgroundColor: Appcolor.btncolor,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Appcolor.btncolor)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Appcolor.btncolor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.btncolor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  side: BorderSide(color: Appcolor.btncolor))),
                          onPressed: () {
                            RemovegeotaggedPWSAPI(villageid, stateid, userid,
                                    token, taggedid, index)
                                .then((value) {
                              pwspendinglistresult.removeAt(index);
                              //Get.back();
                              Navigator.of(context).pop(false);
                            });
                          },
                          child: const Text('Ok',
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
