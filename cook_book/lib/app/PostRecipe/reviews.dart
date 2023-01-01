import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final user = FirebaseAuth.instance.currentUser;



  UserModel loggedInUser = UserModel();

  TextEditingController reviewsController = TextEditingController();

  var postId;

  _ReviewsState({required this.postId});



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
      'Reviewed By': user?.displayName,
      'Profile Picture': user?.photoURL,


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

  final String review, reviewed_by, profile_picture, posted_time;
  //final String timestamp;

  Review({Key? key, required this.review, required this.reviewed_by, required this.profile_picture, required this.posted_time}) : super(key: key);

  factory Review.fromDocument(DocumentSnapshot documentS){
    return Review(

      review: documentS['Review'],
      reviewed_by: documentS['Reviewed By'],
      profile_picture: documentS['Profile Picture'],
      posted_time: documentS['Time'],

    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[

        ListTile(
          title: Text(
              reviewed_by,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          leading: CircleAvatar(
            backgroundImage: NetworkImage(profile_picture),
          ),
          subtitle: Text(
              review,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
          //trailing:
        ),

        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
                posted_time.substring(0, 10)
            ),
          ),
        ),

        Divider(),
      ],
    );
  }
}

