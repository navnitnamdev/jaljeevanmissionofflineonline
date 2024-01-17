import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jaljeevanmissiondynamic/apiservice/Apiservice.dart';
import 'package:jaljeevanmissiondynamic/database/DataBaseHelperJalJeevan.dart';
import 'package:jaljeevanmissiondynamic/localdatamodel/DashboardLocalModal.dart';
import 'package:jaljeevanmissiondynamic/localdatamodel/Userdata.dart';
import 'package:jaljeevanmissiondynamic/model/Myresponse.dart';
import 'package:jaljeevanmissiondynamic/model/Schememodal.dart';
import 'package:jaljeevanmissiondynamic/practisedb/DBPractice.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:jaljeevanmissiondynamic/utility/InternetNotAvailable.dart';
import 'package:jaljeevanmissiondynamic/utility/SyncronizationData.dart';
import 'package:jaljeevanmissiondynamic/utility/Utilityclass.dart';
import 'package:jaljeevanmissiondynamic/view/AssignedVilllage.dart';
import 'package:jaljeevanmissiondynamic/view/LoginScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  String stateid;
  String userid;
  String usertoken;

  Dashboard(
      {required this.stateid,
      required this.userid,
      required this.usertoken,
      Key? key})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GetStorage box = GetStorage();
  var designation = "";
  dynamic message;
  String? divisionid;
  String? userFirstName;
  String? mobile;
  var stateName = "0";
  String? districtName = "";
  var divisionName = '';
  int? stateId;
  int? districtId;
  int totalAssignVillage = 0;
  int totalPwsSchemes = 0;
  int? totalHh;
  int? hHsprovided;
  int? hHsProvidedPer;
  int? remainingHh;
  int? fhtcApprovaPending;
  int? totalSchemes;
  int totalSchoolSchemes = 0;
  int noofPwSsources = 0;
  int pwsSourcesGeotagged = 0;
  int remainingPwsSources = 0;
  int? waterSourcetobeGeotag;
  int? noofInformationboardrequired;
  int noofInformationboardGeotagged = 0;
  int remainingInformationboard = 0;
  int geotaggedOtherAssets = 0;
  int geotaggedStorageStructure = 0;
  int totalSchemeswithoutSource = 0;
  int? roleGeoTagStatus;
  int? roleFhtcTagStatus;
  int? noFhtcProvided;
  int? implementationongoing;
  int? fhtcDone;
  int? hgjReported;
  late List<Map<String, dynamic>> mapResponseone = [];
  var subheading = "";
  var listheaderll = "";
  var listheader = "";
  var MenuId = "";
  var pwsheading = "";
  var listheaderone = "";
  var SubHeadingMenuId = "";
  var SubHeadinggeotag = "";
  var SubHeadingotherassets = "";
  var subHeadingParent = "";
  var SubHeadingofdisinfection = "";
  var SubHeading = "";
  var headingdesinfection = "";
  var pwsSubHeading = "";
  var subheadingotherscemeasset = "";
  var schemeinfosubheading = "";
  var menuid;
  var menusec;
  var HGJheading;
  var SubHeadingHGJ = "";
  var LableValue;
  String? username;
  String? geotagingheading;
  String UserDescription = "";
  var subheadingvillage;
  var SubHeadingHGJvillagecertificategrampanc = "";
  var pwsheadingwatersupply;
  var headinghgjdesination;
  var subHeading_desingtion;
  var subHeading_smaplegrampanchatt;
  var subHeading_smaple;
  var subHeadingmenuid;
  var downloadsmapletwo;
  var downloadsampleone;
  var villagenotcertified;
  var subheadinggeotag_schemeinfo;
  var subheadinggeotag_otherassets;
  var subheadinggeotag_pwssource;
  var headinghgjcertificatvillage;
  List<SubResult>? subresultdesinationlist = [];
  List<SubResult>? sublistheadinglistmenu = [];
  List<SubResult>? downloadsamplevillagelist = [];
  List<SubResult>? downloadsamplevillagelisttwo = [];
  List<SubResult>? hgjcertificatelistgrampanachatlist = [];
  List<SubResult>? villagenotcertificiedlist = [];
  List<SubResult>? subResultofhgjdesingation = [];
  List<SubResult>? hgjcertificatelist = [];
  List<SubResult>? subResultofhgj = [];
  List<SubResult>? subResult = [];
  List<SubResult>? subResultofstatusewatersupply = [];
  List<SubResult>? subResulgeotaggingassignvillagelist = [];
  List<SubResult>? subResulgeotaggingassignvillageschemelist = [];
  List<SubResult>? subResult_utherassetslist = [];
  List<SubResult>? villagenotcertifiedlist = [];
  List<SubResult> disinfectionlist = [];
  var mainHeadingmenuwatersuipply = "";
  var mainHeadingmenugeotagging = "";
  var watersupplyheading = "";
  var leftmenuheading = "";
  var leftmenuheadingvalue = "";
  var leftmenuheadingicon = "";
  var schemeinformationtext = "";
  var schemeinformationvalue = "";
  var schemeinformationicon = "";
  var otherassetstext = "";
  var otherassetstextvalue = "";
  var otherassetstexticon = "";
  var usernameofusername = "";
  var Mobile = "";
  var Designation = "";
  var leftmenuheadingmenuid;
  var userid;
  late Myresponse? myresponse;

  bool hasinternetconnection = false;
  DatabaseHelperJalJeevan? databaseHelperJalJeevan;
  late Future<List<Userdata>> userdatalist;
  late Future<List<DashboardLocalModal>> dbhelpee;
  var dbleftheadingmenuid;
  var dbleftheadingmain;
  var dbleftsubheadingmenuid;
  var dbleftheadinglablemenuid;
  var dbleftsubheadingmenu;
  var dbleftheadinglable;
  var dbleftheadingvalue;

  static CacheManager customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 20,
    ),
  );
  bool _loading = false;

  List<dynamic>? dbmainlist = [];
  List<Schememodal> schemelist = [];
  String schemevalue = '-- Select Scheme --';
  String schemename = "";
  String schemecategory = "";
  String schemeid = "";
  late Schememodal schememodal;
  String? _currentAddress;
  Position? _currentPosition;
  @override
  void initState() {
    isInternet();


    databaseHelperJalJeevan = DatabaseHelperJalJeevan();
    fatchdatauserprofile();
    myresponse = Myresponse();

    schememodal = Schememodal("-- Select Scheme --", "", "");
    print("usertoken> " + " " + widget.usertoken);
    print("userid> " + " " + widget.userid);
    print("stateid> " + " " + widget.stateid);

    doSomeAsyncStuff();

    setState(() {
      /*Apiservice.fetchData(context , box.read("UserToken")).then((value) {
   });*/
/* Apiservice.schemelistapi(context , box.read("UserToken")).then((value) {
        print(value);
      });*/


    });
    super.initState();
  }

  Future isInternet() async {
    await SyncronizationData.isInternet().then((connection) {
      if (connection) {
        synchtomysql();
      } else {}
    });
  }

  Future synchtomysql() async {
    await DatabaseHelperJalJeevan().fatchvillagelist().then((value) {});
  }

  fatchdatauserprofile() {
    userdatalist = databaseHelperJalJeevan!.fatchuserprofile();
  }



  Future<void> doSomeAsyncStuff() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        getData().then((value) {
          myresponse = value;

        });
        setState(() {
          hasinternetconnection = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        hasinternetconnection = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No Internet connection available"
              // message.data["myname"]

              )));
      OfflineScreenDatabase(context);
    }
  }



  Future getData() async {
    setState(() {
      _loading = true;
    });
    var url = '${Apiservice.baseurl}'
            "JJM_Mobile/GetUsermenu?UserId=" +
        widget.userid.toString() +
        "&StateId=" +
        widget.stateid;
    final response =
        await http.post(Uri.parse(url), headers: {"APIKey": widget.usertoken});

    myresponse = Myresponse.fromJson(jsonDecode(response.body));

// Convert JSON objects to Dart objects
    //  List<DashboardLocalModal> dataList = jsonList.map((jsonObject) => DashboardLocalModal.fromMap(jsonObject)).toList();

    //List<DashboardLocalModal> dataList = listone.map((jsonObject) => DashboardLocalModal.fromMap(jsonObject)).toList();

    //  databaseHelperJalJeevan!.insertData(dataList);
//    print("jjmwe"   +dataList[0].username.toString());

    print("ffff" +myresponse!.status.toString());
    if(myresponse!.status.toString()=="false"){
     setState(() {
       Get.off(LoginScreen());
box.remove("UserToken").toString();
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text(myresponse!.message.toString()),

       ));


     });

    }else{
      List<Result>? listResult = myresponse!.result!;

      setState(() {
        if (myresponse!.result == null || myresponse!.status == "false") {
          Get.offAll(LoginScreen());
        }
        else {
          dbmainlist = myresponse!.result!;
          username = myresponse!.userName.toString();
          UserDescription = myresponse!.userDescription.toString();
          UserDescription = myresponse!.userDescription.toString();
         // box.write("username", value["UserFirstName"].toString());
          box.write("username", myresponse!.userName.toString());
          usernameofusername = myresponse!.userName.toString();
          Mobile = myresponse!.Mobile.toString();
          Designation = myresponse!.Designation.toString();

          try {
            for (var listResultmainmenu in listResult) {
              for (int i = 0; i < listResult.length; i++) {
                if (listResultmainmenu.menuId == "20") {
                  List<SubHeadingmenulist>? subheadingmenulist =
                      listResultmainmenu.subHeadingmenulist;

                  for (var subheadingofmainmenulist in subheadingmenulist!) {
                    subResult = subheadingofmainmenulist.result;
                    subHeadingmenuid =
                        subheadingofmainmenulist.subHeadingMenuId.toString();
                    dbleftsubheadingmenu =
                        subheadingofmainmenulist.subHeading.toString();

                    for (var lables in subResult!) {
                      leftmenuheadingmenuid = lables.lableMenuId.toString();
                      leftmenuheading = lables.lableText.toString();
                      leftmenuheadingvalue = lables.lableValue.toString();
                    }
                    dbleftheadingmenuid = listResultmainmenu.menuId;
                    dbleftheadingmain = listResultmainmenu.heading;
                    dbleftsubheadingmenuid = subHeadingmenuid;
                    dbleftheadinglablemenuid = leftmenuheadingmenuid;
                    dbleftheadinglable = leftmenuheading;
                    dbleftheadingvalue = leftmenuheadingvalue;
                  }
                }
                // water supply pws
                else if (listResultmainmenu.menuId == "1") {
                  List<SubHeadingmenulist>? subheadingmenulist =
                      listResultmainmenu.subHeadingmenulist;
                  mainHeadingmenuwatersuipply =
                      listResultmainmenu.heading.toString();
                  for (var subheadingofmainmenulist in subheadingmenulist!) {
                    subResultofstatusewatersupply =
                        subheadingofmainmenulist.result;
                    watersupplyheading =
                        subheadingofmainmenulist.subHeading.toString();

                    if (subHeadingmenuid == "24") {
                      for (var lables in subResultofstatusewatersupply!) {
                        leftmenuheading = lables.lableText.toString();
                        leftmenuheadingvalue = lables.lableValue.toString();
                        leftmenuheadingicon = lables.icon.toString();
                      }
                    }
                  }
                } else if (listResultmainmenu.menuId == "2") {
                  List<SubHeadingmenulist>? subheadingmenulist =
                      listResultmainmenu.subHeadingmenulist;
                  mainHeadingmenugeotagging =
                      listResultmainmenu.heading.toString();

                  for (var subheadingofmainmenulist in subheadingmenulist!) {
                    subheadinggeotag_pwssource =
                        subheadingofmainmenulist.subHeading.toString();
                    subHeadingmenuid =
                        subheadingofmainmenulist.subHeadingMenuId.toString();

                    if (subHeadingmenuid.toString() == "8") {
                      pwsSubHeading =
                          subheadingofmainmenulist.subHeading.toString();
                      subResulgeotaggingassignvillagelist =
                          subheadingofmainmenulist.result;
                      for (var lables in subResulgeotaggingassignvillagelist!) {
                        leftmenuheading = lables.lableText.toString();
                        leftmenuheadingvalue = lables.lableValue.toString();
                        leftmenuheadingicon = lables.icon.toString();
                      }
                    }
                    // scheme information board
                    else if (subHeadingmenuid == "9") {
                      schemeinfosubheading =
                          subheadingofmainmenulist.subHeading.toString();
                      subResulgeotaggingassignvillageschemelist =
                          subheadingofmainmenulist.result;
                      for (var lables
                      in subResulgeotaggingassignvillageschemelist!) {
                        schemeinformationtext = lables.lableText.toString();
                        schemeinformationvalue = lables.lableValue.toString();
                        schemeinformationicon = lables.icon.toString();
                      }
                    }
                    // Otherassets
                    else if (subHeadingmenuid == "10") {
                      subheadingotherscemeasset =
                          subheadingofmainmenulist.subHeading.toString();
                      subResult_utherassetslist = subheadingofmainmenulist.result;
                      for (var lables in subResult_utherassetslist!) {
                        otherassetstext = lables.lableText.toString();
                        otherassetstextvalue = lables.lableValue.toString();
                        otherassetstexticon = lables.icon.toString();
                      }
                    }
                  }
                } else if (listResultmainmenu.menuId == "3") {
                  List<SubHeadingmenulist>? subheadingmenulist =
                      listResultmainmenu.subHeadingmenulist;
                  villagenotcertified = listResultmainmenu.heading.toString();

                  for (var subheadingofmainmenulist in subheadingmenulist!) {
                    subHeadingmenuid =
                        subheadingofmainmenulist.subHeadingMenuId.toString();

                    if (subHeadingmenuid == "32") {
                      downloadsampleone =
                          subheadingofmainmenulist.subHeading.toString();
                      downloadsamplevillagelist = subheadingofmainmenulist.result;
                      for (var lables in downloadsamplevillagelist!) {}
                    } else if (subHeadingmenuid == "33") {
                      downloadsmapletwo =
                          subheadingofmainmenulist.subHeading.toString();
                      downloadsamplevillagelisttwo =
                          subheadingofmainmenulist.result;

                    } else if (subHeadingmenuid.toString() == "26") {
                      subheadingvillage =
                          subheadingofmainmenulist.subHeading.toString();
                      villagenotcertifiedlist = subheadingofmainmenulist.result;
                      for (var lables in villagenotcertifiedlist!) {
                        leftmenuheading = lables.lableText.toString();
                        leftmenuheadingvalue = lables.lableValue.toString();
                        leftmenuheadingicon = lables.icon.toString();
                      }
                    }
                  }
                } else if (listResultmainmenu.menuId.toString() == "4") {
                  List<SubHeadingmenulist>? subheadingmenulist =
                      listResultmainmenu.subHeadingmenulist;
                  headinghgjdesination = listResultmainmenu.heading.toString();

                  for (var subheadingofmainmenulist in subheadingmenulist!) {
                    subHeadingmenuid =
                        subheadingofmainmenulist.subHeadingMenuId.toString();
                    subHeading_desingtion =
                        subheadingofmainmenulist.subHeading.toString();
                    subresultdesinationlist = subheadingofmainmenulist.result;

                    if (subHeadingmenuid.toString() == "29") {
                      for (var lables in subresultdesinationlist!) {
                        leftmenuheading = lables.lableText.toString();
                        leftmenuheadingvalue = lables.lableValue.toString();
                        leftmenuheadingicon = lables.icon.toString();
                      }
                    }
                  }
                }
              }
            }
          } catch (e) {
          } finally {
            setState(() {
              _loading = false;
            });
          }

          // databaseHelperJalJeevan!.
          databaseHelperJalJeevan?.insertDashboarddataindb(DashboardLocalModal(
            id: 0,
            //userid: widget.userid.toString(),
            username: username.toString(),
            userdescription: UserDescription.toString().toString(),
            leftheadingmenuid: dbleftheadingmenuid.toString(),
            leftheading: dbleftheadingmain.toString(),
            subheadingleftmenuid: dbleftsubheadingmenuid.toString(),
            SubHeadingleftmenu: dbleftsubheadingmenu.toString(),
            leftmenulableMenuId: dbleftheadinglablemenuid.toString(),
            leftmenuLableText: dbleftheadinglable.toString(),
            leftmenuLableValue: dbleftheadingvalue.toString(),
          ));
        }
      });
    }


  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text(
                'Dashboard',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              backgroundColor: Appcolor.bgcolor,
              elevation: 5,
              actions: [
                IconButton(
                  onPressed: () async {
                    try {
                      final result =
                          await InternetAddress.lookup('example.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        getData();
                        FocusScope.of(context).unfocus();

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text("Conected to the Internet"
                                    // message.data["myname"]

                                    )));
                      }
                    } on SocketException catch (_) {
                      Utilityclass.showInternetDialog(context);
                    }
                  },
                  icon: const Icon(
                    Icons.sync,
                    color: Appcolor.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // _launchURL();

                    Get.to(const DBPractice());
                  },
                  icon: const Icon(
                    Icons.web,
                    color: Appcolor.white,
                    size: 30,
                  ),
                ),
              ]),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                  : SingleChildScrollView(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible:
                              Provider.of<InternetConnectionStatus>(context) ==
                                  InternetConnectionStatus.disconnected,
                          child: const InternetNotAvailable(),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Image.asset(
                                            'images/bharat.png',
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        Container(
                                          child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Jal Jeevan Mission',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                child: AlertDialog(
                                                  title: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5,
                                                                    right: 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const SizedBox(
                                                                  width: 80,
                                                                  child: Text(
                                                                    "Name :",
                                                                    maxLines: 3,
                                                                    style: TextStyle(
                                                                        color: Appcolor
                                                                            .grey,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  " $usernameofusername",
                                                                  maxLines: 3,
                                                                  style: const TextStyle(
                                                                      color: Appcolor
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                width: 80,
                                                                child: Text(
                                                                  "Mobile No. :",
                                                                  maxLines: 3,
                                                                  style: TextStyle(
                                                                      color: Appcolor
                                                                          .grey,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              Text(
                                                                " $Mobile",
                                                                maxLines: 3,
                                                                style: const TextStyle(
                                                                    color: Appcolor
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                width: 80,
                                                                child: Text(
                                                                  "Desingation :",
                                                                  maxLines: 3,
                                                                  style: TextStyle(
                                                                      color: Appcolor
                                                                          .grey,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              Text(
                                                                " $Designation",
                                                                maxLines: 3,
                                                                style: const TextStyle(
                                                                    color: Appcolor
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  actions: [
                                                    SizedBox(
                                                      child: Center(
                                                          child: Container(
                                                        height: 40,
                                                        color:
                                                            Appcolor.btncolor,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Appcolor
                                                                          .btncolor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                ),
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false),
                                                                child:
                                                                    const Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                      color: Appcolor
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Appcolor
                                                                          .greenmessagecolor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  box.remove("UserToken");
                                                                  box.remove('loginBool');
                                                                  Get.off(
                                                                      LoginScreen());
                                                                },
                                                                child: const Text(
                                                                    'Sign Out',
                                                                    style: TextStyle(
                                                                        color: Appcolor
                                                                            .white)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset('images/profile.png',
                                            width: 50.0, height: 50.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  //4b0082
                                  color:
                                      const Color(0xFFC2C2C2).withOpacity(0.3),
                                  border: Border.all(
                                    color: const Color(0xFFC2C2C2)
                                        .withOpacity(0.3),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                margin: const EdgeInsets.all(10),
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "images/profile.png",
                                                // Replace with your logo file path
                                                width: 60,
                                                height: 60,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    username.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      UserDescription
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          color: Appcolor.dark),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(2),
                                              // height: 45,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: ScrollConfiguration(
                                                behavior: const ScrollBehavior()
                                                    .copyWith(
                                                        overscroll: false),
                                                child: ListView.builder(
                                                    itemCount:
                                                        subResult!.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, int index) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .all(2),
                                                        child: Material(
                                                          elevation: 2.0,
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
                                                                          10.0),
                                                            ),
                                                            onTap: () {},
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .radio_button_checked,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .orange,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          5.0),
                                                                      child:
                                                                          Text(
                                                                        "${subResult![index].lableText} : ${subResult![index].lableValue}",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Appcolor.black,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    //4b0082
                                    color: const Color(0xFFC2C2C2)
                                        .withOpacity(0.3),
                                    border: Border.all(
                                      color: const Color(0xFFC2C2C2)
                                          .withOpacity(0.3),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ), //
                                    ),
                                  ),
                                  child: Column(children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 45,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0B2E7C),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              mainHeadingmenuwatersuipply,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5, top: 5),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: watersupplyheading ==
                                                        "Blank"
                                                    ? const SizedBox()
                                                    : Text(
                                                        watersupplyheading,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.blue,
                                                            fontSize: 16),
                                                      ))),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              // number of items in each row
                                              mainAxisSpacing: 5.0,
                                              // spacing between rows
                                              crossAxisSpacing: 5.0,
                                              childAspectRatio: (340.0 /
                                                  220.0), // spacing between columns
                                            ),
                                            // padding around the grid
                                            itemCount:
                                                subResultofstatusewatersupply!
                                                    .length,
                                            // total number of items
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                  color: Appcolor.white,
                                                  border: Border.all(
                                                    color: Appcolor.white,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(
                                                      10.0,
                                                    ), //
                                                  ),
                                                ),
                                                child: Material(
                                                  elevation: 2.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Appcolor.splashcolor,
                                                    customBorder:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    onTap: () {},
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                subResultofstatusewatersupply![
                                                                        index]
                                                                    .lableValue
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 90,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  subResultofstatusewatersupply![
                                                                          index]
                                                                      .lableText
                                                                      .toString(),
                                                                  maxLines: 3,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      true,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                          height: 90,
                                                          child: Center(
                                                            child: CachedNetworkImage(
                                                                cacheManager:
                                                                    customCacheManager,
                                                                key:
                                                                    UniqueKey(),
                                                                imageUrl: subResultofstatusewatersupply![
                                                                        index]
                                                                    .icon
                                                                    .toString(),
                                                                fit:
                                                                    BoxFit.fill,
                                                                progressIndicatorBuilder: (context,
                                                                        url,
                                                                        downloadProgress) =>
                                                                    Transform.scale(
                                                                        scale:
                                                                            .4,
                                                                        child: CircularProgressIndicator(
                                                                            value: downloadProgress
                                                                                .progress)),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(
                                                                        Icons.image)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 5, top: 10),
                                          child: Material(
                                            elevation: 2.0,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: InkWell(
                                              splashColor: Appcolor.splashcolor,
                                              customBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              onTap: () {
                                                /* Get.to(AssignedVillage(
                                                dbuserid: userid,
                                                userid: widget.userid,
                                                usertoken: widget.usertoken,
                                                stateid: widget.stateid));*/
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Add FHTC',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: CircleAvatar(
                                                        minRadius: 20,
                                                        maxRadius: 20,
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF0D3A98),
                                                        // radius: 30,
                                                        child: IconButton(
                                                          color: Colors.white,
                                                          onPressed: () {
                                                            /* Get.to(AssignedVillage(
                                                            dbuserid: userid,
                                                            userid:
                                                            widget.userid,
                                                            usertoken: widget
                                                                .usertoken,
                                                            stateid: widget
                                                                .stateid));*/
                                                          },
                                                          icon: const Icon(
                                                            Icons.add,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 45,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0B2E7C),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              mainHeadingmenugeotagging
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            pwsSubHeading,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue,
                                                fontSize: 16),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          // number of items in each row
                                          mainAxisSpacing: 5.0,
                                          // spacing between rows
                                          crossAxisSpacing: 5.0,
                                          childAspectRatio: (340.0 / 220.0),
                                        ),
                                        itemCount:
                                            subResulgeotaggingassignvillagelist!
                                                .length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              color: Appcolor.white,
                                              border: Border.all(
                                                color: Appcolor.white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  10.0,
                                                ),
                                              ),
                                            ),
                                            child: Material(
                                              elevation: 2.0,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                              child: InkWell(
                                                splashColor:
                                                    Appcolor.splashcolor,
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                onTap: () {},
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            subResulgeotaggingassignvillagelist![
                                                                    index]
                                                                .lableValue
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 90,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6.0),
                                                            child: Text(
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: true,
                                                              subResulgeotaggingassignvillagelist![
                                                                      index]
                                                                  .lableText
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 90,
                                                      child: Center(
                                                        child: CachedNetworkImage(
                                                            cacheManager:
                                                                customCacheManager,
                                                            key: UniqueKey(),
                                                            imageUrl:
                                                                subResulgeotaggingassignvillagelist![
                                                                        index]
                                                                    .icon
                                                                    .toString(),
                                                            fit: BoxFit.fill,
                                                            progressIndicatorBuilder: (context,
                                                                    url,
                                                                    downloadProgress) =>
                                                                Transform.scale(
                                                                    scale: .4,
                                                                    child: CircularProgressIndicator(
                                                                        value: downloadProgress
                                                                            .progress)),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .image)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          schemeinfosubheading,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: (340.0 / 220.0),

                                          mainAxisSpacing: 5.0,

                                          crossAxisSpacing:
                                              5.0, // spacing between columns
                                        ),
                                        itemCount:
                                            subResulgeotaggingassignvillageschemelist!
                                                .length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              //4b0082
                                              color: Appcolor.white,
                                              border: Border.all(
                                                color: Appcolor.white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  10.0,
                                                ), //
                                              ),
                                            ),
                                            child: Material(
                                              elevation: 2.0,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                              child: InkWell(
                                                splashColor:
                                                    Appcolor.splashcolor,
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                onTap: () {},
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            subResulgeotaggingassignvillageschemelist![
                                                                    index]
                                                                .lableValue
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: SizedBox(
                                                            width: 80,
                                                            child: Text(
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: true,
                                                              subResulgeotaggingassignvillageschemelist![
                                                                      index]
                                                                  .lableText
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 90,
                                                      width: 50,
                                                      child: Center(
                                                        child: CachedNetworkImage(
                                                            cacheManager:
                                                                customCacheManager,
                                                            key: UniqueKey(),
                                                            imageUrl:
                                                                subResulgeotaggingassignvillageschemelist![
                                                                        index]
                                                                    .icon
                                                                    .toString(),
                                                            fit: BoxFit.fill,
                                                            progressIndicatorBuilder: (context,
                                                                    url,
                                                                    downloadProgress) =>
                                                                Transform.scale(
                                                                    scale: .4,
                                                                    child: CircularProgressIndicator(
                                                                        value: downloadProgress
                                                                            .progress)),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .image)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          subheadingotherscemeasset,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: (340.0 / 220.0),
                                          // number of items in each row
                                          mainAxisSpacing: 5.0,
                                          // spacing between rows
                                          crossAxisSpacing:
                                              5.0, // spacing between columns
                                        ),
                                        itemCount:
                                            subResult_utherassetslist!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              color: Appcolor.white,
                                              border: Border.all(
                                                color: Appcolor.white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  10.0,
                                                ),
                                              ),
                                            ),
                                            child: Material(
                                              elevation: 2.0,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                              child: InkWell(
                                                splashColor:
                                                    Appcolor.splashcolor,
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                onTap: () {},
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            subResult_utherassetslist![
                                                                    index]
                                                                .lableValue
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: SizedBox(
                                                            width: 80,
                                                            child: Text(
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: true,
                                                              subResult_utherassetslist![
                                                                      index]
                                                                  .lableText
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 55,
                                                      height: 100,
                                                      child: Center(
                                                        child: CachedNetworkImage(
                                                            cacheManager:
                                                                customCacheManager,
                                                            key: UniqueKey(),
                                                            imageUrl:
                                                                subResult_utherassetslist![
                                                                        index]
                                                                    .icon
                                                                    .toString(),
                                                            fit: BoxFit.fill,
                                                            progressIndicatorBuilder: (context,
                                                                    url,
                                                                    downloadProgress) =>
                                                                Transform.scale(
                                                                    scale: .4,
                                                                    child: CircularProgressIndicator(
                                                                        value: downloadProgress
                                                                            .progress)),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .image)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5, top: 10),
                                      child: Material(
                                        elevation: 2.0,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: InkWell(
                                          splashColor: Appcolor.splashcolor,
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          onTap: () {
                                            Get.to(AssignedVillage(
                                                dbuserid: userid,
                                                userid: widget.userid,
                                                usertoken: widget.usertoken,
                                                stateid: widget.stateid));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Add/ Geo-tag PWS assets',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  child: CircleAvatar(
                                                    minRadius: 20,
                                                    maxRadius: 20,
                                                    backgroundColor:
                                                        const Color(0xFF0D3A98),
                                                    // radius: 30,
                                                    child: IconButton(
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        Get.to(AssignedVillage(
                                                            dbuserid: userid,
                                                            userid:
                                                                widget.userid,
                                                            usertoken: widget
                                                                .usertoken,
                                                            stateid: widget
                                                                .stateid));
                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    villagenotcertified==null  ? SizedBox() :   Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 45,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0B2E7C),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              villagenotcertified,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    downloadsampleone== null ? SizedBox() :   Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 55,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              child: IconButton(
                                                color: Colors.orange,
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.download_rounded,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            downloadsampleone==null  ? SizedBox() :  SizedBox(
                                              width: 200,
                                              child: Text(
                                                downloadsampleone.toString(),
                                                maxLines: 3,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    downloadsmapletwo==null ? SizedBox() :   GestureDetector(
                                      onTap: () {
                                        //Navigator.pushNamed(context, 'assignedvillage');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 5,
                                            top: 5,
                                            bottom: 5,
                                            right: 5),
                                        height: 55,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                child: IconButton(
                                                  color: Colors.orange,
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.download_rounded,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  downloadsmapletwo.toString(),
                                                  maxLines: 3,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    subheadingvillage==null ? SizedBox() :   Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          subheadingvillage.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    villagenotcertifiedlist!.length == 0 ? SizedBox() :   Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 5.0,
                                          crossAxisSpacing: 5.0,
                                          childAspectRatio: (340.0 /
                                              220.0), // spacing between columns
                                        ),
                                        itemCount:
                                            villagenotcertifiedlist!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              color: Appcolor.white,
                                              border: Border.all(
                                                color: Appcolor.white,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  10.0,
                                                ),
                                              ),
                                            ),
                                            child: Material(
                                              elevation: 2.0,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                              child: InkWell(
                                                splashColor:
                                                    Appcolor.splashcolor,
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                onTap: () {},
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            villagenotcertifiedlist![
                                                                    index]
                                                                .lableValue
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 92,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              villagenotcertifiedlist![
                                                                      index]
                                                                  .lableText
                                                                  .toString(),
                                                              maxLines: 4,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: true,
                                                              style: const TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 90,
                                                      child: Center(
                                                        child:
                                                            villagenotcertifiedlist![index]
                                                                        .icon
                                                                        .toString() ==
                                                                    null
                                                                ? const SizedBox()
                                                                : CachedNetworkImage(
                                                                    cacheManager:
                                                                        customCacheManager,
                                                                    key:
                                                                        UniqueKey(),
                                                                    imageUrl: villagenotcertifiedlist![
                                                                            index]
                                                                        .icon
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    progressIndicatorBuilder: (context, url, downloadProgress) => Transform.scale(
                                                                        scale:
                                                                            .4,
                                                                        child: CircularProgressIndicator(
                                                                            value: downloadProgress
                                                                                .progress)),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                            Icons.image)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    subHeading_desingtion==null ? SizedBox() : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          subHeading_desingtion.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                        itemCount:
                                            subresultdesinationlist!.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, int index) {
                                          return GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5),
                                              height: 55,
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF0D3A98),
                                                      minRadius: 20,
                                                      maxRadius: 20,
                                                      child: IconButton(
                                                        color: Colors.white,
                                                        onPressed: () {
                                                          Get.to(AssignedVillage(
                                                              dbuserid: userid,
                                                              userid:
                                                                  widget.userid,
                                                              usertoken: widget
                                                                  .usertoken,
                                                              stateid: widget
                                                                  .stateid));
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      subresultdesinationlist![
                                                              index]
                                                          .lableText
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                  ]),
                                ),
                              ),
                            ]),
                      ],
                    )))),
    );
  }

// offlinescfreen
  Widget OfflineScreenDatabase(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/header_bg.png'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset(
                            'images/bharat.png',
                            // Replace with your logo file path
                            width: 60,
                            // Adjust width and height as needed
                            height: 60,
                          ),
                        ),
                        Container(
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Jal Jeevan Mission',
                                maxLines: 3,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                maxLines: 3,
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
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.only(top: 50),
                                child: AlertDialog(
                                  title: const Text('FE_dhubri'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {},
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
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    //4b0082
                    color: Appcolor.white,
                    border: Border.all(
                      color: Appcolor.white,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ), //                 <--- border radius here
                    ),
                  ),

                  //   color: Colors.white.withOpacity(0.10),
                  child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    "images/profile.png",
                                    // Replace with your logo file path
                                    width: 60,
                                    // Adjust width and height as needed
                                    height: 60,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      username.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.red),
                                    ),
                                    // Text("designation",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        UserDescription.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.blue),
                                      ),
                                    ),
                                    //Text("dd" -""("stateName")',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blue),),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: const EdgeInsets.all(10),
                                // height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: ScrollConfiguration(
                                  behavior: const ScrollBehavior()
                                      .copyWith(overscroll: false),
                                  child: ListView.builder(
                                      // itemCount:responsede?.result.length,
                                      itemCount: subResult!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, int index) {
                                        return Row(children: [
                                          const Icon(
                                            Icons.radio_button_checked,
                                            size: 20,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${subResult![index].lableText} : ${subResult![index].lableValue}",

                                            // mapResponseone2[index]["LableText"].toString(),
                                            //mapResponseone2[index]["LableText"].toString(),
                                            // responsede!.result[index].heading,
                                            style: const TextStyle(
                                                color: Appcolor.black,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ]);
                                      }),
                                ))
                          ],
                        ),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  //4b0082
                  color: Appcolor.white,
                  border: Border.all(
                    color: Appcolor.white,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ), //                 <--- border radius here
                  ),
                ),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFF0B2E7C),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            mainHeadingmenuwatersuipply,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          watersupplyheading,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              fontSize: 16),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // number of items in each row
                        mainAxisSpacing: 5.0,
                        // spacing between rows
                        crossAxisSpacing: 5.0,
                        childAspectRatio:
                            (340.0 / 220.0), // spacing between columns
                      ),
                      // padding around the grid
                      itemCount: subResultofstatusewatersupply!.length,
                      // total number of items
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            //4b0082
                            color: Appcolor.white,
                            border: Border.all(
                              color: Appcolor.white,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ), //                 <--- border radius here
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      subResultofstatusewatersupply![index]
                                          .lableValue
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        subResultofstatusewatersupply![index]
                                            .lableText
                                            .toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                                height: 90,
                                child: Center(
                                  child:
                                      subResultofstatusewatersupply![index]
                                                  .icon
                                                  .toString() ==
                                              null
                                          ? const SizedBox()
                                          :
                                          CachedNetworkImage(
                                              cacheManager: customCacheManager,
                                              key: UniqueKey(),
                                              imageUrl:
                                                  subResultofstatusewatersupply![
                                                          index]
                                                      .icon
                                                      .toString(),
                                              fit: BoxFit.fill,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Transform.scale(
                                                      scale: .4,
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.image)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Status of GeoTagging in assigned villages
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFF0B2E7C),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            mainHeadingmenugeotagging.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          pwsSubHeading,
                          //       subheadinggeotag_pwssource,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              fontSize: 16),
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // number of items in each row
                        mainAxisSpacing: 5.0,
                        // spacing between rows
                        crossAxisSpacing: 5.0,
                        childAspectRatio: (340.0 / 220.0),
                        // spacing between columns
                      ),
                      // padding around the grid
                      itemCount: subResulgeotaggingassignvillagelist!.length,
                      // total number of items
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            //4b0082
                            color: Appcolor.white,
                            border: Border.all(
                              color: Appcolor.white,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ), //                 <--- border radius here
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      subResulgeotaggingassignvillagelist![
                                              index]
                                          .lableValue
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        subResulgeotaggingassignvillagelist![
                                                index]
                                            .lableText
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 90,
                                width: 50,
                                child: Center(
                                  child:
                                      CachedNetworkImage(
                                          cacheManager: customCacheManager,
                                          key: UniqueKey(),
                                          imageUrl:
                                              subResulgeotaggingassignvillagelist![
                                                      index]
                                                  .icon
                                                  .toString(),
                                          fit: BoxFit.fill,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Transform.scale(
                                                  scale: .4,
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.image)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        schemeinfosubheading,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            fontSize: 16),
                      ),
                    ),
                  ),

                  // third gridview
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (340.0 / 220.0),
                        // number of items in each row
                        mainAxisSpacing: 5.0,
                        // spacing between rows
                        crossAxisSpacing: 5.0, // spacing between columns
                      ),
                      // padding around the grid
                      itemCount:
                          subResulgeotaggingassignvillageschemelist!.length,
                      // total number of items
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            //4b0082
                            color: Appcolor.white,
                            border: Border.all(
                              color: Appcolor.white,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ), //                 <--- border radius here
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      subResulgeotaggingassignvillageschemelist![
                                              index]
                                          .lableValue
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: 80,
                                      child: Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        subResulgeotaggingassignvillageschemelist![
                                                index]
                                            .lableText
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                                height: 90,
                                child: Center(
                                  child:
                                      CachedNetworkImage(
                                          cacheManager: customCacheManager,
                                          key: UniqueKey(),
                                          imageUrl:
                                              subResulgeotaggingassignvillageschemelist![
                                                      index]
                                                  .icon
                                                  .toString(),
                                          fit: BoxFit.fill,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Transform.scale(
                                                  scale: .4,
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.image)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subheadingotherscemeasset,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (340.0 / 220.0),
                        // number of items in each row
                        mainAxisSpacing: 5.0,
                        // spacing between rows
                        crossAxisSpacing: 5.0, // spacing between columns
                      ),
                      // padding around the grid
                      itemCount: subResult_utherassetslist!.length,
                      // total number of items
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            //4b0082
                            color: Appcolor.white,
                            border: Border.all(
                              color: Appcolor.white,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ), //                 <--- border radius here
                            ),
                          ),
                          child: Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        subResult_utherassetslist![index]
                                            .lableValue
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SizedBox(
                                        width: 80,
                                        child: Text(
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          subResult_utherassetslist![index]
                                              .lableText
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 90,
                                  child: Center(
                                    child:
                                        CachedNetworkImage(
                                            cacheManager: customCacheManager,
                                            key: UniqueKey(),
                                            imageUrl:
                                                subResult_utherassetslist![
                                                        index]
                                                    .icon
                                                    .toString(),
                                            fit: BoxFit.fill,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Transform.scale(
                                                    scale: .4,
                                                    child:
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.image)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, 'assignedvillage');
                      Get.to(AssignedVillage(
                          dbuserid: userid,
                          userid: widget.userid,
                          usertoken: widget.usertoken,
                          stateid: widget.stateid));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 55,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add/ Geo-tag PWS assets',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: const Color(0xFF0D3A98),
                            minRadius: 20,
                            maxRadius: 20,
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                Get.to(AssignedVillage(
                                    dbuserid: userid,
                                    userid: widget.userid,
                                    usertoken: widget.usertoken,
                                    stateid: widget.stateid));

                                //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Assigned_village(widget.userId, widget.stateid, widget.token )));// Do something with mapResponse here...
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  villagenotcertified.toString()== null ? SizedBox() :      Container(
                    margin: const EdgeInsets.all(10),
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFF0B2E7C),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            villagenotcertified.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  downloadsampleone == null ?  SizedBox() : GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, 'assignedvillage');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 55,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //SubHeadingHGJv illagecertificate
                            // hjgcertificatedownloadlist
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                color: Colors.orange,
                                onPressed: () {
                                  //Get.to(AssignedVilllage(userid:widget.userid, usertoken:widget.usertoken , stateid: widget.stateid ));
                                  //  Get.to(AssignedVillage());
                                  //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Assigned_village(widget.userId, widget.stateid, widget.token )));// Do something with mapResponse here...
                                },
                                icon: const Icon(
                                  Icons.download_rounded,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                downloadsampleone.toString(),
                                maxLines: 3,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, 'assignedvillage');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      height: 55,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //SubHeadingHGJv illagecertificate
                            // hjgcertificatedownloadlist
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                color: Colors.orange,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.download_rounded,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                downloadsmapletwo,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subheadingvillage,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // number of items in each row
                        mainAxisSpacing: 5.0,
                        // spacing between rows
                        crossAxisSpacing: 5.0,
                        childAspectRatio:
                            (340.0 / 220.0), // spacing between columns
                      ),
                      // padding around the grid
                      itemCount: villagenotcertifiedlist!.length,
                      // total number of items
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            //4b0082
                            color: Appcolor.white,
                            border: Border.all(
                              color: Appcolor.white,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ), //                 <--- border radius here
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      villagenotcertifiedlist![index]
                                          .lableValue
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 95,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        villagenotcertifiedlist![index]
                                            .lableText
                                            .toString(),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                                height: 90,
                                child: Center(
                                  child:
                                      villagenotcertifiedlist![index]
                                                  .icon
                                                  .toString() ==
                                              "null"
                                          ? const SizedBox()
                                          :
                                          CachedNetworkImage(
                                              cacheManager: customCacheManager,
                                              key: UniqueKey(),
                                              imageUrl:
                                                  villagenotcertifiedlist![
                                                          index]
                                                      .icon
                                                      .toString(),
                                              fit: BoxFit.fill,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Transform.scale(
                                                      scale: .4,
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.image)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  subHeading_desingtion==null  ? SizedBox() :  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subHeading_desingtion,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  subresultdesinationlist!.length==0 ? SizedBox() : ListView.builder(
                      itemCount: subresultdesinationlist!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            //Navigator.pushNamed(context, 'assignedvillage');
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 55,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: const Color(0xFF0D3A98),
                                    radius: 20,
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        //Get.to(AssignedVilllage(userid:widget.userid, usertoken:widget.usertoken , stateid: widget.stateid ));
                                        Get.to(AssignedVillage(
                                            dbuserid: userid,
                                            userid: widget.userid,
                                            usertoken: widget.usertoken,
                                            stateid: widget.stateid));

                                        //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Assigned_village(widget.userId, widget.stateid, widget.token )));// Do something with mapResponse here...
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    subresultdesinationlist![index]
                                        .lableText
                                        .toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ]),
              ),
            ]),
          ],
        )));
  }

  Future<bool> showExitPopup() async {
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
                child: Text('Exit App'),
              ),
              content: const Padding(
                padding: EdgeInsets.only(left: 25, right: 20),
                child: Text('Are you sure want to exit?'),
              ),
              actions: [
                Container(
                  height: 40,
                  color: Appcolor.btncolor,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.btncolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text(
                            'No',
                            style: TextStyle(color: Appcolor.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.greenmessagecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Yes',
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
