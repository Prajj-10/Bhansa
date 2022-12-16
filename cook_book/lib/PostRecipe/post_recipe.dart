import 'package:cook_book/main.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class PostRecipe extends StatefulWidget {
  const PostRecipe({Key? key}) : super(key: key);

  @override
  State<PostRecipe> createState() => _PostRecipeState();
}

class _PostRecipeState extends State<PostRecipe> {

  //int currentStep = 0;

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
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
                      child: const TextField(

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
                        child: const TextField(

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
                      child: const TextField(

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

                    /*Container(


                      child: Stepper(
                        //currentStep: currentStep,
                        steps: const [
                          Step(
                              title: Text(
                                  "Step 1",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white)),
                              content: TextField(
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
                              )
                          ),


                        ],


                      ),
                    ),*/




                    const SizedBox(
                      height: 20,
                    ),

                    /*ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));

                      },
                      child: const Text("Upload Image"),
                    ),*/

                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Upload Image: ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),

                          SizedBox(
                            width: 15,
                          ),

                          IconButton(
                              onPressed: (){
                                //print('Hello');
                              },
                              color: Colors.white,
                              icon: Icon(Icons.camera_alt, size: 35,)
                          )
                        ],
                      ),
                    )




                  ],
                ),

              ),
            ),

          ],
        ),
      ),

    );
  }
}