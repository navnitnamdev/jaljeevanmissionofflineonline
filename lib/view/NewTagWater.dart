import 'dart:convert';
import 'dart:io';
import 'package:focus_detector/focus_detector.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaljeevanmissiondynamic/model/Schememodal.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:jaljeevanmissiondynamic/view/NewTagScreen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../apiservice/Apiservice.dart';
import '../model/Habitationlistmodal.dart';
import 'AddNewSourceScreen.dart';
import 'LoginScreen.dart';

class NewTagWater extends StatefulWidget {
  String clcikedstatus;
  String stateid;
  String villageid;
  String villagename;

  NewTagWater(
      {required this.clcikedstatus,
      required this.stateid,
      required this.villageid,
      required this.villagename,
      Key? key})
      : super(key: key);

  @override
  State<NewTagWater> createState() => _NewTagWaterState();
}

class _NewTagWaterState extends State<NewTagWater> {
  bool messagedisplaypendingsource = false;
  bool messagenowatersourcecontactofc = false;
  bool viewVisible = false;
  bool selectschemesib = false;
  bool Habitaionsamesourcetext = false;
  bool ERVisible = false;
  bool Watersource = false;
  bool Schemeinformationboard = false;
  bool isGetGeoLocatonlatlong = false;
  bool Storagestructuretype = false;
  bool Selectalreadytaggedsource = false;
  bool SelectalreadytaggedsourceSIB = false;
  bool ESR_Selectalreadytaggedsource = false;
  bool capturepointlocation = false;
  bool cameradisplaygeotag = false;
  bool Elevated_Storage_Reservoir = false;
  bool Selecttaggedsource_camera = false;
  bool Selectstoragetype_ESR = false;
  bool Selectstoragetype_GSR = false;
  bool Getgeolocation_SIB = false;

  //bool isGetGeoLocatonESR = false;
  bool othercategory = false;
  bool ESR_capacity = false;

  //messagevisibility
  bool SelectalreadytaggedsourceESR = false;
  bool isMBRVisible = false;
  bool Clorinatorcategory = false;
  bool PumphouseOthercategory = false;
  bool PumphouseOthercategorywatertreatment = false;
  bool Othercategorymbr = false;
  bool Othercategorygrooundrechargewater = false;
  bool Takephotovisibility = false;
  bool isSameasSource = false;
  String base64Image = "";
  bool messagevisibility = false;
  bool geotaggedonlydropdown = false;
  bool selectschemesource = false;
  bool selectschemesourcemessage_mvc = false;
  bool selectschemenosource_svc = false;

  //bool Elevated_Storage = false;
  String? Selectassettaggingmain;
  String? ESRSource;

  //messagevisibility
  String? Othersmain;
  String? Capturepointotherscategory;
  String? Capturepointotherscategorypumphouse;
  String? Capturepointotherscategorywatertreatment;
  String? Selectassetcategory;
  String? Capturepointotherscategorymbr;
  String? Capturepointotherscategorygroundrecharge;
  String lat = '0';
  String long = '0';
  String? samesource;
  String? samesourcesib;
  String? geoloca;
  var assettaggingtype;
  String getvillagename = "";
  var getclickedstatus;
  String AssetTaggingType = "";
  String approvedState = "";
  String newschameid = "";
  String newschemename = "";
  String messageofscheme_mvs = "";
  String messageof_existingscheme = "";
  String newCategory = "";

  // Initial Selected Value
  File? _image; // Declare a nullable File variable

  List<dynamic> ListResponse = [];
  List<dynamic> Listofsourcetype = [];

  GetStorage box = GetStorage();

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  String dropdownvalue3 = 'Item 1';
  var schemename;

  var schemenameafterselect;

  var location;

  var SchemeId;

  var Latitude;

  var Longitude;

  var HabitationName;
  var SourceType;

  var SourceTypeCategory;
  var StateName;

  var DistrictName;
  var BlockName;

  File? imgFile;
  final imgPicker = ImagePicker();

  List<dynamic> Listdetaillistofscheme = [];
  List<dynamic> Listdetaillistofscheme_mvs = [];
  List<dynamic> ListExistingsource = [];
  List<dynamic> ListExistingsource_location = [];
  String Existingsource_location = "";
  var Existingsource_habitaionid;

  var Existingsource_HabitationName;

  var Existingsource_SchemeId;

  var items3 = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String selectschamename = "";
  String selectcategoryname = "";
  String _mySchemeid = "-- Select Scheme --";
  String? _mySchemecategory;
  String fileNameofimg = "";
  String imagepath = "";
  String dropdownvalue2 = 'Item 6';
  String dropdownvaluedynamic = '';
  CroppedFile? croppedFile;

  String schemeid = "";
  String schemecategory = "";

  List<Schememodal> schemelist = [];
  late Schememodal schememodal;
  String selectscheme_addnewsourcebtn = "";

  String selecthabitation_addnewsourcebtn = "";

  String selectlocationlanmark_addnewsourcebtn = "";

  String villageid_addnewsourcebtn = "";

  String assettaggingid_addnewsourcebtn = "";

  String StateId_addnewsourcebtn = "";

  String schemeid_addnewsourcebtn = "";

  String SourceId_addnewsourcebtn = "";

  String HabitationId_addnewsourcebtn = "";

  String SourceTypeId_addnewsourcebtn = "";

  String SourceTypeCategoryId_addnewsourcebtn = "";

  String villagename_addnewsourcebtn = "";

  var latitute_addnewsourcebtn;

  var longitute_addnewsourcebtn;

  var items2 = [
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
  ];
  String dropdownvalue = 'Item 1';
  String? selectlocation = 'Selectlocation';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  List<int> imageBytes = [];
  TextEditingController locationlandmarkcontroller = TextEditingController();

  var selecthabitaionname = "-- Select Habitaion --";
  var selecthabitaionid;
  List<Habitaionlistmodal> habitationlist = [];
  late Habitaionlistmodal habitaionlistmodal;

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

      final bytes = _file.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      print("filepath_size_KB_cam>>> " + mb.toString());
      print("filepath_size_MB_cam>>> " + mb.toString());
      fileNameofimg = _file.path.split('/').last;
      imgFile != null
          ? 'data:image/png;base64,' + base64Encode(imgFile!.readAsBytesSync())
          : "";

