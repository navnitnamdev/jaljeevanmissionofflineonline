class MyClass {
  String VillageId="";
 // String VillageName="";

  MyClass( this.VillageId);



 /* @override
  String toString() {
    return 'MyClass{VillageId: $title, value: $value}';
  }*/



  Map<String, dynamic> toJson() => {
    'VillageId': VillageId,
   // 'VillageName': VillageName,

  };

}

