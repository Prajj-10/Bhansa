import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../EditProfile/btnEditProfile.dart';
import '../../custom/ExpandedWidgets/expandedProfileDescription.dart';

class ProfileDetail extends StatelessWidget {

  //Variables
  var name;
  var username;
  var description;
  var profilePicture;

  ProfileDetail({super.key, required this.name, required this.username, required this.description, required this.profilePicture});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                    profilePicture != null ?
                    DecorationImage(
                      image: NetworkImage(profilePicture!),
                      fit: BoxFit.fill,
                    )
                    : DecorationImage(
                      image: NetworkImage("https://st3.depositphotos.com/3935465/12919/i/950/depositphotos_129194616-stock-photo-avocado-tomato-and-arugula-salad.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  //child: Image.network("https://media.istockphoto.com/id/1190330112/photo/fried-pork-and-vegetables-on-white-background.jpg?s=612x612&w=0&k=20&c=TzvLLGGvPAmxhKJ6fz91UGek-zLNNCh4iq7MVWLnFwo=",fit: BoxFit.fill,)
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

                                Text(name??"Your name here.",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(username ?? "Your username here.",
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
                            Expanded(child: FollowButton(btnHeight: 35, btnWidth: 60, number: "100K", name: "Followers")),
                            SizedBox(width: size.width*0.02,),
                            Expanded(child: FollowButton(btnHeight: 35, btnWidth: 60, number: "100K", name: "Following")),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Expanded(child: BtnEditProfile()),
                              SizedBox(width: size.width*0.02,),
                              InkWell(
                                onTap: (){

                                },
                                  child: Icon(Icons.settings, color: Colors.white, size: 30,)
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
                  description != null ?
                  ExpandedProfileDescription(profileDescription: description!)
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