      imageBytes = imgFile!.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      print("image64" + base64Image);
    });
    //Navigator.of(context).pop();
  }

  String? _currentAddress;
  Position? _currentPosition;
  final PermissionWithService _permission = Permission.locationWhenInUse;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    print("hasPermission_1" + hasPermission.toString());
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      print("hasPermission_2" + hasPermission.toString());
      print("hasPermission_2" + LocationAccuracy.bestForNavigation.toString());
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

  void _checkPermission() async {
    final status = await _permission.status;
    print('Status_per= $status');
    if (status == PermissionStatus.denied) {
      await _permission.request();
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permanently Denied'); // Never runs.
    }
  }

  var assettypeindexvalue;
  bool _loading = false;

  Future getexistingsourceApi(
    BuildContext context,
    String token,
    String schemeid,
  ) async {
    // var uri = Uri.parse('${Apiservice.baseurl}JJM_Mobile/GetSourceSchemeDetails?VillageId='+widget.villageid+"&StateId="+widget.stateid+"&UserId="+box.read("userid")+"&SchemeId="+_mySchemeid.toString());
    var uri = Uri.parse(
        '${Apiservice.baseurl}JJM_Mobile/GetExistSource?VillageId=' +
            widget.villageid +
            "&StateId=" +
            widget.stateid +
            "&UserId=" +
            box.read("userid").toString() +
            "&SchemeId=" +
            schemeid.toString());
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> mResposne = jsonDecode(response.body);

      setState(() {});
    }
    return jsonDecode(response.body);
  }

  Future getsourceschemedetails(
    BuildContext context,
    String token,
    String schemeid,
  ) async {
    var uri = Uri.parse(
        '${Apiservice.baseurl}JJM_Mobile/GetSourceSchemeDetails?VillageId=' +
            widget.villageid +
            "&StateId=" +
            widget.stateid +
            "&UserId=" +
            box.read("userid").toString() +
            "&SchemeId=" +
            schemeid.toString());
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> mResposne = jsonDecode(response.body);

      setState(() {});
    }
    return jsonDecode(response.body);
  }

  Future getsourceschemedetails_mvs(
    BuildContext context,
    String token,
    String schemeid,
  ) async {
    var uri = Uri.parse(
        '${Apiservice.baseurl}JJM_Mobile/GetSourceScheme_OtherVillage?VillageId=' +
            widget.villageid +
            "&StateId=" +
            widget.stateid +
            "&UserId=" +
            box.read("userid").toString() +
            "&SchemeId=" +
            schemeid.toString());
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> mResposne = jsonDecode(response.body);

      setState(() {});
    }
    return jsonDecode(response.body);
  }

  Future getsourcetyprApi(
    BuildContext context,
    String token,
  ) async {
    setState(() {
      _loading = true;
    });
    var uri = Uri.parse(
        '${Apiservice.baseurl}Master/Get_AssetTaggingType?UserId=' +
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
      print(mResposne);
      Listofsourcetype = mResposne["Result"];

      setState(() {});
    }

    setState(() {
      _loading = false;
    });

    return jsonDecode(response.body);
  }

  Future getschemesource(
    BuildContext context,
    String token,
  ) async {
    final queryParameters = {
      'UserId': box.read("userid").toString(),
      'StateId': widget.stateid,
      'villageid': widget.villageid,
    };
    var uri = Uri.parse('${Apiservice.baseurl}JJM_Mobile/GetSourceScheme');
    final newUri = uri.replace(queryParameters: queryParameters);
    var response = await http.get(
      newUri,
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    if (response.statusCode == 200) {
      ListResponse.add("--Select scheme --");
      Map<String, dynamic> mResposne = jsonDecode(response.body);
      // List   data = jsonDecode(response.body);
      List data = mResposne['schmelist'];
      // ListResponse = mResposne['schmelist'];

      schemelist.clear();
      schemelist.add(schememodal);
      for (int i = 0; i < data.length; i++) {
        newschameid = data[i]["Schemeid"].toString();
        newschemename = data[i]["Schemename"].toString();
        newCategory = data[i]["Category"].toString();
        schemelist.add(Schememodal(newschameid, newschemename, newCategory));
        print("hazardname" + newCategory);
      }

      setState(() {});
      /* Map<String, dynamic> mResposne = jsonDecode(response.body);
      List data = mResposne['data']["All_UserList"];

      hazardslist.clear();
      hazardslist.add(hazardModal_HSE);
      for (int i = 0; i < data.length; i++) {
   */
    }
    return jsonDecode(response.body);
  }

  Future gethabitaionlist(
    BuildContext context,
    String token,
  ) async {
    var uri = Uri.parse(
        '${Apiservice.baseurl}JJM_Mobile/GetHabitationlist?UserId=' +
            box.read("userid") +
            "&StateId=" +
            box.read("stateid") +
            "&VillageId=" +
            widget.villageid);
    var response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'APIKey': token ?? 'DEFAULT_API_KEY'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> mResposne = jsonDecode(response.body);
      print(mResposne);

      List data = mResposne["Result"];

      habitationlist.clear();

      habitationlist.add(habitaionlistmodal);
      for (int i = 0; i < data.length; i++) {
        var habitaionid = data[i]["HabitationId"].toString();
        var habitaionname = data[i]["HabitationName"].toString();

        habitationlist.add(Habitaionlistmodal(habitaionname, habitaionid));
      }
    }
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState

    if (box.read("UserToken").toString() == "null") {
      //if(box.read('UserToken').toString() == "null") {
//print("usertoken  >"+box.read('UserToken').toString());
      //Get.off(Dashboard(stateid: box.read("stateid"),userid: box.read("userid"),usertoken: box.read("UserToken").toString()));
      Get.off(LoginScreen());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please login your token has been expired!")));
      // Get.off(LoginScreen());
    }

    getclickedstatus = widget.clcikedstatus;
    // _checkPermission();
    getvillagename = widget.villagename;

    print("villageid_" + widget.villageid);
    schememodal = Schememodal("-- Select Scheme --", "", "");

    setState(() {
      if (getclickedstatus == "1") {
        assettypeindexvalue = getclickedstatus;
        viewVisible = true;
        //selectschemesib = false;
      } else if (getclickedstatus == "2") {
        setState(() {
          assettypeindexvalue = getclickedstatus;
          Storagestructuretype = false;
          Schemeinformationboard = true;

          // selectschemesib = true;
          viewVisible = true;
        });
      } else if (getclickedstatus == "3") {
        assettypeindexvalue = getclickedstatus;
        Storagestructuretype = true;
        Schemeinformationboard = false;
        // selectschemesib = true;
        viewVisible = true;
      } else if (getclickedstatus == "4") {
        assettypeindexvalue = getclickedstatus;
        // selectschemesib = true;
        viewVisible = true;
      }
    });

    schememodal = Schememodal("-- Select id  --", "-- Select Scheme --", "");

    getsourcetyprApi(context, box.read("UserToken")).then((value) {});
    getschemesource(context, box.read("UserToken")).then((value) {});

    habitaionlistmodal = Habitaionlistmodal(
        "-- Select Habitation --", "-- Select Habitation --");
    gethabitaionlist(context, box.read("UserToken")).then((value) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D3A98),
          iconTheme: const IconThemeData(
            color: Appcolor.white,
          ),
          title: const Text("Tag Water Source",
              style: TextStyle(color: Colors.white)),
        ),
        body: FocusDetector(
          onVisibilityGained: () {},
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/header_bg.png'), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                                      title: Text(box.read("username")),
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
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                widget.villagename,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Appcolor.headingcolor),
                              ),
                            )),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.all(2),
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
                                    "Select Asset Tagging",
                                    style: TextStyle(
                                        fontSize: 14,
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
                                _loading == true
                                    ? Center(
                                        child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Image.asset(
                                                "images/loading.gif")),
                                        /*child: CircularProgressIndicator(
                          strokeWidth: 2,))*/
                                        //  Image.asset("images/loader.gif")
                                      )
                                    : ListView.builder(
                                        itemCount: Listofsourcetype.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, int index) {
                                          return Container(
                                            margin: const EdgeInsets.all(3),
                                            child: Material(
                                              elevation: 2,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: InkWell(
                                                splashColor:
                                                    Appcolor.splashcolor,
                                                onTap: () {},
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: RadioListTile(
                                                        activeColor:
                                                            Appcolor.btncolor,
                                                        //   toggleable: true,
                                                        enableFeedback: true,
                                                        //contentPadding: EdgeInsets.symmetric(horizontal: 0.0 , vertical: 0.0),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 0),
                                                        visualDensity: const VisualDensity(
                                                            horizontal:
                                                                VisualDensity
                                                                    .minimumDensity,
                                                            vertical: VisualDensity
                                                                .minimumDensity),

                                                        title: Container(
                                                            child: Text(Listofsourcetype[
                                                                        index][
                                                                    "AssetTaggingType"]
                                                                .toString())),
                                                        value: Listofsourcetype[
                                                                index]["Id"]
                                                            .toString(),
                                                        groupValue:
                                                            getclickedstatus,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            getclickedstatus =
                                                                value;

                                                            print("selecting" +
                                                                Listofsourcetype[
                                                                            index]
                                                                        ["Id"]
                                                                    .toString());
                                                            print("selecting" +
                                                                getclickedstatus);
                                                            print("selecting_value" +
                                                                value
                                                                    .toString());

                                                            if (getclickedstatus
                                                                    .toString() ==
                                                                "1") {
                                                              setState(() {
                                                                print("source");
                                                                print("value");

                                                                messagedisplaypendingsource =
                                                                    false;
                                                                // selectschemesib = false;
                                                                viewVisible =
                                                                    true;

                                                                ERVisible =
                                                                    false;
                                                                Watersource =
                                                                    false;
                                                                Storagestructuretype =
                                                                    false;
                                                                Schemeinformationboard =
                                                                    false;
                                                                capturepointlocation =
                                                                    false;
                                                                Selectalreadytaggedsource =
                                                                    false;
                                                                messagevisibility =
                                                                    false;
                                                                Elevated_Storage_Reservoir =
                                                                    false;
                                                                Selecttaggedsource_camera =
                                                                    false;
                                                                SelectalreadytaggedsourceSIB =
                                                                    false;
                                                                Selectstoragetype_ESR =
                                                                    false;
                                                                Selectstoragetype_GSR =
                                                                    false;
                                                                Getgeolocation_SIB =
                                                                    false;
                                                                othercategory =
                                                                    false;
                                                                isGetGeoLocatonlatlong =
                                                                    false;
                                                                //  isGetGeoLocatonESR = false;

                                                                ESR_capacity =
                                                                    false;
                                                                Othercategorymbr =
                                                                    false;
                                                                PumphouseOthercategorywatertreatment =
                                                                    false;
                                                                PumphouseOthercategory =
                                                                    false;
                                                                Clorinatorcategory =
                                                                    false;
                                                                Othercategorymbr =
                                                                    false;
                                                                Othercategorygrooundrechargewater =
                                                                    false;
                                                                ESR_Selectalreadytaggedsource =
                                                                    false;

                                                                selectschemesource =
                                                                    false;
                                                                selectschemesourcemessage_mvc =
                                                                    false;
                                                                geotaggedonlydropdown =
                                                                    false;

                                                                Takephotovisibility =
                                                                    false;
                                                              });
                                                            } else if (getclickedstatus
                                                                    .toString() ==
                                                                "2") {
                                                              setState(() {
                                                                print("rajni");

                                                                //selectschemesib = true;
                                                                messagedisplaypendingsource =
                                                                    false;
                                                                viewVisible =
                                                                    true;

                                                                ERVisible =
                                                                    false;
                                                                Watersource =
                                                                    false;
                                                                Schemeinformationboard =
                                                                    true;
                                                                Storagestructuretype =
                                                                    false;
                                                                Selectalreadytaggedsource =
                                                                    false;
                                                                capturepointlocation =
                                                                    false;
                                                                Elevated_Storage_Reservoir =
                                                                    false;
                                                                Selecttaggedsource_camera =
                                                                    false;
                                                                SelectalreadytaggedsourceSIB =
                                                                    false;
                                                                Selectstoragetype_ESR =
                                                                    false;
                                                                Selectstoragetype_GSR =
                                                                    false;
                                                                Getgeolocation_SIB =
                                                                    false;
                                                                othercategory =
                                                                    false;
                                                                isGetGeoLocatonlatlong =
                                                                    false;
                                                                //   isGetGeoLocatonESR = false;
                                                                ESR_capacity =
                                                                    false;
                                                                Othercategorymbr =
                                                                    false;
                                                                PumphouseOthercategorywatertreatment =
                                                                    false;
                                                                PumphouseOthercategory =
                                                                    false;
                                                                Clorinatorcategory =
                                                                    false;
                                                                Othercategorymbr =
                                                                    false;
                                                                Othercategorygrooundrechargewater =
                                                                    false;
                                                                ESR_Selectalreadytaggedsource =
                                                                    false;

                                                                selectschemesource =
                                                                    false;
                                                                selectschemesourcemessage_mvc =
                                                                    false;

                                                                Takephotovisibility =
                                                                    false;
                                                                messagevisibility =
                                                                    false;
                                                              });
                                                            } else if (getclickedstatus ==
                                                                "3") {
                                                              setState(() {
                                                                print("rajni");

                                                                Selectassettaggingmain =
                                                                    value
                                                                        .toString();
                                                                print(
                                                                    Selectassettaggingmain);
                                                                messagedisplaypendingsource =
                                                                    false;
                                                                ERVisible =
                                                                    false;
                                                                selectschemesib =
                                                                    false;
                                                                viewVisible =
                                                                    false;

                                                                Storagestructuretype =
                                                                    true;
                                                                Schemeinformationboard =
                                                                    false;
                                                                capturepointlocation =
                                                                    false;
                                                                Selectalreadytaggedsource =
                                                                    false;
                                                                messagevisibility =
                                                                    false;
                                                                Elevated_Storage_Reservoir =
                                                                    false;
                                                                Selecttaggedsource_camera =
                                                                    false;
                                                                SelectalreadytaggedsourceSIB =
                                                                    false;
                                                                Selectstoragetype_ESR =
                                                                    false;
                                                                Selectstoragetype_GSR =
                                                                    false;
                                                                Getgeolocation_SIB =
                                                                    false;
                                                                othercategory =
                                                                    false;
                                                                isGetGeoLocatonlatlong =
                                                                    false;

                                                                //   isGetGeoLocatonESR = false;
                                                                ESR_capacity =
                                                                    false;
                                                                Othercategorymbr =
                                                                    false;
                                                                PumphouseOthercategorywatertreatment =
                                                                    false;
                                                                PumphouseOthercategory =
                                                                    false;
                                                                Clorinatorcategory =
                                                                    false;
                                                                Othercategorymbr =
                                                                    false;
                                                                Othercategorygrooundrechargewater =
                                                                    false;
                                                                ESR_Selectalreadytaggedsource =
                                                                    false;

                                                                selectschemesource =
                                                                    false;
                                                                selectschemesourcemessage_mvc =
                                                                    false;
                                                                Takephotovisibility =
                                                                    false;
                                                              });
                                                            } else if (getclickedstatus ==
                                                                "4") {
                                                              setState(() {
                                                                print("rajni");
                                                                Selectassettaggingmain =
                                                                    value
                                                                        .toString();
                                                                print(
                                                                    Selectassettaggingmain);
                                                                messagedisplaypendingsource =
                                                                    false;
                                                                ERVisible =
                                                                    false;
                                                                Storagestructuretype =
                                                                    false;
                                                                selectschemesib =
                                                                    false;
                                                                viewVisible =
                                                                    false;
                                                                Schemeinformationboard =
                                                                    false;
                                                                Selectalreadytaggedsource =
                                                                    false;
                                                                capturepointlocation =
                                                                    false;
                                                                Elevated_Storage_Reservoir =
                                                                    false;
                                                                Selecttaggedsource_camera =
                                                                    false;
                                                                SelectalreadytaggedsourceSIB =
                                                                    false;
                                                                Selectstoragetype_ESR =
                                                                    false;
                                                                Selectstoragetype_GSR =
                                                                    false;
                                                                Getgeolocation_SIB =
                                                                    false;
                                                                othercategory =
                                                                    true;
                                                                isGetGeoLocatonlatlong =
                                                                    false;
                                                                //isGetGeoLocatonESR = false;
                                                                ESR_capacity =
                                                                    false;
                                                                Othercategorymbr =
                                                                    false;
                                                                PumphouseOthercategorywatertreatment =
                                                                    false;
                                                                PumphouseOthercategory =
                                                                    false;
                                                                Clorinatorcategory =
                                                                    false;
                                                                Othercategorymbr =
                                                                    false;
                                                                Othercategorygrooundrechargewater =
                                                                    false;
                                                                ESR_Selectalreadytaggedsource =
                                                                    false;

                                                                selectschemesource =
                                                                    false;
                                                                selectschemesourcemessage_mvc =
                                                                    false;
                                                                geotaggedonlydropdown =
                                                                    false;
                                                                messagevisibility =
                                                                    false;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                              ],
                            )),
                      ),
                    ),
                    /////--------------- select scheme Api ------------
                    // scheme
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: viewVisible,
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
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
                              child: SizedBox(
                                width: double.infinity,
                                child: Container(
                                  //  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: InkWell(
                                      splashColor: Appcolor.splashcolor,
                                      onTap: () {},
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(

                                                  "Select Scheme pws ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                          const Divider(
                                            height: 10,
                                            color: Appcolor.lightgrey,
                                            thickness: 1,
                                            // indent : 10,
                                            //endIndent : 10,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 65,
                                            margin: const EdgeInsets.only(
                                                bottom: 10.0,
                                                right: 10,
                                                left: 10),
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
                                            child: DropdownButton<Schememodal>(
                                                itemHeight: 80,
                                                elevation: 10,
                                                dropdownColor: Appcolor.white,
                                                underline: const SizedBox(),
                                                isExpanded: true,
                                                hint: const Text(
                                                  "-- Select Scheme --",
                                                ),
                                                value: schememodal,
                                                items: schemelist
                                                    .map((concernnames) {
                                                  return DropdownMenuItem<
                                                      Schememodal>(
                                                    value: concernnames,
                                                    child: Container(
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 2.0),
                                                      decoration: const BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1))),
                                                      child: Text(
                                                        concernnames.Schemename,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Appcolor.black),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged:
                                                    (Schememodal? newValue) {
                                                  setState(() {
                                                    schememodal = newValue!;
                                                    _mySchemeid =
                                                        newValue!.Schemeid;
                                                    selectschamename =
                                                        newValue.Schemename;
                                                    selectcategoryname =
                                                        newValue!.Category
                                                            .toString();

                                                    /////// Api calling here schemedetailslist ----------

                                                    if (getclickedstatus ==
                                                        "1") {
                                                      if (selectcategoryname.toString() == "svs") {
                                                        setState(() {
                                                          selectschemesource = true;
                                                          selectschemesourcemessage_mvc = true;
                                                          messagevisibility = false;

                                                        });

                                                        getsourceschemedetails(
                                                                context,
                                                                box
                                                                    .read(
                                                                        "UserToken")
                                                                    .toString(),
                                                                _mySchemeid
                                                                    .toString())
                                                            .then((value) {
                                                          setState(() {
                                                            if (value["Message"]
                                                                    .toString() ==
                                                                "Source list") {
                                                              setState(() {
                                                                Listdetaillistofscheme =
                                                                    value[
                                                                        "Result"];
                                                              });
                                                              messagenowatersourcecontactofc=false;
                                                            }
                                                            else {
                                                              Listdetaillistofscheme
                                                                  .clear();
                                                              selectschemenosource_svc = true;
                                                              messagenowatersourcecontactofc=true ;
                                                              // selectschemesource = false;
                                                            }
                                                          });
                                                        });


                                                      } else {
                                                        print("charming");
                                                        setState(() {
                                                          selectschemesourcemessage_mvc = true;
                                                          messagevisibility = false;
                                                          selectschemesource = true;
                                                        });
                                                        getsourceschemedetails(
                                                                context,
                                                                box
                                                                    .read(
                                                                        "UserToken")
                                                                    .toString(),
                                                                _mySchemeid
                                                                    .toString())
                                                            .then((value) {
                                                          setState(() {
                                                            if (value["Message"]
                                                                    .toString() ==
                                                                "Source list") {
                                                              setState(() {
                                                                Listdetaillistofscheme =
                                                                    value[
                                                                        "Result"];
                                                              });
                                                              messagenowatersourcecontactofc=false;
                                                            } else {
                                                              Listdetaillistofscheme
                                                                  .clear();
                                                              selectschemenosource_svc = true;
                                                              messagenowatersourcecontactofc=true;

                                                              samesourcesib = "";

                                                              // selectschemesource = false;
                                                            }
                                                          });
                                                        });

                                                        samesourcesib = "";
                                                      }

                                                      getsourceschemedetails_mvs(
                                                              context,
                                                              box
                                                                  .read(
                                                                      "UserToken")
                                                                  .toString(),
                                                              _mySchemeid
                                                                  .toString())
                                                          .then((value) {
                                                        setState(() {
                                                          if (value["Status"]
                                                                  .toString() ==
                                                              "true") {
                                                            setState(() {
                                                              Listdetaillistofscheme_mvs =
                                                                  value[
                                                                      "Result"];
                                                              messageofscheme_mvs =
                                                                  value["Message"]
                                                                      .toString();
                                                              print("neha)");
                                                            });
                                                            messagenowatersourcecontactofc=false;
                                                            print("charming");
                                                          } else {
                                                            Listdetaillistofscheme_mvs.clear();
                                                            selectschemenosource_svc = true;
                                                            messagenowatersourcecontactofc=true;
                                                            // selectschemesource = false;
                                                          }
                                                          samesourcesib = "";
                                                        });
                                                      });
                                                    } else if (getclickedstatus ==
                                                        "2") {
                                                      selectschemesource =
                                                          false;
                                                      selectschemesourcemessage_mvc =
                                                          false;
                                                      samesourcesib = "";
                                                    }

                                                    // Use null-aware operator to handle null ListRespo
                                                  });
                                                  print("nano");
                                                }),
                                          )
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
                    ),


                    Visibility(
                      visible: capturepointlocation,
                      child: Container(
                        //   margin: EdgeInsets.all(5),
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
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Capture Point Location(Information board_) * ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(
                              height: 10,
                              color: Colors.grey,
                              thickness: 1,
                              // indent : 10,
                              //endIndent : 10,
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          5.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(
                                      //                 <--- border radius here
                                      color: Colors.grey)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RadioListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text("Same as source"),
                                    value: "Sameassource_one",
                                    groupValue: samesource,
                                    onChanged: (value) {
                                      setState(() {
                                        samesource = value.toString();
                                        Selecttaggedsource_camera = true;
                                        ESR_Selectalreadytaggedsource = true;
                                        selectschemesource = false;
                                        selectschemesourcemessage_mvc = false;
                                        //Getgeolocation_SIB=false;
                                        Takephotovisibility = true;
                                        SelectalreadytaggedsourceSIB = false;
                                        messagevisibility = false;
                                        selectschemesib = false;
                                        viewVisible = false;
                                        //samesourcesib
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text("Get geo location"),
                                    value: "GeoLocation",
                                    groupValue: samesource,
                                    onChanged: (value) {
                                      setState(() {
                                        samesource = value.toString();
                                        Selecttaggedsource_camera = false;
                                        SelectalreadytaggedsourceSIB = false;
                                        ESR_Selectalreadytaggedsource = false;
                                        messagevisibility = false;
                                        selectschemesourcemessage_mvc = false;
                                        selectschemesource = false;
                                        geotaggedonlydropdown = false;
                                        selectschemesib = false;
                                        viewVisible = false;

                                        // Getgeolocation_SIB=true;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: messagedisplaypendingsource,
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 5, top: 5, right: 5, bottom: 5),
                        // color: Appcolor.white,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                        child: Container(
                          //margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Alert: Source tagging is pending for this scheme. Kindly tag the source',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                height: 10,
                                color: Appcolor.lightgrey,
                                thickness: 1,
                                // indent : 10,
                                //endIndent : 10,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    getclickedstatus = "1";
                                    messagedisplaypendingsource = false;
                                    Schemeinformationboard = false;
                                    //selectschemesib=false;
                                    viewVisible = true;
                                    selectschemesource = true;

                                    if (selectcategoryname.toString() == "svs") {
                                      selectschemesource = true;
                                      selectschemesourcemessage_mvc = true;
                                      messagevisibility = false;

                                      getsourceschemedetails(
                                              context,
                                              box.read("UserToken").toString(),
                                              _mySchemeid.toString())
                                          .then((value) {
                                        setState(() {
                                          if (value["Message"].toString() ==
                                              "Source list") {
                                            setState(() {
                                              Listdetaillistofscheme =
                                                  value["Result"];
                                            });
                                          } else {
                                            Listdetaillistofscheme.clear();
                                            selectschemesourcemessage_mvc =
                                                true;

                                          }
                                        });
                                      });

                                      samesourcesib = "";
                                    } else {
                                      print("charming");
                                      selectschemesourcemessage_mvc = true;
                                      selectschemesource = false;
                                      messagevisibility = false;

                                      getsourceschemedetails_mvs(
                                              context,
                                              box.read("UserToken").toString(),
                                              _mySchemeid.toString())
                                          .then((value) {
                                        setState(() {
                                          if (value["Status"].toString() ==
                                              "true") {
                                            setState(() {
                                              Listdetaillistofscheme_mvs =
                                                  value["Result"];
                                              messageofscheme_mvs =
                                                  value["Message"].toString();
                                              print("neha)");
                                            });

                                            print("charming");
                                          } else {
                                            Listdetaillistofscheme_mvs.clear();

                                            selectschemesourcemessage_mvc = true;

                                            // selectschemesource = false;
                                          }
                                          samesourcesib = "";
                                        });
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Appcolor.greenmessagecolor,
                                    border: Border.all(
                                      color: Appcolor.greenmessagecolor,
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ), //                 <--- border radius here
                                    ),
                                  ),
                                  child: const SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'Go to source',
                                        style: TextStyle(
                                            color: Appcolor.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
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
                    Visibility(
                      visible: Schemeinformationboard,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //  margin: EdgeInsets.only(top:5),
                            width: double.infinity,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Capture Point Location(Information board) * ",
                                    style: TextStyle(
                                        fontSize: 14,
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

                                //-----------------  sib ---------------
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              5.0) //                 <--- border radius here
                                          ),
                                      border: Border.all(
                                        //                 <--- border radius here
                                        color: Appcolor.lightgrey,
                                      )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text("Same as source"),
                                        value: "1",
                                        groupValue: samesourcesib,
                                        onChanged: (value) {
                                          setState(() {
                                            samesourcesib = value.toString();

                                            Schemeinformationboard = true;
                                            SelectalreadytaggedsourceSIB = true;
                                            Getgeolocation_SIB = false;
                                            isGetGeoLocatonlatlong = false;
                                            ESR_Selectalreadytaggedsource =
                                                false;

                                            selectschemesource = false;
                                            selectschemesourcemessage_mvc =
                                                false;

                                            messagevisibility = false;

                                            //selectschemesib = true;
                                            viewVisible = true;

                                            //////////////////////////////////////////////////////

                                            getexistingsourceApi(
                                                    context,
                                                    box
                                                        .read("UserToken")
                                                        .toString(),
                                                    _mySchemeid.toString())
                                                .then((value) {
                                              setState(() {
                                                if (value["Status"]
                                                        .toString() ==
                                                    "true") {
                                                  setState(() {
                                                    //Listdetaillistofscheme_mvs

                                                    // Habitaionsamesourcetext=true;

                                                    geotaggedonlydropdown =
                                                        true;
                                                    ListExistingsource =
                                                        value["Result"];
                                                    messageof_existingscheme =
                                                        value["Message"]
                                                            .toString();

                                                    ListExistingsource_location
                                                        .add(selectlocation);

                                                    for (int i = 0;
                                                        i <
                                                            ListExistingsource
                                                                .length;
                                                        i++) {
                                                      Existingsource_location =
                                                          value["Result"][i]
                                                                  ["location"]
                                                              .toString();
                                                      Existingsource_habitaionid =
                                                          value["Result"][i][
                                                                  "HabitationId"]
                                                              .toString();
                                                      Existingsource_HabitationName =
                                                          value["Result"][i][
                                                                  "HabitationName"]
                                                              .toString();
                                                      Existingsource_SchemeId =
                                                          value["Result"][i]
                                                                  ["SchemeId"]
                                                              .toString();
                                                      ListExistingsource_location
                                                          .add(
                                                              Existingsource_location);

                                                      print(
                                                          ListExistingsource_location
                                                              .toList());

                                                      /*if(i==0){
                                                      Existingsource_location = value["Result"][i]["location"].toString();
                                                      Existingsource_habitaionid = value["Result"][i]["HabitationId"].toString();
                                                      Existingsource_HabitationName = value["Result"][i]["HabitationName"].toString();
                                                      Existingsource_SchemeId = value["Result"][i]["SchemeId"].toString();
                                                      ListExistingsource_location.add(Existingsource_location);



                                                      print(ListExistingsource_location.toList());
                                                      print("rahul_neha");
                                                    }else if(i==1){
                                                      Existingsource_location = value["Result"][i]["location"].toString();
                                                   Existingsource_habitaionid =      value["Result"][i]["HabitationId"].toString();
                                                   Existingsource_HabitationName =  value["Result"][i]["HabitationName"].toString();
                                                   Existingsource_SchemeId =        value["Result"][i]["SchemeId"].toString();
                                                      ListExistingsource_location.add(Existingsource_location);



                                                      print(ListExistingsource_location.toList());
                                                      print("rahul_neha");
                                                    }*/
                                                    }
                                                  });
                                                } else {
                                                  ListExistingsource.clear();

                                                  setState(() {
                                                    Habitaionsamesourcetext =
                                                        false;
                                                    geotaggedonlydropdown =
                                                        false;
                                                    messagedisplaypendingsource =
                                                        true;
                                                    SelectalreadytaggedsourceSIB =
                                                        false;
                                                  });
                                                }
                                              });
                                            });
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text("Get geo location"),
                                        value: "2",
                                        groupValue: samesourcesib,
                                        onChanged: (value) {
                                          setState(() {
                                            _getCurrentPosition();
                                            samesourcesib = value.toString();

                                            isGetGeoLocatonlatlong = true;
                                            Takephotovisibility = false;
                                            ESR_Selectalreadytaggedsource =
                                                false;
                                            selectschemesource = false;
                                            selectschemesourcemessage_mvc =
                                                false;
                                            SelectalreadytaggedsourceSIB = true;
                                            messagevisibility = false;
                                            geotaggedonlydropdown = false;
                                            Getgeolocation_SIB = true;
                                            //selectschemesib = true;
                                            viewVisible = true;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: Storagestructuretype,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Select Storage Structure Type d',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
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
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Appcolor.lightgrey),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text(
                                            "Elevated Storage Reservior (ESR)"),
                                        value: "ESR",
                                        groupValue: ESRSource,
                                        onChanged: (value) {
                                          setState(() {
                                            ESRSource = value.toString();
                                            Selectstoragetype_ESR = true;
                                            Selectstoragetype_GSR = false;
                                            messagevisibility = false;
                                            ESR_Selectalreadytaggedsource =
                                                false;
                                            selectschemesource = false;
                                            selectschemesourcemessage_mvc =
                                                false;
                                            selectschemesib = false;
                                            viewVisible = false;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text(
                                            "Ground Storage Reservoir (GSR)"),
                                        value: "GSR",
                                        groupValue: ESRSource,
                                        onChanged: (value) {
                                          setState(() {
                                            ESRSource = value.toString();
                                            Selectstoragetype_ESR = false;
                                            Selectstoragetype_GSR = true;
                                            //isGetGeoLocatonESR
                                            print("suhana");
                                            ESR_Selectalreadytaggedsource =
                                                false;
                                            messagevisibility = false;
                                            selectschemesource = false;
                                            selectschemesourcemessage_mvc =
                                                false;
                                            selectschemesib = false;
                                            viewVisible = false;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: Elevated_Storage_Reservoir,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: Container(
                          width: double.infinity,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Capture Point Location (Elevated  Storage Reservoir (ESR))',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                height: 10,
                                color: Appcolor.lightgrey,
                                thickness: 1,
                                // indent : 10,
                                //endIndent : 10,
                              ),
                              Container(
                                width: double.infinity,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text("Same as source"),
                                      value: "Sameassource_d",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          samesource = value.toString();
                                          isGetGeoLocatonlatlong = false;
                                          messagevisibility = false;
                                          ESR_Selectalreadytaggedsource = false;
                                          selectschemesource = false;
                                          selectschemesourcemessage_mvc = false;
                                          ESR_capacity = false;
                                          Getgeolocation_SIB = false;
                                          print("niima");
                                          selectschemesib = false;
                                          viewVisible = false;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text(
                                          "Same as Information Board"),
                                      value: "Sameasinformationboard_esr",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          samesource = value.toString();
                                          isGetGeoLocatonlatlong = false;

                                          Selectalreadytaggedsource = false;
                                          messagevisibility = false;
                                          ESR_Selectalreadytaggedsource = false;
                                          selectschemesource = false;
                                          selectschemesourcemessage_mvc = false;
                                          ESR_capacity = false;
                                          Getgeolocation_SIB = false;
                                          selectschemesib = false;
                                          viewVisible = false;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text("Get geo location"),
                                      value: "GeoLocation",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          samesource = value.toString();
                                          ESR_Selectalreadytaggedsource = false;
                                          selectschemesource = false;
                                          messagevisibility = false;
                                          selectschemesourcemessage_mvc = false;
                                          ESR_capacity = true;
                                          Getgeolocation_SIB = true;
                                          Takephotovisibility = true;
                                          selectschemesib = false;
                                          viewVisible = false;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: Selectstoragetype_ESR,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: Container(
                          width: double.infinity,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Capture Point Location (Elevated Storage Reservior (ESR)) *",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                height: 10,
                                color: Appcolor.lightgrey,
                                thickness: 1,
                                // indent : 10,
                                //endIndent : 10,
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Appcolor.lightgrey),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text("Same as source "),
                                      value: "Sameassource",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          samesource = value.toString();
                                          //  isGetGeoLocatonESR = false;
                                          isGetGeoLocatonlatlong = false;
                                          Getgeolocation_SIB = false;
                                          messagevisibility = false;
                                          Selectalreadytaggedsource = true;
                                          Selecttaggedsource_camera = true;
                                          ESR_capacity = true;
                                          ESR_Selectalreadytaggedsource = true;
                                          SelectalreadytaggedsourceSIB = false;
                                          selectschemesource = false;
                                          selectschemesourcemessage_mvc = false;
                                          isSameasSource = false;
                                          selectschemesib = false;
                                          viewVisible = false;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text(
                                          "Same as Information Board"),
                                      value: "SameasInformationBoard_ESR",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          print("nimmme");
                                          samesource = value.toString();
                                          //  isGetGeoLocatonESR = false;
                                          isGetGeoLocatonlatlong = false;
                                          Getgeolocation_SIB = false;
                                          Selectalreadytaggedsource = true;
                                          Selecttaggedsource_camera = false;
                                          ESR_capacity = true;
                                          messagevisibility = false;

                                          ESR_Selectalreadytaggedsource = true;
                                          SelectalreadytaggedsourceSIB = false;
                                          isSameasSource = false;
                                          selectschemesource = false;
                                          selectschemesourcemessage_mvc = false;
                                          selectschemesib = false;
                                          viewVisible = false;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text("Get geo location"),
                                      value: "GeoLocation",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          samesource = value.toString();
                                          Getgeolocation_SIB = true;
                                          // isGetGeoLocatonESR = true;

                                          isGetGeoLocatonlatlong = true;
                                          print("ravi");
                                          ESR_capacity = true;
                                          SelectalreadytaggedsourceSIB = true;
                                          messagevisibility = false;
                                          //  Getgeolocation_SIB = false;
                                          messagevisibility = false;
                                          ESR_Selectalreadytaggedsource = false;
                                          isSameasSource = false;
                                          selectschemesource = false;
                                          selectschemesourcemessage_mvc = false;
                                          selectschemesib = false;
                                          viewVisible = false;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: Selectstoragetype_GSR,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: Container(
                          width: double.infinity,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Capture Point Location (Ground Storage Reservoir (GSR)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                height: 10,
                                color: Appcolor.lightgrey,
                                thickness: 1,
                                // indent : 10,
                                //endIndent : 10,
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black54),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text("Same as source "),
                                      value: "Sameassource_gsr",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          samesource = value.toString();
                                          print("niima_pro");
                                          //    isGetGeoLocatonESR = false;

                                          Getgeolocation_SIB = false;
                                          ESR_capacity = true;
                                          messagevisibility = false;
                                          ESR_Selectalreadytaggedsource = true;
                                          selectschemesource = false;
                                          selectschemesourcemessage_mvc = false;
                                          selectschemesib = false;
                                          viewVisible = false;
                                          //  Getgeolocation_SIB=true;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text(
                                          "Same as Information Board"),
                                      value: "SameasInformationstructure",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          samesource = value.toString();
                                          print("rahulfe");
                                          Selectalreadytaggedsource = true;
                                          messagevisibility = false;
                                          SelectalreadytaggedsourceSIB = false;
                                          Getgeolocation_SIB = false;

                                          isGetGeoLocatonlatlong = false;
                                          // isGetGeoLocatonESR = true;
                                          ESR_capacity = true;
                                          ESR_Selectalreadytaggedsource = true;
                                          // isGetGeoLocatonESR = false;
                                          selectschemesource = false;
                                          selectschemesourcemessage_mvc = false;
                                          selectschemesib = false;
                                          viewVisible = false;
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text("Get geo location"),
                                      value: "GeoLocation",
                                      groupValue: samesource,
                                      onChanged: (value) {
                                        setState(() {
                                          samesource = value.toString();
                                          isGetGeoLocatonlatlong = true;

                                          messagevisibility = false;
                                          Selectalreadytaggedsource = true;
                                          SelectalreadytaggedsourceSIB = true;
                                          Getgeolocation_SIB = false;
                                          ESR_Selectalreadytaggedsource = false;
                                          selectschemesource = false;
                                          selectschemesourcemessage_mvc = false;
                                          selectschemesib = false;
                                          viewVisible = false;

                                          print("nimrma");
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: ESR_Selectalreadytaggedsource,
                      child: Container(
                        width: double.infinity,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Select already tagged Source for ESR',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              height: 10,
                              color: Appcolor.lightgrey,
                              thickness: 1,
                              // indent : 10,
                              //endIndent : 10,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black54),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: DropdownButton(
                                      // Initial Value
                                      isExpanded: true,
                                      value: dropdownvalue2,
                                      isDense: true,
                                      hint: const Text(
                                        '--Select Scheme--',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: const TextStyle(
                                          color: Appcolor.bgcolor,
                                          fontSize: 16),
                                      dropdownColor: Colors.white,
                                      //drop down view
                                      underline: const SizedBox(),
                                      // Down Arrow Icon
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      // Array list of items
                                      items: items2.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue2 = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    _image != null
                                        ? Image.file(
                                            _image!,
                                            width: 500,
                                            height: 117,
                                          )
                                        : InkWell(
                                            onTap: () {},
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.asset(
                                                  'images/camera.png',
                                                  width: 100.0,
                                                  height: 100.0),
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
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: TextButton(
                                          onPressed: () {

                                            openCamera();
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
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                height: 40,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF0D3A98),
                                    borderRadius: BorderRadius.circular(8)),
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Saved Successfully"),
                                    ));
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
                    Visibility(
                      visible: othercategory,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Select Asset Other Category (D)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
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
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Appcolor.lightgrey),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text("Chlorinator"),
                                        value: "Chlorinator",
                                        groupValue: Othersmain,
                                        onChanged: (value) {
                                          setState(() {
                                            Othersmain = value.toString();
                                            Clorinatorcategory = true;
                                            PumphouseOthercategory = false;
                                            PumphouseOthercategorywatertreatment =
                                                false;
                                            Othercategorymbr = false;
                                            Othercategorygrooundrechargewater =
                                                false;
                                            messagevisibility = false;
                                            ESR_Selectalreadytaggedsource =
                                                false;
                                            SelectalreadytaggedsourceSIB =
                                                false;
                                            Othercategorymbr = false;
                                            selectschemesource = false;
                                            selectschemesourcemessage_mvc =
                                                false;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text("Pump House"),
                                        value: "Pump House",
                                        groupValue: Othersmain,
                                        onChanged: (value) {
                                          setState(() {
                                            Othersmain = value.toString();
                                            PumphouseOthercategory = true;

                                            Clorinatorcategory = false;
                                            PumphouseOthercategorywatertreatment =
                                                false;
                                            Othercategorymbr = false;
                                            Othercategorygrooundrechargewater =
                                                false;
                                            ESR_Selectalreadytaggedsource =
                                                false;
                                            isSameasSource = false;
                                            Othercategorymbr = false;
                                            Othercategorygrooundrechargewater =
                                                false;
                                            selectschemesource = false;
                                            selectschemesourcemessage_mvc =
                                                false;
                                            selectschemesib = false;
                                            viewVisible = false;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text(
                                            "Water Treatment Plan(WTP)"),
                                        value: "WTP",
                                        groupValue: Othersmain,
                                        onChanged: (value) {
                                          setState(() {
                                            Othersmain = value.toString();
                                            PumphouseOthercategory = false;
                                            Clorinatorcategory = false;
                                            PumphouseOthercategorywatertreatment =
                                                true;
                                            Othercategorymbr = true;
                                            Othercategorygrooundrechargewater =
                                                true;
                                            ESR_Selectalreadytaggedsource =
                                                false;
                                            Othercategorymbr = false;
                                            messagevisibility = false;
                                            Othercategorygrooundrechargewater =
                                                false;
                                            selectschemesource = false;
                                            selectschemesourcemessage_mvc =
                                                false;
                                            selectschemesib = false;
                                            viewVisible = false;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text(
                                            "Mass Balancing Reservior (MBR)"),
                                        value: "MBR",
                                        groupValue: Othersmain,
                                        onChanged: (value) {
                                          setState(() {
                                            Othersmain = value.toString();
                                            PumphouseOthercategorywatertreatment =
                                                false;
                                            PumphouseOthercategory = false;
                                            Clorinatorcategory = false;
                                            Othercategorymbr = true;
                                            Othercategorygrooundrechargewater =
                                                false;
                                            ESR_Selectalreadytaggedsource =
                                                false;
                                            Othercategorymbr = true;
                                            selectschemesource = false;
                                            messagevisibility = false;
                                            selectschemesourcemessage_mvc =
                                                false;
                                            selectschemesib = false;
                                            viewVisible = false;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        contentPadding: EdgeInsets.zero,
                                        title: const Text(
                                            "Ground Water Recharge Structure"),
                                        value: "Ground Water",
                                        groupValue: Othersmain,
                                        onChanged: (value) {
                                          setState(() {
                                            Othersmain = value.toString();
                                            PumphouseOthercategorywatertreatment =
                                                false;
                                            PumphouseOthercategory = false;
                                            Clorinatorcategory = false;

                                            Othercategorygrooundrechargewater =
                                                true;
                                            ESR_Selectalreadytaggedsource =
                                                false;
                                            Othercategorymbr = false;
                                            selectschemesource = false;
                                            messagevisibility = false;
                                            selectschemesourcemessage_mvc =
                                                false;
                                            selectschemesib = false;
                                            viewVisible = false;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: ESR_capacity,
                      child: Container(
                        width: double.infinity,
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
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Appcolor.lightgrey),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Capacity (In Liter)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: TextFormField(
                                        //style: const TextStyle(color: Appcolor.lightgrey),
                                        decoration: InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                              10.0,
                                            ),
                                            borderSide: new BorderSide(
                                                color: Appcolor.lightgrey),
                                          ),
                                          //   fillColor: Colors.grey.shade100,
                                          // filled: true,
                                          // prefixIcon: Icon(Icons.settings,
                                          //   color: Colors.black,),
                                          hintText: "Enter Capacity (in Liter)",
                                        ),
                                      ),
                                    ),
                                  ],
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
                    Visibility(
                      visible: Takephotovisibility,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 200,
                              width: 400,
                              padding: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  _image != null
                                      ? Image.file(
                                          _image!,
                                          width: 500,
                                          height: 117,
                                        )
                                      : InkWell(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                                'images/camera.png',
                                                width: 100.0,
                                                height: 100.0),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: Container(
                                      height: 40,
                                      width: 200,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF0D3A98),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: TextButton(
                                        onPressed: () {

                                          openCamera();
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
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 40,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF0D3A98),
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Saved Successfully"),
                                  ));
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
                    // location esr
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: Getgeolocation_SIB,
                      child: Container(
                        width: double.infinity,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Add New location of water source',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              height: 10,
                              color: Appcolor.lightgrey,
                              thickness: 1,
                              // indent : 10,
                              //endIndent : 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10, top: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Appcolor.lightgrey),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    '  Habitation',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
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
                                        borderRadius: BorderRadius.circular(6)),
                                    child: DropdownButton<Habitaionlistmodal>(
                                        itemHeight: 60,
                                        elevation: 10,
                                        dropdownColor: Appcolor.light,
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        hint: const Text(
                                          "-- Select Habitation --",
                                        ),
                                        value: habitaionlistmodal,
                                        items:
                                            habitationlist.map((habitations) {
                                          return DropdownMenuItem<
                                              Habitaionlistmodal>(
                                            value: habitations,
                                            child: Text(
                                              habitations.HabitationName,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Appcolor.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged:
                                            (Habitaionlistmodal? newValue) {
                                          setState(() {
                                            habitaionlistmodal = newValue!;
                                            selecthabitaionid =
                                                newValue!.HabitationId;
                                            selecthabitaionname =
                                                newValue.HabitationName;
                                            print("selecthabitaionname" +
                                                selecthabitaionname);
                                          });
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Source Location/landmark',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            controller:
                                                locationlandmarkcontroller,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                            decoration: InputDecoration(

                                                // filled: true,
                                                // prefixIcon: Icon(Icons.settings,
                                                //   color: Colors.black,),
                                                hintText:
                                                    "Enter Source Location/landmark",
                                                hintStyle: const TextStyle(
                                                    color: Appcolor.grey,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isGetGeoLocatonlatlong,
                      child: Container(
                        width: double.infinity,
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
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Geotagged of Information Board bbb',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
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
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Latitute',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _getCurrentPosition();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: const Color(0xffbFFFDE5),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        ' ${_currentPosition?.latitude ?? ""}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'Longitude',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _getCurrentPosition();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: const Color(0xffbfffde5),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        ' ${_currentPosition?.longitude ?? ""}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  /*  ElevatedButton(
                                      onPressed: () async {
                                        Position position =
                                        await Geolocator.getCurrentPosition(
                                            desiredAccuracy:
                                            LocationAccuracy.high);
                                        print("position_of" + position.toString());
                                        lat = ' ${position.latitude} ';
                                        long = ' ${position.longitude}';

                                        print("position_of" +
                                            lat.toString() +
                                            " " +
                                            lat);
                                        setState(() {});
                                        // GetAddressFromLatLong(position);
                                        _getCurrentPosition();
                                      },
                                      child: const Text('Get Location')),*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: Clorinatorcategory,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Capture Point Location (Chlorinator) * ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Appcolor.lightgrey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Same as Source"),
                                          value: "SameasSourceChlorinator",
                                          groupValue:
                                              Capturepointotherscategory,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategory =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              isSameasSource = true;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Information Board"),
                                          value:
                                              "SameasInformationBoardclorinator",
                                          groupValue:
                                              Capturepointotherscategory,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategory =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              messagevisibility = false;
                                              selectschemesource = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Storage Structure"),
                                          value:
                                              "SameasStorageStructureclorinator",
                                          groupValue:
                                              Capturepointotherscategory,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategory =
                                                  value.toString();
                                              messagevisibility = false;
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              selectschemesource = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        /*  RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Mass Balancing Reservior (MBR)"),
                                          value: "MBR",
                                          groupValue: Capturepointotherscategory,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategory =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                            });
                                          },
                                        ),*/
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Get Geo Location"),
                                          value: "GetGeoLocationclorinator",
                                          groupValue:
                                              Capturepointotherscategory,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategory =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              selectschemesource = false;
                                              selectschemesourcemessage_mvc =
                                                  false;

                                              Getgeolocation_SIB = true;
                                              messagevisibility = false;
                                              isGetGeoLocatonlatlong = true;
                                              Takephotovisibility = true;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: PumphouseOthercategory,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Capture Point Location (Pump House) * ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Appcolor.lightgrey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Same as Source"),
                                          value: "SameasSourcePumpHouse",
                                          groupValue:
                                              Capturepointotherscategorypumphouse,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorypumphouse =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              SelectalreadytaggedsourceSIB =
                                                  true;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Information Board"),
                                          value:
                                              "SameasInformationBoardPumpHouse",
                                          groupValue:
                                              Capturepointotherscategorypumphouse,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorypumphouse =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              SelectalreadytaggedsourceSIB =
                                                  true;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Storage Structure"),
                                          value:
                                              "SameasStorageStructurePumpHouse",
                                          groupValue:
                                              Capturepointotherscategorypumphouse,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorypumphouse =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              SelectalreadytaggedsourceSIB =
                                                  true;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Get Geo Location"),
                                          value: "GetGeoLocationPumpHouse",
                                          groupValue:
                                              Capturepointotherscategorypumphouse,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorypumphouse =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: PumphouseOthercategorywatertreatment,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(0),
                            width: double.infinity,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Capture Point Location (Water Treatment Plan(WTP))* ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(
                                    height: 10,
                                    color: Appcolor.lightgrey,
                                    thickness: 1,
                                    // indent : 10,
                                    //endIndent : 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Appcolor.lightgrey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Same as Source"),
                                          value: "SameasSourcePumpHouse",
                                          groupValue:
                                              Capturepointotherscategorywatertreatment,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorywatertreatment =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              selectschemesource = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              messagevisibility = false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Information Board"),
                                          value:
                                              "SameasInformationBoardPumpHouse",
                                          groupValue:
                                              Capturepointotherscategorywatertreatment,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorywatertreatment =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              selectschemesource = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              messagevisibility = false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Storage Structure"),
                                          value:
                                              "SameasStorageStructurePumpHouse",
                                          groupValue:
                                              Capturepointotherscategorywatertreatment,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorywatertreatment =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Get Geo Location"),
                                          value: "GetGeoLocationPumpHouse",
                                          groupValue:
                                              Capturepointotherscategorywatertreatment,
                                          onChanged: (value) {
                                            setState(() {
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              messagevisibility = false;
                                              Capturepointotherscategorywatertreatment =
                                                  value.toString();
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: Othercategorymbr,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Capture Point Location (Mass Balancing Resorvoir (MBR))',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Divider(
                                    height: 10,
                                    color: Appcolor.lightgrey,
                                    thickness: 1,
                                    // indent : 10,
                                    //endIndent : 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Appcolor.lightgrey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Same as Source"),
                                          value: "SameasSourcembr",
                                          groupValue:
                                              Capturepointotherscategorymbr,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorymbr =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              isSameasSource = true;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Information Board"),
                                          value: "SameasInformationBoardmbr",
                                          groupValue:
                                              Capturepointotherscategorymbr,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorymbr =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              isSameasSource = true;
                                              messagevisibility = false;
                                              selectschemesource = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Storage Structure"),
                                          value: "SameasStorageStructurembr",
                                          groupValue:
                                              Capturepointotherscategorymbr,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorymbr =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              isSameasSource = true;
                                              messagevisibility = false;
                                              selectschemesource = false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Get Geo Location"),
                                          value: "geolocationothercategorymbr",
                                          groupValue:
                                              Capturepointotherscategorymbr,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorymbr =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              selectschemesource = false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              isSameasSource = false;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: Othercategorygrooundrechargewater,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Capture Point Location (Ground Water Recharge Structure) *',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Appcolor.lightgrey),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Same as Source"),
                                          value: "SameasSourcegroundrecharge",
                                          groupValue:
                                              Capturepointotherscategorygroundrecharge,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorygroundrecharge =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              isSameasSource = true;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Information Board"),
                                          value:
                                              "SameasInformationBoardgroundrecharge",
                                          groupValue:
                                              Capturepointotherscategorygroundrecharge,
                                          onChanged: (value) {
                                            setState(() {
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              Capturepointotherscategorygroundrecharge =
                                                  value.toString();
                                              isSameasSource = true;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text(
                                              "Same as Storage Structure"),
                                          value:
                                              "SameasStorageStructuregroundrecharge",
                                          groupValue:
                                              Capturepointotherscategorygroundrecharge,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorygroundrecharge =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              isSameasSource = true;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Get Geo Location"),
                                          value:
                                              "geolocationothercategorygroundrecharge",
                                          groupValue:
                                              Capturepointotherscategorygroundrecharge,
                                          onChanged: (value) {
                                            setState(() {
                                              Capturepointotherscategorygroundrecharge =
                                                  value.toString();
                                              ESR_Selectalreadytaggedsource =
                                                  false;
                                              selectschemesource = false;
                                              messagevisibility = false;
                                              selectschemesourcemessage_mvc =
                                                  false;
                                              selectschemesib = false;
                                              viewVisible = false;
                                              Habitaionsamesourcetext = false;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: geotaggedonlydropdown,
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 8, top: 5, right: 8, bottom: 5),
                        // color: Appcolor.white,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 10,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              5.0,
                            ), //                 <--- border radius here
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Select already tagged Source',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                height: 10,
                                color: Appcolor.lightgrey,
                                thickness: 1,
                                // indent : 10,
                                //endIndent : 10,
                              ),
                              Container(
                                margin: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: DropdownButton(
                                  // Initial Value
                                  isExpanded: true,
                                  value: selectlocation.toString(),
                                  isDense: true,

                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  dropdownColor: Colors.white,
                                  //drop down view
                                  underline: const SizedBox(),
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  // Array list of items
                                  items: ListExistingsource_location.map(
                                      (dynamic? items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (dynamic? newValue) {
                                    setState(() {
                                      selectlocation = newValue!.toString();
                                      print("valueofselect" +
                                          Existingsource_habitaionid!
                                              .toString()
                                              .toString());

                                      selectschemesib = false;
                                      viewVisible = false;
                                      selectschemesource = false;
                                      selectschemesourcemessage_mvc = false;

                                      Habitaionsamesourcetext = true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                        visible: Habitaionsamesourcetext,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8, top: 5, right: 8, bottom: 5),
                              // color: Appcolor.white,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 10,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    5.0,
                                  ), //                 <--- border radius here
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Habitaion',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Divider(
                                      height: 10,
                                      color: Appcolor.lightgrey,
                                      thickness: 1,
                                      // indent : 10,
                                      //endIndent : 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8.0),
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                        height: 40,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color: const Color(0xffbFFFDE5),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          Existingsource_HabitationName
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8, top: 5, right: 8, bottom: 5),
                              // color: Appcolor.white,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 10,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    5.0,
                                  ), //                 <--- border radius here
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Scheme',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Divider(
                                      height: 10,
                                      color: Appcolor.lightgrey,
                                      thickness: 1,
                                      // indent : 10,
                                      //endIndent : 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8.0),
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                        height: 40,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color: const Color(0xffbFFFDE5),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          selectschamename.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
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
                              padding: const EdgeInsets.all(7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Geotagged of Information Board bbb',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
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
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 15, right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Text(
                                          'Latitute',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _getCurrentPosition();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              color: const Color(0xffbFFFDE5),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              ' ${_currentPosition?.latitude ?? ""}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'Longitude',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _getCurrentPosition();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              color: const Color(0xffbfffde5),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              ' ${_currentPosition?.longitude ?? ""}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),

                    Visibility(
                      visible: SelectalreadytaggedsourceSIB,
                      child: Container(
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
                          child: Container(
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  width: 2,
                                                  color:
                                                      Appcolor.COLOR_PRIMARY),
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            margin: const EdgeInsets.only(
                                                left: 0, top: 10),
                                            width: 260,
                                            height: 200,
                                            child: const Image(
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 2,
                                                color: Appcolor.COLOR_PRIMARY),
                                          ),
                                          padding: const EdgeInsets.all(3),
                                          margin: const EdgeInsets.only(
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
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextButton(
                                      onPressed: () {

                                        openCamera();
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
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: 40,
                                    width: 200,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF0D3A98),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TextButton(
                                      onPressed: () {
                                        if (samesourcesib == "1") {
                                          if (getclickedstatus.toString() ==
                                              "") {
                                            print("chhr");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please select  source")));
                                          }
                                          /*else if (locationlandmarkcontroller.text
                                              .trim()
                                              .toString()
                                              .isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please enter location/landmark")));
                                          }*/
                                          else if (imgFile == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please select image")));
                                          } else {
                                            /* box.read("userid").toString();
                                            //box.read("UserToken").toString() ;

                                            widget.villageid;

                                            box.read("stateid");
                                            _mySchemeid;
                                            // widget.SourceId,
                                            getclickedstatus;
                                            "0";
                                            box.read("DivisionId").toString();
                                            selecthabitaionid.toString();



                                            locationlandmarkcontroller.text
                                                .toString();

                                            _currentPosition!.latitude.toString();
                                            _currentPosition!.longitude.toString();
                                            "0";
                                            base64Image;*/

                                            /* print("token >" +
                                                box.read("UserToken").toString());
                                            print("userid >" +
                                                box.read("userid").toString());
                                            print("villageid >" + widget.villageid);
                                            print("assettaggingid >" +
                                                getclickedstatus);
                                            print("stateid >" + box.read("stateid"));
                                            print("schemeid >" + _mySchemeid);
                                            print("divisionid >" +
                                                box.read("DivisionId").toString());
                                            print("divisionid >" +
                                                selecthabitaionid.toString());
                                            print(
                                                "sourcetypeid >" + getclickedstatus);

                                            print("samesourcesib >" +
                                                samesourcesib.toString());
                                            print("nanmark >" +
                                                locationlandmarkcontroller.text
                                                    .toString());
                                            print("latitute >" +
                                                _currentPosition!.latitude
                                                    .toString());
                                            print("longitue >" +
                                                _currentPosition!.longitude
                                                    .toString());*/

                                            Apiservice.SIBSavetaggingapi(
                                                    context,
                                                    box
                                                        .read("UserToken")
                                                        .toString(),
                                                    box
                                                        .read("userid")
                                                        .toString(),
                                                    widget.villageid,
                                                    samesourcesib.toString(),
                                                    box.read("stateid"),
                                                    Existingsource_SchemeId,
                                                    getclickedstatus,
                                                    box
                                                        .read("DivisionId")
                                                        .toString(),
                                                    Existingsource_habitaionid
                                                        .toString(),
                                                    locationlandmarkcontroller
                                                        .text
                                                        .toString(),
                                                    _currentPosition!.latitude
                                                        .toString(),
                                                    _currentPosition!.longitude
                                                        .toString(),
                                                    "0",
                                                    base64Image)
                                                .then((value) {
                                              Get.back();
                                              if (value["Status"].toString() ==
                                                  "false") {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            value["msg"]
                                                                .toString())));
                                              } else if (value["Status"]
                                                      .toString() ==
                                                  "true") {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            value["msg"]
                                                                .toString())));
                                              }
                                            });
                                          }
                                        } else {
                                          if (getclickedstatus.toString() ==
                                              "") {
                                            print("chhr");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please select  source")));
                                          } else if (_mySchemeid.toString() ==
                                              "-- Select Scheme --") {
                                            print("chhr");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please select  Scheme")));
                                          } else if (selecthabitaionname
                                                  .toString() ==
                                              "-- Select Habitaion --") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please select habitaion")));
                                          } else if (locationlandmarkcontroller
                                              .text
                                              .trim()
                                              .toString()
                                              .isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please enter location/landmark")));
                                          } else if (imgFile == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Please select image")));
                                          } else {
                                            box.read("userid").toString();
                                            //box.read("UserToken").toString() ;

                                            widget.villageid;

                                            box.read("stateid");
                                            _mySchemeid;
                                            // widget.SourceId,
                                            getclickedstatus;
                                            "0";
                                            box.read("DivisionId").toString();
                                            selecthabitaionid.toString();
                                            locationlandmarkcontroller.text
                                                .toString();

                                            _currentPosition!.latitude
                                                .toString();
                                            _currentPosition!.longitude
                                                .toString();
                                            "0";
                                            base64Image;

                                            Apiservice.SIBSavetaggingapi(
                                                    context,
                                                    box
                                                        .read("UserToken")
                                                        .toString(),
                                                    box
                                                        .read("userid")
                                                        .toString(),
                                                    widget.villageid,
                                                    samesourcesib.toString(),
                                                    box.read("stateid"),
                                                    _mySchemeid,
                                                    getclickedstatus,
                                                    box
                                                        .read("DivisionId")
                                                        .toString(),
                                                    selecthabitaionid
                                                        .toString(),
                                                    locationlandmarkcontroller
                                                        .text
                                                        .toString(),
                                                    _currentPosition!.latitude
                                                        .toString(),
                                                    _currentPosition!.longitude
                                                        .toString(),
                                                    "0",
                                                    base64Image)
                                                .then((value) {
                                              Get.back();
                                              if (value["Status"].toString() ==
                                                  "false") {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            value["msg"]
                                                                .toString())));
                                              } else if (value["Status"]
                                                      .toString() ==
                                                  "true") {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            value["msg"]
                                                                .toString())));
                                              }
                                            });
                                          }
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
                    ),

                    Visibility(
                      visible: isSameasSource,
                      child: Container(
                        /*  decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(7.0),*/
                        width: double.infinity,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select already tagged Source',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black54),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                            color: Colors.black, width: 1.5),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: DropdownButton(
                                      // Initial Value
                                      isExpanded: true,
                                      value: dropdownvalue2,
                                      isDense: true,
                                      hint: const Text(
                                        '--Select Scheme--',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      dropdownColor: Colors.white,
                                      //drop down view
                                      underline: const SizedBox(),
                                      // Down Arrow Icon
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      // Array list of items
                                      items: items2.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue2 = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 200,
                                width: 400,
                                padding: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    _image != null
                                        ? Image.file(
                                            _image!,
                                            width: 500,
                                            height: 117,
                                          )
                                        : InkWell(
                                            onTap: () {},
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.asset(
                                                  'images/camera.png',
                                                  width: 100.0,
                                                  height: 100.0),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Center(
                                      child: Container(
                                        height: 40,
                                        width: 200,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF0D3A98),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: TextButton(
                                          onPressed: () {

                                            openCamera();
                                          },
                                          child: const Text(
                                            'Take Photo ff',
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
                            Center(
                              child: Container(
                                height: 40,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF0D3A98),
                                    borderRadius: BorderRadius.circular(8)),
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Saved Successfully "),
                                    ));
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



                    Visibility(

                        visible: selectschemesourcemessage_mvc,
                        child: Container(
                          margin: const EdgeInsets.all(2),
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
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    //"Details of PWS source mvc:",
                                    "Details of PWS source :",
                                    style: TextStyle(
                                        color: Appcolor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                const Divider(
                                  height: 10,
                                  color: Colors.grey,
                                  thickness: 1,
                                  // indent : 10,
                                  //endIndent : 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                               Visibility(
                                 visible: messagenowatersourcecontactofc,

                                 child:  Center(
                                   child: Container(
                                     decoration: BoxDecoration(
                                       color: Appcolor.lightyello,
                                       border: Border.all(
                                         color: Appcolor.red,
                                         width: 1,
                                       ),
                                       borderRadius: const BorderRadius.all(
                                         Radius.circular(
                                           5.0,
                                         ), //                 <--- border radius here
                                       ),
                                     ),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment: CrossAxisAlignment.start,


                                       children: [
                                         const Padding(
                                           padding: EdgeInsets.all(8.0),
                                           child: Text(
                                             maxLines:3,
                                             "Alert! Till date no water source entry has been \ndone for this scheme. Kindly contact to your \ndivision officer.",
                                             style: TextStyle(
                                                 fontWeight: FontWeight.w400,
                                                 fontSize: 14,
                                                 color: Appcolor.black),
                                           ),
                                         )
                                         ,Material(
                                           child: InkWell(
                                             splashColor: Appcolor.grey,
                                             onTap: () {
                                           
                                               setState(() {
                                                 messagenowatersourcecontactofc=false;
                                               });
                                           
                                             },
                                             child: const Padding(
                                               padding: EdgeInsets.all(5.0),
                                               child: Icon(Icons.close_rounded, color: Appcolor.red,),
                                             ),
                                           ),
                                         )
                                       ]
                                       ,
                                     ),
                                   )),),

                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                          itemCount:
                                              Listdetaillistofscheme.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            selectscheme_addnewsourcebtn =
                                                Listdetaillistofscheme[index]
                                                    ["SchemeName"];
                                            selecthabitation_addnewsourcebtn =
                                                Listdetaillistofscheme[index]
                                                    ["HabitationName"];
                                            selectlocationlanmark_addnewsourcebtn =
                                                Listdetaillistofscheme[index]
                                                    ["location"];
                                            villageid_addnewsourcebtn =
                                                widget.villageid;
                                            assettaggingid_addnewsourcebtn =
                                                Listofsourcetype[index]["Id"]
                                                    .toString();
                                            StateId_addnewsourcebtn =
                                                box.read("stateid").toString();
                                            schemeid_addnewsourcebtn =
                                                _mySchemeid;
                                            SourceId_addnewsourcebtn =
                                                Listdetaillistofscheme[index]
                                                        ["SourceId"]
                                                    .toString();
                                            HabitationId_addnewsourcebtn =
                                                Listdetaillistofscheme[index]
                                                        ["HabitationId"]
                                                    .toString();
                                            SourceTypeId_addnewsourcebtn =
                                                Listdetaillistofscheme[index]
                                                        ["SourceTypeId"]
                                                    .toString();
                                            SourceTypeCategoryId_addnewsourcebtn =
                                                Listdetaillistofscheme[index]
                                                        ["SourceTypeCategoryId"]
                                                    .toString();
                                            villagename_addnewsourcebtn =
                                                widget.villagename;
                                            latitute_addnewsourcebtn =
                                                _currentPosition?.latitude;
                                            longitute_addnewsourcebtn =
                                                _currentPosition?.longitude;

                                            return Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5, top: 5),
                                                  child: Column(
                                                    children: [
                                                      Material(
                                                        elevation: 4,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: InkWell(
                                                          splashColor: Appcolor
                                                              .splashcolor,
                                                          onTap: () {},
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius: const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            5.0) //                 <--- border radius here
                                                                        ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Appcolor
                                                                          .lightgrey,
                                                                    )),
                                                            child: Container(
                                                              margin: const EdgeInsets
                                                                  .all(10),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Listdetaillistofscheme[index]["IsApprovedState"].toString() ==
                                                                              "0"
                                                                          ? const SizedBox()
                                                                          : const Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(1.0),
                                                                                child: Text(
                                                                                  "Verified by State",
                                                                                  style: TextStyle(color: Appcolor.greenmessagecolor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Listdetaillistofscheme[index]["IsApprovedState"].toString() == "0" &&
                                                                              Listdetaillistofscheme[index]["ExistTagWaterSourceId"].toString() != "0"
                                                                          ? Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: ElevatedButton(
                                                                                onPressed: () {},
                                                                                child: const Text(
                                                                                  'Untag source location',
                                                                                  style: TextStyle(color: Appcolor.white, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: Appcolor.pink,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(12), // <-- Radius
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : const SizedBox()
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Padding(
                                                                        padding: EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              117,
                                                                          child:
                                                                              Text(
                                                                            "Source location/landmark :",
                                                                            maxLines:
                                                                                10,
                                                                            style: TextStyle(
                                                                                color: Appcolor.btncolor,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            maxLines:
                                                                                4,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            Listdetaillistofscheme[index]["location"].toString(),
                                                                            style: const TextStyle(
                                                                                color: Appcolor.btncolor,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 16),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Divider(
                                                                    height: 10,
                                                                    color: Appcolor
                                                                        .lightgrey,
                                                                    thickness:
                                                                        1,
                                                                    // indent : 10,
                                                                    //endIndent : 10,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            117,
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets
                                                                              .all(
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            "Source Category :",
                                                                            style: TextStyle(
                                                                                color: Appcolor.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                        child:
                                                                            Text(
                                                                          Listdetaillistofscheme[index]
                                                                              [
                                                                              "SourceTypeCategory"],
                                                                          style: const TextStyle(
                                                                              color: Appcolor.black,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            117,
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets
                                                                              .all(
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            "Source Type :",
                                                                            style: TextStyle(
                                                                                color: Appcolor.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                        child:
                                                                            Text(
                                                                          Listdetaillistofscheme[index]
                                                                              [
                                                                              "SourceType"],
                                                                          style: const TextStyle(
                                                                              color: Appcolor.black,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Listdetaillistofscheme[index]["Latitude"] ==
                                                                              0 ||
                                                                          Listdetaillistofscheme[index]["Longitude"] ==
                                                                              0
                                                                      ? const SizedBox()
                                                                      : Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 117,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "Habitation :",
                                                                                  style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Text(
                                                                                Listdetaillistofscheme[index]["HabitationName"],
                                                                                style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  Listdetaillistofscheme[index]["Latitude"] ==
                                                                              0 ||
                                                                          Listdetaillistofscheme[index]["Longitude"] ==
                                                                              0
                                                                      ? const SizedBox()
                                                                      : Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 117,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "Location :",
                                                                                  style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  maxLines: 4,
                                                                                  Listdetaillistofscheme[index]["location"].toString(),
                                                                                  style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  Listdetaillistofscheme[index]["IsApprovedState"].toString() ==
                                                                              "0" &&
                                                                          Listdetaillistofscheme[index]["ExistTagWaterSourceId"].toString() !=
                                                                              "0"
                                                                      ? Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 117,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "Latitude :",
                                                                                  style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Text(
                                                                                Listdetaillistofscheme[index]["Latitude"].toString(),
                                                                                style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : const SizedBox(),
                                                                  Listdetaillistofscheme[index]["IsApprovedState"].toString() ==
                                                                              "0" &&
                                                                          Listdetaillistofscheme[index]["ExistTagWaterSourceId"].toString() !=
                                                                              "0"
                                                                      ? Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 117,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "Longitude :",
                                                                                  style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Text(
                                                                                Listdetaillistofscheme[index]["Longitude"].toString(),
                                                                                style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : const SizedBox(),
                                                                  const Divider(
                                                                    height: 10,
                                                                    color: Appcolor
                                                                        .lightgrey,
                                                                    thickness:
                                                                        1,
                                                                    // indent : 10,
                                                                    //endIndent : 10,
                                                                  ),
                                                                  Align(
                                                                    // foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    //ExistTagWaterSourceId
                                                                    child: Listdetaillistofscheme[index]["ExistTagWaterSourceId"].toString() ==
                                                                                "0" &&
                                                                            Listdetaillistofscheme[index]["IsApprovedState"].toString() ==
                                                                                "0"
                                                                        ? ElevatedButton(
                                                                            style:
                                                                                ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: const BorderSide(color: Colors.red)))),
                                                                            onPressed: () {
                                                                              Get.to(NewTagScreen(selectscheme: Listdetaillistofscheme[index]["SchemeName"], selecthabitation: Listdetaillistofscheme[index]["HabitationName"], selectlocationlanmark: Listdetaillistofscheme[index]["location"], villageid: widget.villageid, assettaggingid: Listofsourcetype[index]["Id"].toString(), StateId: box.read("stateid").toString(), schemeid: _mySchemeid, SourceId: Listdetaillistofscheme[index]["SourceId"].toString(), HabitationId: Listdetaillistofscheme[index]["HabitationId"].toString(), SourceTypeId: Listdetaillistofscheme[index]["SourceTypeId"].toString(), SourceTypeCategoryId: Listdetaillistofscheme[index]["SourceTypeCategoryId"].toString(), villagename: widget.villagename));
                                                                            },
                                                                            child: const Text("Proceed and tag"))
                                                                        : const SizedBox(),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      /*  selectcategoryname == "svs"
                                                          ? ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    Colors.purple,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 30,
                                                                        vertical: 10),
                                                              ),
                                                              onPressed: () {
                                                                Get.to(
                                                                    AddNewSourceScreen(
                                                                  selectscheme: Listdetaillistofscheme[index]["SchemeName"],
                                                                  selecthabitation: Listdetaillistofscheme[index]["HabitationName"],
                                                                  selectlocationlanmark: Listdetaillistofscheme[index]["location"],
                                                                  villageid: widget.villageid,
                                                                  assettaggingid: Listofsourcetype[index]["Id"].toString(),
                                                                  StateId: box.read("stateid").toString(),
                                                                  schemeid: _mySchemeid,
                                                                      SourceId: Listdetaillistofscheme[index]["SourceId"].toString(),
                                                                  HabitationId: Listdetaillistofscheme[index]["HabitationId"].toString(),
                                                                  SourceTypeId: Listdetaillistofscheme[index]["SourceTypeId"].toString(),
                                                                  SourceTypeCategoryId: Listdetaillistofscheme[index]["SourceTypeCategoryId"].toString(),
                                                                  villagename: widget.villagename,
                                                                  latitute: _currentPosition?.latitude,
                                                                  longitute: _currentPosition?.longitude,

                                                                ));

                                                                */ /*  if(Listdetaillistofscheme.length>0){
                                                              showuntagedalertbox( Listdetaillistofscheme[index]["SchemeName"].toString(),Listdetaillistofscheme[index]["HabitationName"].toString(),
                                                                Listdetaillistofscheme[index]["location"].toString(),widget.villageid,Listofsourcetype[index]["Id"].toString(),box.read("stateid").toString(),

                                                                _mySchemeid,Listdetaillistofscheme[index]["SourceId"].toString(),Listdetaillistofscheme[index]["HabitationId"].toString(),
                                                                Listdetaillistofscheme[index]["SourceTypeId"].toString(),Listdetaillistofscheme[index]["SourceTypeCategoryId"].toString(),widget.villagename.toString(),
                                                                _currentPosition!.latitude.toDouble(),_currentPosition!.longitude.toDouble(),
                                                              );
                                                            }else{
                                                              Get.to(
                                                                  AddNewSourceScreen(
                                                                    selectscheme: Listdetaillistofscheme[index]["SchemeName"],
                                                                    selecthabitation: Listdetaillistofscheme[index]["HabitationName"],

                                                                    selectlocationlanmark: Listdetaillistofscheme[index]["location"],
                                                                    villageid: widget.villageid,
                                                                    assettaggingid: Listofsourcetype[index]["Id"].toString(),

                                                                    StateId: box.read("stateid").toString(),
                                                                    schemeid: _mySchemeid,
                                                                    SourceId: Listdetaillistofscheme[index]["SourceId"].toString(),

                                                                    HabitationId: Listdetaillistofscheme[index]["HabitationId"].toString(),
                                                                    SourceTypeId: Listdetaillistofscheme[index]["SourceTypeId"].toString(),
                                                                    SourceTypeCategoryId: Listdetaillistofscheme[index]["SourceTypeCategoryId"].toString(),

                                                                    villagename:widget.villagename,
                                                                    latitute:_currentPosition?.latitude,
                                                                    longitute:_currentPosition?.longitude,)

                                                              );
                                                            }*/ /*
                                                              },
                                                              child: Text(
                                                                "Add New Source & Geo-tag",
                                                                style: TextStyle(
                                                                    color:
                                                                        Appcolor.white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ))
                                                          : SizedBox()*/
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                      selectcategoryname == "svs"
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.purple,
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 10),
                                              ),
                                              onPressed: () {
                                                Get.to(AddNewSourceScreen(


                                                    selectscheme:
                                                        selectscheme_addnewsourcebtn,
                                                    selecthabitation:
                                                        selecthabitation_addnewsourcebtn,
                                                    selectlocationlanmark:
                                                        selectlocationlanmark_addnewsourcebtn,
                                                    villageid:
                                                        villageid_addnewsourcebtn,
                                                    assettaggingid:
                                                        assettaggingid_addnewsourcebtn,
                                                    StateId:
                                                        StateId_addnewsourcebtn,
                                                    schemeid:
                                                        schemeid_addnewsourcebtn,
                                                    SourceId:
                                                        SourceId_addnewsourcebtn,
                                                    HabitationId:
                                                        HabitationId_addnewsourcebtn,
                                                    SourceTypeId:
                                                        SourceTypeId_addnewsourcebtn,
                                                    SourceTypeCategoryId:
                                                        SourceTypeCategoryId_addnewsourcebtn,
                                                    villagename:
                                                        villagename_addnewsourcebtn,
                                                    latitute:
                                                        latitute_addnewsourcebtn,
                                                    longitute:
                                                        longitute_addnewsourcebtn));
                                              },
                                              child: const Text(
                                                "Add New Source & Geo-tag",
                                                style: TextStyle(
                                                    color: Appcolor.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                                selectcategoryname == "mvs"   ?
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      messagevisibility = true;
                                    });
                                  },
                                  child: Center(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                5.0,
                                              ), //                 <--- border radius here
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              messageofscheme_mvs.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Appcolor.orange),
                                            ),
                                          ))),
                                ): const SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                    visible: messagevisibility,
                                    child: Container(
                                      // margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Appcolor.white,
                                        border: Border.all(
                                          color: Colors.red ,
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
                                        Row(
                                          children: [
                                      const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        "List of water source already exists in other \nvillages & attached to selected scheme",
                                        style: TextStyle(
                                            color: Appcolor.btncolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                    ,Material(
                                child: InkWell(
                                splashColor: Appcolor.grey,
                                    onTap: () {

                        setState(() {
                          messagevisibility=false;
                        });

                        },
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.close_rounded, color: Appcolor.red,),
                          ),
                        ),)
                                          ],
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
                                                itemCount:
                                                    Listdetaillistofscheme_mvs
                                                        .length,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(
                                                            bottom: 5, top: 5),
                                                        child: Column(
                                                          children: [
                                                            Material(
                                                              elevation: 4,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child: InkWell(
                                                                splashColor:
                                                                    Appcolor
                                                                        .splashcolor,
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .all(
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Listdetaillistofscheme_mvs[index]["IsApprovedState"].toString() == "0"
                                                                                ? const SizedBox()
                                                                                : const Align(
                                                                                    alignment: Alignment.centerRight,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(1.0),
                                                                                      child: Text(
                                                                                        "Verified by State",
                                                                                        style: TextStyle(color: Appcolor.greenmessagecolor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Listdetaillistofscheme_mvs[index]["IsApprovedState"].toString() == "0" && Listdetaillistofscheme_mvs[index]["ExistTagWaterSourceId"].toString() != "0"
                                                                                ? Align(
                                                                                    alignment: Alignment.centerRight,
                                                                                    child: ElevatedButton(
                                                                                      onPressed: () {},
                                                                                      child: const Text(
                                                                                        'Untag source location',
                                                                                        style: TextStyle(color: Appcolor.white, fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                      style: ElevatedButton.styleFrom(
                                                                                        backgroundColor: Appcolor.pink,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(12), // <-- Radius
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : const SizedBox()
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const Padding(
                                                                              padding: EdgeInsets.all(5.0),
                                                                              child: SizedBox(
                                                                                width: 117,
                                                                                child: Text(
                                                                                  "Source location/landmark :",
                                                                                  maxLines: 10,
                                                                                  style: TextStyle(color: Appcolor.btncolor, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  maxLines: 4,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  Listdetaillistofscheme_mvs[index]["location"].toString(),
                                                                                  style: const TextStyle(color: Appcolor.btncolor, fontWeight: FontWeight.w400, fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const Divider(
                                                                          height:
                                                                              10,
                                                                          color:
                                                                              Appcolor.lightgrey,
                                                                          thickness:
                                                                              1,
                                                                          // indent : 10,
                                                                          //endIndent : 10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 117,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "District:",
                                                                                  style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Text(
                                                                                Listdetaillistofscheme_mvs[index]["DistrictName"],
                                                                                style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 117,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "Block :",
                                                                                  style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Text(
                                                                                Listdetaillistofscheme_mvs[index]["BlockName"],
                                                                                style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 117,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "Panchayat :",
                                                                                  style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Text(
                                                                                Listdetaillistofscheme_mvs[index]["PanchayatName"],
                                                                                style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 117,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  "Village :",
                                                                                  style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: Text(
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  maxLines: 4,
                                                                                  Listdetaillistofscheme_mvs[index]["VillageName"].toString(),
                                                                                  style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Listdetaillistofscheme_mvs[index]["IsApprovedState"].toString() == "0" &&
                                                                                Listdetaillistofscheme_mvs[index]["ExistTagWaterSourceId"].toString() != "0"
                                                                            ? Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 117,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(5.0),
                                                                                      child: Text(
                                                                                        "Latitude :",
                                                                                        style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                    child: Text(
                                                                                      Listdetaillistofscheme_mvs[index]["Latitude"].toString(),
                                                                                      style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : const SizedBox(),
                                                                        Listdetaillistofscheme_mvs[index]["IsApprovedState"].toString() == "0" &&
                                                                                Listdetaillistofscheme_mvs[index]["ExistTagWaterSourceId"].toString() != "0"
                                                                            ? Row(
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    width: 117,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.all(5.0),
                                                                                      child: Text(
                                                                                        "Longitude :",
                                                                                        style: TextStyle(color: Appcolor.black, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                    child: Text(
                                                                                      Listdetaillistofscheme_mvs[index]["Longitude"].toString(),
                                                                                      style: const TextStyle(color: Appcolor.black, fontWeight: FontWeight.w400, fontSize: 16),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            : const SizedBox(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showuntagedalertbox(
      String selectscheme,
      String selecthabitation,
      String selectlocationlanmark,
      String villageid,
      String assettaggingid,
      String StateId,
      String schemeid,
      String SourceId,
      String HabitationId,
      String SourceTypeId,
      String SourceTypeCategoryId,
      String villagename,
      double latitute,
      double longitute) async {
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
                  "This scheme already has PWS source.Do you want to add a new source?",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                            AddNewSourceScreen(
                                selectscheme: selectscheme,
                                selecthabitation: selecthabitation,
                                selectlocationlanmark: selectlocationlanmark,
                                villageid: villageid,
                                assettaggingid: assettaggingid,
                                StateId: StateId,
                                schemeid: schemeid,
                                SourceId: SourceId,
                                HabitationId: HabitationId,
                                SourceTypeId: SourceTypeId,
                                SourceTypeCategoryId: SourceTypeCategoryId,
                                villagename: villagename,
                                latitute: _currentPosition?.latitude,
                                longitute: _currentPosition?.longitude);

                            Navigator.of(context).pop(false);
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
