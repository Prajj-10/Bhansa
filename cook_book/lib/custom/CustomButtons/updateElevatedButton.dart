import 'package:flutter/material.dart';
class UpdateElevatedButton extends StatelessWidget {


  Function ontap;

  UpdateElevatedButton({super.key, required this.ontap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF215C76),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),

          ),
          onPressed: () =>ontap(),
          child: Center(
            child: Text("Save Changes"),
          )
      ),
    );
  }
}
