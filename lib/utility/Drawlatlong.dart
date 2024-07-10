import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;


class Drawlatlong {
/*
  static img.Image drawlatlong(String path, String lat, String long) {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy HH:mm a');
    final timestamp = formatter.format(now);
    final originalImage = img.decodeImage(File(path).readAsBytesSync());

    final img.Image watermarkedImage = img.copyResize(
        originalImage!, width: 480, height: 680);
    img.drawString(watermarkedImage, x: 12,
      y: 580,
      'Date: $timestamp\nLat: ${lat ?? ""}/ Long: ${long ?? ""}',
      font: img.arial14,
      color: img.ColorFloat32.rgb(255, 0, 0),);
   // return watermarkedImage;
    return watermarkedImage;
  }
*/



  static img.Image drawlatlong(String path, String lat, String long, img.BitmapFont? customFont) {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy HH:mm a');
    final timestamp = formatter.format(now);

    final originalImage = img.decodeImage(File(path).readAsBytesSync());

    if (originalImage == null) {
      throw Exception('Failed to decode image');
    }

    final watermarkedImage = img.copyResize(originalImage, width: 480, height: 680);

    final text = 'Date: $timestamp\nLat: $lat / Long: $long';

    print("custom" + customFont.toString());
    final font = customFont;

    img.drawString(watermarkedImage, text,font: font!, x: 12, y:580,  color: img.ColorRgba8(255, 0, 0, 255), );

    return watermarkedImage;
  }


}
