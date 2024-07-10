import 'package:flutter/material.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';
class Stylefile {
  static double CONTAINER_HEIGHTDROPDOWN = 45;
  static double CONTAINER_WIDTH = 0;
  static double TEXTFORMFIELD_HEIGHT = 45;
  static double BOXHEIGHT = 80;
  static double BOXWIDTH = 90;


  static const TextStyle Textstylecolorblack = TextStyle(
    //   fontFamily: 'Poppins',
    color: Appcolor.black,
    fontSize: 14,
  );
  static const TextStyle Textcolorwhitesize16 = TextStyle(
    // fontFamily: 'Poppins',
    //   color: Appcolor.white,
      fontSize: 16,
      fontWeight: FontWeight.w600);

  static const TextStyle Textcolorblackboldsizesixteen = TextStyle(
      color: Appcolor.black,
      fontSize: 25,
      fontWeight: FontWeight.bold);
  static const TextStyle Textcolorblackbold20 = TextStyle(
      fontFamily: 'Poppins',
      color: Appcolor.black,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static const TextStyle Textcolorblackboldsizesixteenunderline = TextStyle(
      fontFamily: 'Poppins',
      color: Appcolor.black,
      decoration: TextDecoration.underline,
      fontSize: 16,
      fontWeight: FontWeight.bold);

  static void showmessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
/*
  static void showmessageforvalidationtrue(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),backgroundColor: Appcolor.greenmessagecolor,
    ));
  }*/

  static void showmessageforvalidationtrue(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(

      content: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_double_arrow_down_outlined,
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Appcolor.greenmessagecolor,
    ));
  }

  static void showmessageforvalidationfalse(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_double_arrow_down_outlined,
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Appcolor.red,
    ));
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

/*  static void showmessageforvalidationfalse(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),backgroundColor: Appcolor.red,
    ));
  }*/
  static void showmessageapisuccess(
      BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),backgroundColor: Appcolor.greenmessagecolor,
    ));
  }


  static void showmessageapierrors(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),backgroundColor: Appcolor.errormesssagecolor,
    ));
  }

  static const TextStyle hinttextstyle = TextStyle(
    // fontFamily: "Poppins",
    color: Appcolor.grey,
  );
  static ButtonStyle elevatedbuttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Appcolor.white, backgroundColor: Appcolor.btncolor,
    textStyle: const TextStyle( fontWeight: FontWeight.bold, fontSize: 14),
    elevation: 5,
    /*minimumSize:  Size(230, 40),
    maximumSize:  Size(230,40),*/

    padding: const EdgeInsets.symmetric(horizontal: 5),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(width: 1, color: Appcolor.btncolor)),
  );

  static _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }


  static const TextStyle submainheadingstyle = TextStyle(
    // fontFamily: "Poppins",
    color: Appcolor.black,
    fontSize: 11
  );
  static const TextStyle mainheadingstyle = TextStyle(
    // fontFamily: "Poppins",
      color: Colors.black,
      fontSize: 18,
      fontWeight:
      FontWeight.bold
  );
}