import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class Ingredients extends StatelessWidget {
  List<dynamic> ingredientsList;
  Ingredients({Key? key, required this.ingredientsList}) : super(key: key);
  //List <int> exampleList =  ingredientsList;
  @override
  Widget build(BuildContext context) {
    final Map<int, dynamic> ingredients = ingredientsList.asMap();
    var size = MediaQuery.of(context).size;
  print(ingredients.entries);


    //print(ingList);
    return ListView(
      padding: EdgeInsets.only(top: 15),
        children: ingredients.entries.map((entry) {
         // var w = Text(entry.value +": " +entry.key.toString());

          var widget = Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(width:20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width),
                      color: Colors.white,
                    ),
                    child: Center(child: Text((entry.key+1).toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black,),))
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,),
                  child: Container(
                    //color: Colors.white,
                    width: size.width-50,
                    child: Text(entry.value, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white,),),
                  ),
                ),
              ],
            ),
          );

          return widget;
        }).toList(),

    );



  }


}
