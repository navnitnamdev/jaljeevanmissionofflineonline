class Myresponse {
  bool? status;
  String? message;
  String? userName;
  String? userDescription;
  int? UserId;
  String? Mobile;
  String? Designation;
  List<Result>? result;

  Myresponse(
      {this.status,
        this.message,
        this.userName,
        this.userDescription,
        this.UserId,
        this.Mobile,
        this.Designation,
        this.result});

  Myresponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    userName = json['UserName'];
    userDescription = json['UserDescription'];
    UserId = json['UserId'];
    Mobile = json['Mobile'];
    Designation = json['Designation'];
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['UserName'] = userName;
    data['UserDescription'] = userDescription;
    data['UserId'] = UserId;
    data['Mobile'] = Mobile;
    data['Designation'] = Designation;
    if (result != null) {
      data['Result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? menuId;
  String? heading;
  List<SubHeadingmenulist>? subHeadingmenulist;

  Result({this.menuId, this.heading, this.subHeadingmenulist});

  Result.fromJson(Map<String, dynamic> json) {
    menuId = json['MenuId'];
    heading = json['Heading'];
    if (json['SubHeadingmenulist'] != null) {
      subHeadingmenulist = <SubHeadingmenulist>[];
      json['SubHeadingmenulist'].forEach((v) {
        subHeadingmenulist!.add(SubHeadingmenulist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MenuId'] = menuId;
    data['Heading'] = heading;
    if (subHeadingmenulist != null) {
      data['SubHeadingmenulist'] =
          subHeadingmenulist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubHeadingmenulist {
  String? subHeadingMenuId;
  String? subHeading;
  String? subHeadingParentId;
  List<SubResult>? result;

  SubHeadingmenulist(
      {this.subHeadingMenuId,
        this.subHeading,
        this.subHeadingParentId,
        this.result});

  SubHeadingmenulist.fromJson(Map<String, dynamic> json) {
    subHeadingMenuId = json['SubHeadingMenuId'];
    subHeading = json['SubHeading'];
    subHeadingParentId = json['SubHeadingParentId'];
    if (json['Result'] != null) {
      result = <SubResult>[];
      json['Result'].forEach((v) {
        result!.add(SubResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SubHeadingMenuId'] = subHeadingMenuId;
    data['SubHeading'] = subHeading;
    data['SubHeadingParentId'] = subHeadingParentId;
    if (result != null) {
      data['Result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubResult {
  String? lableMenuId;
  String? lableText;
  String? lableValue;
  String? icon;

  SubResult({this.lableMenuId, this.lableText, this.lableValue, this.icon});

  SubResult.fromJson(Map<String, dynamic> json) {
    lableMenuId = json['lableMenuId'];
    lableText = json['LableText'];
    lableValue = json['LableValue'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lableMenuId'] = lableMenuId;
    data['LableText'] = lableText;
    data['LableValue'] = lableValue;
    data['Icon'] = icon;
    return data;
  }
}











