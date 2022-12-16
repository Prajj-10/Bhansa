
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class Preferences extends StatelessWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
   //const imageURL = "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60";
    //const imageURL = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80";
    const imageURL = "https://www.altitudehimalaya.com/media/files/Blog/Food/Most-Popular-Nepalese-Foods.jpeg";
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff002a2a),
              Color(0xff011313),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            stops: [0.3, 0.8],
          )
        ),
        child: Column(
          children: [

            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(top:5,bottom: 0,left: 30, right: 30),
              child: const Text("Choose Your Favourite \n \t \t \t \t \t \t  Cuisine",
              style: TextStyle(
                fontSize: 24, fontWeight:FontWeight.bold,
              ),),
            ),

            Container(
              width: size.width,
              height: size.height/1.29,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: GridView.builder(
                itemCount: 15,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (ctx, index)
              {
                return Card(
                  color: HexColor('#067275'),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  elevation: 10,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)
                      ),
                    child: Stack(
                      children: [
                        Image.network(imageURL, height: 75, width: 150, fit: BoxFit.cover,),
                        Container(
                          margin: const EdgeInsets.only(top: 78, left: 15 ,),
                          child: const Text("Nepalese",
                          style: TextStyle(color: Colors.white, fontSize: 12,)),
                        ),
                      ],
                    ),
                  ),


                );

              }),


            ),

            //Continue Button
            Material(
              color: HexColor('#067275'),
              borderRadius: BorderRadius.circular(8),

              child: InkWell(
                //onTap: () => moveToHome(context),
                onTap: (){
                  print("Continue Pressed");
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  alignment: Alignment.center,
                  width: 150,
                  height: 50,

                  child:const Text("Continue", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),),
                ),
              ),
            ),


            // ElevatedButton(
            //     onPressed: (){
            //       print("Continue");
            //     },
            //     child: Text("Continue",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            // )



          ],
    ),
      ),
    );

  }
}


