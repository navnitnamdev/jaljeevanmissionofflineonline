class Savesourcetypemodal {
  bool? status;
  String? message;
  List<Resultone>? result;

  Savesourcetypemodal({this.status, this.message, this.result});

  Savesourcetypemodal.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['Result'] != null) {
      result = <Resultone>[];
      json['Result'].forEach((v) {
        result!.add(Resultone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (result != null) {
      data['Resultone'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resultone {
  int? id;
  String? assetTaggingType;
  String? remarks;

  Resultone({this.id, this.assetTaggingType, this.remarks});

  Resultone.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    assetTaggingType = json['AssetTaggingType'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['AssetTaggingType'] = assetTaggingType;
    data['Remarks'] = remarks;
    return data;
  }
}
