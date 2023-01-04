import 'package:cook_book/custom/CustomButtons/saveButton.dart';
import 'package:flutter/material.dart';
class Saved extends StatelessWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GridView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            //height: 80,
            width: size.width*0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF94C9E8FF).withOpacity(1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [

                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://loop.frontiersin.org/images/profile/1438029/203"),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),

                        SizedBox(width: size.width*0.02,),

                        Text("Hello Bye", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),


                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    width: size.width,
                    child: Image.network("https://media.istockphoto.com/id/1166171010/photo/spicy-grilled-jerk-chicken-on-a-plate.jpg?s=612x612&w=0&k=20&c=AEY55ma7yVvL4YUb4HPxaD7MJ7YcJ2g2sYWHnMXTJDk=",
                    fit: BoxFit.fitWidth,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recipe', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
                          Text("Time: 1hrs 30 min", style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal),),
                        ],
                      ),
                      //Icon(Icons.save),
                      Save_Button(),

                    ],
                  ),


                ],
              ),
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16/20,
        // mainAxisSpacing: 20,
      ),

    );
  }
}
