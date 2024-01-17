class Userdata{
  final int? id;
  final String? userid;
  final String? username;
  final String? mobilenumber;
  final String? designation;

  Userdata({ this.id, required this.userid , required this.username,required this.mobilenumber ,required this.designation});

  Userdata.fromMap(Map<String , dynamic> res):
        id = res['id'],
        userid = res['userid'],
        username = res['username'],
        mobilenumber = res['mobilenumber'],
  designation = res['designation'];
  Map<String , Object?> toMap(){

    return {

      'id':id,
      'userid':userid,
      'username':username,
      'mobilenumber':mobilenumber,
      'designation':designation,

    };
  }



}