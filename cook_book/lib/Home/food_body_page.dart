import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/Home/Home_Custom_Widget/big_text.dart';
import 'package:flutter/material.dart';

import '../app/RecipeDetail_Page/recipeDetails.dart';
import 'Home_Custom_Widget/small_text.dart';

class FoodBodyPage extends StatefulWidget {
  const FoodBodyPage({Key? key}) : super(key: key);

  @override
  State<FoodBodyPage> createState() => _FoodBodyPageState();
}

class _FoodBodyPageState extends State<FoodBodyPage> {
  //CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection("recipe_details");
  var _firestoreDB = FirebaseFirestore.instance.collection("recipe_details").snapshots();

  PageController pageController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestoreDB,
        builder: (context, snapshot){
        if(!snapshot.hasData) return CircularProgressIndicator();
          return Container(
            height: 300,
            //color: Colors.red,
            child: PageView.builder(
                controller: pageController,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot recipe_Snapshot = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RecipeDetails(recipe_snapshot: recipe_Snapshot),),);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 210,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: index.isEven? Color(0xFF69c5df) : Color(0xFF9294cc),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('${snapshot.data?.docs[index]['Photo']}'),
                              )

                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 100,
                            //width: 250,
                            margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),

                            child: Container(
                              padding: EdgeInsets.only(top: 20,left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(text: "${snapshot.data?.docs[index]['Title']}", color: Colors.black, size: 14,),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [

                                      //For Rating Star
                                      Wrap(
                                        children: List.generate(5, (index) => Icon(Icons.star, color: Colors.cyanAccent, size: 15,)),
                                      ),

                                      SizedBox(width: 10,),
                                      SmallText(text: "4.5",),

                                      SizedBox(width: 10,),
                                      SmallText(text: "1278",),

                                      SizedBox(width: 10,),
                                      SmallText(text: "comments",),


                                    ],
                                  ),

                                  SizedBox(height: 20,),

                                  Row(
                                    children: [

                                    ],
                                  )
                                ],
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        });

  }

  // Widget _buildPageItem(int index){
  //   return StreamBuilder(
  //       stream: _firestoreDB,
  //       builder: (context, snapshot){
  //         if(!snapshot.hasData) return CircularProgressIndicator();
  //
  //
  //       });
  //   // return Stack(
  //   //   children: [
  //   //     Container(
  //   //       height: 210,
  //   //       margin: EdgeInsets.only(left: 10, right: 10),
  //   //       decoration: BoxDecoration(
  //   //           borderRadius: BorderRadius.circular(30),
  //   //           color: index.isEven? Color(0xFF69c5df) : Color(0xFF9294cc),
  //   //           image: DecorationImage(
  //   //             fit: BoxFit.cover,
  //   //             image: NetworkImage('https://travelfoodatlas.com/wp-content/uploads/2020/09/Bibimbap.jpg.webp'),
  //   //           )
  //   //
  //   //       ),
  //   //     ),
  //   //
  //   //     Align(
  //   //       alignment: Alignment.bottomCenter,
  //   //       child: Container(
  //   //         height: 100,
  //   //         //width: 250,
  //   //         margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
  //   //         decoration: BoxDecoration(
  //   //             borderRadius: BorderRadius.circular(30),
  //   //             color: Colors.white,
  //   //         ),
  //   //
  //   //         child: Container(
  //   //           padding: EdgeInsets.only(top: 20,left: 15, right: 15),
  //   //           child: Column(
  //   //             crossAxisAlignment: CrossAxisAlignment.start,
  //   //             children: [
  //   //               BigText(text: "${snapshot = context.data.documents[index]['Title']}" color: Colors.black, size: 14,),
  //   //
  //   //               SizedBox(
  //   //                 height: 10,
  //   //               ),
  //   //
  //   //               Row(
  //   //                 children: [
  //   //
  //   //                   //For Rating Star
  //   //                   Wrap(
  //   //                     children: List.generate(5, (index) => Icon(Icons.star, color: Colors.cyanAccent, size: 15,)),
  //   //                   ),
  //   //
  //   //                   SizedBox(width: 10,),
  //   //                   SmallText(text: "4.5",),
  //   //
  //   //                   SizedBox(width: 10,),
  //   //                   SmallText(text: "1278",),
  //   //
  //   //                   SizedBox(width: 10,),
  //   //                   SmallText(text: "comments",),
  //   //
  //   //
  //   //                 ],
  //   //               ),
  //   //
  //   //               SizedBox(height: 20,),
  //   //
  //   //               Row(
  //   //                 children: [
  //   //
  //   //                 ],
  //   //               )
  //   //             ],
  //   //           ),
  //   //         ),
  //   //
  //   //       ),
  //   //     ),
  //   //   ],
  //   // );
  // }
}
