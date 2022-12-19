
import 'package:cook_book/app/MyProfile/profileDetail.dart';
import 'package:cook_book/custom/CustomListView/recipeListView.dart';
import 'package:flutter/material.dart';
import '../../custom/CustomGridView/savedGridView.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
                colors: [
                  Color(0xFF01231C).withOpacity(1),
                  Color(0xFF131926).withOpacity(0.9),
                  //Color(0xFF0E2839).withOpacity(0.5),
                  Color(0xFF081017).withOpacity(0.8),
                ]
            ),
        ),
        child: DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return[
                  SliverList(delegate: SliverChildListDelegate([
                    const ProfileDetail(),
                  ]),)
                ];
              },
              body: SizedBox(
                width: size.width,
                //height: 1000,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF555555).withOpacity(0.2),
                          Color(0xFF7A7A7A).withOpacity(0.05),
                        ]

                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.blueGrey,
                          indicatorWeight: 1,
                          indicatorColor: Colors.white,
                          tabs: [
                            Tab(
                              child: Text("Recipes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            ),
                            Tab(
                              child: Text("Saved", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                              children: [
                                Recipe(),
                                Saved(),
                              ]),
                        ),
                      ],
                    ),
                  ),

                ),
              ),


            ),
          ),

        ),
      ),
    );
  }
}
