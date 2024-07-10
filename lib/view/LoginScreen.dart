import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jaljeevanmissiondynamic/view/OTPScreen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:jaljeevanmissiondynamic/controller/Logincontroller.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:jaljeevanmissiondynamic/utility/Stylefile.dart';
import 'package:jaljeevanmissiondynamic/utility/Textfile.dart';
import 'package:jaljeevanmissiondynamic/utility/Utilityclass.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';
import '../apiservice/Apiservice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GetStorage box = GetStorage();
  final logincontroller = Logincontroller();
  bool isShownPassword = false;
  var random;
  var random1;
  var hashedPassword;
  var HASHpassword;
  var RandomNumber = 0;
  var RandomNumber1 = 0;
  var addcaptcha = 0;
  var RandomNumbersalt = 0;
  var _passwordStrength = '';
  bool _hidepasswordforotp = true;

  final passNotifier = ValueNotifier<PasswordStrength?>(null);

  @override
  void initState() {
    super.initState();
    _hidepasswordforotp = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkversion();
    });

    random = generateRandomString(6);
  }

  Future<void> checkversion() async {
    var uri =
        Uri.parse("${Apiservice.baseurl}JJM_Mobile/Get_MasterData?&StateId=");

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var map = (response.body as Map);
      String str = (await PackageInfo.fromPlatform()).version;

      var appversion = Version.parse(str);
      var lattestappversion = Version.parse(map["version"]);
      var minappversion = Version.parse(map["minversion"]);
      var checkmin = appversion >= minappversion;

      if (appversion < lattestappversion) {
        showDialog(
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () => Future.value(checkmin),
                child: AlertDialog(
                  title: const Text("Update App"),
                  content:
                      Text("Update version from $str to ${map["version"]}"),
                ),
              );
            });
      }
    }
  }

  _launchURL() async {
    final Uri url = Uri.parse(
        'https://ejalshakti.gov.in/JJM/JJM/DataEntry/user/ViewFlipBook.aspx?id=8');
    String encodedUrl = Uri.encodeFull(url.toString());
    try {
      if (await canLaunch(encodedUrl)) {
        await launch(encodedUrl);
      } else {
        throw 'Could not launch $encodedUrl';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  Future<void> downloadPDF(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory?.path}/Offline_Geotagging_User_manual.pdf';
      File file = File(filePath);
      await file.writeAsBytes(bytes);
      // Optionally, you can open the downloaded file using a PDF viewer here
    } else {
      throw Exception('Failed to download PDF: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    // dispose the controllers so they don't display values on the login screen after logging out
    logincontroller.emailcontroller.dispose();
    logincontroller.passwordcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0), //
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'Login ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            backgroundColor: Appcolor.btncolor,
            elevation: 5,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/header_bg.png'),
                fit: BoxFit.fill,
                scale: 3),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/header_bg.png'),
                        fit: BoxFit.fill,
                        scale: 3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.asset(
                          "images/bharat.png",
                          width: 60,
                          height: 60,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/header_bg.png'),
                              fit: BoxFit.fill,
                              scale: 3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Textfile.headingjaljeevan,
                                      textAlign: TextAlign.justify,
                                      style: Stylefile.mainheadingstyle),
                                  SizedBox(
                                    child: Text(Textfile.subheadingjaljeevan,
                                        textAlign: TextAlign.justify,
                                        style: Stylefile.submainheadingstyle),
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
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 0,
                  color: Colors.white.withOpacity(0.8),
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sign in to',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Your Account !',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'images/appjalicon.png',
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Login Id',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: TextFormField(
                              maxLength: 100,
                              maxLines: 1,
                              controller: logincontroller.emailcontroller,
                              decoration: InputDecoration(
                                counterText: '',
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                hintText: "Enter Login Id",
                                hintStyle: const TextStyle(fontSize: 16),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[a-zA-Z0-9_]+$')
                                        .hasMatch(value)) {
                                  return "Enter correct phone number";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          _hidepasswordforotp == false
                              ? SizedBox()
                              : Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Password',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: TextFormField(
                                          maxLength: 100,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            fillColor: Colors.grey.shade100,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: "Enter password",
                                            hintStyle:
                                                const TextStyle(fontSize: 16),
                                            suffixIcon: Align(
                                              widthFactor: 1.0,
                                              heightFactor: 1.0,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    isShownPassword =
                                                        !isShownPassword;
                                                  });
                                                },
                                                child: Icon(
                                                  isShownPassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                ),
                                              ),
                                            ),
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textInputAction: TextInputAction.next,
                                          obscureText: !isShownPassword,
                                          controller: logincontroller
                                              .passwordcontroller,
                                          onChanged: (password) {
                                            var bytes = utf8.encode(password);
                                            var digest = sha512.convert(bytes);
                                            hashedPassword =
                                                digest.toString().toUpperCase();
                                            HASHpassword = hashedPassword +
                                                RandomNumbersalt.toString();
                                            print(
                                                "SHA-512 Hash: $HASHpassword");
                                          },
                                        ),
                                      ),
                                      Text(
                                        _passwordStrength,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _passwordStrength == 'Weak'
                                              ? Colors.red
                                              : _passwordStrength == 'Medium'
                                                  ? Colors.orange
                                                  : Colors.green,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 90,
                                              width: double.infinity,
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              margin: const EdgeInsets.only(
                                                  left: 0, right: 50),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                margin: const EdgeInsets.only(
                                                    top: 20, bottom: 20),
                                                child: Center(
                                                  child: Text(
                                                    '$RandomNumber'
                                                    " + "
                                                    '$RandomNumber1 =  ?',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.transparent,
                                            child: IconButton(
                                                color: Colors.black,
                                                onPressed: () {
                                                  setState(() {
                                                    random =
                                                        generateRandomString(6);
                                                  });
                                                },
                                                icon: Center(
                                                    child: Image.asset(
                                                  "images/ddd.png",
                                                  scale: 4,
                                                ))),
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: TextFormField(
                                          maxLength: 100,
                                          maxLines: 1,
                                          controller:
                                              logincontroller.entercaptcha,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            fillColor: Colors.grey.shade100,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: "Enter Captcha",
                                          ),
                                          keyboardType: const TextInputType
                                              .numberWithOptions(decimal: true),
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputAction: TextInputAction.done,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value == random) {
                                              return "Enter correct Captcha code";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 40,
                          ),
                          _hidepasswordforotp == false
                              ? Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width, // <-- match_parent
                                    height: 45, // <-- match-parent
                                    child: ElevatedButton(
                                        style: Stylefile.elevatedbuttonStyle,
                                        onPressed: () async {
                                          if (logincontroller
                                              .emailcontroller.text
                                              .trim()
                                              .toString()
                                              .isEmpty) {
                                            Stylefile
                                                .showmessageforvalidationfalse(
                                                    context,
                                                    Textfile.usernamerequired);
                                          } else {
                                            try {
                                              final result =
                                                  await InternetAddress.lookup(
                                                      'example.com');
                                              if (result.isNotEmpty &&
                                                  result[0]
                                                      .rawAddress
                                                      .isNotEmpty) {
                                                // logincontroller.LoginApi(context, HASHpassword, RandomNumbersalt.toString());

                                                Get.to(OTPScreen());

                                                FocusScope.of(context)
                                                    .unfocus();
                                              }
                                              random = generateRandomString(6);
                                            } on SocketException catch (_) {
                                              Utilityclass.showInternetDialog(
                                                  context);
                                            }
                                          }
                                        },
                                        child: Text(
                                          "Send OTP",
                                          style: Stylefile.Textcolorwhitesize16,
                                        )),
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                    width: double.infinity, // <-- match_parent
                                    height: 45, // <-- match-parent
                                    child: ElevatedButton(
                                        style: Stylefile.elevatedbuttonStyle,
                                        onPressed: () async {
                                          if (logincontroller
                                              .emailcontroller.text
                                              .trim()
                                              .toString()
                                              .isEmpty) {
                                            Stylefile
                                                .showmessageforvalidationfalse(
                                                    context,
                                                    Textfile.usernamerequired);
                                          } else if (logincontroller
                                              .passwordcontroller.text
                                              .trim()
                                              .toString()
                                              .isEmpty) {
                                            Stylefile
                                                .showmessageforvalidationfalse(
                                                    context,
                                                    Textfile.passwordrequired);
                                          } else if (logincontroller
                                                  .passwordcontroller.text
                                                  .trim()
                                                  .toString()
                                                  .length <
                                              5) {
                                            Stylefile.showmessageforvalidationfalse(
                                                context,
                                                Textfile
                                                    .passwordlengthshouldbefive);
                                          } else if (logincontroller
                                              .entercaptcha.text
                                              .trim()
                                              .toString()
                                              .isEmpty) {
                                            Stylefile
                                                .showmessageforvalidationfalse(
                                                    context,
                                                    Textfile.entercaptcha);
                                          } else if (!logincontroller
                                              .entercaptcha.text
                                              .trim()
                                              .toString()
                                              .contains(
                                                  addcaptcha.toString())) {
                                            Stylefile
                                                .showmessageforvalidationfalse(
                                                    context,
                                                    Textfile
                                                        .entercaptchacorrect);
                                          } else {
                                            try {
                                              final result =
                                                  await InternetAddress.lookup(
                                                      'example.com');
                                              if (result.isNotEmpty &&
                                                  result[0]
                                                      .rawAddress
                                                      .isNotEmpty) {
                                                logincontroller.LoginApi(
                                                    context,
                                                    HASHpassword,
                                                    RandomNumbersalt
                                                        .toString());
                                                FocusScope.of(context)
                                                    .unfocus();
                                              }
                                              random = generateRandomString(6);
                                            } on SocketException catch (_) {
                                              Utilityclass.showInternetDialog(
                                                  context);
                                            }
                                          }
                                        },
                                        child: Text(
                                          Textfile.login,
                                          style: Stylefile.Textcolorwhitesize16,
                                        )),
                                  ),
                                ),
                          SizedBox(height: 5),
                          _hidepasswordforotp == false
                              ? SizedBox(
                                  height: 25,
                                  width: MediaQuery.of(context).size.width,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(0)),
                                      onPressed: () async {
                                        /*   try {
                                    final result =
                                    await InternetAddress.lookup('example.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                    }
                                  } on SocketException catch (_) {
                                    Stylefile.showmessageforvalidationfalse(context,
                                        "Unable to Connect to the Internet. Please check your network settings.");
                                  }*/
                                        setState(() {
                                          _hidepasswordforotp = true;
                                        });
                                        logincontroller.passwordcontroller
                                            .clear();
                                      },
                                      child: Text(
                                        "Login with UserId",
                                        style: TextStyle(
                                            color:
                                                Appcolor.btncolor, // Text color
                                            fontWeight:
                                                FontWeight.w500, // Bold text
                                            fontSize: 15 // Text size
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 25,
                                  width: MediaQuery.of(context).size.width,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.all(0)),
                                      onPressed: () async {
                                        /* try {
                                    final result =
                                        await InternetAddress.lookup('example.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                    }
                                  } on SocketException catch (_) {
                                    Stylefile.showmessageforvalidationfalse(context,
                                        "Unable to Connect to the Internet. Please check your network settings.");
                                  }*/
                                        setState(() {
                                          _hidepasswordforotp = false;
                                        });
                                        logincontroller.passwordcontroller
                                            .clear();
                                      },
                                      child: Text(
                                        "Login with OTP",
                                        style: TextStyle(
                                            color:
                                                Appcolor.btncolor, // Text color
                                            fontWeight:
                                                FontWeight.w500, // Bold text
                                            fontSize: 15 // Text size
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 25,
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(0)),
                                onPressed: () async {
                                  try {
                                    final result = await InternetAddress.lookup(
                                        'example.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                      _launchURL();
                                    }
                                  } on SocketException catch (_) {
                                    Stylefile.showmessageforvalidationfalse(
                                        context,
                                        "Unable to Connect to the Internet. Please check your network settings.");
                                  }
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Add some spacing between the icon and text
                                    Text(
                                      "Download user manual",
                                      style: TextStyle(
                                          color: Appcolor.btncolor,
                                          // Text color
                                          fontWeight: FontWeight.w500,
                                          // Bold text
                                          fontSize: 15 // Text size
                                          ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.download_rounded,
                                      color: Appcolor.btncolor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Image.asset("images/nicone.png")),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String generateRandomString(int len) {
    int max = 15;
    RandomNumber = Random().nextInt(max);
    RandomNumber1 = Random().nextInt(max);
    addcaptcha = RandomNumber + RandomNumber1;
    RandomNumbersalt = Random().nextInt(max);
    print("randomnumber$RandomNumbersalt");
    print("ramndomnumber$addcaptcha");

    return addcaptcha.toString();
  }
}
