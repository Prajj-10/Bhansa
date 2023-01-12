import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/RecipeDetail_Page/recipe_detail.dart';
import 'package:cook_book/custom/CustomButtons/saveButton.dart';
import 'package:flutter/material.dart';

import '../../app/RecipeDetail_Page/recipeDetails.dart';
class Saved extends StatefulWidget {
  var userId;
  Saved({Key? key, required this.userId}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  var recipeImage;
  var recipeTitle;
  var recipeTotalDuration;
  var writerProfile;
  var writerName;

  Future<void> recipeDetails(var recipe_id) async{
    var postedBy;
    await FirebaseFirestore.instance.collection('recipe_details').doc(recipe_id).get().then((value) {
      setState(() {
        recipeTitle = value.data()!['Title'];
        recipeImage = value.data()!['Photo'];
        recipeTotalDuration = value.data()!['Total Duration'];
        postedBy = value.data()!['Posted By'];
      });
    });

    await FirebaseFirestore.instance.collection('users').doc(postedBy).get().then((value) {
      setState(() {
        writerName = value.data()!['name'];
        writerProfile = value.data()!['profile picture'];
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var recipeReference = FirebaseFirestore.instance.collection('saved').doc(widget.userId).collection('savedRecipies');
    return StreamBuilder(
      stream: recipeReference.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return Text("No saved recipies");
        }
        else{
          return GridView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              String recipe_id = snapshot.data!.docs[index].id;
              final DocumentSnapshot recipe_Snapshot = snapshot.data!.docs[index];

              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Recipe_Detail(recipeId: recipe_id, ),),);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    //height: 80,
                    width: size.width*0.3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFFFFFFF).withOpacity(1),
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
                                      image: NetworkImage(recipe_Snapshot['writer_profile'] ?? "https://cdn3.vectorstock.com/i/1000x1000/08/37/profile-icon-male-user-person-avatar-symbol-vector-20910837.jpg"),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                SizedBox(width: size.width*0.02,),

                                Text(recipe_Snapshot['writer_name'] ?? "Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),),


                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: size.width,
                            child: Image.network(recipe_Snapshot['recipe_image'] ?? "https://media.istockphoto.com/id/1166171010/photo/spicy-grilled-jerk-chicken-on-a-plate.jpg?s=612x612&w=0&k=20&c=AEY55ma7yVvL4YUb4HPxaD7MJ7YcJ2g2sYWHnMXTJDk=",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:size.width*0.3,
                                        child: Text(recipe_Snapshot['recipe_title'] ?? "Title", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),)
                                    ),
                                    Text(recipe_Snapshot['recipe_duration'] ?? "Duration", style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal, color: Colors.black),),
                                  ],
                                ),
                                //Save_Button(),
                              ],
                            ),
                          ),
                        ],
                      ),
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
    );
  }
}
