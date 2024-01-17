import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utility/Appcolor.dart';
import '../view/LoginScreen.dart';

class Addfhtcscreen extends StatefulWidget {
  const Addfhtcscreen({super.key});

  @override
  State<Addfhtcscreen> createState() => _AddfhtcscreenState();
}

class _AddfhtcscreenState extends State<Addfhtcscreen> {
  GetStorage box = GetStorage();

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
      body: Container(
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
            child: Column(
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
                                  title: const Text('FE_dhubri'),
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

              ],
            ),
          ),


        ),
      ),

    );
  }
}
