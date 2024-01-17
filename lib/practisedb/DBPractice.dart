import 'package:flutter/material.dart';
import 'package:jaljeevanmissiondynamic/practisedb/DBHelper.dart';
import 'package:jaljeevanmissiondynamic/database/notes.dart';
import 'package:jaljeevanmissiondynamic/utility/Appcolor.dart';


class DBPractice extends StatefulWidget {
  const DBPractice({super.key});


  @override
  State<DBPractice> createState() => _DBPracticeState();
}

class _DBPracticeState extends State<DBPractice> {


  DBHelper? dbHelper;
  late Future<List<NotesModel>> noteslist;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dbHelper=DBHelper();
    loaddata();

  }

  loaddata() async{
    noteslist = dbHelper!.getnoteslist();

    print("notelisthere_");


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("Databse record")),
      body:
         SingleChildScrollView(
           child: Column(
             children: [
               SizedBox(
                 height: 40,
                 child: ElevatedButton(onPressed: (){
                   dbHelper?.insert(NotesModel( title: "preetin", age: 22)).then((value){
                     print("data added");
                     setState(() {
                       noteslist = dbHelper!.getnoteslist();
                       print(dbHelper!.getnoteslist());
                     });
                   }).onError((error, stackTrace) {
                     print(error.toString());
                   }
           
                   );
                 }, child: Text("ADD")),
               ),
               Container(
                 height: 600,
                 width: MediaQuery.of(context).size.width,
                 child: FutureBuilder(
                   future:  noteslist,

                   builder: (context , AsyncSnapshot<List<NotesModel>>  snapshot){

                     if(snapshot.hasData){
                       return Card(
                         child:  ListView.builder(

                             itemCount: snapshot.data!.length,
                             itemBuilder: (context ,int index){
                               print("listlength"+snapshot.data!.length.toString());

                               return InkWell(
                                 onTap: (){
                                   dbHelper!.update(NotesModel(id: snapshot.data![index].id! , title: "shanker", age: 50));
                                   setState(() {
                                     noteslist =dbHelper!.getnoteslist();
                                   });
                                 },
                                 child: Dismissible(
                                   direction: DismissDirection.endToStart,
                                   key: ValueKey<int> (snapshot.data![index].id! ),
                                   background: Container(
                                     color: Appcolor.black,
                                     child: Icon(Icons.delete , ),
                                   ),
                                   onDismissed: (DismissDirection direction){
                                     setState(() {
                                       /// delete data from database
                                 dbHelper!.delete(snapshot.data![index].id!);
                                 noteslist=dbHelper!.getnoteslist();
                                 snapshot.data!.removeAt(index).id!;
                                 print("lengthofnana" +snapshot.data![index].id.toString() );
                                     });
                                   },


                                   child: Container(
                                     color: Appcolor.COLOR_PRIMARY,
                                     width: 200,
                                     margin: EdgeInsets.all(5),
                                     child: Column(
                                       children: [
                                         Text(snapshot.data![index].title.toString()),
                                         Text(snapshot.data![index].age.toString()),

                                       ],
                                     ),
                                   ),
                                 ),
                               );
                             }),
                       );
                     }else{
                    return   Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()),
                    );
                     }

                   },),
               ),
             ],
           
           
           ),
         ),
    );
  }
}
