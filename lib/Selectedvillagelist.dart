import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/localdatamodel/Localmasterdatamodal.dart';
import 'package:jaljeevanmissiondynamic/utility/Stylefile.dart';
import 'package:jaljeevanmissiondynamic/utility/Textfile.dart';
import 'package:jaljeevanmissiondynamic/view/Dashboard.dart';
import 'package:jaljeevanmissiondynamic/view/VillageDetails.dart';

import 'CommanScreen.dart';
import 'addfhtc/jjm_facerd_appcolor.dart';
import 'database/DataBaseHelperJalJeevan.dart';
import 'localdatamodel/Villagelistdatalocaldata.dart';
import 'view/LoginScreen.dart';

class Selectedvillaglist extends StatefulWidget {
  /*Selectedvillaglist({super.key});*/

  String stateId;
  String userId;
  String usertoken;
/*//  String totalofflinevillage;
  Selectedvillaglist({super.key, required this.stateId, required this.userId, required this.usertoken});

  @override
  State<Selectedvillaglist> createState() => _SelectedvillaglistState(stateId: stateId, userId: userId, usertoken: usertoken);*/

  Selectedvillaglist({super.key, required this.stateId, required this.userId, required this.usertoken});
  @override
  State<Selectedvillaglist> createState() => _SelectedvillaglistState(stateId: stateId, userId: userId, usertoken: usertoken);
}

class _SelectedvillaglistState extends State<Selectedvillaglist> {
  GetStorage box = GetStorage();
  TextEditingController searchController = TextEditingController();
  String searchString = "";
  String gettotalvillage = "";
  String OfflineStatus = "";
  bool _loading = false;
  String stateId;
  String userId;
  String usertoken;
  _SelectedvillaglistState({required this.stateId, required this.userId, required this.usertoken});
  DatabaseHelperJalJeevan? databaseHelperJalJeevan;
  bool isselect = true;
  List<dynamic> saveoffinevillaglist = [];
  int? index;
  var Nolistpresent;
  var totalsibrecord;
  List listone = [];
  var selectvillagelist;
  List<Localmasterdatanodal> offlinevillagelistlist = [];
  late Localmasterdatanodal localmasterdatanodal;
  final bool _isLoading = false;
  late Future<List<Villagelistlocaldata>> villagelistlocal;
  List _newList = [];
  List list = [];
  List<Localmasterdatanodal> localpwspendingDataList = [];

  countdatain_sibtable() async {
    totalsibrecord ??= 0;

    totalsibrecord = await databaseHelperJalJeevan!.countRows_forsib();
    print("datacount$totalsibrecord");
  }

  callfornumber() async {
    Nolistpresent ??= 0;

    Nolistpresent = await databaseHelperJalJeevan!.countRows();
    print("datacount$Nolistpresent");
  }




  @override
  void initState() {
    super.initState();

    box.read("refreshtimerapi").toString();
    databaseHelperJalJeevan = DatabaseHelperJalJeevan();

    localmasterdatanodal = Localmasterdatanodal();

    if (box.read("UserToken").toString() == "null") {
      Get.offAll(const LoginScreen());
      box.remove("UserToken").toString();
      Stylefile.showmessageforvalidationfalse(context, "Please login, your token has been expired!");

    }



    getAllofflinevillagelistfromdb(context);
    callfornumber();
  }

  Future<void> cleartable_localmasterschemelisttable() async {
    await databaseHelperJalJeevan!.cleardb_localmasterschemelist();
    await databaseHelperJalJeevan!.cleartable_villagedetails();
    await databaseHelperJalJeevan!.cleardb_localhabitaionlisttable();
    await databaseHelperJalJeevan!.cleardb_sourcedetailstable();
    await databaseHelperJalJeevan!.truncatetable_dashboardtable();
    await databaseHelperJalJeevan!.cleardb_sibmasterlist();
  }

  Future<void> cleartable_localmastertables() async {
    await databaseHelperJalJeevan!.truncateTable_localmasterschemelist();
    await databaseHelperJalJeevan!.cleardb_localmasterschemelist();
    await databaseHelperJalJeevan!.cleartable_villagelist();
    await databaseHelperJalJeevan!.cleartable_villagedetails();
    await databaseHelperJalJeevan!.cleardb_localhabitaionlisttable();
    await databaseHelperJalJeevan!.cleardb_sourcedetailstable();
    await databaseHelperJalJeevan!.cleardb_sibmasterlist();
  }

