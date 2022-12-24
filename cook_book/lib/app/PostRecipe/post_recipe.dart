import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cook_book/main.dart';

import '../../model/user_model.dart';
import 'storage_services.dart';


import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:file_picker/file_picker.dart';

import 'cookingSteps_model.dart';

class PostRecipe extends StatefulWidget {
  const PostRecipe({Key? key}) : super(key: key);

  @override
  State<PostRecipe> createState() => _PostRecipeState();
}

class _PostRecipeState extends State<PostRecipe> {

  //int currentStep = 0;
  CollectionReference recipeDetails = FirebaseFirestore.instance.collection('recipe_details');

  String? ingredients, recipe_title;
  int? num_of_servings;

  String image_url = "";

  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  CookingStepsModel steps_model = CookingStepsModel();

  final user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();




  @override
  void initState(){

    super.initState();

    steps_model.cooking_steps = new List<String>.empty(growable: true);
    steps_model.cooking_steps!.add("");

    //Fluttertoast.showToast(msg: "Logged In successfully.");
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

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final Storage storage = Storage();

    return Scaffold(
      //backgroundColor: Colors.black,
      /*appBar: AppBar(
        title: const Text("Post Your Recipe"),
        centerTitle: true,
      ),*/

      body: SingleChildScrollView(
        child: Column(

          children: [
            /*SizedBox(
              height: 90,
            ),*/
            Container(
              height: height/2.2,
              width: width,
              decoration: const BoxDecoration(

                image: DecorationImage(
                  image: AssetImage("assets/postRecipe.jpg"),
                  fit: BoxFit.cover,
                ),

                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const Align(
              alignment: Alignment.center,
              child: Text(
                "Recipe Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(

                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),

                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Recipe Title: ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 50,
                      child:  TextField(

                        onChanged: (value){
                          recipe_title = value;
                        },



                        style: TextStyle(fontSize: 20, color: Colors.white),

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Number of Servings: ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 50,
                        width: 180,
                        child: TextField(

                          onChanged: (value){
                            num_of_servings = int.parse(value);
                            //num_of_servings = value;
                          },

                          style: TextStyle(fontSize: 20, color: Colors.white),

                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Ingredients: ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 50,
                      child:  TextField(

                        onChanged: (value){
                          ingredients = value;
                        },

                        style: TextStyle(fontSize: 20, color: Colors.white),

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Directions: ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    ListView.separated(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index){
                          return Column(
                            children: [_directions(index)],
                          );
                        },
                        separatorBuilder: (context, index)=> const Divider(),
                        itemCount: steps_model.cooking_steps!.length
                    ),

                    const SizedBox(
                      height: 20,
                    ),



                    Container(
                      child: Row(
                        children: [
                          const Text(
                            "Upload Image: ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 15,
                          ),

                          /*IconButton(
                              onPressed: (){
                                //print('Hello');
                                _getFromCamera();
                              },
                              color: Colors.white,
                              icon: Icon(Icons.camera_alt, size: 35,)
                          ),*/

                          IconButton(
                              /*onPressed: ()async{
                                final results = await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg'],
                                );

                                if(results == null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("No Photo selected"),
                                      )
                                  );

                                  return null;
                                }

                                final path = results.files.single.path!;
                                final fileName = results.files.single.name;

                                storage
                                    .uploadImage(path, fileName)
                                    .then((value)=>print('Done'));

                              },*/
                              color: Colors.white,
                              icon: const Icon(Icons.file_upload, size: 35,),

                            onPressed: () { uploadImage(); },
                          ),

                        ],
                      ),
                    ),








                    const SizedBox(
                      height: 50,
                    ),

                    ElevatedButton(
                        onPressed: () {
                          addRecipe();
                        },
                        child: Text('Post Recipe')
                    ),

                    const SizedBox(
                      height: 30,
                    ),




                  ],
                ),

              ),
            ),

          ],
        ),
      ),

    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  }

  uploadImage() async{

    //pick image from gallery
    //install file_picker package and import necessary library
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await  imagePicker.pickImage(source: ImageSource.gallery);

    if(file==null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //upload picked image in firestore
    //install firebase_storage package and import necessary library

    //get a reference to storage
    Reference referenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceroot.child('images');

    //create reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //store image
    //error handeling
    try{

      await referenceImageToUpload.putFile(File(file!.path));
      image_url = await referenceImageToUpload.getDownloadURL();

    } catch(e){print(e);}


  }

  Future<void> addRecipe() {

    if(image_url.isEmpty){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload Image')));
    }

    return recipeDetails
        .add({
      'Title': recipe_title,
      'Number of Servings': num_of_servings,
      'Ingredients': ingredients, // 42
      'Image': image_url,
      'Posted By':loggedInUser.name,
    })
        .then((value) => print("Posted"))
        .catchError((error) => print("Failed to add Recipe: $error"));
  }

  Widget _directions(index){
    //var index;
    return Padding(
      padding: EdgeInsets.all(0),

      child: Row(
        children: [
          Flexible(
            child: FormHelper.inputFieldWidget(
              textColor: Colors.white,

              context,
              "steps_$index",
              "",
                  (onValidate){
                if(onValidate.isEmpty){
                  return 'Step ${index +1} cannot be empty!!!';
                }

                return null;
              },
                  (onSavedVal){
                steps_model.cooking_steps![index] = onSavedVal;
              },
              borderColor: Colors.white,
              borderFocusColor: Colors.white,
              borderRadius: 0,
              fontSize: 16,


            ),
          ),

          Visibility(
            child: IconButton(
              icon: Icon(
                Icons.add_circle,
                color: Colors.lightGreenAccent,
                size: 30,
              ),
              onPressed: (){addSteps();},
            ),
            visible: index == steps_model.cooking_steps!.length -1,
          ),



          /*SizedBox(
                  width: 10,
                ),*/

          Visibility(
            child: IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: Colors.redAccent,
                size: 30,
              ),
              onPressed: (){removeSteps(index);},
            ),
            visible: index > 0,
          ),


        ],
      ),


    );
  }

  void addSteps(){
    setState(() {
      steps_model.cooking_steps!.add("");
    });
  }

  void removeSteps(index){
    setState(() {
      if(steps_model.cooking_steps!.length > 1){

        steps_model.cooking_steps!.removeAt(index);
      }
    });
  }
}