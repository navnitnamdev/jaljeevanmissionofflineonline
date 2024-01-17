import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jaljeevanmissiondynamic/model/Habitationlistmodal.dart';
import '../apiservice/Apiservice.dart';
import '../utility/Appcolor.dart';
import 'LoginScreen.dart';

class AddNewSourceScreen extends StatefulWidget {

  var selectscheme;
  var selecthabitation;
  var selectlocationlanmark;
  var villageid;
  var assettaggingid;
  var StateId;
  var schemeid;
  var SourceId;
  var HabitationId;
  var SourceTypeId;
  var SourceTypeCategoryId;
  var villagename;
//var Landmark;
  var selectlatitude;
  var selectlongitude;
  var latitute;
  var longitute;
  AddNewSourceScreen({required this.selectscheme ,required this.selecthabitation ,required this.selectlocationlanmark ,required this.villageid ,
    required this.assettaggingid ,  required this.StateId , required this.schemeid ,required this.SourceId ,
    required this.HabitationId ,  required this.SourceTypeId , required this.SourceTypeCategoryId ,required this.villagename ,required this.latitute ,required this.longitute ,
    /*required this.selectlatitude ,  required this.selectlongitude */ super.key});

  @override
  State<AddNewSourceScreen> createState() => _AddNewSourceScreenState();
}

class _AddNewSourceScreenState extends State<AddNewSourceScreen> {


  var getclickedstatus;
  var uniqueJsonList=[];
  var uniqueJsonList2=[];


  GetStorage box  = GetStorage();
  List<dynamic> mainListsourcecategory=[];

String sourcetypeid="";
  String fileNameofimg = "";
String sourcetype="";
String sourceTypeCategoryId="";
String SourceTypeCategory="";
String  selectradiobutton="";
var selectradiobutton_category;
String?  select_sourcetyperadiobutton="";
var select_sourcetypeid;

  TextEditingController locationlandmarkcontroller =TextEditingController();

  String imagepath = "";
  File? imgFile;
  final imgPicker = ImagePicker();
List<dynamic> minisource=[];
  String base64Image="";
  List<int> imageBytes=[];
List<dynamic> sourcetypeidlistone=[];
List<dynamic> sourcetypeidlist=[];
List<dynamic> minisource2=[];
List<dynamic> SourceTypeCategoryList=[];
List<dynamic> SourceTypeCategoryList_id=[];
List<dynamic> sourcetypelistone_id=[];
var SourceTypeCategoryId;
var selecthabitaionname="-- Select Habitaion --";
var selecthabitaionid;

var distinctlist=[];
var distinct_categorylist=[];
List<Habitaionlistmodal> habitationlist=[];
late Habitaionlistmodal habitaionlistmodal;

