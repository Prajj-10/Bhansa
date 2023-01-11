import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../custom/CustomButtons/Follow_UnFollowButton.dart';
import '../../custom/ExpandedWidgets/expandedProfileDescription.dart';
import '../EditProfile/editProfile.dart';

class UserProfileDetail extends StatefulWidget {

  //Variables
  var profileId;
  var name;
  var username;
  var description;
  var profilePicture;

  UserProfileDetail({super.key,required this.profileId, required this.name, required this.username, required this.description, required this.profilePicture});
  @override
  State<UserProfileDetail> createState() => _UserProfileDetailState();
}

class _UserProfileDetailState extends State<UserProfileDetail> {
  //Variables
  bool isFollowing = false;
  int noOfFollowers = 0;
  int noOfFollowing = 0;

  //Firestore references
  final followersRef = FirebaseFirestore.instance.collection('Followers');
  final followingRef = FirebaseFirestore.instance.collection('Following');
  var user = FirebaseAuth.instance.currentUser;

  void checkIfFollowing() async {

    DocumentSnapshot docSnapshot = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(user?.uid)
        .get();
    setState(() {
      isFollowing = docSnapshot.exists;
    });
  }

  getFollowers() async {
    QuerySnapshot snapshot = await followersRef
    .doc(widget.profileId)
    .collection('userFollowers')
    .get();
    setState(() {
      noOfFollowers = snapshot.docs.length;
    });
  }

  getFollowings() async {
    QuerySnapshot snapshot = await followingRef
        .doc(widget.profileId)
        .collection('userFollowing')
        .get();
    setState(() {
      noOfFollowing = snapshot.docs.length;
    });
  }

  handleFollow(){
    setState(() {
      isFollowing = true;
    });
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(user?.uid)
        .set({});

    followingRef
        .doc(user?.uid)
        .collection('userFollowing')
        .doc(widget.profileId)
        .set({
      "name" : widget.name,
      "profile_picture" : widget.profilePicture,
      "user": user?.uid,
    });
  }

  handleUnfollow(){
    //print("Hello");
    setState(() {
      isFollowing = false;
    });

    //Remove Followers
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(user?.uid)
        .get().then((data) {
          if (data.exists){
            data.reference.delete();
            }
          });

    followingRef
        .doc(user?.uid)
        .collection('userFollowing')
        .doc(widget.profileId)
        .get().then((data) {
        if (data.exists){
          data.reference.delete();
          }
         });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    checkIfFollowing();
    getFollowers();
    getFollowings();
    return Column(
      children: [

            Row(
              children: [
                Container(
                  height: size.width/2.7,
                  width: size.width/2.7,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image:
                    //loggedInUser.profilePicture != null ?
                    widget.profilePicture != null ?
                    DecorationImage(
                      image: NetworkImage(widget.profilePicture!),
                      fit: BoxFit.fill,
                    )
                    : DecorationImage(
                      image: NetworkImage("https://st3.depositphotos.com/3935465/12919/i/950/depositphotos_129194616-stock-photo-avocado-tomato-and-arugula-salad.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                //SizedBox(width: size.width*0.05,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Row(
                          children: [
                            SizedBox(width: size.width*0.05,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(widget.name??"Your name here.",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(widget.username ?? "Your username here.",
                                    style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height*0.01,),
                        Row(
                          children: [
                            SizedBox(width: size.width*0.03,),
                            Expanded(child: Follower_Following(btnHeight: 35, btnWidth: 60, number: noOfFollowers, name: "Followers")),
                            SizedBox(width: size.width*0.02,),
                            Expanded(child: Follower_Following(btnHeight: 35, btnWidth: 60, number: noOfFollowing, name: "Following")),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: isFollowing? Follow_Unfollow(
                                  text: "Unfollow",
                                  function: handleUnfollow,
                                )
                                    : Follow_Unfollow(
                                    text: "Follow",
                                    function: handleFollow,
                                )
                                ),
                              SizedBox(width: size.width*0.02,),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(height: size.height*0.01,),

            // ---------------Profile Description
            Row(
              children: [
                Expanded(
                  child:
                  widget.description != null ?
                  ExpandedProfileDescription(profileDescription: widget.description!)
                      :SizedBox(height: 20,),
                ),

              ],

            ),

            SizedBox(height: size.height*0.01,),

      ],
    );
  }


}

class Follower_Following extends StatelessWidget {
  //const Button({Key? key}) : super(key: key);

  final double btnHeight;
  final double btnWidth;
  final int number;
  final String name;

  const Follower_Following({required this.btnHeight, required this.btnWidth, required this.number, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight,
      width: btnWidth,

      decoration: BoxDecoration(
        color: Color(0xFF1B6E13),
        borderRadius: BorderRadius.circular(30),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
          Text(name, style: TextStyle(fontSize: 12, color: Colors.white),),
        ],
      ),
    );
  }
}
