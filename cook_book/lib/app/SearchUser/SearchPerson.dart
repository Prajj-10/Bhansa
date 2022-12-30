import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPerson extends SearchDelegate{
  CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection("users");

  var firestoreDB = FirebaseFirestore.instance.collection("recipe_details").snapshots();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget> [
      IconButton(
          onPressed: (){
            query = "";
          },
          icon: Icon(Icons.close)
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          else
          {
            if(
            snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['name']
                .toString().toLowerCase()
                .contains(query.toLowerCase())).isEmpty
            ){
              return Center (child: Text("No Found"),);
            }
            else{
              //Fetch Data here
              //print(snapshot.data);
              return ListView(
                children: [

                  ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['name']
                      .toString().toLowerCase()
                      .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?>  data){
                    final String name = data.get('name');

                    return ListTile(
                      onTap: () {

                      }
                      ,
                      title: Text(name),
                      subtitle: Text("Hello"),
                      leading: Icon(Icons.person),
                    );
                  }),

                ],
              );
           }

          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Search Here"),);
    // return  StreamBuilder<QuerySnapshot>(
    //     stream: _firebaseFirestore.snapshots().asBroadcastStream(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
    //       if (!snapshot.hasData){
    //         return Center(child: CircularProgressIndicator());
    //       }
    //       else
    //       {
    //           //Fetch Data here
    //           //print(snapshot.data);
    //           return ListView(
    //             children: [
    //
    //               ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['name']
    //                   .toString().toLowerCase()
    //                   .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?>  data){
    //                 final String name = data.get('name');
    //
    //                 return ListTile(
    //                   onTap: () {
    //
    //                   }
    //                   ,
    //                   title: Text(name),
    //                   subtitle: Text("Hello"),
    //                   leading: Icon(Icons.person),
    //                 );
    //               }),
    //
    //             ],
    //           );
    //
    //
    //       }
    //     });
  }
  
}
