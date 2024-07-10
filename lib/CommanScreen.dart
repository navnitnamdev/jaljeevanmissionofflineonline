import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jaljeevanmissiondynamic/addfhtc/jjm_facerd_appcolor.dart';
import 'package:jaljeevanmissiondynamic/view/Dashboard.dart';
import 'package:jaljeevanmissiondynamic/view/VillageDetails.dart';

import 'Selectedvillagelist.dart';
class NewScreenPoints extends StatelessWidget {
  int no;
  String villageId;
  var villageName;
  NewScreenPoints({super.key, required this.no, required this.villageId, required this.villageName});

@override
Widget build(BuildContext context) {
  // TODO: implement build
  return

    Column(
      children: [
        ScreenPoints(no: no, villageId: villageId, villageName: villageName),
        PointsAndLines(numberOfPoints: no,villageId: villageId,villageName: villageName,)
      ],
    );
}

}


class ScreenPoints extends StatelessWidget {
  var no;
  String villageId;
  var villageName;
  ScreenPoints({super.key, required this.no, required this.villageId, required this.villageName});
  final int numberOfPoints = 2;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
        alignment:Alignment.centerLeft,
        child

        : Padding(
          padding: const EdgeInsets.only(left: 12 ,),
          child: Text(buildText(), style: const TextStyle(color: Appcolor.btncolor, fontSize: 16 , fontWeight: FontWeight.bold,),),
        ));
  }

  String buildText() {
    String screen = "Screen:- ";
    return screen;
  }

}
class PointsAndLines extends StatelessWidget {
   int numberOfPoints = 4; // Change this value to set the number of points
  GetStorage box = GetStorage();
  var str = ['1', '2', '3', '4' ,'5'];
   String villageId;
   var villageName;

  PointsAndLines({super.key, required this.numberOfPoints,required this.villageId, required this.villageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        /*mainAxisAlignment: MainAxisAlignment.spaceEvenly,*/
        children: _buildPointsAndLines(),
      ),
    );
  }

  List<Widget> _buildPointsAndLines() {
    List<Widget> widgets = [];
    for (int i = 1; i <= numberOfPoints; i++) {

      if (i == numberOfPoints) {
        widgets.add(_buildPoint(i.toString(), true));
      } else {
        widgets.add(_buildPoint(i.toString(), false));
      }

      if (i <= numberOfPoints - 1) {
        widgets.add(_buildLine());
      }
    }

    return widgets;
  }


  Widget _buildPoint(String title, bool done) {
    return
      GestureDetector(
        onTap: () {
          // Action to perform when the container is tapped
          print('Container tapped!');
          if (title == "1") {
            //Get.back();

            Get.offAll(Dashboard(
              stateid: box.read("stateid").toString(),
              userid: box.read("userid").toString(),
              usertoken: box.read("UserToken").toString()));
          }
          if (title == "2") {
            Get.to(
                Selectedvillaglist(
                    stateId: box.read("stateid").toString(),
                    userId: box.read("userid").toString(),
                    usertoken: box.read("UserToken").toString()));
          }
          if (title == "3") {
            Get.to(VillageDetails(villageid: villageId, villagename: villageName, stateid: box.read("stateid").toString(), userID: box.read("userid").toString(), token: box.read("UserToken").toString()));
          }
 if (title == "4") {
            Get.back();
          }



        },
        child:
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done == true? Appcolor.btncolor:Colors.grey,
          ),
          child: Center(
              child: Text(title, style: const TextStyle(color: Colors.white),)),
        ),);
  }

  Widget _buildLine() {
    return Container(
      width: 20,
      height: 2,
      color: Colors.black,
    );
  }
}
