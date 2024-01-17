import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/apiservice/Apiservice.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:jaljeevanmissiondynamic/view/NewTagWater.dart';
import 'package:jaljeevanmissiondynamic/view/Otherassets/Otherassetsgeotaggedpendingapprove.dart';
import 'package:jaljeevanmissiondynamic/view/SIB/Schemeinformationboard.dart';
import 'package:jaljeevanmissiondynamic/view/pws/PWSPendingapproval.dart';

import 'LoginScreen.dart';
import 'SS/Storagestructurependingapproved.dart';

class VillageDetails extends StatefulWidget {
  var villageid = "";
  var villagename = "";
  var stateid = "";

  VillageDetails({required this.villageid,required this.villagename, required this.stateid, Key? key})
      : super(key: key);

  @override
  State<VillageDetails> createState() => _VillageDetailsState();
}

class _VillageDetailsState extends State<VillageDetails> {
  var getstateid;

  var getsvillageid;

  GetStorage box = GetStorage();

  var HeadingMessage;

  var PanchayatName;

  var VillageName;

  var district;

  var Block;

  var Panchayat;
  var Total_Noof_PWS_Schemes;
  var Total_No_of_School_AWs_Schemes;
  var PendingWsTotal;
  var BalanceWsTotal;

  var TotalWsGeoTagged;

  var BalanceIBTotal;

  var PendingIBTotal;

  var TotalIBGeoTagged;

  var PendingApprovalSSTotal;
  var TotalSSGeoTagged;

  var TotalOAGeoTagged;
  var BalanceOATotal;
  var TotalNoOfWaterSource;

  bool _loading = false;

