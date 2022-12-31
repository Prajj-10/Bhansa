import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowRecipeDetails extends StatefulWidget {

  final QueryDocumentSnapshot<Object?>? data;

  const ShowRecipeDetails({Key? key, this.data}) : super(key: key);

  @override
  State<ShowRecipeDetails> createState() => _ShowRecipeDetailsState();
}

class _ShowRecipeDetailsState extends State<ShowRecipeDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text("${widget.data!.get('Title')}"),
          // ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: ClipRRect(
                      //borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network('${widget.data!.get('Photo')}',
                        height: 120,
                        fit: BoxFit.cover,
                        width: double.infinity,),
                    ),

                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    //color: Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("${widget.data!.get('Title')}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),

                          SizedBox(
                            height: 10,
                          ),

                          Text("${widget.data!.get('Description')}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),),

                        ],
                      ),
                    ),

                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
