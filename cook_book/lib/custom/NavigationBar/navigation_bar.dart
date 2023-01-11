

import 'package:cook_book/Home/recipe_home_page.dart';
import 'package:cook_book/app/GoogleMap/googlemap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/MyProfile/myProfile.dart';
import '../../app/PostRecipe/post_recipe.dart';
import '../../app/SearchRecipe/search_recipe.dart';
import '../../app/SearchRecipe/search_recipe_2.dart';

import '../../app/SearchUser/SearchPerson.dart';
import '../../app/registration_page/registration.dart';
import '../../authentication/logged_in2.dart';
class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}
class _NavigationState extends State<Navigation> {
  @override
  int index = 0;

  //Calling the pages (most be in sequential order)
  List screen = [RecipeHomePage(),  PostRecipe(), Google_Map(), MyProfile(userId: FirebaseAuth.instance.currentUser?.uid,) ];


  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF061624),
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          setState(() {
            index = 1;
          });

        },
        child: Icon(Icons.add_outlined,
          color: Colors.white,
          size: 28,),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: isKeyboardOpen? null :  BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: const Color(0xFF061624),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              //Home
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Icon(Icons.home_outlined,
                    size: 28,
                    color: index == 0 ? Colors.cyan : Colors.white),
              ),


              //Category
              GestureDetector(
                onTap: () => showSearch(context: context, delegate: SearchRecipe2()),
                //onTap: () => showSearch(context: context, delegate: SearchPerson()),
                child: Icon(Icons.search_outlined,
                    size: 28,
                    color: index == 1 ? Colors.cyan : Colors.white),
              ),

              SizedBox(width: 10),

              //Favourite
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                },
                child: Icon(Icons.local_grocery_store_outlined,
                    size: 28,
                    color: index == 2 ? Colors.cyan : Colors.white),
              ),

              //Profile
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                },
                child: Icon(Icons.person_outline,
                    size: 28,
                    color: index == 3 ? Colors.cyan : Colors.white),
              ),
            ],
          ),
        ),
      ),

      body: screen[index],


    );
  }
}