  Future<void> getAllofflinevillagelistfromdb(BuildContext context) async {
  // databaseHelperJalJeevan!.duplicate_selectedvill();
    setState(() {
      _loading = true;
    });
    await databaseHelperJalJeevan
        ?.getAllofflinevillagelistfromdb()
        .then((value) {
      setState(() {
        _loading = false;
      });

      offlinevillagelistlist = value.toList();
      for (int i = 0; i < offlinevillagelistlist.length; i++) {
        print("villagelisthere${offlinevillagelistlist[i].villageName}");
        print("village_id${offlinevillagelistlist[i].villageId}");
      }
    });
  }

  List<dynamic> ListResponse = [];
  bool isFABVisible = true; // Tracks FAB visibility
  Offset fabPosition = const Offset(1, 600); // Initial position of the FAB
  var VillageId;
  var VillageName;
  bool checkedValue = false;
  String checkedboxvalueselet = "";
  List<bool> isCheckedList = [];

  void _runFilter(String enterkeyword) {
    List searchresult = [];
    if (enterkeyword.isEmpty) {
      setState(() {
        searchresult = ListResponse;
      });
    } else {
      searchresult = ListResponse.where((village) {
        if (searchresult.toString() ==
            village["VillageName"]
                .toString()
                .toLowerCase()
                .contains(enterkeyword.toLowerCase())) {}
        return village["VillageName"]
            .toString()
            .toLowerCase()
            .contains(enterkeyword.toLowerCase());
      }).toList();
    }
    setState(() {
      _newList = searchresult;
    });
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(onWillPop: () async{
      Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) =>
          Dashboard(stateid: stateId, userid: userId, usertoken: usertoken)));


