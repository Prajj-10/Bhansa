import 'package:flutter/material.dart';

import '../../app/MyProfile/myProfile.dart';
import '../../app/PostRecipe/post_recipe.dart';
import '../../app/Preferences/preferences.dart';
import '../home_page.dart';



class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  @override
  int index = 0;

  //Calling the pages (most be in sequential order)
  List screen = [HomePage(), Preferences(), PostRecipe(), MyProfile() ];



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          setState(() {
            index = 2;
          });

        },
        child: Icon(Icons.add,
          color: Colors.white,
          size: 26,),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.blueGrey,

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
                child: Icon(Icons.home,
                    size: 24,
                    color: index == 0 ? Colors.cyan : Colors.white),
              ),


              //Category
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Icon(Icons.search,
                    size: 24,
                    color: index == 1 ? Colors.cyan : Colors.white),
              ),

              SizedBox(width: 10),

              //Favourite
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                },
                child: Icon(Icons.favorite,
                    size: 24,
                    color: index == 3 ? Colors.cyan : Colors.white),
              ),

              //Profile
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 4;
                  });
                },
                child: Icon(Icons.person,
                    size: 24,
                    color: index == 4 ? Colors.cyan : Colors.white),
              ),
            ],
          ),
        ),
      ),

      body: screen[index],


    );
  }
}