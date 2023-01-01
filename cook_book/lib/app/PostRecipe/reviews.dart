import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class Reviews extends StatefulWidget {

  //final String recipeID, postOwnerId, postMediaUrl;
  var recipeID, reviewerID, reviewerProfilePicture;

  Reviews({Key? key, required this.recipeID, required this.reviewerID, required this.reviewerProfilePicture}) : super(key: key);



  @override
  State<Reviews> createState() => _ReviewsState(recipeID: this.recipeID, postOwnerId: this.reviewerID, postMediaUrl: this.reviewerProfilePicture);
}

class _ReviewsState extends State<Reviews> {

  CollectionReference recipeReviews = FirebaseFirestore.instance.collection('recipe_reviews');

  final user = FirebaseAuth.instance.currentUser;



  UserModel loggedInUser = UserModel();

  TextEditingController reviewsController = TextEditingController();

  //late final String recipeID, postOwnerId, postMediaUrl;
  var recipeID, postOwnerId, postMediaUrl;

  _ReviewsState({required this.recipeID, required this.postOwnerId, required this.postMediaUrl});



  buildReviews(){
    return StreamBuilder(
        stream: recipeReviews.doc(recipeID).collection("recipe_reviews").snapshots(),
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
        .doc(recipeID)
        .collection('recipe_reviews')
        .add({

      'Name': loggedInUser.name,
      'Review': reviewsController.text,
      'Time': DateTime.now(),
      'Avatar': loggedInUser.profilePicture,
      'U-Id': loggedInUser.uid

    });

    reviewsController.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        centerTitle: true,
      ),

      body: Column(
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
  }

}

class Review extends StatelessWidget {

  final String username, userId, avatarUrl, review;
  final Timestamp timestamp;

  Review({Key? key, required this.username, required this.userId, required this.avatarUrl, required this.review, required this.timestamp}) : super(key: key);

  factory Review.fromDocument(DocumentSnapshot documentS){
    return Review(
      /*username: documentS['username'],
      userId: documentS['userId'],
      review: documentS['review'],
      timestamp: documentS['timestamp'],
      avatarUrl: documentS['avatarUrl'],*/

      username: documentS['Name'],
      userId: documentS['U-Id'],
      review: documentS['Review'],
      timestamp: documentS['Time'],
      avatarUrl: documentS['Avatar'],

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

