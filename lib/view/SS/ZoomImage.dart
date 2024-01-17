import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
class ZoomImage extends StatefulWidget {
  String imgurl;
  ZoomImage({required this.imgurl ,super.key});

  @override
  State<ZoomImage> createState() => _practisesecState();
}

class _practisesecState extends State<ZoomImage> {

  String geturl="";

  var fullimg;


  Uint8List convertBase64Image(String base64String) {
    return Base64Decoder().convert(base64String.split(',').last);
  }
  @override
  void initState() {
    // TODO: implement initState
    geturl = widget.imgurl;

    super.initState();
   fullimg =   convertBase64Image(geturl);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black,
        appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
    iconTheme: const IconThemeData(
    color: Appcolor.white
    ),
        ),
      body: Stack(children: [

        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 10,
              child: Image.memory(convertBase64Image(geturl),
                  gaplessPlayback: true)
          ),
        ),
      ],
      ),
    );
  }
}
