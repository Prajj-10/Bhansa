import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class Reviews extends StatefulWidget {

  //final String postId, postOwnerId, postMediaUrl;
  var postId;
  //, postOwnerId, postMediaUrl;

  Reviews({Key? key, required this.postId}) : super(key: key);



  @override
  State<Reviews> createState() => _ReviewsState(postId: this.postId);
}

class _ReviewsState extends State<Reviews> {

  CollectionReference recipeReviews = FirebaseFirestore.instance.collection('recipe_reviews');

  final user = FirebaseAuth.instance.currentUser;



  UserModel loggedInUser = UserModel();

  TextEditingController reviewsController = TextEditingController();

  //late final String postId, postOwnerId, postMediaUrl;
  var postId;
  //, postOwnerId, postMediaUrl;

  _ReviewsState({required this.postId});



  buildReviews(){

    //QLyNouJdBVUkh5iVbkrE
    //lLidy7jeEVBuqm2JCtvG
    //m3qPdGS0vh2PVkTzTNrl

    //from recipe details: ip5z8vKiaZHGYIEwPQch


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

      //'Name': 'Rohit',
      'Review': reviewsController.text,
      'Time': DateTime.now(),
      //'Avatar': "loggedInUser.profilePicture",
      //'U-Id': "loggedInUser.uid"

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

                decoration: InputDecoration(
                    labelText: "Write Review..."
                ),

              ),
              trailing: OutlinedButton(
                onPressed: () => addReview(),
                child: Text('Post'),
              ),
            ),
          ],
        ),
    );
    //);
  }

}

class Review extends StatelessWidget {

  final String review;
  //final String timestamp;

  Review({Key? key, required this.review}) : super(key: key);

  factory Review.fromDocument(DocumentSnapshot documentS){
    return Review(
      /*username: documentS['username'],
      userId: documentS['userId'],
      review: documentS['review'],
      timestamp: documentS['timestamp'],
      avatarUrl: documentS['avatarUrl'],*/

      //username: documentS['Name'],
      //userId: documentS['U-Id'],
      review: documentS['Review'],
      //timestamp: documentS['Time'],
      //avatarUrl: documentS['Avatar'],

    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[

        ListTile(
          title: Text(review),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/postRecipe.png"),
          ),
          subtitle: Text('2078-01-23'),
        ),

        Divider(),
      ],
    );
  }
}

