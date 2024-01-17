
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:jaljeevanmissiondynamic/controller/Logincontroller.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:jaljeevanmissiondynamic/utility/Stylefile.dart';
import 'package:jaljeevanmissiondynamic/utility/Textfile.dart';
import 'package:jaljeevanmissiondynamic/utility/Utilityclass.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final logincontroller = Logincontroller();
  bool isShownPassword = false;
  var random ;
  var random1 ;
  var  hashedPassword;
  var HASHpassword;
  int RandomNumber=0;
  int RandomNumber1=0;
  int addcaptcha=0;
  int RandomNumbersalt=0;


  @override
  void initState() {
    super.initState();

    random = generateRandomString(6);


  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:const Text( 'Login ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
          backgroundColor:Appcolor.btncolor,
          elevation: 5,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/header_bg.png'), fit: BoxFit.fill, scale: 3),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
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
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sign in to',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Your Account !',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'images/app_icon.png',
                                  width: 50,
                                  height: 50,
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
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: TextFormField(
                              controller: logincontroller.emailcontroller,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Enter Login Id",
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
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
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Enter password",
                                suffixIcon: Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isShownPassword = !isShownPassword;
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

                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              obscureText: !isShownPassword,
                              controller:
                                  logincontroller.passwordcontroller,

                              onChanged: (password) {

                                var bytes = utf8.encode(password);
                                var digest = sha512.convert(bytes);
                                hashedPassword = digest.toString().toUpperCase();
                                HASHpassword = hashedPassword+RandomNumbersalt.toString();
                                print("SHA-512 Hash: $HASHpassword");
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 90,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(left: 5),
                                  margin: const EdgeInsets.only(
                                      left: 0, right: 50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(4)),

                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Center(
                                      child: Text(
                                        '$RandomNumber' +
                                            " + " +
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
                                        random = generateRandomString(6);
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
                              controller: logincontroller.entercaptcha,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Enter Captcha",
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty || value == random) {
                                  return "Enter correct Captcha code";
                                } else {

                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                                style: Stylefile.elevatedbuttonStyle,
                                onPressed: () async {
                                  if (logincontroller.emailcontroller.text
                                      .trim()
                                      .toString()
                                      .isEmpty) {
                                    Stylefile.showmessage(
                                        context, Textfile.usernamerequired);
                                  } else if (logincontroller.passwordcontroller.text.trim().toString().isEmpty) {
                                    Stylefile.showmessage(
                                        context, Textfile.passwordrequired);
                                  } else if (logincontroller
                                          .passwordcontroller.text
                                          .trim()
                                          .toString()
                                          .length <
                                      5) {
                                    Stylefile.showmessage(
                                        context,
                                        Textfile
                                            .passwordlengthshouldbefive);
                                  } else if (logincontroller
                                      .entercaptcha.text
                                      .trim()
                                      .toString()
                                      .isEmpty) {
                                    Stylefile.showmessage(
                                        context, Textfile.entercaptcha);
                                  } else if (!logincontroller
                                      .entercaptcha.text
                                      .trim()
                                      .toString()
                                      .contains(addcaptcha.toString())) {
                                    Stylefile.showmessage(context,
                                        Textfile.entercaptchacorrect);
                                  }

                                  else {
                                    try {
                                      final result =
                                          await InternetAddress.lookup(
                                              'example.com');
                                      if (result.isNotEmpty &&
                                          result[0].rawAddress.isNotEmpty) {
                                        logincontroller.LoginApi(context, HASHpassword, RandomNumbersalt.toString());
                                        FocusScope.of(context).unfocus();
                                      }
                                      random = generateRandomString(6);
                                    } on SocketException catch (_) {
                                      Utilityclass.showInternetDialog(context);
                                    }
                                  }
                                },
                                child: Text(
                                  Textfile.login,
                                  style: Stylefile.Textcolorwhitesize16,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 90,
                            width: double.infinity,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                color: Colors.yellow[200],
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Alert! Existing user(JJM mobile app) Verification & password generation.',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text('Click here',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent[700]))
                              ],
                            ),
                          )
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
    print("randomnumber" +RandomNumbersalt.toString());
    print("randomnumber" +addcaptcha.toString());


    return addcaptcha.toString();
  }
}
