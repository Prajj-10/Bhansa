import 'package:flutter/material.dart';

import 'Home_Custom_Widget/info_widget.dart';
import 'Home_Custom_Widget/info_widget_2.dart';
import 'Home_Custom_Widget/recipe_listview_widget.dart';
import 'food_body_page.dart';

class RecipeHomePage extends StatefulWidget {
  const RecipeHomePage({Key? key}) : super(key: key);

  @override
  State<RecipeHomePage> createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: InfoWidget(),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return[
                SliverList(delegate: SliverChildListDelegate([
                  //InfoWidget(),
                  FoodBodyPage(),
                  InfoWidget2(),
                  SizedBox(height: 20,),
                ]),)
              ];
            },
            body: Expanded(
              child: RecipeListViewWidget(),

          ),

          ),


        ));
  }
}