    return true; },
    child:FocusDetector(
      onVisibilityGained: () {},
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0), //
          child: AppBar(
            backgroundColor: const Color(0xFF0D3A98),
            iconTheme: const IconThemeData(
              color: Appcolor.white,
            ),
            title: const Text("Village list",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            actions: <Widget>[

              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () async {
                  Get.offAll(Dashboard(stateid: box.read("stateid"), userid: box.read("userid"), usertoken: box.read("UserToken")));
                },
              )
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/header_bg.png'),
                        fit: BoxFit.cover),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 11,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'images/bharat.png',
                                        width: 60,
                                        height: 60,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(Textfile.headingjaljeevan,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: Stylefile
                                                        .mainheadingstyle),
                                                SizedBox(
                                                  child: Text(
                                                      Textfile
                                                          .subheadingjaljeevan,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: Stylefile
                                                          .submainheadingstyle),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                    /*  showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) {
                                            return Container(
                                              *//*    margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.only(top: 50),
                                    *//*
                                              child: AlertDialog(
                                                backgroundColor: Appcolor.white,
                                                titlePadding: const EdgeInsets.only(
                                                    top: 0, left: 0, right: 00),
                                                contentPadding: const EdgeInsets.only(
                                                    top: 12,
                                                    left: 24,
                                                    bottom: 20),
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25),
                                                buttonPadding:
                                                    const EdgeInsets.all(13),
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      20.0,
                                                    ),
                                                  ),
                                                ),

                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                title: Container(
                                                  decoration: BoxDecoration(
                                                    color: Appcolor.btncolor,
                                                    border: Border.all(
                                                      color: Appcolor.btncolor,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Jal jeevan mission",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Appcolor.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                content: const Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Are you sure want to sign out from this application ?",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Appcolor.black),
                                                  ),
                                                ),

                                                // title: Text(box.read("username").toString()),
                                                actions: [
                                                  Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Appcolor.btncolor,
                                                        border: Border.all(
                                                          color:
                                                              Appcolor.btncolor,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            30.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          box.remove(
                                                              "UserToken");
                                                          box.remove(
                                                              'loginBool');
                                                          cleartable_localmasterschemelisttable();

                                                          Get.offAll(
                                                              LoginScreen());
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(const SnackBar(
                                                                  content: Text(
                                                                      "Sign out successfully")));
                                                        },
                                                        child: const Text(
                                                          'Sign Out',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Appcolor
                                                                  .white),
                                                        ),
                                                      )),
                                                  Container(
                                                    height: 40,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Appcolor.white,
                                                      border: Border.all(
                                                        color:
                                                            Appcolor.btncolor,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(
                                                          30.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Appcolor
                                                                .btncolor),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });*/

                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: true, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Appcolor.white,
                                            titlePadding: const EdgeInsets.only(top: 0, left: 0, right: 00),

                                            // insetPadding: EdgeInsets.symmetric(horizontal: 25),
                                            buttonPadding: const EdgeInsets.all(10),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  5.0,
                                                ),
                                              ),
                                            ),

                                            actionsAlignment: MainAxisAlignment.center,
                                            title:  Container(
                                              color: Appcolor.red,
                                              child: const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text("Jal jeevan mission" ,style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Appcolor.white),),
                                                ),
                                              ),
                                            ),
                                            content: const SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text("Are you sure want to sign out from this application ?",style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Appcolor.black),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              Container(
                                                height:40,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Appcolor.red,
                                                    width: 1,
                                                  ),//assign either here or to the container
                                                  borderRadius: BorderRadius.circular(10),),
                                                child: TextButton(
                                                  child: const Text('No', style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Appcolor.black),),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                              Container(
                                                height:40,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Appcolor.red,
                                                    width: 1,
                                                  ),//assign either here or to the container
                                                  borderRadius: BorderRadius.circular(10),),
                                                child: TextButton(
                                                  child: const Text('Yes' , style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Appcolor.black),),
                                                  onPressed: () async{

                                                    box.remove("UserToken");
                                                    box.remove('loginBool');
                                                    cleartable_localmasterschemelisttable();
                                                    Get.offAll(const LoginScreen());
                                                    Stylefile.showmessageapisuccess(context, "Sign out successfully");

                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: const Icon(
                                        Icons.logout,
                                        size: 35,
                                        color: Appcolor.btncolor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            NewScreenPoints(villageId: '0', villageName: "",no: 2),


                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {

                                    });
                                  },

                                  child: Column(
                                    children: [
                                       const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'Select villages for geotagging assets' ,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Appcolor.headingcolor,
                                                  fontSize: 16),
                                            ),
                                          )),
                                      const Divider(
                                        thickness: 1,
                                        height: 10,
                                        color: Appcolor.lightgrey,
                                      ),
                                      _loading == true
                                          ? const CircularProgressIndicator()
                                          : Column(
                                              children: [
                                                offlinevillagelistlist.isEmpty
                                                    ? const Center(
                                                        child: SizedBox(
                                                          height: 100,
                                                          child: Center(
                                                              child: Text(
                                                            "No data found",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          )),
                                                        ),
                                                      )
                                                    : Container(
                                                        margin:
                                                            const EdgeInsets.all(5),
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                offlinevillagelistlist
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    int index) {

                                                              int counter= index+1;
                                                              return offlinevillagelistlist[
                                                                          index]
                                                                      .villageName
                                                                      .toString()
                                                                      .toUpperCase()
                                                                      .toLowerCase()
                                                                      .contains(searchString
                                                                          .toLowerCase()
                                                                          .toString())
                                                                  ?

                                                              Container(
                                                                      margin: const EdgeInsets
                                                                          .all(
                                                                              5),
                                                                      child:
                                                                          Material(
                                                                        elevation:
                                                                            2.0,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Appcolor.splashcolor,
                                                                          customBorder:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                          onTap: () {
                                                                            var villageid =
                                                                                offlinevillagelistlist[index].villageId.toString();
                                                                            var villagename =
                                                                                offlinevillagelistlist[index].villageName.toString();
                                                                            print("village_id_selected$villageid");
                                                                            print("usertoken_selected${box.read("UserToken")}");
                                                                           /* return WillPopScope(onWillPop: () async{ Get.off(Dashboard(stateid: stateId, userid: userId, usertoken: usertoken));
                                                                            return false; },*/
                                                                            Get.to(VillageDetails(
                                                                            //userId:userId,
                                                                                //usertoken: usertoken,
                                                                                villageid: offlinevillagelistlist[index].villageId.toString(),
                                                                                villagename: villagename,
                                                                                stateid: box.read("stateid"), userID: userId,token: usertoken,));
                                                                          },
                                                                          child: Container(
                                                                            margin:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                            Container(
                                                                                margin: const EdgeInsets.all(0),
                                                                                height:40,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween
                                                                                  ,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height:40,
                                                                                      child: Row(
                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.start,

                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.all(5.0),
                                                                                            child: Text(
                                                                                              "$counter.",
                                                                                              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                                                                                            ),
                                                                                          ),const SizedBox(width: 10,),   Text(
                                                                                            offlinevillagelistlist[index].villageName.toString(),
                                                                                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),

                                                                                    IconButton(
                                                                                      color: Colors.black,
                                                                                      onPressed: () {

                                                                                        var villageid =
                                                                                        offlinevillagelistlist[index].villageId.toString();
                                                                                        var villagename =
                                                                                        offlinevillagelistlist[index].villageName.toString();
                                                                                        print("village_id_selected$villageid");

                                                                                        Get.to(VillageDetails(
                                                                                          //userId:userId,
                                                                                          //usertoken: usertoken,
                                                                                          villageid: offlinevillagelistlist[index].villageId.toString(),
                                                                                          villagename: villagename,
                                                                                          stateid: box.read("stateid"), userID: userId,token: usertoken,));


                                                                                      },
                                                                                      icon: const Icon(
                                                                                        Icons.double_arrow,
                                                                                        size: 20,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox();
                                                            }),
                                                      )
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
             /* Positioned(
                left: fabPosition.dx.clamp(0.0, MediaQuery.of(context).size.width - 56), // 56 is the button width
                top: fabPosition.dy.clamp(0.0, MediaQuery.of(context).size.height - 56), // 56 is the button height
                child: GestureDetector(
                  onPanUpdate: (details) {

                    setState(() {

                      fabPosition += details.delta;
                      fabPosition = Offset(
                        fabPosition.dx.clamp(0.0, MediaQuery.of(context).size.width - 56),
                        fabPosition.dy.clamp(0.0, MediaQuery.of(context).size.height - 56),
                      );
                    });
                  },
                  child: Container(
                    child: FloatingActionButton(
                      backgroundColor: Appcolor.btncolor, // Set the button color
                      child: Icon(Icons.refresh, color: Colors.white), // Change the icon to a refresh icon
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;

                        });
                        try {
                          final result = await InternetAddress.lookup(
                              'example.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {

                            //getData();
                            cleartable_localmastertables();
                            Apiservice.Getmasterapi(context).then((value) {
                              print("valueofthis_" + value.toString());

                                setState(() {
                                  _isLoading = false;
                                });

                              for (int i = 0; i < value.villagelist.length; i++) {
                                var userid = value.villagelist[i].userId;
                                var villageId = value.villagelist[i].villageId;
                                var stateId = value.villagelist[i].stateId;
                                var villageName = value.villagelist[i].VillageName;
                                print("villageid" + villageId.toString());

                                databaseHelperJalJeevan
                                    ?.insertMastervillagelistdata(
                                    Localmasterdatanodal(
                                        UserId: userid.toString(),
                                        villageId: villageId.toString(),
                                        StateId: stateId.toString(),
                                        villageName: villageName.toString()
                                    ))
                                    .then((value) {

                                });
                                //truncateTable_localmasterdatatable();

                              }
                              databaseHelperJalJeevan!.removeDuplicateEntries();

                              for (int i = 0; i <
                                  value.villageDetails.length; i++) {
                                var status = "";
                                //  var stateName =value.villageDetails[0].stateName;
                                var stateName = "Assam";

                                var districtName = value.villageDetails[i]
                                    .districtName;
                                var stateid = value.villageDetails[i].stateId;
                                var blockName = value.villageDetails[i].blockName;
                                var panchayatName = value.villageDetails[i]
                                    .panchayatName;
                                var stateidnew = value.villageDetails[i].stateId;
                                var userId = value.villageDetails[i].userId;
                                var villageIddetails = value.villageDetails[i]
                                    .villageId;
                                var villageName = value.villageDetails[i]
                                    .villageName;
                                var totalNoOfScheme = value.villageDetails[i]
                                    .totalNoOfScheme;
                                var totalNoOfWaterSource =
                                    value.villageDetails[i].totalNoOfWaterSource;
                                var totalWsGeoTagged = value.villageDetails[i]
                                    .totalWsGeoTagged;
                                var pendingWsTotal = value.villageDetails[i]
                                    .pendingWsTotal;
                                var balanceWsTotal = value.villageDetails[i]
                                    .balanceWsTotal;
                                var totalSsGeoTagged = value.villageDetails[i]
                                    .totalSsGeoTagged;
                                var pendingApprovalSsTotal =
                                    value.villageDetails[i]
                                        .pendingApprovalSsTotal;
                                var totalIbRequiredGeoTagged =
                                    value.villageDetails[i]
                                        .totalIbRequiredGeoTagged;
                                var totalIbGeoTagged = value.villageDetails[i]
                                    .totalIbGeoTagged;
                                var pendingIbTotal = value.villageDetails[i]
                                    .pendingIbTotal;
                                var balanceIbTotal = value.villageDetails[i]
                                    .balanceIbTotal;
                                var totalOaGeoTagged = value.villageDetails[i]
                                    .totalOaGeoTagged;
                                var balanceOaTotal = value.villageDetails[i]
                                    .balanceOaTotal;
                                var totalNoOfSchoolScheme =
                                    value.villageDetails[i].totalNoOfSchoolScheme;
                                var totalNoOfPwsScheme = value.villageDetails[i]
                                    .totalNoOfPwsScheme;


                                databaseHelperJalJeevan
                                    ?.insertMastervillagedetails(
                                    Localmasterdatamodal_VillageDetails(
                                      status: "0",
                                      stateName: stateName,
                                      districtName: districtName,
                                      blockName: blockName,
                                      panchayatName: panchayatName,
                                      stateId: stateidnew.toString(),
                                      userId: userId.toString(),
                                      villageId: villageIddetails.toString(),
                                      villageName: villageName,
                                      totalNoOfScheme: totalNoOfScheme.toString(),
                                      totalNoOfWaterSource: totalNoOfWaterSource
                                          .toString(),
                                      totalWsGeoTagged: totalWsGeoTagged
                                          .toString(),
                                      pendingWsTotal: pendingWsTotal.toString(),
                                      balanceWsTotal: balanceWsTotal.toString(),
                                      totalSsGeoTagged: totalSsGeoTagged
                                          .toString(),
                                      pendingApprovalSsTotal: pendingApprovalSsTotal
                                          .toString(),
                                      totalIbRequiredGeoTagged: totalIbRequiredGeoTagged
                                          .toString(),
                                      totalIbGeoTagged: totalIbGeoTagged
                                          .toString(),
                                      pendingIbTotal: pendingIbTotal.toString(),
                                      balanceIbTotal: balanceIbTotal.toString(),
                                      totalOaGeoTagged: totalOaGeoTagged
                                          .toString(),
                                      balanceOaTotal: balanceOaTotal.toString(),
                                      totalNoOfSchoolScheme: totalNoOfSchoolScheme
                                          .toString(),
                                      totalNoOfPwsScheme: totalNoOfPwsScheme
                                          .toString(),
                                    ));


                                //truncatetable_villagedetails();
                              }

                              for (int i = 0; i < value.schmelist.length; i++) {
                                var schemeidnew = value.schmelist[i].schemeid;
                                var villageid = value.schmelist[i].villageId;
                                var schemenamenew = value.schmelist[i].schemename;
                                var schemenacategorynew = value.schmelist[i]
                                    .category;


                                databaseHelperJalJeevan
                                    ?.insertMasterSchmelist(
                                    Localmasterdatamoda_Scheme(
                                      schemeid: schemeidnew.toString(),
                                      villageId: villageid.toString(),
                                      schemename: schemenamenew.toString(),
                                      category: schemenacategorynew.toString(),
                                    ));
                                // truncateTable_localmasterschemelist();
                              }

                              for (int i = 0; i < value.sourcelist.length; i++) {
                                var sourceId = value.sourcelist[i].sourceId;
                                var SchemeId = value.sourcelist[i].schemeId;
                                var stateid = value.sourcelist[i].stateid;
                                var Schemename = value.sourcelist[i].schemeName;
                                var villageid = value.sourcelist[i].villageId;
                                var sourceTypeId = value.sourcelist[i]
                                    .sourceTypeId;
                                var statename = value.sourcelist[i].stateName;
                                var sourceTypeCategoryId = value.sourcelist[i]
                                    .sourceTypeCategoryId;
                                var habitationId = value.sourcelist[i]
                                    .habitationId;
                                var villageName = value.sourcelist[i].villageName;
                                var existTagWaterSourceId = value.sourcelist[i]
                                    .existTagWaterSourceId;
                                var isApprovedState = value.sourcelist[i]
                                    .isApprovedState;
                                var landmark = value.sourcelist[i].landmark;
                                var latitude = value.sourcelist[i].latitude;
                                var longitude = value.sourcelist[i].longitude;
                                var habitationName = value.sourcelist[i]
                                    .habitationName;
                                var location = value.sourcelist[i].location;
                                var sourceTypeCategory = value.sourcelist[i]
                                    .sourceTypeCategory;
                                var sourceType = value.sourcelist[i].sourceType;
                                var districtName = value.sourcelist[i]
                                    .districtName;
                                var districtId = value.sourcelist[i].districtId;
                                var panchayatNamenew = value.sourcelist[i]
                                    .panchayatName;
                                var blocknamenew = value.sourcelist[i].blockName;


                                databaseHelperJalJeevan
                                    ?.insertMasterSourcedetails(
                                    LocalSourcelistdetailsModal(
                                      schemeId: SchemeId.toString(),

                                      sourceId: sourceId.toString(),
                                      villageId: villageid.toString(),
                                      schemeName: Schemename,
                                      // category: category,
                                      sourceTypeId: sourceTypeId.toString(),
                                      sourceTypeCategoryId: sourceTypeCategoryId
                                          .toString(),
                                      habitationId: habitationId.toString(),
                                      existTagWaterSourceId: existTagWaterSourceId
                                          .toString(),
                                      isApprovedState: isApprovedState.toString(),
                                      landmark: landmark,
                                      latitude: latitude.toString(),
                                      longitude: longitude.toString(),
                                      habitationName: habitationName,
                                      location: location,
                                      sourceTypeCategory: sourceTypeCategory,
                                      sourceType: sourceType,
                                      stateName: statename,
                                      districtName: districtName,
                                      blockName: blocknamenew,
                                      panchayatName: panchayatNamenew,
                                      districtId: districtId.toString(),
                                      villageName: villageName,
                                      stateId: stateid.toString(),
                                    ));
                                //truncateTable_localmastersourcedetails();
                              }

                              for (int i = 0; i <
                                  value.habitationlist.length; i++) {
                                var villafgeid = value.habitationlist[i]
                                    .villageId;
                                var habitationId = value.habitationlist[i]
                                    .habitationId;
                                var habitationName = value.habitationlist[i]
                                    .habitationName;


                                databaseHelperJalJeevan
                                    ?.insertMasterhabitaionlist(
                                    LocalHabitaionlistModal(
                                        villageId: villafgeid.toString(),
                                        HabitationId: habitationId.toString(),
                                        HabitationName: habitationName
                                            .toString()));
                                //truncateTable_localmasterhabitaionlist();

                              }
                              for (int i = 0; i <
                                  value.informationBoardList.length; i++) {
                                databaseHelperJalJeevan?.insertmastersibdetails(
                                    LocalmasterInformationBoardItemModal(
                                        userId: value.informationBoardList[i]
                                            .userId.toString(),
                                        villageId: value.informationBoardList[i]
                                            .villageId.toString(),
                                        stateId: value.informationBoardList[i]
                                            .stateId.toString(),
                                        schemeId: value.informationBoardList[i]
                                            .schemeId.toString(),
                                        districtName: value
                                            .informationBoardList[i].districtName,
                                        blockName: value.informationBoardList[i]
                                            .blockName,
                                        panchayatName: value
                                            .informationBoardList[i]
                                            .panchayatName,
                                        villageName: value.informationBoardList[i]
                                            .villageName,
                                        habitationName: value
                                            .informationBoardList[i]
                                            .habitationName,
                                        latitude: value.informationBoardList[i]
                                            .latitude.toString(),
                                        longitude: value.informationBoardList[i]
                                            .longitude.toString(),
                                        sourceName: value.informationBoardList[i]
                                            .sourceName,
                                        schemeName: value.informationBoardList[i]
                                            .schemeName,
                                        message: value.informationBoardList[i]
                                            .message,
                                        status: value.informationBoardList[i]
                                            .status.toString()

                                    )


                                );
                              }
                            });


                        *//* setState(() {
                           box.write("refreshtimerapi", currentTime);

                         });*//*


                          }

                        } on SocketException catch (_) {
                          print('not connected');

                            setState(() {
                              _isLoading = false;
                            });


                          Stylefile.showmessageforvalidationfalse(context , "Unable to Connect to the Internet. Please check your network settings." );


                        }
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: _isLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>( Appcolor.btncolor),
                )
                    : Container(),
              ),*/
            ],
          ),
        ),
      ),
    ));
  }
}
