import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cook_book/main.dart';
import 'package:duration_picker/duration_picker.dart';

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

  //var image_url = "";

  //var selectedDuration;

  //String selectedDuration = "";
  //String? selectedDuration;


  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  CookingStepsModel steps_model = CookingStepsModel();

  final user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();


  Duration _duration = const Duration(hours: 0, minutes: 0);
  //var cook_time;
  //Duration selectedDuration = const Duration(hours: 0, minutes: 0);


  //To display selected image in UI
  //XFile? file;




  @override
  void initState(){

    super.initState();

    steps_model.cooking_steps = new List<String>.empty(growable: true);
    steps_model.cooking_steps!.add("");

    steps_model.recipe_ingredients = new List<String>.empty(growable: true);
    steps_model.recipe_ingredients!.add("");

    //Fluttertoast.showToast(msg: "Logged In successfully.");
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
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
            //First Image
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
                          steps_model.recipe_title = value;
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

                          keyboardType: TextInputType.number,

                          onChanged: (value){
                            steps_model.num_of_servings = int.parse(value);
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

                   /* const SizedBox(
                      height: 20,
                    ),*/

                    /*const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Ingredients: ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ),*/

                    const SizedBox(
                      height: 10,
                    ),

                    /*Container(
                      height: 50,
                      child:  TextField(

                        onChanged: (value){
                          steps_model.recipe_ingredients = value;
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
                    ),*/

                    const SizedBox(
                      height: 20,
                    ),

                    /*DurationPicker(
                        onChange: (val) {
                          _duration = val;
                          setState(() {

                          });
                      },
                      duration: _duration,
                      baseUnit: BaseUnit.minute,
                    ),*/

                    Container(
                      child: Row(
                        children: [
                          const Text(
                            "Prepare Duration: ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 15,
                          ),

                          IconButton(

                            color: Colors.white,
                            icon: const Icon(Icons.timer, size: 35,),

                            onPressed: () async {



                              Duration? selectedDuration = await showDurationPicker(context: context, initialTime: const Duration(minutes: 0));

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Preparing Duration is: $selectedDuration')),
                              );

                              setState(() {
                                steps_model.prepare_duration = selectedDuration.toString();
                              });



                            },


                          ),

                        ],
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),


                    Container(
                      child: Row(
                        children: [
                          const Text(
                            "Cooking Duration: ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 15,
                          ),

                          IconButton(

                            color: Colors.white,
                            icon: const Icon(Icons.timer, size: 35,),

                            onPressed: () async {



                              Duration? selectedDuration = await showDurationPicker(context: context, initialTime: const Duration(minutes: 0));

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Duration is: $selectedDuration')),
                              );

                              setState(() {
                                steps_model.cooking_duration = selectedDuration.toString();
                              });



                            },


                          ),

                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),


                    /*ElevatedButton(
                        onPressed: () async{
                          Duration? selectedDuration = await showDurationPicker(context: context, initialTime: const Duration(minutes: 0));

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Duration is: $selectedDuration')),
                          );

                        },
                        child: const Text("Pick Duration")

                    ),*/

                    /*const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Duration: $selectedDuration',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ),*/



                    const SizedBox(
                      height: 10,
                    ),

                    /*const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        selectedDuration,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ),*/

                    //Rohit code
                    // const Align(
                    //   alignment: Alignment.bottomLeft,
                    //   child: Text(
                    //     "cooking_steps: ",
                    //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                    //   ),
                    // ),



                    
                    //Rohit Code

                    //
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    //
                    // ListView.separated(
                    //     shrinkWrap: true,
                    //     physics: const ScrollPhysics(),
                    //     itemBuilder: (context, index){
                    //       return Column(
                    //         children: [_cooking_steps(index)],
                    //       );
                    //     },
                    //     separatorBuilder: (context, index)=> const Divider(),
                    //     itemCount: steps_model.cooking_steps!.length
                    // ),
                    
                    

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

                    SizedBox(
                      height: 10,
                    ),

                    //if (file != null) Image.file(file!, height: 150, width: 150, fit: BoxFit.cover) else FlutterLogo(size: 150,),

                    SizedBox(
                      height: 40,
                    ),


                    //Calling own widget
                    _uiWidget(),





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
    //XFile? image = await  imagePicker.pickImage(source: ImageSource.gallery);

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
      steps_model.image_url = await referenceImageToUpload.getDownloadURL();

    } catch(e){print(e);}


  }

  Future<void> addRecipe() {

    if(steps_model.image_url!.isEmpty){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload Image')));
    }

    return recipeDetails
        .add({
      /*'Title': recipe_title,
      'Number of Servings': num_of_servings,
      'Ingredients': ingredients,
      'Direction': steps_model.toJson(),
      'Image': image_url,
      'Posted By':loggedInUser.name,*/
      //'Time taken': selectedDuration
      'Details': steps_model.toJson(),
    })
        .then((value) => print("Posted"))
        .catchError((error) => print("Failed to add Recipe: $error"));
  }

  Widget _uiWidget(){
    return new Form(
      key: globalKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // FormHelper.inputFieldWidgetWithLabel(context,
              //     "username",
              //     "Username",
              //     "username",
              //     (onValidateVal){
              //   if(onValidateVal.isEmpty){
              //     return "Cannot be empty";
              //   }
              //   return null;
              //     },
              //     (onSavedVal){
              //   this.steps_model.cooking_steps = onSavedVal;
              //     },
              //   borderColor: Colors.redAccent,
              //   borderFocusColor: Colors.redAccent,
              //   borderRadius: 2,
              //   fontSize: 14,
              //   labelFontSize: 16,
              // ),

              _ingredientsContainer(),

              SizedBox(
                height: 50,
              ),

              _directionContainer(),

              const SizedBox(
                height: 15,
              ),

              //Post Recipe Button
              Center(
                child: FormHelper.submitButton(
                    btnColor: Colors.green,
                    borderColor: Colors.green,

                    "Post Recipe",
                        () {
                      if(validateAndSave()){
                        print(steps_model.toJson());
                        addRecipe();
                      }
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _directionContainer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Directions",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        //stepContainerUI(0)

        ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index){
              return Column(
                children: [
                  stepContainerUI(index),
                ],
              );
            },
            separatorBuilder: (contex, index)=> const Divider(),
            itemCount: steps_model.cooking_steps!.length)

      ],
    );

  }

  Widget stepContainerUI(index){
    return Padding(padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Flexible(child:
          FormHelper.inputFieldWidget(context,
            "step_$index",
            "Add Directions:",
            textColor: Colors.white,
                (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Cannot ${index + 1} be empty";
              }
              return null;
            },
                (onSavedVal){
              this.steps_model.cooking_steps![index] = onSavedVal;
            },
            borderColor: Colors.white,
            borderFocusColor: Colors.white,
            borderRadius: 2,
            fontSize: 14,
            hintColor: Colors.white,
          ),),

          Visibility(child:
          SizedBox(
            width:35 ,
            child: IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green,),
              onPressed: () {
                addStepControl();
              },

            ),
          ),
            visible: index == steps_model.cooking_steps!.length-1,
          ),

          Visibility(child:
          SizedBox(
            width:35 ,
            child: IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.redAccent,),
              onPressed: () {
                removeStepControl(index);
              },

            ),
          ),
            visible: index > 0,
          ),

        ],
      ),
    );
  }

  void addStepControl(){
    setState(() {
      steps_model.cooking_steps!.add("");
    });
  }

  void removeStepControl(index){
    setState(() {
      if(steps_model.cooking_steps!.length > 1){
        steps_model.cooking_steps!.removeAt(index);
      }
    });
  }

  //Ingredients Widget
  Widget _ingredientsContainer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Ingredients",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        //stepContainerUI(0)

        ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index){
              return Column(
                children: [
                  stepContainerUI_ingredients(index),
                ],
              );
            },
            separatorBuilder: (contex, index)=> const Divider(),
            itemCount: steps_model.recipe_ingredients!.length)

      ],
    );

  }

  Widget stepContainerUI_ingredients(index){
    return Padding(padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(child:
          FormHelper.inputFieldWidget(context,
            "step_$index",
            "Add Ingredients:",
            textColor: Colors.white,
                (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Cannot ${index + 1} be empty";
              }
              return null;
            },
                (onSavedVal){
              this.steps_model.recipe_ingredients![index] = onSavedVal;
            },
            borderColor: Colors.white,
            borderFocusColor: Colors.white,
            borderRadius: 2,
            fontSize: 14,
            hintColor: Colors.white,
          ),),

          Visibility(child:
          SizedBox(
            width:35 ,
            child: IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green,),
              onPressed: () {
                addStepControl_ingredients();
              },

            ),
          ),
            visible: index == steps_model.recipe_ingredients!.length-1,
          ),

          Visibility(child:
          SizedBox(
            width:35 ,
            child: IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.redAccent,),
              onPressed: () {
                removeStepControl_ingredients(index);
              },

            ),
          ),
            visible: index > 0,
          ),

        ],
      ),
    );
  }

  void addStepControl_ingredients(){
    setState(() {
      steps_model.recipe_ingredients!.add("");
    });
  }

  void removeStepControl_ingredients(index){
    setState(() {
      if(steps_model.recipe_ingredients!.length > 1){
        steps_model.recipe_ingredients!.removeAt(index);
      }
    });
  }


  bool validateAndSave(){
    final form = globalKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }



  //Rohit Codes
  // Widget _cooking_steps(index){
  //   //var index;
  //   return Padding(
  //     padding: EdgeInsets.all(0),
  //
  //     child: Row(
  //       children: [
  //         Flexible(
  //           child: FormHelper.inputFieldWidget(
  //             textColor: Colors.white,
  //
  //             context,
  //             "steps_$index",
  //             "",
  //                 (onValidate){
  //               if(onValidate.isEmpty){
  //                 return 'Step ${index +1} cannot be empty!!!';
  //               }
  //
  //               return null;
  //             },
  //                 (onSavedVal){
  //               steps_model.cooking_steps![index] = onSavedVal;
  //             },
  //             borderColor: Colors.white,
  //             borderFocusColor: Colors.white,
  //             borderRadius: 0,
  //             fontSize: 16,
  //
  //
  //           ),
  //         ),
  //
  //         Visibility(
  //           child: IconButton(
  //             icon: Icon(
  //               Icons.add_circle,
  //               color: Colors.lightGreenAccent,
  //               size: 30,
  //             ),
  //             onPressed: (){addSteps();},
  //           ),
  //           visible: index == steps_model.cooking_steps!.length -1,
  //         ),
  //
  //
  //
  //
  //         Visibility(
  //           child: IconButton(
  //             icon: Icon(
  //               Icons.remove_circle,
  //               color: Colors.redAccent,
  //               size: 30,
  //             ),
  //             onPressed: (){removeSteps(index);},
  //           ),
  //           visible: index > 0,
  //         ),
  //
  //
  //       ],
  //     ),
  //
  //
  //   );
  // }
  //
  //
  // void addSteps(){
  //   setState(() {
  //     steps_model.cooking_steps!.add("");
  //   });
  // }
  //
  // void removeSteps(index){
  //   setState(() {
  //     if(steps_model.cooking_steps!.length > 1){
  //
  //       steps_model.cooking_steps!.removeAt(index);
  //     }
  //   });
  //
  // }
  //
  // bool validateAndSave(){
  //   final form = globalKey.currentState;
  //   if(form!.validate()){
  //     form.save();
  //     return true;
  //   }
  //   else{
  //     return false;
  //   }
  // }
}