  @override
  void initState() {
    if(box.read("UserToken").toString() == "null") {
      Get.off(LoginScreen());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please login your token has been expired!")));
    }
    getsvillageid = widget.villageid;
    VillageName = widget.villagename;
    getstateid = widget.stateid;

    setState(() {
      _loading = true;
    });

    Apiservice.getvillagedetailsApi(
      context,
      widget.villageid,
      widget.stateid,
      box.read("userid"),
      box.read("UserToken"),
    ).then((value) {


      district = value["DistrictName"].toString();
      VillageName = value["VillageName"].toString();
      Block = value["BlockName"].toString();
      PanchayatName = value["PanchayatName"].toString();
      Total_Noof_PWS_Schemes = value["TotalNoOfPWSScheme"].toString();
      Total_No_of_School_AWs_Schemes =
          value["TotalNoOfSchoolScheme"].toString();
      PendingWsTotal = value["PendingWsTotal"].toString();
      BalanceWsTotal = value["BalanceWsTotal"].toString();
      TotalWsGeoTagged = value["TotalWsGeoTagged"].toString();
      BalanceIBTotal = value["BalanceIBTotal"].toString();
      PendingIBTotal = value["PendingIBTotal"].toString();
      TotalIBGeoTagged = value["TotalIBGeoTagged"].toString();
      PendingApprovalSSTotal = value["PendingApprovalSSTotal"].toString();
      TotalSSGeoTagged = value["TotalSSGeoTagged"].toString();
      TotalOAGeoTagged = value["TotalOAGeoTagged"].toString();
      BalanceOATotal = value["BalanceOATotal"].toString();
      TotalNoOfWaterSource = value["TotalNoOfWaterSource"].toString();

      setState(() {
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onVisibilityGained: () {
        Apiservice.getvillagedetailsApi(
          context,
          widget.villageid,
          widget.stateid,
          box.read("userid"),
          box.read("UserToken"),
        ).then((value) {
          district = value["DistrictName"].toString();
          VillageName = value["VillageName"].toString();
          Block = value["BlockName"].toString();
          PanchayatName = value["PanchayatName"].toString();
          Total_Noof_PWS_Schemes = value["TotalNoOfPWSScheme"].toString();
          Total_No_of_School_AWs_Schemes =
              value["TotalNoOfSchoolScheme"].toString();
          PendingWsTotal = value["PendingWsTotal"].toString();
          BalanceWsTotal = value["BalanceWsTotal"].toString();
          TotalWsGeoTagged = value["TotalWsGeoTagged"].toString();
          BalanceIBTotal = value["BalanceIBTotal"].toString();
          PendingIBTotal = value["PendingIBTotal"].toString();
          TotalIBGeoTagged = value["TotalIBGeoTagged"].toString();
          PendingApprovalSSTotal = value["PendingApprovalSSTotal"].toString();
          TotalSSGeoTagged = value["TotalSSGeoTagged"].toString();
          TotalOAGeoTagged = value["TotalOAGeoTagged"].toString();
          BalanceOATotal = value["BalanceOATotal"].toString();
          TotalNoOfWaterSource = value["TotalNoOfWaterSource"].toString();

          setState(() {
            _loading = false;
          });
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D3A98),
          iconTheme: const IconThemeData(
            color: Appcolor.white,
          ),
          title: const Text("Village Details",
              style: TextStyle(color: Colors.white)),
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
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'images/bharat.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jal Jeevan Mission',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Department of Drinking Water and Sanitation',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'Ministry of Jal Shakti',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.only(top: 50),
                                        child: AlertDialog(
                                          title:  Text(box.read("username").toString()),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  box.remove("UserToken");
                                                  box.remove('loginBool');
                                                  Get.off(LoginScreen());
                                                },
                                                child: const Text('Sign Out'))
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset('images/profile.png',
                                    width: 50.0, height: 50.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Geo-tag water assets',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Appcolor.headingcolor),
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
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
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Village : ${VillageName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Appcolor.headingcolor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Appcolor.white,
                                    border: Border.all(
                                      color: Appcolor.lightgrey,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 5,
                                      top: 5.0,
                                      right: 5.0,
                                      bottom: 5.0),
                                  child: Material(
                                    child: InkWell(
                                      splashColor: Appcolor.splashcolor,
                                      onTap: () {},
                                      child: Container(
                                          child: Column(children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                'District : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                district,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Color(0xFF0D3A98),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                'Block : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                Block.toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Color(0xFF0D3A98),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                'PanchayatName : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                PanchayatName.toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Color(0xFF0D3A98),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                'Total No of PWS Schemes : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                Total_Noof_PWS_Schemes
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Color(0xFF0D3A98),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                'Total No of School/AWs Schemes :  ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                Total_No_of_School_AWs_Schemes
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Color(0xFF0D3A98),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                'Total No of PWS Source :  ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                TotalNoOfWaterSource
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Color(0xFF0D3A98),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ])),
                                    ),
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Status of Geo-tag PWS assets',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Appcolor.headingcolor),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  border: Border.all(
                                    color: Appcolor.lightgrey,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5.0, right: 5.0, bottom: 5.0),
                                child: Material(
                                  child: InkWell(
                                    splashColor: Appcolor.splashcolor,
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10, left: 5),
                                          child: Text(
                                            '(A).PWS Source',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 1,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 10,
                                                      top: 0),
                                                  child: TotalWsGeoTagged != "0"
                                                      ? Material(
                                                          elevation: 2.0,
                                                          color: Appcolor.greeenlight,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: InkWell(
                                                            splashColor: Appcolor
                                                                .splashcolor,
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              Get.to(PWSPendingapproval(
                                                                  villageid: widget
                                                                      .villageid,
                                                                  villagename: widget.villagename,

                                                                  stateid: widget
                                                                      .stateid,
                                                                  token: box.read(
                                                                      "UserToken"),
                                                                  statusapproved:
                                                                      "1"));
                                                            },
                                                            child: Ink(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    child: const Center(
                                                                        child: Text(
                                                                      'Geo-tagged \n     and \napproved',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )),
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 10,
                                                                    color: Appcolor
                                                                        .lightgrey,
                                                                  ),
                                                                  Center(
                                                                      child:
                                                                          Text(
                                                                    TotalWsGeoTagged,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Appcolor
                                                                            .btnbordercolor),
                                                                  ))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Material(
                                                          elevation: 2.0,
                                                          color: Appcolor
                                                              .greeenlight,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: InkWell(
                                                            splashColor: Appcolor
                                                                .splashcolor,
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                            child: Ink(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    child: const Center(
                                                                        child: Text(
                                                                      'Geo-tagged \n     and \napproved',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )),
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 10,
                                                                    color: Appcolor
                                                                        .lightgrey,
                                                                  ),
                                                                  Center(
                                                                      child:
                                                                          Text(
                                                                    TotalWsGeoTagged,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Appcolor
                                                                            .btnbordercolor),
                                                                  ))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              Expanded(
                                                child: PendingWsTotal != "0"
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 2,
                                                            right: 5,
                                                            bottom: 10,
                                                            top: 0),
                                                        child: Material(
                                                          elevation: 2.0,
                                                          color: Appcolor
                                                              .lightyello,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: InkWell(
                                                              splashColor: Appcolor
                                                                  .splashcolor,
                                                              customBorder:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10.0,
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                Get.to(PWSPendingapproval(
                                                                    villageid: widget.villageid,
                                                                    villagename: widget.villagename,
                                                                    stateid: widget
                                                                        .stateid,
                                                                    token: box.read(
                                                                        "UserToken"),
                                                                    statusapproved:
                                                                        "0"));
                                                              },
                                                              child: Ink(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                      child: const Center(
                                                                          child: Text(
                                                                        'Pending \n     for \napproval',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      )),
                                                                    ),
                                                                    const Divider(
                                                                      thickness:
                                                                          1,
                                                                      height:
                                                                          10,
                                                                      color: Appcolor
                                                                          .lightgrey,
                                                                    ),
                                                                    Center(
                                                                        child:
                                                                            Text(
                                                                      PendingWsTotal,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Appcolor.btnbordercolor),
                                                                    ))
                                                                  ],
                                                                ),
                                                              )),
                                                        ),
                                                      )
                                                    : Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 2,
                                                            right: 5,
                                                            bottom: 10,
                                                            top: 0),
                                                        color:
                                                            Appcolor.lightyello,
                                                        child: Material(
                                                          elevation: 2.0,
                                                          color: Appcolor
                                                              .lightyello,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: InkWell(
                                                            splashColor: Appcolor
                                                                .splashcolor,
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                            child: Ink(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    child: const Center(
                                                                        child: Text(
                                                                      'Pending \n     for \napproval',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )),
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 10,
                                                                    color: Appcolor
                                                                        .lightgrey,
                                                                  ),
                                                                  Center(
                                                                      child:
                                                                          Text(
                                                                    PendingWsTotal,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Appcolor
                                                                            .btnbordercolor),
                                                                  ))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 10,
                                                    top: 0),
                                                decoration: BoxDecoration(
                                                    color: Appcolor.pinklight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Appcolor
                                                              .lightgrey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: const Center(
                                                            child: Text(
                                                          ' \n Balance     \n',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                      ),
                                                      const Divider(
                                                        thickness: 1,
                                                        height: 10,
                                                        color:
                                                            Appcolor.lightgrey,
                                                      ),
                                                      BalanceWsTotal == "0"
                                                          ? Center(
                                                              child: Text(
                                                              BalanceWsTotal,
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Appcolor
                                                                      .btnbordercolor),
                                                            ))
                                                          : GestureDetector(
                                                              onTap: () {},
                                                              child: Center(
                                                                  child: Text(
                                                                BalanceWsTotal,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Appcolor
                                                                        .btnbordercolor),
                                                              ))),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Container(
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffb3C53C2)),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Appcolor.splashcolor,
                                                  customBorder:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  onTap: () {
                                                    Get.to(NewTagWater(clcikedstatus:"1" , stateid:widget.stateid ,villageid:widget.villageid,villagename:widget.villagename,));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Add/Geo-tag PWS Source',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14),
                                                      ),
                                                      IconButton(
                                                        color: Colors.black,
                                                        onPressed: () {
                                                          Get.to(NewTagWater(clcikedstatus:"1" , stateid:widget.stateid ,villageid:widget.villageid,villagename:widget.villagename,));

                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .double_arrow_outlined,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  border: Border.all(
                                    color: Appcolor.lightgrey,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5.0, right: 5.0, bottom: 5.0),
                                child: Material(
                                  child: InkWell(
                                    splashColor: Appcolor.splashcolor,
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10, left: 5),
                                          child: Text(
                                            '(B).Scheme Information Board',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 10,
                                                    top: 0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: TotalIBGeoTagged == "0"
                                                    ? Material(
                                                        elevation: 2.0,
                                                  color: Appcolor.greeenlight,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: InkWell(
                                                          splashColor: Appcolor
                                                              .splashcolor,
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10.0,
                                                            ),
                                                          ),
                                                          child: Ink(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'Geo-tagged \n     and \napproved',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  )),
                                                                ),
                                                                const Divider(
                                                                  thickness: 1,
                                                                  height: 10,
                                                                  color: Appcolor
                                                                      .lightgrey,
                                                                ),
                                                                Center(
                                                                    child: Text(
                                                                  TotalIBGeoTagged,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Appcolor
                                                                          .btnbordercolor),
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Material(
                                                        elevation: 2.0,
                                                  color: Appcolor.greeenlight,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: InkWell(
                                                          splashColor: Appcolor
                                                              .splashcolor,
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10.0,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            Get.to(Schemeinformationboard(
                                                                villageid: widget.villageid,
                                                                VillageName:widget.villagename,

                                                                stateid: widget.stateid,
                                                                token: box.read(
                                                                    "UserToken"),
                                                                statusapproved:
                                                                    "1"));
                                                          },
                                                          child: Ink(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'Geo-tagged \n     and \napproved',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  )),
                                                                ),
                                                                const Divider(
                                                                  thickness: 1,
                                                                  height: 10,
                                                                  color: Appcolor
                                                                      .lightgrey,
                                                                ),
                                                                Center(
                                                                    child: Text(
                                                                  TotalIBGeoTagged,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Appcolor
                                                                          .btnbordercolor),
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 10,
                                                    top: 0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: PendingIBTotal == "0"
                                                    ? Material(
                                                        elevation: 2.0,
                                                        color:
                                                            Appcolor.lightyello,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: InkWell(
                                                          splashColor: Appcolor
                                                              .splashcolor,
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10.0,
                                                            ),
                                                          ),
                                                          child: Ink(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'Pending \n     for \napproval',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  )),
                                                                ),
                                                                const Divider(
                                                                  thickness: 1,
                                                                  height: 10,
                                                                  color: Appcolor
                                                                      .lightgrey,
                                                                ),
                                                                Center(
                                                                    child: Text(
                                                                  PendingIBTotal,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Appcolor
                                                                          .btnbordercolor),
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Material(
                                                        elevation: 2.0,
                                                        color:
                                                            Appcolor.lightyello,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.to(Schemeinformationboard(
                                                                villageid: widget.villageid,
                                                                VillageName:widget.villagename,
                                                                stateid: widget
                                                                    .stateid,
                                                                token: box.read(
                                                                    "UserToken"),
                                                                statusapproved:
                                                                    "0"));
                                                          },
                                                          splashColor: Appcolor
                                                              .splashcolor,
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10.0,
                                                            ),
                                                          ),
                                                          child: Ink(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'Pending \n     for \napproval',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  )),
                                                                ),
                                                                const Divider(
                                                                  thickness: 1,
                                                                  height: 10,
                                                                  color: Appcolor
                                                                      .lightgrey,
                                                                ),
                                                                Center(
                                                                    child: Text(
                                                                  PendingIBTotal,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Appcolor
                                                                          .btnbordercolor),
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 10,
                                                    top: 0),
                                                decoration: BoxDecoration(
                                                    color: Appcolor.pinklight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Appcolor
                                                              .lightgrey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: const Center(
                                                            child: Text(
                                                          ' \n   Balance   \n',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                      ),
                                                      const Divider(
                                                        thickness: 1,
                                                        height: 10,
                                                        color:
                                                            Appcolor.lightgrey,
                                                      ),
                                                      Center(
                                                          child: Text(
                                                        BalanceIBTotal,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Appcolor
                                                                .btnbordercolor),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 10,
                                                    top: 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Container(
                                              padding: const EdgeInsets.all(2),
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffb3C53C2)),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Material(
                                                child: InkWell(
                                                  splashColor:
                                                      Appcolor.splashcolor,
                                                  customBorder:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  onTap: () {
                                                    Get.to( NewTagWater(clcikedstatus:"2",  stateid:widget.stateid,villageid:widget.villageid,villagename:widget.villagename));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Add/Geo-tag Scheme Information Boards',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13.5),
                                                      ),
                                                      IconButton(
                                                        color: Colors.black,
                                                        onPressed: () {
                                                          /* Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>
                                                                  NewTagWater(geotagSS:Geo_tagSS,widget.userId, widget.stateid,widget.villageid,
                                                                      widget.token )));*/

                                                          Get.to( NewTagWater(clcikedstatus:"2", stateid:widget.stateid,villageid:widget.villageid,villagename:widget.villagename));
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .double_arrow_outlined,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  border: Border.all(
                                    color: Appcolor.lightgrey,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5.0, right: 5.0, bottom: 5.0),
                                child: Material(
                                  child: InkWell(
                                    splashColor: Appcolor.splashcolor,
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10, left: 5),
                                          child: Text(
                                            '(C). Storage Structure',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: TotalSSGeoTagged != "0"
                                                    ? Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        child: Material(
                                                          elevation: 2.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => Storagestructurependingapproved(
                                                                        villageid:
                                                                            widget
                                                                                .villageid,
                                                                        stateid:
                                                                            widget
                                                                                .stateid,
                                                                        token: box.read(
                                                                            "UserToken"),
                                                                        statusapproved:
                                                                            "1")),
                                                              );
                                                            },
                                                            child: Ink(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    child: const Center(
                                                                        child: Text(
                                                                      '\n Geo-tagged     \n',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )),
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 10,
                                                                    color: Appcolor
                                                                        .lightgrey,
                                                                  ),
                                                                  Center(
                                                                      child:
                                                                          Text(
                                                                    TotalSSGeoTagged,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Appcolor
                                                                            .btnbordercolor),
                                                                  )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 5,
                                                            right: 5,
                                                            bottom: 10,
                                                            top: 0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Material(
                                                          elevation: 2.0,
                                                          color: Appcolor.greeenlight,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: InkWell(
                                                            splashColor: Appcolor
                                                                .splashcolor,
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0,
                                                              ),
                                                            ),
                                                            child: Ink(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    child: const Center(
                                                                        child: Text(
                                                                      ' \n  Geo-tagged   \n',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )),
                                                                  ),
                                                                  const Divider(
                                                                    thickness:
                                                                        1,
                                                                    height: 10,
                                                                    color: Appcolor
                                                                        .lightgrey,
                                                                  ),
                                                                  Center(
                                                                      child:
                                                                          Text(
                                                                    TotalSSGeoTagged,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Appcolor
                                                                            .btnbordercolor),
                                                                  )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 10,
                                                    top: 0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child:
                                                    PendingApprovalSSTotal !=
                                                            "0"
                                                        ? Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 0),
                                                            child: Material(
                                                              elevation: 2.0,
                                                              color: Appcolor
                                                                  .lightyello,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => Storagestructurependingapproved(
                                                                            villageid:
                                                                                widget.villageid,
                                                                            stateid: widget.stateid,
                                                                            token: box.read("UserToken"),
                                                                            statusapproved: "0")),
                                                                  );
                                                                },
                                                                child: Ink(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          'Pending \n     for \napproval',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w500),
                                                                        )),
                                                                      ),
                                                                      const Divider(
                                                                        thickness:
                                                                            1,
                                                                        height:
                                                                            10,
                                                                        color: Appcolor
                                                                            .lightgrey,
                                                                      ),
                                                                      Center(
                                                                          child:
                                                                              Text(
                                                                        PendingApprovalSSTotal,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Appcolor.btnbordercolor),
                                                                      )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            decoration: BoxDecoration(
                                                                color: Appcolor
                                                                    .lightyello,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Material(
                                                              elevation: 2.0,
                                                              color: Appcolor
                                                                  .lightyello,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child: InkWell(
                                                                splashColor:
                                                                    Appcolor
                                                                        .splashcolor,
                                                                customBorder:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10.0,
                                                                  ),
                                                                ),
                                                                child: Ink(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: const Center(
                                                                            child: Text(
                                                                          'Pending \n     for \napproval',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.w500),
                                                                        )),
                                                                      ),
                                                                      const Divider(
                                                                        thickness:
                                                                            1,
                                                                        height:
                                                                            10,
                                                                        color: Appcolor
                                                                            .lightgrey,
                                                                      ),
                                                                      Center(
                                                                          child:
                                                                              Text(
                                                                        PendingApprovalSSTotal,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Appcolor.btnbordercolor),
                                                                      )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Container(
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffb3c53c2)),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Appcolor.splashcolor,
                                                  customBorder:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  onTap: () {
                                                    Get.to( NewTagWater(clcikedstatus:"3", stateid:widget.stateid,villageid:widget.villageid, villagename:widget.villagename));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Add/Geo-tag Storage Structure',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14),
                                                      ),
                                                      IconButton(
                                                        color: Colors.black,
                                                        onPressed: () {
                                                          Get.to( NewTagWater(clcikedstatus:"3", stateid:widget.stateid,villageid:widget.villageid, villagename:widget.villagename));

                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .double_arrow_outlined,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  border: Border.all(
                                    color: Appcolor.lightgrey,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5.0, right: 5.0, bottom: 5.0),
                                child: Material(
                                  child: InkWell(
                                    splashColor: Appcolor.splashcolor,
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10, left: 5),
                                          child: Text(
                                            '(D). Other assets',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 0,
                                                right: 0,
                                                bottom: 0,
                                                top: 0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 5,
                                                            right: 5,
                                                            bottom: 10,
                                                            top: 0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child:
                                                            TotalOAGeoTagged !=
                                                                    "0"
                                                                ? Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            0),
                                                                    child:
                                                                        Material(
                                                                          color: Appcolor.greeenlight,
                                                                      elevation:
                                                                          2.0,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Get.to(Otherassetsgeotaggedpendingapprove(
                                                                              villageid: widget.villageid,
                                                                              stateid: widget.stateid,
                                                                              token: box.read("UserToken"),
                                                                              statusapproved: "1"));
                                                                        },
                                                                        child:
                                                                            Ink(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                padding: const EdgeInsets.all(5),
                                                                                child: const Center(
                                                                                    child: Text(
                                                                                  ' \n  Geo-tagged   \n',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                              const Divider(
                                                                                thickness: 1,
                                                                                height: 10,
                                                                                color: Appcolor.lightgrey,
                                                                              ),
                                                                              Center(
                                                                                  child: Text(
                                                                                TotalOAGeoTagged,
                                                                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Appcolor.btnbordercolor),
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child:
                                                                        Material(
                                                                      elevation:
                                                                          2.0,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Appcolor.splashcolor,
                                                                        customBorder:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            10.0,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Ink(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                padding: const EdgeInsets.all(5),
                                                                                child: const Center(
                                                                                    child: Text(
                                                                                  ' \n  Geo-tagged   \n',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                              const Divider(
                                                                                thickness: 1,
                                                                                height: 10,
                                                                                color: Appcolor.lightgrey,
                                                                              ),
                                                                              Center(
                                                                                  child: Text(
                                                                                TotalOAGeoTagged,
                                                                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Appcolor.btnbordercolor),
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 5,
                                                            right: 5,
                                                            bottom: 10,
                                                            top: 0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child:
                                                            BalanceOATotal !=
                                                                    "0"
                                                                ? Material(
                                                                    elevation:
                                                                        2.0,
                                                                    color: Appcolor
                                                                        .lightyello,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(Otherassetsgeotaggedpendingapprove(
                                                                            villageid:
                                                                                widget.villageid,
                                                                            stateid: widget.stateid,
                                                                            token: box.read("UserToken"),
                                                                            statusapproved: "0"));
                                                                      },
                                                                      child:
                                                                          Ink(
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width,
                                                                              padding: const EdgeInsets.all(5),
                                                                              child: const Center(
                                                                                  child: Text(
                                                                                'Pending \n     for \napproval',
                                                                                style: TextStyle(fontWeight: FontWeight.w500),
                                                                              )),
                                                                            ),
                                                                            const Divider(
                                                                              thickness: 1,
                                                                              height: 10,
                                                                              color: Appcolor.lightgrey,
                                                                            ),
                                                                            Center(
                                                                                child: Text(
                                                                              BalanceOATotal,
                                                                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Appcolor.btnbordercolor),
                                                                            )),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child:
                                                                        Material(
                                                                      elevation:
                                                                          2.0,
                                                                      color: Appcolor
                                                                          .lightyello,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Appcolor.splashcolor,
                                                                        customBorder:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            10.0,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Ink(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                padding: const EdgeInsets.all(5),
                                                                                child: const Center(
                                                                                    child: Text(
                                                                                  'Pending \n     for \napproval',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                              const Divider(
                                                                                thickness: 1,
                                                                                height: 10,
                                                                                color: Appcolor.lightgrey,
                                                                              ),
                                                                              Center(
                                                                                  child: Text(
                                                                                BalanceOATotal,
                                                                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Appcolor.btnbordercolor),
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Container(
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffb3C53C2)),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Appcolor.splashcolor,
                                                  customBorder:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  onTap: () {
                                                    Get.to(NewTagWater(clcikedstatus:"4", stateid:widget.stateid,villageid:widget.villageid, villagename:widget.villagename));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'Add/Geo-tag Other assets ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14),
                                                      ),
                                                      IconButton(
                                                        color: Colors.black,
                                                        onPressed: () {


                                                          Get.to( NewTagWater(clcikedstatus:"4", stateid:widget.stateid,villageid:widget.villageid,villagename:widget.villagename));
                                                        },
                                                        icon: const Icon(
                                                          Icons.double_arrow_outlined,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
