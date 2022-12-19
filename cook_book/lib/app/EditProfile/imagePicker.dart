import 'package:flutter/material.dart';
class Image_Picker extends StatelessWidget {
  const Image_Picker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF).withOpacity(1),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Choose profile", style: TextStyle(fontSize: 18, decoration: TextDecoration.none, color: Colors.black),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.camera, size: 50, color: Color(0xFF08082b),),
                    label: Text("Camera", style: TextStyle(color: Colors.black, fontSize: 14),),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: (){},
                    icon: Icon(Icons.image, size: 50, color: Color(0xFF08082b),),
                    label: Text("Gallery", style: TextStyle(color: Colors.black),),
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
