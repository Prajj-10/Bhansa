import 'package:flutter/material.dart';
class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

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
                  Color(0xFF01231C).withOpacity(0.9),
                  Color(0xFF131926).withOpacity(0.9),
                  Color(0xFF0E2839).withOpacity(0.5),
                ]
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              //height: size.height,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF454545).withOpacity(0.3),
                ),
                
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                            onPressed: (){},
                            child: Text("Upload new profile", style: TextStyle(fontSize: 16),),
                        ),

                        //Name
                        editProfile_InputField(txtLabel: "Name"),

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


class editProfile_InputField extends StatelessWidget {
  var txtLabel;

  editProfile_InputField({super.key, required txtLabel});


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
