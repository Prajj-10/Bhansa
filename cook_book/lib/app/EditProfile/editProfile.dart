import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/EditProfile/imagePicker.dart';
import 'package:cook_book/custom/CustomButtons/updateElevatedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user_model.dart';
import 'editProfile.dart';
class EditProfile extends StatefulWidget {

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  File? profilePicture;
  Future imagePicker(ImageSource source) async{
    try {
      final img = await ImagePicker().pickImage(source: source);
      if (img == null) return;
      final imageTemporary = File(img.path);
      setState(()=> this.profilePicture = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");

    }
  }
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          title: Center(child: Text("Edit Profile", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
          backgroundColor: Color(0xFF01231C),
          elevation: 0,
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
                colors: [
                  Color(0xFF01231C).withOpacity(1),
                  Color(0xFF131926).withOpacity(0.9),
                  Color(0xFF081017).withOpacity(0.8),
                ]
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.85,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF081017).withOpacity(0.7),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          child: Column(
                            children: [
                              profilePicture != null?
                              ClipOval(child: Image.file(profilePicture!, width: 160, height: 160, fit: BoxFit.cover,))
                              :SizedBox(
                                height: 160,
                                width: 160,

                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1, color: Colors.white),
                                    image: const DecorationImage(
                                      image: NetworkImage("https://img.freepik.com/premium-vector/smiling-chef-cartoon-character_8250-10.jpg?w=2000"),

                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),

                              ),

                              TextButton(
                                onPressed: (){
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (builder)=>Image_Picker(pickImage: imagePicker,),
                                  );
                                },
                                child: const Text("Upload new profile", style: TextStyle(fontSize: 16, color: Colors.blue), ),
                              ),

                              //Name
                              editProfile_InputField(txt_Label: "Name", max_Length: 25, max_Lines: 1,placeholder: user?.displayName,),

                              //Username
                              editProfile_InputField(txt_Label: "Username", max_Length: 16, max_Lines: 1,placeholder: user?.email,),

                              //Description
                              editProfile_InputField(txt_Label: "Description", max_Length: 1000, max_Lines: 5,placeholder: user?.uid,),

                              SizedBox(height: 30,),
                              //Update Button
                              UpdateElevatedButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



//Text field
class editProfile_InputField extends StatelessWidget {

  var txt_Label;
  int max_Length;
  int max_Lines;
  var placeholder;

  editProfile_InputField({super.key, required this.txt_Label, required this.max_Length, required this.max_Lines, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: max_Length,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: max_Lines,
      initialValue: placeholder,
      /*onFieldSubmitted: (String value){
        debugPrint(value);
      },*/
      style: TextStyle(color: Colors.white, fontSize: 12),
      decoration: InputDecoration(
        counterStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Times New Roman"),
        //hintText: "Username",
        labelText: txt_Label,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white,),
        ),
      ),
    );
  }
}
class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  final user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
