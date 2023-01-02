import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../RecipeDetail_Page/recipeDetails.dart';

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
              return Center (child: Text("Oops!!! Recipe Not Found"),);
            }
            else{
              //Fetch Data here
              print(snapshot.data);

              return ListView(
                children: [

                  ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Title']
                      .toString().toLowerCase()
                      .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?>  data){
                    final String title = data.get('Title');
                    final String image = data.get('Photo');

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RecipeDetails(recipe_snapshot: data)));
                          //print("Selected Recipe: $title");
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              child: Image.network('${image}',
                                height: 120,
                                fit: BoxFit.cover,
                                width: double.infinity,),
                            ),
                            Positioned(
                              bottom: 10,
                                left: 10,
                                child: Column(
                                  children: [
                                    Text(title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),)
                                  ],
                                ))


                          ],

                        ),
                      ),
                    );


                  }),

                ],
              );


              // return Column(
              //   children: [
              //     ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Title']
              //         .toString().toLowerCase()
              //         .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?>  data){
              //       final String title = data.get('Title');
              //       final String image = data.get('Photo');
              //
              //       return Expanded(
              //         child: GridView.builder(
              //             itemCount: 1,
              //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              //             itemBuilder: (context, index)
              //             {
              //               return Container(
              //                 margin: EdgeInsets.all(5),
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: Colors.red,
              //                 ),
              //                 child: Center(
              //                   child: Column(
              //                     children: [
              //                       ClipRRect(
              //                         borderRadius: const BorderRadius.only(
              //                             topLeft: Radius.circular(10),
              //                             topRight: Radius.circular(10)),
              //                         child: Image.network("${image}",
              //                           height: 120,
              //                           fit: BoxFit.cover,
              //                           width: double.infinity,),
              //                       ),
              //                       Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Column(children: [
              //                           Text(title, style: const TextStyle(
              //                             color: Colors.white, fontWeight: FontWeight.bold,
              //                           ),
              //                           ),
              //
              //                           const Text("9.0",
              //                             style: TextStyle(color: Colors.amber),),
              //
              //                         ],),),
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             }),
              //       );
              //
              //     }),
              //
              //   ],
              // );



            }

          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Search Your Favourite  Recipe",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.grey,
    ),),);

    ////#Display Data in the search screen
    // return  StreamBuilder<QuerySnapshot>(
    //     stream: _firebaseFirestore.snapshots().asBroadcastStream(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
    //       if (!snapshot.hasData){
    //         return Center(child: CircularProgressIndicator());
    //       }
    //       else
    //       {
    //         if(
    //         snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Title']
    //             .toString().toLowerCase()
    //             .contains(query.toLowerCase())).isEmpty
    //         ){
    //           return Center (child: Text("No Found"),);
    //         }
    //         else{
    //           //Fetch Data here
    //           print(snapshot.data);
    //
    //           return ListView(
    //             children: [
    //
    //               ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Title']
    //                   .toString().toLowerCase()
    //                   .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?>  data){
    //                 final String title = data.get('Title');
    //                 final String image = data.get('Photo');
    //
    //                 return Padding(
    //                   padding: const EdgeInsets.all(5),
    //                   child: Stack(
    //                     children: [
    //                       ClipRRect(
    //                         borderRadius: BorderRadius.only(
    //                             topLeft: Radius.circular(10),
    //                             topRight: Radius.circular(10)),
    //                         child: Image.network('${image}',
    //                           height: 120,
    //                           fit: BoxFit.cover,
    //                           width: double.infinity,),
    //                       ),
    //                       Positioned(
    //                           bottom: 10,
    //                           left: 10,
    //                           child: Column(
    //                             children: [
    //                               Text(title,
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontSize: 16,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),)
    //                             ],
    //                           ))
    //
    //
    //                     ],
    //
    //                   ),
    //                 );
    //
    //
    //               }),
    //
    //             ],
    //           );
    //
    //         }
    //
    //       }
    //     });
  }

}
