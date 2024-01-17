// To parse this JSON data, do
//
//     final oaGeotagmodal = oaGeotagmodalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OaGeotagmodal oaGeotagmodalFromJson(String str) => OaGeotagmodal.fromJson(json.decode(str));

String oaGeotagmodalToJson(OaGeotagmodal data) => json.encode(data.toJson());

class OaGeotagmodal {
  bool status;
  String message;
  String district;
  String block;
  String panchayat;
  String headingMessage;
  List<Result> result;

  OaGeotagmodal({
    required this.status,
    required this.message,
    required this.district,
    required this.block,
    required this.panchayat,
    required this.headingMessage,
    required this.result,
  });

  factory OaGeotagmodal.fromJson(Map<String, dynamic> json) => OaGeotagmodal(
    status: json["Status"],
    message: json["Message"],
    district: json["District"],
    block: json["Block"],
    panchayat: json["Panchayat"],
    headingMessage: json["HeadingMessage"],
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "District": district,
    "Block": block,
    "Panchayat": panchayat,
    "HeadingMessage": headingMessage,
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  int taggedId;
  String schemeName;
  String imageUrl;
  int stateId;
  int villageId;
  String districtName;
  String blockName;
  String panchayatName;
  String villageName;
  String sourceName;
  dynamic sourceCatogery;
  dynamic sourcetype;
  String latitude;
  String longitude;
  int photoStatus;
  int capicityInltr;
  dynamic storageStructureType;
  dynamic otherCategory;
  String habitationName;
  int isApprovedDivisionBy;
  int isApprovedStateBy;
  int status;
  String message;

  Result({
    required this.taggedId,
    required this.schemeName,
    required this.imageUrl,
    required this.stateId,
    required this.villageId,
    required this.districtName,
    required this.blockName,
    required this.panchayatName,
    required this.villageName,
    required this.sourceName,
    required this.sourceCatogery,
    required this.sourcetype,
    required this.latitude,
    required this.longitude,
    required this.photoStatus,
    required this.capicityInltr,
    required this.storageStructureType,
    required this.otherCategory,
    required this.habitationName,
    required this.isApprovedDivisionBy,
    required this.isApprovedStateBy,
    required this.status,
    required this.message,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    taggedId: json["TaggedId"],
    schemeName: json["SchemeName"],
    imageUrl: json["ImageURL"],
    stateId: json["StateId"],
    villageId: json["VillageId"],
    districtName: json["DistrictName"],
    blockName: json["BlockName"],
    panchayatName: json["PanchayatName"],
    villageName: json["VillageName"],
    sourceName: json["SourceName"],
    sourceCatogery: json["SourceCatogery"],
    sourcetype: json["sourcetype"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    photoStatus: json["PhotoStatus"],
    capicityInltr: json["CapicityInltr"],
    storageStructureType: json["StorageStructureType"],
    otherCategory: json["OtherCategory"],
    habitationName: json["HabitationName"],
    isApprovedDivisionBy: json["IsApprovedDivisionBy"],
    isApprovedStateBy: json["IsApprovedStateBy"],
    status: json["Status"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "TaggedId": taggedId,
    "SchemeName": schemeName,
    "ImageURL": imageUrl,
    "StateId": stateId,
    "VillageId": villageId,
    "DistrictName": districtName,
    "BlockName": blockName,
    "PanchayatName": panchayatName,
    "VillageName": villageName,
    "SourceName": sourceName,
    "SourceCatogery": sourceCatogery,
    "sourcetype": sourcetype,
    "Latitude": latitude,
    "Longitude": longitude,
    "PhotoStatus": photoStatus,
    "CapicityInltr": capicityInltr,
    "StorageStructureType": storageStructureType,
    "OtherCategory": otherCategory,
    "HabitationName": habitationName,
    "IsApprovedDivisionBy": isApprovedDivisionBy,
    "IsApprovedStateBy": isApprovedStateBy,
    "Status": status,
    "Message": message,
  };
}
