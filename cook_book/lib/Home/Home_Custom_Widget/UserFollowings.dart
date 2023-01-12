import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/Home/Home_Custom_Widget/big_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/MyProfile/myProfile.dart';
import '../../app/SearchUser/SearchPerson.dart';
import '../../app/UserProfile/userProfile.dart';

class FollowingUsersList extends StatelessWidget{

  var currUserId = FirebaseAuth.instance.currentUser?.uid;
  //CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection("Following").doc('uid').collection('userFollowing');


  // @override
  // void initState() {
  //   //Function
  //   super.initState();
  //
  // }
  @override
  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance.collection("Following").doc(currUserId).collection('userFollowing').snapshots();
    return StreamBuilder(
        stream: firestoreDB,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: Text("You are not following anyone."),);
          }
          else{
            return Container(
                height: 100,
                //color: Colors.red,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index){
                      var uid = snapshot.data?.docs[index].id;
                      return GestureDetector(
                        onTap: ()=> currUserId==uid?
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile(userId: uid)))
                            :Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile(userId: uid,))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage('${snapshot.data?.docs[index]['profile_picture']}'),
                                //backgroundImage: NetworkImage('https://i.pinimg.com/736x/59/37/5f/59375f2046d3b594d59039e8ffbf485a.jpg'),
                              ),
                              Container(
                                  width: 80,
                                  child: BigText(text: '${snapshot.data?.docs[index]['name']}', size: 14,))
                            ],
                          ),
                        ),
                      );
                    })
            );
          }


        });
  }

}