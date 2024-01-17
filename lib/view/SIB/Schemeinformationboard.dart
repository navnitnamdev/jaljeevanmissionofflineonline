import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jaljeevanmissiondynamic/model/SIBGeotagmodal.dart';
import '../../apiservice/Apiservice.dart';
import '../../utility/Appcolor.dart';
import '../SS/ZoomImage.dart';

class Schemeinformationboard extends StatefulWidget {
  String villageid;
  String VillageName;
  String stateid;
  String token;
  String statusapproved;

  Schemeinformationboard(
      {required this.villageid,
      required this.VillageName,
      required this.stateid,
      required this.token,
      required this.statusapproved,
      super.key});

  @override
  State<Schemeinformationboard> createState() => _SchemeinformationboardState();
}

class _SchemeinformationboardState extends State<Schemeinformationboard> {
  String getstateid = "";
  String getvillageid = "";
  String getstatusapproved = "";
  GetStorage box = GetStorage();
  String statusforapproveornot = "";
  String statusforapproveornot_message = "";
  String village = "";
  String message = "";
  String Panchayat = "";
  String villagename = "";
  String Block = "";
  String district = "";
  String gettoken = "";
  bool _loading = false;
  late SibGeotagmodal sibGeotagmodal;
  List<Result> sibgeotaglist = [];

  @override
  void initState() {
    villagename = widget.VillageName.toString();
    getvillageid = widget.villageid;
    getstateid = widget.stateid;
    gettoken = widget.token;
    getstatusapproved = widget.statusapproved;
    print("getstateid$getstateid");
    print("gettoken$gettoken");
    print("getstatusapproved$getstatusapproved");

    sibGeotagmodal = SibGeotagmodal(
        status: true,
        message: "ff",
        district: "",
        block: "",
        panchayat: "",
        headingMessage: "",
        result: []);

    SIBPendingapprovalAPI(getvillageid, getstateid, box.read("userid"),
            getstatusapproved, gettoken)
        .then((value) {});

    /* if(getstatusapproved=="0") {
      SIBPendingapprovalAPI(
          getvillageid, getstateid, box.read("userid"), getstatusapproved,
          gettoken).then((value) {
        setState(() {

        });
      });
    }else{
      SIBPendingapprovalAPI(
          getvillageid, getstateid, box.read("userid"), getstatusapproved,
          gettoken).then((value) {
        setState(() {

        });
      });
    }*/
    super.initState();
  }

