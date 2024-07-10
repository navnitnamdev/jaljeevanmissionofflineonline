import 'package:flutter/material.dart';

class InternetAllow extends StatelessWidget {
   const InternetAllow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
            child:  const Center(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Unable to Connect to the Internet. Please check your network settings.',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
      ),
    );
  }
}

class InternetAllowwithimage extends StatelessWidget {
  const InternetAllowwithimage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child:  Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height/2,
              child: Image.asset(
                "images/nointer.gif"
              ),
            ),
          ),
        ),
      ),
    );
  }
}