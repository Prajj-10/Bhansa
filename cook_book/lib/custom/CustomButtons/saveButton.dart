import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Save_Button extends StatefulWidget {
  var recipeId;
  Save_Button({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<Save_Button> createState() => _Save_ButtonState();
}

class _Save_ButtonState extends State<Save_Button> {
  bool isSaved = false;
  var recipeTitle;
  var recipeDuration;
  var recipeImage;
  var writerProfile;
  var writerName;

  var savedReference = FirebaseFirestore.instance.collection("saved");
  var user = FirebaseAuth.instance.currentUser;

  // Check following status
  checkIfSaved() async{
    DocumentSnapshot docSnapshot = await savedReference
        .doc(user?.uid)
        .collection('savedRecipies')
        .doc(widget.recipeId)
        .get();
    setState(() {
      isSaved = docSnapshot.exists;
    });
  }

  //Function  to handle save recipe
  handleSave(){
    savedReference
    .doc(user?.uid)
    .collection('savedRecipies')
    .doc(widget.recipeId)
    .set({
      "writer_name": writerName,
      "writer_profile": writerProfile,
      "recipe_title":recipeTitle,
      "recipe_duration": recipeDuration,
      "recipe_image": recipeImage,
    });
    setState(() {
      isSaved = true;
    });
  }

  //Handle unsave recipe
  handleUnsave(){
    savedReference
        .doc(user?.uid)
        .collection('savedRecipies')
        .doc(widget.recipeId)
        .get()
        .then((data){
      if(data.exists){
        data.reference.delete();
      }
    });
    setState(() {
      isSaved = false;
    });

  }
  
  getRecipeDetails() async{
    var recipe_detail = await FirebaseFirestore.instance.collection('recipe_details').doc(widget.recipeId).get();
    var writer_detail = await FirebaseFirestore.instance.collection('users').doc(recipe_detail.data()!['Posted By']).get();
    setState(() {
        recipeTitle = recipe_detail.data()!['Title'];
        recipeDuration = recipe_detail.data()!['Total Duration'];
        recipeImage = recipe_detail.data()!['Photo'];
        writerProfile = writer_detail.data()!['profile picture'];
        writerName = writer_detail.data()!['name'];
    });

  }

  @override
  void initState() {
    super.initState();
    checkIfSaved();
    
    getRecipeDetails();

    print("Bye");
  }
  @override
  Widget build(BuildContext context) {
    return isSaved? IconButton(
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.bookmark,
        color: Colors.blue,
        size: 28,
      ),
      onPressed: handleUnsave,

    )
    : IconButton(
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.bookmark_border_outlined,
        color: Colors.blueGrey,
        size: 28,
      ),
      onPressed: handleSave,
    );
  }
}
