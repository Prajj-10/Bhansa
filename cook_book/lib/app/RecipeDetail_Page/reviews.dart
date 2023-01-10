import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/user_model.dart';

class Reviews extends StatefulWidget {

  var postId;


  Reviews({Key? key, required this.postId}) : super(key: key);



  @override
  State<Reviews> createState() => _ReviewsState(postId: this.postId);
}

class _ReviewsState extends State<Reviews> {

  CollectionReference recipeReviews = FirebaseFirestore.instance.collection('recipe_reviews');

  var u_name;
  var photo;

  final ref = FirebaseDatabase.instance.ref('users');
  final user = FirebaseAuth.instance.currentUser;


  void getDetails() async{

    var userDetails = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    setState(() {
      u_name = userDetails.data()!['username'];
      photo = userDetails.data()!['profile picture'];
    });
  }


  @override
  void initState() {
    getDetails();
    super.initState();

  }



  TextEditingController reviewsController = TextEditingController();

  var postId;

  _ReviewsState({required this.postId});

  //getDetails();



  buildReviews(){


    return StreamBuilder(
      stream: recipeReviews.doc(postId).collection("recipe_reviews").snapshots(),
      builder: (context, snapshot){

        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        List<Review> reviews = [];

        snapshot.data!.docs.forEach((documentS){
          reviews.add(Review.fromDocument(documentS));
        });

        return ListView(
          children: reviews,
        );
      },

    );


  }



  addReview(){

    recipeReviews
        .doc(postId)
        .collection('recipe_reviews')
        .add({

      'Review': reviewsController.text,
      'Time': DateTime.now().toString(),
      'Reviewed By': u_name,
      'Profile Picture': photo,
      'Posted byId': user?.uid

    });

    reviewsController.clear();


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Color(0xFF07060E),
      child: Column(
        children: [
          Expanded(
            child: buildReviews(),
          ),

          Divider(),

          ListTile(
            title: TextFormField(

              controller: reviewsController,

              decoration: const InputDecoration(
                  labelText: "Write Review..."
              ),

            ),
            trailing: OutlinedButton(
              onPressed: () => addReview(),
              child: const Text('Post'),
            ),
          ),
        ],
      ),
    );
    //);
  }

}







//------------------------Review UI--------------------//

class Review extends StatefulWidget {

  var review, reviewed_by, profile_picture, posted_time, posted_byId;

  Review({Key? key, required this.review, required this.reviewed_by, required this.profile_picture, required this.posted_time, required this.posted_byId}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();

  factory Review.fromDocument(DocumentSnapshot documentS){
    return Review(
      review: documentS['Review'],
      reviewed_by: documentS['Reviewed By'],
      profile_picture: documentS['Profile Picture'],
      posted_time: documentS['Time'],
      posted_byId: documentS['Posted byId'],

    );
  }
}

class _ReviewState extends State<Review> {
  CollectionReference recipeReviews = FirebaseFirestore.instance.collection('recipe_reviews');

  var current_u_name;
  var current_photo;


  final ref = FirebaseDatabase.instance.ref('users');
  final user = FirebaseAuth.instance.currentUser;



  void getCurrentDetails(String docId) async{

    var userDetails = await FirebaseFirestore.instance.collection('users').doc(docId).get();

    setState(() {
      current_u_name = userDetails.data()!['username'];
      current_photo = userDetails.data()!['profile picture'];
    });
  }
  //getCurrentDetails(widget.posted_byId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentDetails(widget.posted_byId);
  }





  @override
  Widget build(BuildContext context) {

    //getCurrentDetails(widget.posted_byId);

    return Column(
      children:[

        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                 current_u_name ?? 'Guest',
                //widget.reviewed_by,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                //posted_time.substring(0, 10) ?? '',
                //'Time',
                widget.posted_time.substring(0, 10) ?? 'Null',
                //posted_time,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),

          leading: CircleAvatar(
            backgroundImage: NetworkImage(current_photo ?? 'https://cdn-icons-png.flaticon.com/512/3177/3177440.png'),
          ),
          subtitle: Text(
            //reviewsController ?? 'reviews',
            //'This is good',
            widget.review ?? 'Null',
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
          //trailing:
        ),


        Divider(color: Colors.grey.withOpacity(1),endIndent: 5, indent: 5,),
      ],
    );
  }
}