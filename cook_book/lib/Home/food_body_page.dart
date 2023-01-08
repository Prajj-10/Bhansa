import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/Home/Home_Custom_Widget/big_text.dart';
import 'package:cook_book/Home/Home_Custom_Widget/icon_and_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../app/RecipeDetail_Page/recipeDetails.dart';
import '../custom/CustomButtons/likebutton.dart';
import 'Home_Custom_Widget/info_widget_2.dart';
import 'Home_Custom_Widget/recipe_listview_widget.dart';
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
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 210;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        //print("current val: ${_currPageValue.toString()}");
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Matrix4 matrix = new Matrix4.identity();
    var screenHeight = MediaQuery.of(context).size.height;
    final double pageView = screenHeight/2.45; //300
    final double pageViewContainer = screenHeight/3.50; //210
    final double pageViewTextContainer = screenHeight/7.36; //100

    return StreamBuilder(
        stream: _firestoreDB,
        builder: (context, snapshot){
          //if(!snapshot.hasData) return CircularProgressIndicator();
          if(!snapshot.hasData) return Text("No data");
          return Column(
            children: [
              Container(
                height: pageView,
                //color: Colors.red,
                child: PageView.builder(
                    controller: pageController,
                    //itemCount: snapshot.data?.docs.length,
                    itemCount: 5,

                    itemBuilder: (context, index){
                      Matrix4 matrix = new Matrix4.identity();
                      if(index == _currPageValue.floor()){
                        var currScale = 1 - (_currPageValue - index) * (1-_scaleFactor);
                        var currTrans = _height* (1-currScale)/2;
                        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
                      }
                      else if (index == _currPageValue.floor()+1){
                        var currScale = _scaleFactor + (_currPageValue -index + 1) * (1-_scaleFactor);
                        var currTrans = _height* (1-currScale)/2;
                        matrix = Matrix4.diagonal3Values(1, currScale, 1);
                        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
                      }
                      else if (index == _currPageValue.floor()-1){
                        var currScale = 1 - (_currPageValue - index) * (1-_scaleFactor);
                        var currTrans = _height* (1-currScale)/2;
                        matrix = Matrix4.diagonal3Values(1, currScale, 1);
                        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
                      }
                      else{
                        var currScale = 0.8;
                        matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height * (1- _scaleFactor)/2, 1);
                      }

                      final DocumentSnapshot recipe_Snapshot = snapshot.data!.docs[index];
                      return Transform(
                        transform: matrix,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RecipeDetails(recipe_snapshot: recipe_Snapshot),),);
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: pageViewContainer,
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
                                  height: pageViewTextContainer,
                                  //width: 250,
                                  margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
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

                                            Container(
                                              height: 30,
                                              //width: 90,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  //color: Color(0xFF000000).withOpacity(0.5),
                                                color: index.isEven? Color(0xFF69c5df).withOpacity(0.5) : Color(0xFF9294cc).withOpacity(0.5),
                                              ),
                                                child: Likes_Button(recipeId: snapshot.data?.docs[index].id)
                                            ),
                                            //For Rating Star
                                            // Wrap(
                                            //   children: List.generate(5, (index) => Icon(Icons.star, color: Colors.cyanAccent, size: 15,)),
                                            // ),

                                            SizedBox(width: 10,),
                                            SmallText(text: "4.5",),

                                            SizedBox(width: 10,),
                                            SmallText(text: "1278",),

                                            SizedBox(width: 10,),
                                            SmallText(text: "comments",),


                                          ],
                                        ),



                                        // SizedBox(height: 10,),
                                        //
                                        // Row(
                                        //   children: [
                                        //     IconAndTextWidget(
                                        //         icon: Icons.circle_sharp,
                                        //         text: "Normal",
                                        //         iconColor: Colors.orangeAccent),
                                        //
                                        //     SizedBox(width: 5,),
                                        //     IconAndTextWidget(
                                        //         icon: Icons.location_on,
                                        //         text: "1.7km",
                                        //         iconColor: Colors.lightBlue),
                                        //
                                        //     SizedBox(width: 5,),
                                        //     IconAndTextWidget(
                                        //         icon: Icons.access_time_rounded,
                                        //         text: "32min",
                                        //         iconColor: Colors.greenAccent)
                                        //
                                        //   ],
                                        // )

                                      ],
                                    ),
                                  ),



                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              DotsIndicator(
                dotsCount: 5,
                position: _currPageValue,
                decorator: DotsDecorator(
                  activeColor: Colors.cyanAccent,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),


            ],
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
