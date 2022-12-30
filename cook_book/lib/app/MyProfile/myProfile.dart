
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/MyProfile/profileDetail.dart';
import 'package:cook_book/custom/CustomListView/recipeListView.dart';
import 'package:cook_book/model/cookingSteps_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../custom/CustomGridView/savedGridView.dart';
import '../../model/user_model.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  /*UserModel loggedInUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;

  Future _getData() async => await FirebaseFirestore.instance
      .collection("users")
      .doc(user?.uid)
      .get()
      .then((value)=> {

    loggedInUser = UserModel.fromMap(value.data()),
    print(loggedInUser!.name),

  });*/

  //Variables
  var name;
  var username;
  var description;
  var profilePicture;
  CollectionReference recipeReference =FirebaseFirestore.instance.collection("recipe_details") ;

  //Get user data from firebase
  void _getUserDetails() async{
    final user = await FirebaseAuth.instance.currentUser;
    //UserModel loggedInUser = UserModel();
    //CookingStepsModel recipeList = new CookingStepsModel();
    var _userDetails = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    setState(() {
      name = _userDetails.data()!['name'];
      username = _userDetails.data()!['username'];
      description = _userDetails.data()!['description'];
      profilePicture = _userDetails.data()!['profilePicture'];
    });
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
    //_getData();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          leading: Icon(Icons.arrow_back, color: Colors.white,),
          elevation: 0,
          backgroundColor: Color(0xFF01231C),
          title: Text(username ?? "username"),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
                colors: [
                  Color(0xFF01231C).withOpacity(1),
                  Color(0xFF131926).withOpacity(0.9),
                  //Color(0xFF0E2839).withOpacity(0.5),
                  Color(0xFF081017).withOpacity(0.8),
                ]
            ),
        ),
        child: DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return[
                  SliverList(delegate: SliverChildListDelegate([
                    ProfileDetail(name: name, description: description, profilePicture: profilePicture, username: username),
                  ]),)
                ];
              },
              body: SizedBox(
                width: size.width,
                //height: 1000,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF555555).withOpacity(0.2),
                          Color(0xFF7A7A7A).withOpacity(0.05),
                        ]

                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.blueGrey,
                          indicatorWeight: 1,
                          indicatorColor: Colors.white,
                          tabs: [
                            Tab(
                              height: 50,
                              child: Column(
                                children: [
                                  Icon(Icons.food_bank_outlined, size: 30,),
                                  Text("Recipes", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: [
                                  Icon(Icons.bookmark_border_outlined, size: 30,),
                                  Text("Saved", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                              children: [
                                Recipe(reference: recipeReference),
                                Saved(),
                              ]),
                        ),
                      ],
                    ),
                  ),

                ),
              ),


            ),
          ),

        ),
      ),
    );
  }
}
