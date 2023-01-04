import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/Home/Home_Custom_Widget/big_text.dart';
import 'package:cook_book/Home/Home_Custom_Widget/small_text.dart';
import 'package:cook_book/Home/Home_Custom_Widget/small_text2.dart';
import 'package:flutter/material.dart';

import 'icon_and_text.dart';

class RecipeListViewWidget extends StatefulWidget {
  const RecipeListViewWidget({Key? key}) : super(key: key);

  @override
  State<RecipeListViewWidget> createState() => _RecipeListViewWidgetState();
}

class _RecipeListViewWidgetState extends State<RecipeListViewWidget> {
  var _firestoreDB = FirebaseFirestore.instance.collection("recipe_details").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestoreDB,
        builder: (context, snapshot){
        if(!snapshot.hasData) return Center(child: Text("No Data"),);

        return Container(
          height: 600,
          // color: Colors.red,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            //shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    children: [
                      //Image Section
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                              fit : BoxFit.cover,
                              image: NetworkImage('${snapshot.data?.docs[index]['Photo']}'),
                            )
                        ),
                      ),

                      //Text Section
                      Expanded(
                        child: Container(
                            height: 100,
                            //width:200,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)
                              ),
                              color: Colors.white,
                            ),

                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: "${snapshot.data?.docs[index]['Title']}", color: Colors.black, size: 18,),
                                  SizedBox(height: 10,),
                                  SmallText2(text: "${snapshot.data?.docs[index]['Description']}"),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      IconAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: Colors.orangeAccent),

                                      SizedBox(width: 2,),
                                      IconAndTextWidget(
                                          icon: Icons.cookie_outlined,
                                          text: "${snapshot.data?.docs[index]['Number of Servings']}",
                                          iconColor: Colors.lightBlue),

                                      SizedBox(width: 2,),
                                      IconAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: "${snapshot.data?.docs[index]['Total Duration']}",
                                          iconColor: Colors.greenAccent)

                                    ],
                                  )
                                ],
                              ),
                            )
                        ),


                      )



                    ],
                  ),
                );
              }
          ),
        );
        });

  }
}
