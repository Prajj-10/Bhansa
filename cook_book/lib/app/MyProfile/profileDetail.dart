import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';
import '../../custom/ExpandedWidgets/expandedProfileDescription.dart';
import '../EditProfile/editProfile.dart';
import '../loginpage/login.dart';

class ProfileDetail extends StatefulWidget {

  //Variables
  var name;
  var username;
  var description;
  var profilePicture;

  ProfileDetail({super.key, required this.name, required this.username, required this.description, required this.profilePicture});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  int noOfFollowers = 0;
  int noOfFollowing = 0;
  var currentUserId = FirebaseAuth.instance.currentUser?.uid;

  final followersRef = FirebaseFirestore.instance.collection('Followers');
  final followingRef = FirebaseFirestore.instance.collection('Following');

  getFollowers() async {
    QuerySnapshot snapshot = await followersRef
        .doc(currentUserId)
        .collection('userFollowers')
        .get();
    setState(() {
      noOfFollowers = snapshot.docs.length;
    });
  }

  getFollowings() async {
    QuerySnapshot snapshot = await followingRef
        .doc(currentUserId)
        .collection('userFollowing')
        .get();
    setState(() {
      noOfFollowing = snapshot.docs.length;
    });
  }

  final ref = FirebaseDatabase.instance.ref('users');
  final user = FirebaseAuth.instance.currentUser;
  final googleSignIn = GoogleSignIn();
  UserModel loggedInUser = UserModel();

  Future<void> logout(BuildContext context) async {
    await googleSignIn.currentUser?.clearAuthCache();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
    Fluttertoast.showToast(msg: "Logged Out Successfully.");
  }

  @override
  void initState() {
    super.initState();
    getFollowings();
    getFollowers();
  }
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Column(
      children: [
            Row(
              children: [
                Container(
                  height: size.width/2.8,
                  width: size.width/2.8,

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

                                Text(widget.name??"Your name here",
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
                            Expanded(child: FollowButton(btnHeight: 35, btnWidth: 60, number: noOfFollowers.toString(), name: "Followers")),
                            SizedBox(width: size.width*0.02,),
                            Expanded(child: FollowButton(btnHeight: 35, btnWidth: 60, number: noOfFollowing.toString(), name: "Following")),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Expanded(child: OutlinedButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile()));
                                },

                                style: OutlinedButton.styleFrom(
                                  //backgroundColor: Colors.white,
                                  side: BorderSide(color: Colors.white),
                                  foregroundColor: Colors.orange,
                                  fixedSize: Size(100, 30),
                                ),


                                child: Text("Edit Profile"),

                              ),),
                              SizedBox(width: size.width*0.02,),
                              InkWell(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (builder){
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                          title: Text("Are you sure you want to Logout?", style: TextStyle(color: Colors.black),),
                                          actions: [
                                            TextButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                                            ),
                                            TextButton(
                                                onPressed: (){
                                                  logout(context);
                                                },
                                                child: Text("Yes, Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        );
                                      }
                                  );
                                  //logout(context);
                                },
                                  child: Icon(Icons.logout, color: Colors.red, size: 30,)
                              ),

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

class FollowButton extends StatelessWidget {
  //const Button({Key? key}) : super(key: key);

  final double btnHeight;
  final double btnWidth;
  final String number;
  final String name;

  const FollowButton({required this.btnHeight, required this.btnWidth, required this.number, required this.name});

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
          Text(number, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
          Text(name, style: TextStyle(fontSize: 12, color: Colors.white),),
        ],
      ),
    );
  }
}
