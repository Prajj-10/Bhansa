import 'package:flutter/material.dart';

class Follow_Unfollow extends StatelessWidget {
  Function function;
  String text;

  Follow_Unfollow({Key? key, required this.text, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        //backgroundColor: Colors.white,
        side: BorderSide(color: Colors.white),
        foregroundColor: Colors.orange,
        fixedSize: Size(100, 30),
      ),
        onPressed: ()=> function(),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
    );
  }
}
