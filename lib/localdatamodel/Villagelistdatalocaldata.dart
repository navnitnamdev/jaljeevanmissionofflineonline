class Villagelistlocaldata{


  final int? id;
  final String? villageId;
  final String? villageName;


  Villagelistlocaldata({ this.id ,required this.villageId,required this.villageName });

  Villagelistlocaldata.fromMap(Map<String , dynamic> res):
        id = res['id'],
        villageId = res['villageId'],
        villageName = res['villageName'];

  Map<String , Object?> toMap(){

    return {

      'id':id,
      'villageId':villageId,
      'villageName':villageName,


    };
  }




}