import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/apiservice/Apiservice.dart';
import 'package:jaljeevanmissiondynamic/database/DataBaseHelperJalJeevan.dart';
import 'package:jaljeevanmissiondynamic/localdatamodel/Villagelistdatalocaldata.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:jaljeevanmissiondynamic/view/VillageDetails.dart';

import 'LoginScreen.dart';

class AssignedVillage extends StatefulWidget {


  var usertoken;
  var stateid;

  AssignedVillage(
      {

      required this.usertoken,
      required this.stateid,
      Key? key})
      : super(key: key);

  @override
  State<AssignedVillage> createState() => _AssignedVillageState();
}

class _AssignedVillageState extends State<AssignedVillage> {
  List<dynamic> ListResponse = [];
  GetStorage box = GetStorage();




  late Future<List<Villagelistlocaldata>> villagelistlocal;

  List _newList = [];

  List list = [];
  DatabaseHelperJalJeevan? databaseHelperJalJeevan;
  var VillageId;
  var VillageName;
  bool checkedValue=false;
  String checkedboxvalueselet="";
  List<bool> isCheckedList=[];


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
  void initState() {
    super.initState();



    if(box.read("UserToken").toString() == "null") {
      Get.offAll(const LoginScreen());
      box.remove("UserToken").toString();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please login, your token has been expired!")));
    }

    databaseHelperJalJeevan = DatabaseHelperJalJeevan();

     Apiservice.getvillagelistapi(box.read("userid"), widget.stateid, widget.usertoken)
        .then((value) {


     if (value["Status"].toString() == "false") {
          print("ddddd${value["Status"]}");
         setState(() {
           Get.offAll(const LoginScreen());
           box.remove("UserToken").toString();
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content: Text(value["Message"].toString())));
         });

        }else{
          setState(() {
            ListResponse = value["Villagelist_Datas"];
            _newList = ListResponse;
            isCheckedList = List.generate(_newList.length, (index) => false);

          });
        }



    });

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D3A98),
        iconTheme: const IconThemeData(
          color: Appcolor.white,
        ),
        title: const Text("Assigned Village",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.add,
                color: Appcolor.white,
                size: 30,
              ),
              onPressed: () async {

              })
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child:
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/header_bg.png'), fit: BoxFit.cover),
          ),
          child: FutureBuilder(
            future: Apiservice.getvillagelistapi(
                box.read("userid"), widget.stateid, widget.usertoken),
            //future: villagelistlocal,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
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
                                Image.asset(
                                  'images/bharat.png',
                                  width: 60,
                                  height: 60,
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
                                        padding: const EdgeInsets.only(top: 50),
                                        child: AlertDialog(
                                          title: Text(
                                              box.read("username").toString()),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  box.remove("UserToken");
                                                  box.remove('loginBool');
                                                  Get.off(const LoginScreen());
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged out successfully")));
                                                },
                                                child: const Text('Sign Out'))
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: const Icon(Icons.logout , size: 40, color: Appcolor.btncolor,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFF0B2E7C),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Geo-tag water assets',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          autofocus: false,
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Appcolor.black,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Appcolor.bgcolor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search Villages...',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Appcolor.btncolor, width: 3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            _runFilter(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Material(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Select Village',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Appcolor.headingcolor,
                                            fontSize: 18),
                                      ),
                                    )),
                                const Divider(
                                  thickness: 1,
                                  height: 10,
                                  color: Appcolor.lightgrey,
                                ),
                                Container(
                                    child: _newList.isNotEmpty
                                        ?
                                    ListView.builder(
                                            itemCount: _newList.length,
                                            //  itemCount: snapshot.data!.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, int index) {
                                              return
                                                Container(
                                                    height: 50,
                                                    padding:
                                                    const EdgeInsets.all(2),
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
                                                          BorderRadius
                                                              .circular(10.0),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    VillageDetails(token: box.read('UserToken'),
                                                                      userID: box.read('userid'),
                                                                      villageid: _newList[index]
                                                                      [
                                                                      "VillageId"]
                                                                          .toString(),
                                                                      villagename:
                                                                      _newList[index]["VillageName"]
                                                                          .toString(),
                                                                      stateid: widget
                                                                          .stateid,
                                                                    )),
                                                          );
                                                          
                                                    print("villageid_${_newList[index]["VillageId"]}");
                                                        },
                                                        child:
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [

                                                           Container(
                                                             child: Padding(
                                                               padding:
                                                               const EdgeInsets
                                                                   .all(5.0),
                                                               child: Text(
                                                                 _newList[index][
                                                                 "VillageName"]
                                                                     .toString(),
                                                                 style: const TextStyle(
                                                                     fontWeight:
                                                                     FontWeight
                                                                         .w500,
                                                                     fontSize: 15),
                                                               ),
                                                             ),
                                                           ),

                                                            IconButton(
                                                              color: Colors.black,
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => VillageDetails(
                                                                        token: box.read("UserToken"),
                                                                          userID: box.read("userid"),
                                                                          villageid:
                                                                          _newList[index]["VillageId"]
                                                                              .toString(),
                                                                          villagename:
                                                                          _newList[index]["VillageName"]
                                                                              .toString(),
                                                                          stateid:
                                                                          widget.stateid)),
                                                                );
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
                                                    )
                                                );
                                            }): const CircularProgressIndicator())



                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator()),
                );
              } else {
                return Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: const Text("No Internet")),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
