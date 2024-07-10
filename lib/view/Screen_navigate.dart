import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Selectedvillagelist.dart';
import 'Dashboard.dart';

class ScreenPoints extends StatelessWidget {
  String no;
  ScreenPoints({super.key, required this.no});
  final int numberOfPoints = 2;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(buildText(), style: const TextStyle(color: Colors.black, fontSize: 20),);
  }

  String buildText() {
    String screen = "Screen : ";
    return screen;
  }

}
class PointsAndLines extends StatelessWidget {
  final int numberOfPoints = 4; // Change this value to set the number of points
  GetStorage box = GetStorage();
  var str = ['1', '2', '3', '4'];

  PointsAndLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        /*mainAxisAlignment: MainAxisAlignment.spaceEvenly,*/
        children: _buildPointsAndLines(),
      ),
    );
  }

  List<Widget> _buildPointsAndLines() {
    List<Widget> widgets = [];
    for (int i = 0; i < numberOfPoints; i++) {
      widgets.add(_buildPoint(str[i]));
      if (i < numberOfPoints - 1) {
        widgets.add(_buildLine());
      }
    }
    return widgets;
  }


  Widget _buildPoint(String title) {
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
              usertoken: box.read("UserToken").toString(), ));
          }
          if (title == "2") {
            Get.to(
                Selectedvillaglist(
                    stateId: box.read("stateid").toString(),
                    userId: box.read("userid").toString(),
                    usertoken: box.read("UserToken").toString()));
          }
          if (title == "3") {
            Get.back();
          }

        },
        child:
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: title == "4"?Colors.blue:Colors.grey,
          ),
          child: Center(
              child: Text(title, style: const TextStyle(color: Colors.white),)),
        ),);
  }

  Widget _buildLine() {
    return Container(
      width: 12,
      height: 2,
      color: Colors.black,
    );
  }
}
