import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Directions extends StatelessWidget {
  List<dynamic> directionsList;
  Directions({Key? key, required this.directionsList}) : super(key: key);
  //List <int> exampleList =  ingredientsList;
  @override
  Widget build(BuildContext context) {
    final Map<int, dynamic> ingredients = directionsList.asMap();
    var size = MediaQuery.of(context).size;
    print(ingredients.entries);


    //print(ingList);
    return ListView(
      /*mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,*/
      children: ingredients.entries.map((entry) {
        // var w = Text(entry.value +": " +entry.key.toString());

        var widget = Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Step "+(entry.key+1).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(entry.value,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white,),
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
