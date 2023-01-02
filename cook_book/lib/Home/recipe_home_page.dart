import 'package:flutter/material.dart';

import 'Home_Custom_Widget/info_widget.dart';

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
          // appBar: AppBar(
          //   title: Text("Cook Book", style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w500,
          //   ),),
          // ),

          body: Column(
            children: [
              InfoWidget(),

            ],
          ),
        ));
  }
}
