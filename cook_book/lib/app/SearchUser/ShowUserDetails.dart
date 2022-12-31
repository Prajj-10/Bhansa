import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowUserDetails extends StatefulWidget {

  final QueryDocumentSnapshot<Object?>? data;

  const ShowUserDetails({Key? key, this.data}) : super(key: key);

  @override
  State<ShowUserDetails> createState() => _ShowUserDetailsState();
}

class _ShowUserDetailsState extends State<ShowUserDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.data!.get('name')}"),
          ),
          body: Container(
            margin: EdgeInsets.all(50),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('${widget.data!.get('profile picture')}'),
                  ),
                  Text(widget.data!.get('name')),
                  Text(widget.data!.get('description')),
                ],
              ),

          )
          
        ));
  //     Container(
  //     child: Center(child: Text("Hello ${widget.data!.get('name')}")),
  //   );
  }
}
