import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaljeevanmissiondynamic/apiservice/Apiservice.dart';
import '../utility/Appcolor.dart';
import 'LoginScreen.dart';
class NewTagScreen extends StatefulWidget {

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
   NewTagScreen({required this.selectscheme ,required this.selecthabitation ,required this.selectlocationlanmark ,required this.villageid ,
     required this.assettaggingid ,  required this.StateId , required this.schemeid ,required this.SourceId ,
     required this.HabitationId ,  required this.SourceTypeId , required this.SourceTypeCategoryId ,required this.villagename ,
     /*required this.selectlatitude ,  required this.selectlongitude */ super.key});

  @override
  State<NewTagScreen> createState() => _NewTagState();
}

class _NewTagState extends State<NewTagScreen> {
  CroppedFile? croppedFile;
  File? _image;
  String? getselectscheme;
  String? getselecthabitation;
  String? getselectlocationlanmark;
  String? getselectlatitude;
  String? getselectlongitude;
  String? getvillageid;
  String? stateid;
  String? getassettaggingid;
  TextEditingController locationlandmarkcontroller =TextEditingController();
  TextEditingController latcontroller =TextEditingController();
  TextEditingController longcontroller =TextEditingController();


  String? getstateid;
  String? gender;
  String dropdownvalue2 = 'Item 6';
  // Initial Selected Value
  String dropdownvalue = 'Item 1';
  bool capturepointlocation = true;
  bool sourcevisible = false;
  bool selectschemesource = false;
  GetStorage box = GetStorage();

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String fileNameofimg = "";
  String imagepath = "";
  File? imgFile;
  final imgPicker = ImagePicker();
  String? _currentAddress;
  Position? _currentPosition;
  String base64Image="";
  List<int> imageBytes=[];


  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("position_of" +position.toString());
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position



      );
    }).catchError((e) {
      debugPrint(e);
    });
  }


  Future<void> _cropImage() async {
    if (imgFile != null) {
      croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 400,
              height: 420,
            ),
            viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          imgFile = File(croppedFile!.path);

          FileConverter.getBase64FormateFile(croppedFile!.path);
        });
      }
    }
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
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
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
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

    _getCurrentPosition();
  getstateid =  widget.StateId.toString();
  getselectscheme =  widget.selectscheme;
    getselecthabitation =  widget.selecthabitation;
    getselectlocationlanmark =  widget.selectlocationlanmark;
    getselectlatitude =  widget.selectlatitude;
    getselectlongitude =  widget.selectlongitude;
    print("getselectlatitude"+getselectlatitude.toString());

    setState(() {
      locationlandmarkcontroller.text = getselectlocationlanmark.toString();
     /* latcontroller.text = getselectlatitude.toString();
      longcontroller.text = getselectlongitude.toString();*/
    });

  }

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );


    setState(() {
      imgFile = File(imgCamera!.path);

      imagepath = imgCamera.path;
      final File file = File(imgCamera!.path);
      //  compressFile(_file);
      print("filepath_crop>>> " + imagepath);
    //  _cropImage();
      final bytes = file.readAsBytesSync().lengthInBytes;

      final kb = bytes / 1024;
      final mb = kb / 1024;

      fileNameofimg = file.path.split('/').last;
      imgFile != null
          ? 'data:image/png;base64,' + base64Encode(imgFile!.readAsBytesSync())
          : "";

      imageBytes = imgFile!.readAsBytesSync();
       base64Image = base64Encode(imageBytes);
  print("image64" +base64Image);
    });



   /* imgFile = File(imgCamera!.path);
    imagepath = imgCamera.path;
    final File _file = File(imgCamera!.path);
      String _imagePath = imagepath;
      File _imageFile = File(_imagePath);

      // Read bytes from the file object
      Uint8List _bytes = await _imageFile.readAsBytes();

      // base64 encode the bytes
      String _base64String = base64.encode(_bytes);
      setState(() {
        base64Image = _base64String;
        print("nayati" +base64Image);
      });*/

    //Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:const Color(0xFF0D3A98),
          iconTheme: const IconThemeData(
            color: Appcolor.white,
          ),
          title: const Text("Tag Water Source",style: TextStyle(color: Colors.white) ),),
        body: Container(

          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/header_bg.png'), fit: BoxFit.cover),
          ),
          child: FocusDetector(
            onVisibilityGained: (){

      setState(() {

      });

            },

            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Image.asset('images/bharat.png', // Replace with your logo file path
                                width: 60, // Adjust width and height as needed
                                height: 60,
                              ),
                            ),

                            Container(
                              child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Jal Jeevan Mission', style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
                                  Text('Department of Drinking Water and Sanitation', style: TextStyle(color: Colors.black, fontSize: 12,),),
                                  Text('Ministry of Jal Shakti',style: TextStyle(color: Colors.black, fontSize: 12),),
                                ],
                              ),
                            ),
                          ],
                        ),


                        InkWell(
                          onTap: () {
                            showDialog( context: context, builder: (context) {
                              return Container(
                                padding: const EdgeInsets.only(top: 50),
                                child: AlertDialog(
                                  title:  Text(box.read("username")),
                                  actions: [
                                    TextButton(onPressed: () {
                                      box.remove("UserToken");
                                      box.remove('loginBool');
                                      Get.off(LoginScreen());
                                    }, child: const Text('Sign Out'))
                                  ],
                                ),
                              );
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset('images/profile.png', width: 50.0, height: 50.0),),
                        ),
                      ],

                    ),

                    const SizedBox(height: 20,),

                     Align(
                        alignment: Alignment.topLeft ,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Village : "+widget.villagename,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Appcolor.headingcolor),),
                        )),




                    // scheme
                    const SizedBox(height: 5,),

                    Visibility(

                      visible: capturepointlocation,
                      child: Container(
                      //  color:Appcolor.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [


                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text("Selected scheme :",
                                          maxLines:4,
                                          style: TextStyle(color: Appcolor.black , fontWeight: FontWeight.bold , fontSize: 16),),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SizedBox(
                                //'${Apiservice.baseurl}
                                        child: Text( '${getselectscheme}',
                                          maxLines:10, style: const TextStyle(color: Appcolor.black , fontWeight: FontWeight.w400 , fontSize: 14),),
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
                                        child: Text("Location of PWS source:",
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
                                        child: Text("Habitation",
                                          maxLines:4,
                                          style: TextStyle(color: Appcolor.black , fontWeight: FontWeight.bold , fontSize: 14),),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Appcolor.yellow,
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
                                          child: Text('${getselecthabitation}',
                                            maxLines:4,
                                            style: const TextStyle(color: Appcolor.grey , fontWeight: FontWeight.w400 , fontSize: 14),),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text("Source location/landmark",
                                          maxLines:4,
                                          style: TextStyle(color: Appcolor.grey , fontWeight: FontWeight.bold , fontSize: 14),),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      width: double.infinity,
                                      height: 45,
                                      child: TextFormField(
                                        controller: locationlandmarkcontroller,
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          hintText: '${getselectlocationlanmark}',
                                        ),
                                        keyboardType: TextInputType.visiblePassword,
                                        textInputAction: TextInputAction.done,

                                      ),
                                    ),

                                  ],
                                ),
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
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Appcolor.yellow,
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
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Appcolor.yellow,
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
                                  ],
                                ),
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
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Appcolor.COLOR_PRIMARY),
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            margin: const EdgeInsets.only(left: 0, top: 10),
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
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 2,
                                                color: Appcolor.COLOR_PRIMARY),
                                                                                ),
                                                                                padding: const EdgeInsets.all(3),
                                                                                margin: const EdgeInsets.only(left: 10, top: 10),
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
                                             /* showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                      margin:
                                                      const EdgeInsets.all(10),
                                                      padding: const EdgeInsets.only(
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
                                              if(locationlandmarkcontroller.text.toString().isEmpty){
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    content: Text("Please enter source location/landmark")));
                                              } else if(_currentPosition!.latitude.toString().isEmpty){
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    content: Text("Please enter latitute")));

                                              } else if(_currentPosition!.longitude.toString().isEmpty){
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    content: Text("Please enter longitude")));

                                              }


                                              else if(imgFile==null){
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    content: Text("Please select image")));

                                              }

                                              else{



                                                Apiservice.PWSSourceSavetaggingapi(context ,
                                                    box.read("UserToken").toString() ,
                                                    box.read("userid").toString() ,
                                                    widget.villageid,
                                                    widget.assettaggingid,
                                                    getstateid.toString(),
                                                    widget.schemeid,

                                                    widget.SourceId,
                                                    box.read("DivisionId").toString() ,
                                                    widget.HabitationId,
                                                    widget.SourceTypeId,
                                                    widget.SourceTypeCategoryId,
                                                    getselectlocationlanmark.toString(),
                                                      _currentPosition!.latitude.toString(),
                                                       _currentPosition!.longitude.toString(),


                                                    //FileConverter.getBase64FormateFile(croppedFile!.path),
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




                  ],
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }

}

class FileConverter {
  static String getBase64FormateFile(String path) {
    File file = File(path);
    print('File is = ' + file.toString());
    print('path is = ' + path.toString());
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    print("filebase64-> " +fileInBase64);

    return fileInBase64;
  }
}