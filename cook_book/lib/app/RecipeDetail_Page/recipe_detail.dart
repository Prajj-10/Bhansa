import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/UserProfile/userProfile.dart';
import 'package:cook_book/custom/CustomListView/ingredientsListView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../custom/CustomButtons/likebutton.dart';
import '../../custom/CustomButtons/saveButton.dart';
import '../../custom/CustomListView/directionsListView.dart';
import '../../custom/ExpandedWidgets/expandedRecipeDescription.dart';
import '../MyProfile/myProfile.dart';
import 'reviews.dart';

class Recipe_Detail extends StatefulWidget {

  final recipeId;

  const Recipe_Detail({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<Recipe_Detail> createState() => _Recipe_DetailsState();
}

class _Recipe_DetailsState extends State<Recipe_Detail> with TickerProviderStateMixin{
  var writer_name;
  var writer_username;
  var writer_profilePicture;
  var writer_id;
  late TabController _controller ;
  var currentUserId;
  //Recipe details
  var recipe_title;
  var cooking_direction;
  var cook_duration;
  var description;
  var ingredients;
  var likes;
  var no_of_servings;
  var image;
  var posted_by;
  var posted_on;
  var prepare_duration;
  var total_duration;

  void _getRecipeDetails() async{
    var recipe_snapshot = await FirebaseFirestore.instance.collection('recipe_details').doc(widget.recipeId).get();
    setState(() {
      recipe_title = recipe_snapshot.data()!['Title'];
      cooking_direction =recipe_snapshot.data()!['Cooking Direction'];
      cook_duration = recipe_snapshot.data()!['Cooking Duration'];
      description = recipe_snapshot.data()!['Description'];
      ingredients = recipe_snapshot.data()!['Ingredients'];
      likes = recipe_snapshot.data()!['Likes'];
      no_of_servings = recipe_snapshot.data()!['Number of Servings'];
      image = recipe_snapshot.data()!['Photo'];
      posted_by = recipe_snapshot.data()!['Posted By'];
      posted_on = recipe_snapshot.data()!['Posted On'];
      prepare_duration = recipe_snapshot.data()!['Prepare Duration'];
      total_duration = recipe_snapshot.data()!['Total Duration'];
    });
    _getWriterDetails(posted_by);
  }


  void _getWriterDetails(writerId) async{
    var userReference = await FirebaseFirestore.instance.collection('users').doc(writerId).get();
    setState(() {
      writer_name = userReference.data()!['name'];
      writer_username = userReference.data()!['username'];
      writer_profilePicture = userReference.data()!['profile picture'];
      writer_id = writerId;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _getRecipeDetails();
    currentUserId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 300,
                  //collapsedHeight: 56,
                  //floating: true,
                  pinned: true,
                  backgroundColor: Color(0xFF07060E),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(Icons.more_vert_rounded, size: 25,),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(image ?? "https://media.istockphoto.com/id/1320857678/photo/brazilian-fish-stew-moqueca.jpg?b=1&s=170667a&w=0&k=20&c=bcE72Zq71JEVt_lfL0fYWMCMjYV4AtxHxxB4EMIZamw=",
                      fit: BoxFit.cover,
                    ) ?? Image.asset("assets/recipe.jpg", fit: BoxFit.cover,),
                    title: Container(
                      width: size.width*0.6,
                      child: Text(recipe_title ?? "Recipe Title",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),
              ];
            },

            body: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFF07060E).withOpacity(1),
                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: ()=> currentUserId==writer_id?
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile(userId: writer_id)))
                              :Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile(userId: writer_id,))),
                              child: Container(
                                child: Row(
                                  children: [
                                    Center(
                                      child: ClipOval(
                                        child: Image.network(writer_profilePicture?? "https://img.freepik.com/premium-vector/smiling-chef-cartoon-character_8250-10.jpg?w=2000",
                                        //child: Image.network("https://img.freepik.com/premium-vector/smiling-chef-cartoon-character_8250-10.jpg?w=2000",

                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(writer_name ?? "Master Chef", style: TextStyle(decoration: TextDecoration.none, fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                                        Text(writer_username ?? "master_chef", style: TextStyle(decoration: TextDecoration.none, fontSize: 12, fontWeight: FontWeight.normal,color: Colors.white),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xFFFFFFFF).withOpacity(0.2),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Likes_Button(recipeId: widget.recipeId,),
                                  Save_Button(recipeId: widget.recipeId,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Servings", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,),),
                                SizedBox(height: 5,),
                                Text(no_of_servings.toString() ?? "null",style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal,),),
                              ],
                            ),
                            const VerticalDivider(
                              color: Colors.blueGrey,
                              thickness: 2,
                              indent: 6,
                              endIndent: 6,

                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Prep Time", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,),),
                                SizedBox(height: 5,),
                                Text(prepare_duration ?? "null",style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal,),),
                              ],
                            ),
                            const VerticalDivider(
                              color: Colors.blueGrey,
                              thickness: 2,
                              indent: 6,
                              endIndent: 6,

                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Cook Time", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,),),
                                SizedBox(height: 5,),
                                Text(cook_duration ?? "null", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal,),),
                              ],
                            ),
                            const VerticalDivider(
                              color: Colors.blueGrey,
                              thickness: 2,
                              indent: 6,
                              endIndent: 6,

                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Total Time", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,),),
                                SizedBox(height: 5,),
                                Text(total_duration ?? "null", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal,),),
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),),
                      ExpandedRecipeDescription(recipeDescription: description ??"Recipe Description"),
                      SizedBox(height: 10,),
                      Container(
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          color: Color(0xFF07060E),
                          border: Border(
                              top: BorderSide(width: 2, color: Colors.blueGrey),
                              bottom: BorderSide(width: 2, color: Colors.blueGrey)
                          ),
                        ),
                        height: 50,
                        child: TabBar(
                          controller: _controller,
                          tabs: [
                            Text("Ingredients", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("Directions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("Reviews", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      Expanded(
                          child: TabBarView(
                            controller: _controller,
                            children: [
                              Ingredients(ingredientsList: ingredients),
                              Directions(directionsList: cooking_direction),
                              Reviews(postId: widget.recipeId),
                            ],
                          )
                      )

                    ],
                  ),
                ),
              ),
            ),

          ),

    );
  }
}

