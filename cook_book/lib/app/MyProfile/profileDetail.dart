import 'package:flutter/material.dart';

import '../EditProfile/btnEditProfile.dart';
import '../../custom/ExpandedWidgets/expandedProfileDescription.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({Key? key}) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [

            Row(
              children: [
                Container(
                  height: size.width/2.4,
                  width: size.width/2.4,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image: const DecorationImage(
                      image: NetworkImage("https://st3.depositphotos.com/3935465/12919/i/950/depositphotos_129194616-stock-photo-avocado-tomato-and-arugula-salad.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  //child: Image.network("https://media.istockphoto.com/id/1190330112/photo/fried-pork-and-vegetables-on-white-background.jpg?s=612x612&w=0&k=20&c=TzvLLGGvPAmxhKJ6fz91UGek-zLNNCh4iq7MVWLnFwo=",fit: BoxFit.fill,)
                ),
                //SizedBox(width: size.width*0.05,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Row(
                          children: [
                            SizedBox(width: size.width*0.05,),
                            Column(
                              children: const [

                                Text("Master Chef",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text("@master_chef",
                                    style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height*0.02,),
                        Row(
                          children: [
                            SizedBox(width: size.width*0.03,),
                            Expanded(child: FollowButton(btnHeight: 40, btnWidth: 85, number: "100K", name: "Followers")),
                            SizedBox(width: size.width*0.02,),
                            Expanded(child: FollowButton(btnHeight: 40, btnWidth: 85, number: "100K", name: "Following")),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(child: BtnEditProfile()),
                              SizedBox(width: size.width*0.02,),
                              Icon(Icons.settings, color: Colors.white, size: 40,),

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
                  child: ExpandedProfileDescription(profileDescription: "This pizza soup is a comfort food recipe to the max! Who wouldn’t want all the flavors of a supreme pizza wrapped up in a cozy bowl? The broth is flavored with pizza sauce, tomatoes, and a little Parmesan to make it creamy. The toppings are swimming along inside: bell peppers, garlic and mushrooms, making for a savory pop that surprises you in every bite. Serve with garlic toast, grilled cheese or simply crusty bread and it’s a meal you’ll want to make over and over…and over."),
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
          Text(number, style: TextStyle(fontSize: 14, color: Colors.white),),
          Text(name, style: TextStyle(fontSize: 14, color: Colors.white),),
        ],
      ),
    );
  }
}
