import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchRecipe2 extends SearchDelegate{
  CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection("recipe_details");

  //var firestoreDB = FirebaseFirestore.instance.collection("recipe_details").snapshots();

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
            snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Title']
                .toString().toLowerCase()
                .contains(query.toLowerCase())).isEmpty
            ){
              return Center (child: Text("No Found"),);
            }
            else{
              //Fetch Data here
              print(snapshot.data);

              return GridView.builder(
                  itemCount: snapshot.data?.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index)
                  {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.network("${snapshot.data?.docs[index]['Photo']}",
                              height: 120,
                              fit: BoxFit.cover,
                              width: double.infinity,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Text(snapshot.data?.docs[index]['Title'], style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold,
                              ),
                              ),

                              const Text("9.0",
                                style: TextStyle(color: Colors.amber),),

                            ],),),
                        ],
                      ),
                    );
                  });

            }

          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          else
          {
              //Fetch Data here
              //print(snapshot.data);

              return GridView.builder(
                  itemCount: snapshot.data?.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index)
                  {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.network("${snapshot.data?.docs[index]['Photo']}",
                              height: 120,
                              fit: BoxFit.cover,
                              width: double.infinity,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Text(snapshot.data?.docs[index]['Title'], style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold,
                              ),
                              ),

                              const Text("9.0",
                                style: TextStyle(color: Colors.amber),),

                            ],),),
                        ],
                      ),
                    );
                  });

          }
        });
  }

}