  Future SIBPendingapprovalAPI(String villageid, String stateid, String userid,
      String status, String token) async {
    setState(() {
      _loading = true;
    });
    var response = await http.get(
      Uri.parse(
          "${Apiservice.baseurl}JJM_Mobile/GetGeotaggedInformationBoard?VillageId=$villageid&StateId=$stateid&UserId=$userid&Status=$status"),
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    try {
      if (response.statusCode == 200) {
        sibGeotagmodal = SibGeotagmodal.fromJson(jsonDecode(response.body));
        district = sibGeotagmodal.district;
        Block = sibGeotagmodal.block;
        Panchayat = sibGeotagmodal.panchayat;
        message = sibGeotagmodal.message;
        setState(() {
          if (sibGeotagmodal.result.isEmpty) {
            sibgeotaglist.clear();
          } else {
            sibgeotaglist = sibGeotagmodal.result;
          }
        });
      }
    } finally {
      _loading = false;
    }
  }

  Future RemovegeotaggedSIBAPI(String villageid, String stateid, String userid,
      String token, String taggedid, int index) async {
    var response = await http.get(
      Uri.parse(
          "${Apiservice.baseurl}JJM_Mobile/RemoveGeoTaggedInformationBoard?VillageId=$villageid&StateId=$stateid&UserId=$userid&TaggedId=$taggedid"),
      headers: {'Content-Type': 'application/json', 'APIKey': token},
    );
    try {
      if (response.statusCode == 200) {
        var responseof = jsonDecode(response.body);
        var message = responseof["Message"].toString();
        var Status = responseof["Status"].toString();
        if (Status == "true")
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message.toString()),
          ));
      }
    } catch (e) {
      e.printError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: const Color(0xFF0D3A98),
            iconTheme: const IconThemeData(
              color: Appcolor.white,
            ),
            title: const Text("Geo-tagged Scheme Information(Pending)",
                style: TextStyle(fontSize: 18, color: Colors.white))),
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
                  )
                : SingleChildScrollView(
                    child: getstatusapproved == "0"
                        ? Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // color: const Color(0xFFC2C2C2).withOpacity(0.3),
                              border: Border.all(
                                color: Colors.green,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Village : ${widget.VillageName}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Appcolor.headingcolor),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  thickness: 1,
                                  height: 10,
                                  color: Appcolor.lightgrey,
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
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
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
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
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
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
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                              "Geo-tagged PWS Water Source (Pending for approval)"),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          height: 10,
                                          color: Appcolor.lightgrey,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        sibgeotaglist.length == 0
                                            ? const Text(
                                                "Alert! Record remove successfully",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Appcolor.black),
                                              )
                                            : Container(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: sibgeotaglist.length,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, int index) {
                                                    statusforapproveornot =
                                                        sibgeotaglist[index]
                                                            .status
                                                            .toString();
                                                    statusforapproveornot_message =
                                                        sibgeotaglist[index]
                                                            .message
                                                            .toString();

                                                    return Container(
                                                        margin:
                                                            const EdgeInsets.only(
                                                                left: 5,
                                                                right: 5,
                                                                bottom: 5,
                                                                top: 0),
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFFFFFFF),
                                                          border: Border.all(
                                                            color: Colors.green,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              5,
                                                                          top: 5),
                                                                  child: SizedBox(
                                                                      width: 140,
                                                                      child: Text(
                                                                        "Scheme Name : ",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              5,
                                                                          top: 5),
                                                                  child: SizedBox(
                                                                      child:
                                                                          Text(
                                                                                                                                        sibgeotaglist[
                                                                        index]
                                                                    .schemeName
                                                                    .toString(),
                                                                                                                                        style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13,
                                                                    color: Appcolor
                                                                        .black),
                                                                                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              5,
                                                                          top: 5),
                                                                  child: SizedBox(
                                                                      child: Text(
                                                                    sibgeotaglist[
                                                                            index]
                                                                        .habitationName
                                                                        .toString(),
                                                                    style: const TextStyle(
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
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        "${sibgeotaglist[index]
                                                                                .latitude} , ${sibgeotaglist[index]
                                                                                .latitude}",
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
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        sibgeotaglist[
                                                                                index]
                                                                            .latitude
                                                                            .toString()
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
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        sibgeotaglist[
                                                                                index]
                                                                            .longitude
                                                                            .toString()
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
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        sibgeotaglist[
                                                                                index]
                                                                            .message
                                                                            .toString()
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            color:
                                                                                Appcolor.red),
                                                                      )),
                                                                )
                                                              ],
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
                                                                      .all(8.0),
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
                                                                            Appcolor
                                                                                .lightgrey,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Get.to(ZoomImage(
                                                                            imgurl:
                                                                                sibgeotaglist[index].imageUrl));
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .remove_red_eye_outlined,
                                                                        size: 18,
                                                                        color: Appcolor
                                                                            .white,
                                                                      ),
                                                                      label:
                                                                          const Text(
                                                                        "View",
                                                                        style: TextStyle(
                                                                            color: Appcolor
                                                                                .white,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ElevatedButton
                                                                        .icon(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            Appcolor
                                                                                .pink,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        showuntagedalertbox(
                                                                                sibgeotaglist[index].villageId.toString(),
                                                                                sibgeotaglist[index].stateId.toString(),
                                                                                box.read("userid").toString(),
                                                                                gettoken,
                                                                                sibgeotaglist[index].taggedId.toString(),
                                                                                index)
                                                                            .then((value) {
                                                                          setState(
                                                                              () {});
                                                                        });
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        size:
                                                                            18.0,
                                                                        Icons
                                                                            .delete_outline_outlined,
                                                                        color: Appcolor
                                                                            .white,
                                                                      ),
                                                                      label:
                                                                          const Text(
                                                                        "Untag Geo-location",
                                                                        style: TextStyle(
                                                                            color: Appcolor
                                                                                .white,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    )
                                                                  ]),
                                                            )
                                                          ],
                                                        ));
                                                  }),
                                            ),
                                      ],
                                    )),
                              ],
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC2C2C2).withOpacity(0.3),
                              border: Border.all(
                                color: Colors.green,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Village : ${widget.VillageName}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Appcolor.headingcolor),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  thickness: 1,
                                  height: 10,
                                  color: Appcolor.lightgrey,
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
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
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
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
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 5),
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
                                      color: const Color(0xFFC2C2C2)
                                          .withOpacity(0.3),
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                              "Geo-tagged PWS Water Source (Pending for approval)"),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          height: 10,
                                          color: Appcolor.lightgrey,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        sibgeotaglist.length == 0
                                            ? const Text(
                                                "Alert! Record remove successfully",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Appcolor.black),
                                              )
                                            : Container(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: sibgeotaglist.length,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, int index) {
                                                    statusforapproveornot =
                                                        sibgeotaglist[index]
                                                            .status
                                                            .toString();
                                                    statusforapproveornot_message =
                                                        sibgeotaglist[index]
                                                            .message
                                                            .toString();
                                              
                                                    return Container(
                                                        margin:
                                                            const EdgeInsets.only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 10,
                                                                top: 0),
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                                  0xFFC2C2C2)
                                                              .withOpacity(0.3),
                                                          border: Border.all(
                                                            color: Colors.green,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                              10.0,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              5,
                                                                          top: 5),
                                                                  child: SizedBox(
                                                                      width: 140,
                                                                      child: Text(
                                                                        "Scheme Name : ",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              5,
                                                                          top: 5),
                                                                  child: SizedBox(
                                                                      child:
                                                                          Text(
                                                                                                                                        sibgeotaglist[
                                                                        index]
                                                                    .schemeName
                                                                    .toString(),
                                                                                                                                        style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13,
                                                                    color: Appcolor
                                                                        .black),
                                                                                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              5,
                                                                          top: 5),
                                                                  child: SizedBox(
                                                                      child: Text(
                                                                    sibgeotaglist[
                                                                            index]
                                                                        .habitationName
                                                                        .toString(),
                                                                    style: const TextStyle(
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
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        "${sibgeotaglist[index]
                                                                                .latitude} , ${sibgeotaglist[index]
                                                                                .latitude}",
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
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        sibgeotaglist[
                                                                                index]
                                                                            .sourceCatogery
                                                                            .toString()
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
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        sibgeotaglist[
                                                                                index]
                                                                            .sourcetype
                                                                            .toString()
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
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        sibgeotaglist[
                                                                                index]
                                                                            .latitude
                                                                            .toString()
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
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        sibgeotaglist[
                                                                                index]
                                                                            .longitude
                                                                            .toString()
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
                                                                  padding: EdgeInsets
                                                                      .only(
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
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Appcolor.black),
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
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
                                                                        sibgeotaglist[
                                                                                index]
                                                                            .message
                                                                            .toString()
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            color:
                                                                                Appcolor.red),
                                                                      )),
                                                                )
                                                              ],
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
                                                                      .all(8.0),
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
                                                                            Appcolor
                                                                                .lightgrey,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Get.to(ZoomImage(
                                                                            imgurl:
                                                                                sibgeotaglist[index].imageUrl));
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .remove_red_eye_outlined,
                                                                        size: 18,
                                                                        color: Appcolor
                                                                            .white,
                                                                      ),
                                                                      label:
                                                                          const Text(
                                                                        "View",
                                                                        style: TextStyle(
                                                                            color: Appcolor
                                                                                .white,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            )
                                                          ],
                                                        ));
                                                  }),
                                            ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                  )));
  }

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
                            RemovegeotaggedSIBAPI(villageid, stateid, userid,
                                    token, taggedid, index)
                                .then((value) {
                              sibgeotaglist.removeAt(index);
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
