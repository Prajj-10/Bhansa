import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cook_book/main.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:intl/intl.dart';


import '../../model/user_model.dart';
import 'storage_services.dart';


import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:file_picker/file_picker.dart';

import '../../model/cookingSteps_model.dart';



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

  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  CookingStepsModel steps_model = CookingStepsModel();

  DateTime postedDateTime = DateTime.now();
  //String postedDate = DateTime.now("yyyy-MM-dd").toString();

  //String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //'EEEE, MMM d, yyyy' output=> Tuesday, Jan 25, 2022

  //String currentDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());

  final user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  Duration _duration = const Duration(hours: 0, minutes: 0);

  Duration cook_duration = Duration.zero;
  Duration prep_duration = Duration.zero;
  Duration t_duration = Duration.zero;

  //To display selected image in UI
  var file;

  var _counterTextRecipeTitle = "";
  var _counterTextRecipeDescription= "";


  @override
  void initState(){
    super.initState();
    steps_model.cooking_steps = new List<String>.empty(growable: true);
    steps_model.cooking_steps!.add("");

    steps_model.recipe_ingredients = new List<String>.empty(growable: true);
    steps_model.recipe_ingredients!.add("");

    steps_model.likes = new List<String>.empty(growable: true);
    steps_model.likes!.add("");

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

      appBar: AppBar(
        title: Text(
          'Post Recipe',
          style: GoogleFonts.dancingScript(
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white)
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(

          children: [
            const SizedBox(
              height: 50,
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Upload Image: ",
                style: GoogleFonts.robotoMono(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            //First Image
            Stack(
                children: [
                  Container(
                    child: file != null ?
                    Image.file(
                      file!,
                      height: height/2.2,
                      width: width,
                      fit: BoxFit.cover,)
                        : Container(
                      height: height/2.2,
                      width: width,
                      //color: Colors.white,
                      decoration: const BoxDecoration(

                        image: DecorationImage(
                          image: AssetImage("assets/Camera.png"),
                          fit: BoxFit.cover,
                        ),

                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        /*borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),*/
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * .4,
                    top: height * .2,
                    child: Container(
                      child: IconButton(
                        color: Colors.grey,
                        icon: const Icon(Icons.add_a_photo, size: 40,),
                        onPressed: () { uploadImage();},
                      ),
                    ),
                  ),

                ]
            ),


            const SizedBox(
              height: 20,
            ),


            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Recipe Title: ",
                        //style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                        style: GoogleFonts.robotoMono(
                            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 85,
                      child:  TextField(
                        onChanged: (value){
                          steps_model.recipe_title = value;

                          setState(() {
                            _counterTextRecipeTitle = (50 - value.length).toString();
                          });
                        },

                        maxLength: 50,

                        style: TextStyle(fontSize: 16, color: Colors.white),

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          counterText: "$_counterTextRecipeTitle / 50",
                          counterStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),


                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Recipe Description: ",
                        style: GoogleFonts.robotoMono(
                            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 180,
                      child:  TextField(
                        expands: true,
                        maxLines: null,
                        onChanged: (value){
                          steps_model.recipe_description = value;

                          setState(() {
                            _counterTextRecipeDescription = (500 - value.length).toString();
                          });
                        },
                        maxLength: 500,

                        style: TextStyle(fontSize: 16, color: Colors.white),

                        decoration: InputDecoration(
                          hintText: 'Write a short description of your Recipe...',
                          hintStyle: TextStyle(fontSize: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          counterText: "$_counterTextRecipeDescription / 500",
                          counterStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),


                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Number of Servings: ",
                        style: GoogleFonts.robotoMono(
                            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                        ),
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
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                "Prepare Duration: ",
                                style: GoogleFonts.robotoMono(
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                                ),
                              ),

                              IconButton(
                                color: Colors.white,
                                icon: const Icon(Icons.timer, size: 35,),
                                onPressed: () async {
                                  Duration? selectedDuration = await showDurationPicker(context: context, initialTime: const Duration(minutes: 0));
                                  setState(() {
                                    prep_duration = selectedDuration!;
                                    steps_model.p_duration= selectedDuration.toString();

                                    String testDuration = selectedDuration.toString();
                                    if(testDuration.substring(0, 1) =='0'){
                                      steps_model.prepare_duration = testDuration.substring(2, 4) +" min";
                                    }
                                    else if(testDuration.substring(2, 4) == '00'){
                                      steps_model.prepare_duration = testDuration.substring(0, 1) + " hrs ";
                                    }
                                    else{
                                      steps_model.prepare_duration = testDuration.substring(0, 1) + " hrs " + testDuration.substring(2, 4) +" min";
                                    }
                                  });
                                },
                              ),

                              Text(
                                "${steps_model.prepare_duration}",
                                //style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                                style: GoogleFonts.robotoMono(
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                "Cooking Duration: ",
                                style: GoogleFonts.robotoMono(
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                                ),
                              ),

                              IconButton(
                                color: Colors.white,
                                icon: const Icon(Icons.timer, size: 35,),
                                onPressed: () async {
                                  Duration? selectedDuration = await showDurationPicker(context: context, initialTime: const Duration(minutes: 0));
                                  setState(() {
                                    //steps_model.cooking_duration = selectedDuration?.inMinutes as Duration?;
                                    steps_model.c_duration = selectedDuration.toString();
                                    cook_duration=selectedDuration!;

                                    String testDuration = selectedDuration.toString();
                                    if(testDuration.substring(0, 1) =='0'){
                                      steps_model.cooking_duration = testDuration.substring(2, 4) +" min";
                                    }
                                    else if(testDuration.substring(2, 4) == '00'){
                                      steps_model.cooking_duration = testDuration.substring(0, 1) + " hrs ";
                                    }
                                    else{
                                      steps_model.cooking_duration = testDuration.substring(0, 1) + " hrs " + testDuration.substring(2, 4) +" min";
                                    }
                                    calcTotalDuration();
                                  });
                                },

                              ),

                              Text(
                                "${steps_model.cooking_duration}",
                                style: GoogleFonts.robotoMono(
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //Calling own widget
                    _uiWidget(),
                    const SizedBox(
                      height: 20,
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

  calcTotalDuration(){
    t_duration =cook_duration+prep_duration;
    String totalDuration = t_duration.toString();

    setState(() {
      //steps_model.testDurationFinal = totalDuration;
      if(totalDuration.substring(0, 1) =='0'){
        steps_model.testDurationFinal = totalDuration.substring(2, 4) +" min";
      }
      else if(totalDuration.substring(2, 4) == '00'){
        steps_model.testDurationFinal = totalDuration.substring(0, 1) + " hrs ";
      }
      else{
        steps_model.testDurationFinal = totalDuration.substring(0, 1) + " hrs " + totalDuration.substring(2, 4) +" min";
      }
    });

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

  Future uploadImage() async{

    //pick image from gallery
    //install file_picker package and import necessary library
    ImagePicker imagePicker = ImagePicker();
    final file = (await  imagePicker.pickImage(source: ImageSource.gallery));
    //XFile? image = await  imagePicker.pickImage(source: ImageSource.gallery);

    if(file==null) return;

    //Added Later
    final imageTemporary = File(file.path);
    setState(() => this.file = imageTemporary);
    //End

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
      'Title' : steps_model.recipe_title,
      'Description': steps_model.recipe_description,
      'Number of Servings' : steps_model.num_of_servings,
      'Ingredients': steps_model.toJson_Ingredients(),
      'Cooking Direction': steps_model.toJson_CookingDirections(),
      'Prepare Duration' : steps_model.prepare_duration,
      'Cooking Duration' : steps_model.cooking_duration,
      'Total Duration': steps_model.testDurationFinal,
      'Posted By':user?.uid,
      'Photo' : steps_model.image_url,
      'Posted On' : postedDateTime,
      'Likes': steps_model.toJson_Likes(),


    })
        .then((value) => print("Posted ${value.id}"))
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

              _ingredientsContainer(),

              SizedBox(
                height: 50,
              ),

              _directionContainer(),

              const SizedBox(
                height: 50,
              ),

              //Post Recipe Button
              Center(
                child: FormHelper.submitButton(
                    btnColor: Colors.green,
                    borderColor: Colors.green,

                    "Post Recipe",
                        () {
                      if(validateAndSave()){


                        if(steps_model.recipe_title == null || steps_model.recipe_description == null || steps_model.num_of_servings == null || steps_model.p_duration == null || steps_model.c_duration == null || file == null){
                          //print('All fields are Required!!!');

                          AnimatedSnackBar.material(
                              'All fields are required including Image!!!',
                              type: AnimatedSnackBarType.error,
                              mobileSnackBarPosition: MobileSnackBarPosition.top,
                              desktopSnackBarPosition:
                              DesktopSnackBarPosition.topRight)
                              .show(context);

                        }

                        else{
                          addRecipe();
                        }

                      }
                    }
                ),
              ),

              SizedBox(
                height: 50,
              ),

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
            "Directions:",
            textAlign: TextAlign.left,
            style: GoogleFonts.robotoMono(
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
            ),
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
                return "Direction ${index + 1} be empty";
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
          padding: const EdgeInsets.all(0),
          child: Text(
            "Ingredients:",
            textAlign: TextAlign.left,
            style: GoogleFonts.robotoMono(
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
            ),
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
                return "Ingredients ${index + 1} be empty";
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

}