  String? _currentAddress;
  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future gethabitaionlist(
      BuildContext context,
      String token,
      ) async {
    var uri = Uri.parse(
        '${Apiservice.baseurl}JJM_Mobile/GetHabitationlist?UserId=' +
            box.read("userid")+"&StateId="+box.read("stateid")+"&VillageId="+widget.villageid);
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> mResposne = jsonDecode(response.body);

      List data  = mResposne["Result"];

      habitationlist.clear();

      habitationlist.add(habitaionlistmodal);
      for(int i =0 ; i < data.length ; i++){

        var habitaionid = data[i]["HabitationId"].toString();
       var  habitaionname = data[i]["HabitationName"].toString();

      habitationlist.add(Habitaionlistmodal(habitaionname, habitaionid));


      }






    }
    return jsonDecode(response.body);
  }




  Future getcategoryApi(
      BuildContext context,
      String token,
      ) async {
    var uri = Uri.parse(
        '${Apiservice.baseurl}Master/GetSourceCategorylist?UserId=' +
            box.read("userid"));
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> mResposne = jsonDecode(response.body);

      mainListsourcecategory = mResposne["Result"];
  setState(() {




          for(int i =0 ; i < mainListsourcecategory.length ; i++) {
            SourceTypeCategoryId = mainListsourcecategory[i]["SourceTypeCategoryId"].toString();
            SourceTypeCategoryList_id.add(SourceTypeCategoryId);

            final SourceTypeCategory = mainListsourcecategory[i]["SourceTypeCategory"];
            SourceTypeCategoryList.add(SourceTypeCategory);

 final sourcetypeid = mainListsourcecategory[i]["SourceTypeId"];
            sourcetypelistone_id.add(sourcetypeid);


            final jsonList = SourceTypeCategoryList.map((item) => jsonEncode(item)).toList();
            final uniqueJsonList = jsonList.toSet().toList();
             distinctlist = uniqueJsonList.map((item) => jsonDecode(item)).toList();


 final categoryid = SourceTypeCategoryList_id.map((item) => jsonEncode(item)).toList();
            final categorylist = categoryid.toSet().toList();
            distinct_categorylist = categorylist.map((item) => jsonDecode(item)).toList();




            if(SourceTypeCategory=="Ground Water"){



              if (SourceTypeCategoryId.toString() == "1") {
               setState(() {
                 minisource.add(mainListsourcecategory[i]["SourceType"].toString());
                 sourcetypeidlistone.add(mainListsourcecategory[i]["SourceTypeId"].toString());

               });
              }

            }
            else if(SourceTypeCategory=="Surface Water")  {
              if (SourceTypeCategoryId.toString() == "2") {
              setState(() {
                minisource2.add(mainListsourcecategory[i]["SourceType"].toString());
                sourcetypeidlist.add(mainListsourcecategory[i]["SourceTypeId"].toString());
              });
              }
            }
          /*  else if(SourceTypeCategory=="Spring")  {
              if (SourceTypeCategoryId.toString() == "3") {
              setState(() {
                minisource2.add(mainListsourcecategory[i]["SourceType"].toString());
                sourcetypeidlist.add(mainListsourcecategory[i]["SourceTypeId"].toString());

                print("charming_2" +sourcetypeidlist.toString());
              });
              }
            }*/


          }
       });




      setState(() {});
    }
    return jsonDecode(response.body);
  }

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );


    setState(() {
      imgFile = File(imgCamera!.path);

      imagepath = imgCamera.path;
      final File _file = File(imgCamera!.path);
      //  compressFile(_file);
      print("filepath_crop>>> " + imagepath);
      //  _cropImage();
      final bytes = _file
          .readAsBytesSync()
          .lengthInBytes;

      final kb = bytes / 1024;
      final mb = kb / 1024;

      fileNameofimg = _file.path
          .split('/')
          .last;
      imgFile != null
          ? 'data:image/png;base64,' + base64Encode(imgFile!.readAsBytesSync())
          : "";

      imageBytes = imgFile!.readAsBytesSync();
      base64Image = base64Encode(imageBytes);


     // Navigator.of(context).pop();
    });
  }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();

      if(box.read("UserToken").toString() == "null") {

          Get.off(LoginScreen());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please login your token has been expired!")));
      }

      print("state_id" + box.read("stateid"));
      print("state_id" + widget.villageid);
      print("userid" + box.read("userid"));
      habitaionlistmodal = Habitaionlistmodal("-- Select Habitation --", "-- Select Habitation --");
      getcategoryApi(context, box.read("UserToken"));
      gethabitaionlist(context, box.read("UserToken")).then((value) {

           setState(() {
         // locationlandmarkcontroller.text = getselectlocationlanmark.toString();

        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D3A98),
          iconTheme: const IconThemeData(
            color: Appcolor.white,
          ),
          title: const Text("Add new source",
              style: TextStyle(color: Colors.white)),
        ),
        body: GestureDetector(
      onTap: () {
      FocusScope.of(context).requestFocus(new FocusNode());
      },
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/header_bg.png'), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Image.asset(
                                'images/bharat.png',
                                // Replace with your logo file path
                                width: 60, // Adjust width and height as needed
                                height: 60,
                              ),
                            ),
                            Container(
                              child: const Column(
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
                                      title:  Text(box.read("username").toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold , color: Appcolor.black),),
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
                    const SizedBox(
                      height: 20,
                    ),
          
                    Row(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Village :",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Appcolor.headingcolor),
                              ),
                            )),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                widget.villagename,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Appcolor.headingcolor),
                              ),
                            )),
                      ],
                    ),
                     Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Selected scheme :"+" "+
                       widget.selectscheme,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
          
                    //  margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color:  Appcolor.lightgrey,
                        border: Border.all(
                          color: Appcolor.lightgrey,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ), //                 <--- border radius here
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        child: InkWell(
                            splashColor: Appcolor.splashcolor,
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
          
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Add new source",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  height: 10,
                                  color: Appcolor.lightgrey,
                                  thickness: 1,
                                  // indent : 10,
                                  //endIndent : 10,
                                ),
                                Container(
                                  child: ListView.builder(
                                      itemCount: distinctlist.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, int index) {
                                        return Container(
                                          margin: const EdgeInsets.only(left: 3 , right: 3 , bottom: 5 ),
                                          child: Material(
                                            elevation: 5,
                                            borderRadius: BorderRadius.circular(
                                                10.0),
                                            child: InkWell(
                                              splashColor: Appcolor.splashcolor,
                                              onTap: () {},
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                  
                                                      margin: const EdgeInsets.all(0),
                                                      child:
                                                      RadioListTile(
                                                        activeColor: Appcolor
                                                            .btncolor,
                                                        //   toggleable: true,
                                                        enableFeedback: true,
                                                        //contentPadding: EdgeInsets.symmetric(horizontal: 0.0 , vertical: 0.0),
                                                        contentPadding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 0),
                                                        visualDensity:
                                                        const VisualDensity(
                                                            horizontal:
                                                            VisualDensity
                                                                .minimumDensity,
                                                            vertical: VisualDensity
                                                                .minimumDensity),
                                                        title: new Text(distinctlist[index].toString()),
                                                        value: distinctlist[index].toString(),
                                                        groupValue: selectradiobutton,
                                  
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectradiobutton = value!;
                                                            selectradiobutton_category = distinct_categorylist[index]!;
                                  
                                                          });
                                                        },
                                                      )
                                                  ),
                                  
                                  
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
          
                                SizedBox(height: 2,),
          
          
          
          
          
          
          
                              ],
                            )),
                      ),
                    ),
          
                    SizedBox(height: 5,),
                    selectradiobutton=="" ? SizedBox() :
          Container(
            margin: const EdgeInsets.only(top: 10, right: 0, left: 0, bottom: 10),
            decoration: BoxDecoration(
              color:  Appcolor.white,
              border: Border.all(
                color: Appcolor.lightgrey,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
          10.0,
                ), //                 <--- border radius here
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Select Source type",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 10,
              color: Appcolor.lightgrey,
              thickness: 1,
              // indent : 10,
              //endIndent : 10,
            ),
            selectradiobutton == "Ground Water" ?
            ListView.builder(
                itemCount: minisource.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(3),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(
                          10.0),
                      child: InkWell(
                        splashColor: Appcolor.splashcolor,
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
          
                                margin: const EdgeInsets.all(
                                    0),
                                child:
                                RadioListTile(
                                  activeColor: Appcolor.btncolor,
                                  enableFeedback: true,
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 0),
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal:
                                      VisualDensity
                                          .minimumDensity,
                                      vertical: VisualDensity
                                          .minimumDensity),
                                  title: new Text(minisource[index]
                                      .toString()),
                                  value: minisource[index].toString(),
                                  groupValue: select_sourcetyperadiobutton,
          
                                  onChanged: (value) {
                                    setState(() {
                                      select_sourcetyperadiobutton = value!;
                                      select_sourcetypeid=sourcetypeidlist[index].toString();
          
          
                                    });
                                  },
                                )
                            ),
          
          
                          ],
                        ),
                      ),
                    ),
                  );
                })      : SizedBox(),
          ],
                ),
          
          
                Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            selectradiobutton == "Surface Water"     ? ListView.builder(
                itemCount: minisource2.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(
                          10.0),
                      child: InkWell(
                        splashColor: Appcolor.splashcolor,
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
          
                              //  margin: const EdgeInsets.all(5),
                                child:
                                RadioListTile(
                                  activeColor: Appcolor
                                      .btncolor,
                                  //   toggleable: true,
                                  enableFeedback: true,
                                  //contentPadding: EdgeInsets.symmetric(horizontal: 0.0 , vertical: 0.0),
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 0),
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal:
                                      VisualDensity
                                          .minimumDensity,
                                      vertical: VisualDensity
                                          .minimumDensity),
                                  title: new Text(minisource2[index].toString()),
                                  value: minisource2[index].toString(),
                                  groupValue: select_sourcetyperadiobutton,
          
                                  onChanged: (value) {
                                    setState(() {
                                      select_sourcetyperadiobutton = value!;
          
          
                                      //sourcetypeidlistone
                                      select_sourcetypeid=sourcetypeidlist[index].toString();
          
          
                                    });
                                  },
                                )
                            ),
          
          
                          ],
                        ),
                      ),
                    ),
                  );
                }) : SizedBox()
          ],
                )
              ],
            ),
          ),
                    Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color:  Appcolor.white,
                        border: Border.all(
                          color: Appcolor.lightgrey,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ), //                 <--- border radius here
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15,),
                          const Padding(
                            padding: EdgeInsets.only(left: 10 , right: 10 ,bottom: 10,top: 5),
                            child: Text(
                              "Select habitation",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
          
          
                          Container(
                            height: 55,
                            margin: const EdgeInsets.only(
                                bottom: 5.0, right: 5, left: 5),
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color: Appcolor.lightgrey,
                                    width: .5),
                                borderRadius:
                                BorderRadius.circular(6)),
                            child:
          
          
                            Container(
                              height: 50,
                              margin: EdgeInsets.all(5),

                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              // padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 2.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey, width: 1))),


                              child: DropdownButton<Habitaionlistmodal>(
                                  itemHeight: 60,
                                  elevation: 10,
                                  dropdownColor:  Appcolor.light,
                                  underline: const SizedBox(),
          
                                  isExpanded: true,
                                  hint: Text(
                                    "-- Select Habitation --",
                                  ),
                                  value: habitaionlistmodal,
                                  items: habitationlist.map((habitations) {
                                    return DropdownMenuItem<
                                        Habitaionlistmodal>(
                                      value: habitations,

                                      child: Text(
                                        habitations.HabitationName,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                            Appcolor.black),
          
                                      ),
                                    );
                                  }).toList(),
                                  onChanged:
                                      (Habitaionlistmodal? newValue) {
                                    setState(() {
                                      habitaionlistmodal = newValue!;
                                      selecthabitaionid = newValue!.HabitationId;
                                      selecthabitaionname = newValue.HabitationName;
          
          
          
                                    });
                                  }),
                            ),
          
          
                          ),
                          SizedBox(height: 5,),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10 , right: 10 ,bottom: 10,top: 5),
                                    child: Text("Source location/landmark",
                                      maxLines:4,
                                      style: TextStyle(color: Appcolor.black , fontWeight: FontWeight.bold , fontSize: 16),),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5 , bottom: 10 , right: 5),
                                  width: double.infinity,
                                  height: 45,
                                  child: TextFormField(
                                    controller: locationlandmarkcontroller,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText:"Enter landmark/location",hintStyle: TextStyle(color: Appcolor.grey, fontWeight: FontWeight.w400)
          
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
          
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
          
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        border: Border.all(
                          color: Appcolor.lightgrey,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ), //                 <--- border radius here
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, right: 10, left: 5, bottom: 10),
                                child: Text("Geo-coordinates of PWS source",
                                  maxLines:4,
                                  style: TextStyle(color: Appcolor.black , fontWeight: FontWeight.bold , fontSize: 16),),
                              ),
                            ),
                            const Divider(
                              height: 10,
                              color: Appcolor.lightgrey,
                              thickness: 1,
                              // indent : 10,
                              //endIndent : 10,
                            ),
          
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text("Latitude",
                                  maxLines:4,
                                  style: TextStyle(color: Appcolor.black , fontWeight: FontWeight.bold , fontSize: 14),),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _getCurrentPosition();
                              },
                              child: Container(

                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Appcolor.lightblue,
                                  border: Border.all(
                                    color: Appcolor.lightgrey,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ), //                 <--- border radius here
                                  ),
                                ),
                                width: double.infinity,
                                height: 40,
                                //color: Appcolor.lightyello,
                                child:  Align(
                                  alignment: Alignment.centerLeft,
                                  child:  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child:
                                    Text(' ${_currentPosition?.latitude ?? ""}',
                                      maxLines:4,
                                      style: const TextStyle(color: Appcolor.grey , fontWeight: FontWeight.w400 , fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text("Longitude",
                                  maxLines:4,
                                  style: TextStyle(color: Appcolor.black , fontWeight: FontWeight.bold , fontSize: 14),),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _getCurrentPosition();
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                color: Appcolor.lightblue,
                                  border: Border.all(
                                    color: Appcolor.lightgrey,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ), //                 <--- border radius here
                                  ),
                                ),
                                width: double.infinity,
                                height: 40,
                                //color: Appcolor.lightyello,
                                child:  Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('${_currentPosition?.longitude ?? ""}',
                                      maxLines:4,
                                      style: const TextStyle(color: Appcolor.grey , fontWeight: FontWeight.w400 , fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        border: Border.all(
                          color: Appcolor.lightgrey,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ), //                 <--- border radius here
                        ),
                      ),
                      child: Center(
                        child:
                        Container(
          
                          margin: const EdgeInsets.all(5),
          
                          /// padding: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              imgFile == null
                                  ? Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius
                                          .circular(5),
                                      border: Border.all(
                                          width: 2,
                                          color: Appcolor
                                              .COLOR_PRIMARY),
                                    ),
                                    padding: EdgeInsets.all(3),
                                    margin: EdgeInsets.only(
                                        left: 0, top: 10),
                                    width: 260,
                                    height: 200,
                                    child: Image(
                                      width: 260,
                                      height: 200,
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        'images/imagenot.png',
                                      ),
                                    )),
                              )
                                  : Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(
                                        5),
                                    border: Border.all(
                                        width: 2,
                                        color: Appcolor
                                            .COLOR_PRIMARY),
                                  ),
                                  padding: EdgeInsets.all(3),
                                  margin: EdgeInsets.only(
                                      left: 10, top: 10),
                                  width: 260,
                                  height: 200,
                                  child: Image.file(
                                    imgFile!,
                                    width: 260,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
          
          
                              const SizedBox(
                                height: 25,
                              ),
                              Center(
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF0D3A98),
                                      borderRadius: BorderRadius
                                          .circular(8)),
                                  child: TextButton(
                                    onPressed: () {
                                      openCamera();
                                     /* showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              margin:
                                              const EdgeInsets.all(
                                                  10),
                                              padding: const EdgeInsets
                                                  .only(
                                                  top: 50),
                                              child:
                                              AlertDialog(
                                                actionsAlignment: MainAxisAlignment.center,
          
                                                title: const Center(child: Text('Please Take Photo',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),)),
                                                actions: [
                                                  Container(
          
                                                    // color:Appcolor.btncolor,
                                                    child: TextButton(
                                                        onPressed: () {
          
          
                                                          openCamera();
                                                        },
                                                        child: Container(
                                                          height: 35,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              //shape: BoxShape.circle,
                                                              borderRadius: BorderRadius.circular(8)
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              'CAMERA' , style: TextStyle(color: Appcolor.white),),
                                                          ),
                                                        )),
                                                  ),
          
                                                ],
                                              ),
                                            );
                                          });*/
                                    },
                                    child: const Text(
                                      'Take Photo ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 20),
                                  height: 40,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF0D3A98),
                                      borderRadius: BorderRadius
                                          .circular(8)),
                                  child: TextButton(
                                    onPressed: () {
          
          
                                      if(selectradiobutton.toString()=="") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content: Text("Please select  source")));
          
                                      /*  if (selectradiobutton.toString() == "Ground Water") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                              content: Text("Please select source type")));
                                        } else if (selectradiobutton.toString() ==
                                            "Surface Water") {
                                          ScaffoldMessenger.of(context)
                                               .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please select source type 2")));
                                        }
                             */
          
                                      } else if(select_sourcetyperadiobutton=="" ){
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content: Text("Please select source type")));
          
                                      }
          
                                       else if(selecthabitaionname.toString()=="-- Select Habitaion --"){
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Please select habitaion")));
          
                                        }else if(locationlandmarkcontroller.text.trim()
                                            .toString()
                                            .isEmpty){
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Please enter location/landmark")));
          
                                        } else if(imgFile==null){
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Please select image")));
          
                                        }else{
          
          
                                      /*  box.read("UserToken").toString() ;
                                      box.read("userid").toString() ;
                                      widget.villageid;
                                      widget.assettaggingid;
                                      box.read("stateid");
                                      widget.schemeid;
                                      // widget.SourceId,
                                      "0";
                                      box.read("DivisionId").toString() ;
                                        selecthabitaionid.toString();
          
                                      //------------------------
                                      select_sourcetypeid.toString();
                                      selectradiobutton_category;
          
          
          
                                      locationlandmarkcontroller.text.toString();
          
                                      _currentPosition!.latitude.toString();
                                      _currentPosition!.longitude.toString();
                                      "0";
                                      base64Image;
          */
          
          
                                        Apiservice.PWSSourceSavetaggingapi(context ,
                                          box.read("UserToken").toString() ,
                                          box.read("userid").toString() ,
                                          widget.villageid,
                                          widget.assettaggingid,
                                          box.read("stateid"),
                                          widget.schemeid.toString(),
                                          // widget.SourceId,
                                          "0",
                                          box.read("DivisionId").toString() ,
                                            selecthabitaionid.toString(),
          
                                          //------------------------
                                          select_sourcetypeid.toString(),
                                          selectradiobutton_category.toString(),
                                           locationlandmarkcontroller.text.toString(),
                                          _currentPosition!.latitude.toString(),
                                          _currentPosition!.longitude.toString(),
                                          "0",base64Image).then((value) {
          
                                        Get.back();
                                          if(value["Status"].toString()=="false"){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(value["msg"].toString())));
          
                                        }else if(value["Status"].toString()=="true"){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(value["msg"].toString())));
          
                                        }
                                      });
                                        }
          
          
          
          
          
          
          
                                    },
                                    child: const Text(
                                      'Save ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
          
          
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

}
