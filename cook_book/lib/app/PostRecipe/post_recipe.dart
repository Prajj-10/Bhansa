import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/PostRecipe/reviews.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  DocumentReference recipe_details_doc_reference = FirebaseFirestore.instance.collection('recipe_details').doc();
  //DocumentSnapshot docSnap = await recipe_details_doc_reference.get()

  String? document_id = "";

  //DocumentSnapshot docSnap = recipe_details_doc_reference.get();
  Future<String> get_data(DocumentReference doc_ref) async {
    DocumentSnapshot docSnap = await doc_ref.get();
    var doc_id2 = docSnap.reference.id;
    return doc_id2;
  }

  //To retrieve the string
  //String documentId = await get_data();
  //String documentId = await get_data(recipe_details_doc_reference);







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
  //var cook_time;
  //Duration selectedDuration = const Duration(hours: 0, minutes: 0);


  //To display selected image in UI
  var file;

  //Duration? total_duration, p_duration, c_duration;
  //var postId = 'ip5z8vKiaZHGYIEwPQch';
  var postId = 'jmFMW3la98dG7G9mEmfk';
  //var ownerId, mediaUrl;






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

      body: SingleChildScrollView(
        child: Column(

          children: [
            const SizedBox(
              height: 50,
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
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 160,
                    child: Container(

                      child: IconButton(

                        color: Colors.black,
                        icon: const Icon(Icons.file_upload, size: 50,),

                        onPressed: () { uploadImage();},

                      ),



                    ),
                  ),

                ]
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
                        "Recipe Description: ",
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
                          steps_model.recipe_description = value;
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



                    const SizedBox(
                      height: 10,
                    ),



                    const SizedBox(
                      height: 20,
                    ),



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
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
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
                                //Previous code start
                                //steps_model.cooking_duration = selectedDuration.toString();
                                //Previous code end

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
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 70,

                    ),

                    //Calling own widget
                    _uiWidget(),

                    const SizedBox(
                      height: 20,
                    ),

                    IconButton(
                        color: Colors.white,

                        onPressed: (){
                          showReviews(

                            context,
                            postId: postId,
                            /*ownerId: ownerId,
                            mediaUrl: mediaUrl,*/

                          );
                          //showReviews();
                          print('--------------------------Hello-------------------------');
                        } ,


                        icon: Icon(Icons.reviews_sharp, size: 35,)
                    ),

                    const SizedBox(
                      height: 70,

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
      //'Recipe ID': steps_model.recipe_id_pk = DateTime.now().millisecondsSinceEpoch.toString(),
      //'Recipe ID' : "",
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
      'Posted On' : postedDateTime

    })

    //.then((value) => document_id = value.id.toString())
    //.whenComplete((value) => document_id = value.id)
    //.then((value) => recipeDetails.add({"Recipe Id": ${value.id} }))
        .then((value) => print("Posted ${value.id}"))
        .catchError((error) => print("Failed to add Recipe: $error"));
  }

  /*Future<void> updateRecipeId() async {

    var dID = get_data(recipe_details_doc_reference);

    return recipeDetails
        .doc(recipeDetails.id)
        .update({'Recipe ID': recipeDetails.id})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));



  }*/

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
                        //print(steps_model.toJson());
                        addRecipe();
                        //updateRecipeId();

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

}


showReviews(BuildContext context, { var postId}) {

  Navigator.push(context, MaterialPageRoute(builder: (context){

    return Reviews(
      postId: postId,
      /*postOwnerId: ownerId,
      postMediaUrl: mediaUrl,*/
    );

  }));

}


