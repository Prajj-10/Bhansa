import 'package:cook_book/app/EditProfile/imagePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EditProfile extends StatelessWidget {
  const EditProfile({super.key});
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
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF081017).withOpacity(0.7),
                ),
                
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.width*0.35,
                            width: size.width*0.35,

                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1, color: Colors.white),
                                image: DecorationImage(
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
                                    builder: (builder)=>Image_Picker(),
                                );
                              },
                              child: Text("Upload new profile", style: TextStyle(fontSize: 16),),
                          ),

                          //Name
                          editProfile_InputField(txtLabel: "Name"),

                          //Username
                          editProfile_InputField(txtLabel: "Username"),

                          //Description
                          editProfile_InputField(txtLabel: "Description"),

                        ],
                      ),
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


//Choose image picker options
/*Widget modal_chooseImagePicker(BuildContext context){
  return SizedBox(
    height: 200,
    width: MediaQuery.of(context).size.width,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withOpacity(0.8),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Choose profile picture", style: TextStyle(fontSize: 18, decoration: TextDecoration.none, color: Colors.black),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.camera),
                    label: Text("Camera", style: TextStyle(color: Colors.white),),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: (){},
                  icon: Icon(Icons.camera),
                  label: Text("Camera", style: TextStyle(color: Colors.white),),
                ),


              ],
            )
          ],
        ),
      ),
    ),
  );
}*/

class editProfile_InputField extends StatelessWidget {
  var txtLabel;

  editProfile_InputField({super.key, required this.txtLabel});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Times New Roman"),
        //hintText: "Username",
        labelText: txtLabel,
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
