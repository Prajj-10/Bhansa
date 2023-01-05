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
      'U-ID': user?.uid

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

  var review, reviewed_by, profile_picture, posted_time;

  Review({Key? key, required this.review, required this.reviewed_by, required this.profile_picture, required this.posted_time}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState(review: this.review, reviewed_by: this.reviewed_by, profile_picture: this.profile_picture, posted_time: this.posted_time);

  factory Review.fromDocument(DocumentSnapshot documentS){
    return Review(
      review: documentS['Review'],
      reviewed_by: documentS['Reviewed By'],
      profile_picture: documentS['Profile Picture'],
      posted_time: documentS['Time'],
    );
  }
}

class _ReviewState extends State<Review> {
  CollectionReference recipeReviews = FirebaseFirestore.instance.collection('recipe_reviews');

  var u_name;
  var photo;

  var review_data;
  var date_data;

  final ref = FirebaseDatabase.instance.ref('users');
  final user = FirebaseAuth.instance.currentUser;



  void getDetails() async{

    var userDetails = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    setState(() {
      u_name = userDetails.data()!['username'];
      photo = userDetails.data()!['profile picture'];
    });
  }

  var review, reviewed_by, profile_picture, posted_time;

  _ReviewState({required this.review, required this.reviewed_by, required this.profile_picture, required this.posted_time,});


  factory _ReviewState.fromDocument(DocumentSnapshot documentS){
    return _ReviewState(
      review: documentS['Review'],
      reviewed_by: documentS['Reviewed By'],
      profile_picture: documentS['Profile Picture'],
      posted_time: documentS['Time'],
    );
  }



  @override
  void initState() {
    getDetails();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children:[

        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                u_name ?? 'Guest',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                //posted_time.substring(0, 10) ?? '',
                //'Time',
                posted_time.substring(0, 10) ?? 'Null',
                //posted_time,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),

          leading: CircleAvatar(
            backgroundImage: NetworkImage(photo ?? 'https://cdn-icons-png.flaticon.com/512/3177/3177440.png'),
          ),
          subtitle: Text(
            //reviewsController ?? 'reviews',
            //'This is good',
            review ?? 'Null',
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
          //trailing:
        ),


        Divider(color: Colors.grey.withOpacity(1),endIndent: 5, indent: 5,),
      ],
    );
  }
}



