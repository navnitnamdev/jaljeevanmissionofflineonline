class DashboardLocalModal {
  final int? id;

  //final String? userid;
  final String? username;
  final String? userdescription;
  final String? leftheadingmenuid;
  final String? leftheading;
  final String? subheadingleftmenuid;
  final String? SubHeadingleftmenu;
  final String? leftmenulableMenuId;
  final String? leftmenuLableText;
  final String? leftmenuLableValue;

/*  final String? dbpws_subheadinglablevalueone;
  final String? dbpws_subheadinglablevaluetwo;
  final String? dbpws_subheadinglablevaluethree;*/
  /* final String? leftmenuIcon;*/

  DashboardLocalModal({
    this.id,
    // required this.userid ,
    required this.username,
    required this.userdescription,
    required this.leftheadingmenuid,
    required this.leftheading,
    required this.subheadingleftmenuid,
    required this.SubHeadingleftmenu,
    required this.leftmenulableMenuId,
    required this.leftmenuLableText,
    required this.leftmenuLableValue,
    /*   required this.dbpws_subheadinglablevalueone,
           required this.dbpws_subheadinglablevaluetwo,
           required this.dbpws_subheadinglablevaluethree,*/
    /*required this.leftmenuIcon*/
  });

  DashboardLocalModal.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        //  userid = res['userid'],
        username = res['username'],
        userdescription = res['userdescription'],
        leftheadingmenuid = res['leftheadingmenuid'],
        leftheading = res['leftheading'],
        subheadingleftmenuid = res['subheadingleftmenuid'],
        SubHeadingleftmenu = res['SubHeadingleftmenu'],
        leftmenulableMenuId = res['leftmenulableMenuId'],
        leftmenuLableText = res['leftmenuLableText'],
        leftmenuLableValue = res['leftmenuLableValue'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      //'userid':userid,
      'username': username,
      'userdescription': userdescription,
      'leftheadingmenuid': leftheadingmenuid,
      'leftheading': leftheading,
      'subheadingleftmenuid': subheadingleftmenuid,
      'SubHeadingleftmenu': SubHeadingleftmenu,
      'leftmenulableMenuId': leftmenulableMenuId,
      'leftmenuLableText': leftmenuLableText,
      'leftmenuLableValue': leftmenuLableValue,
    };
  }
}
