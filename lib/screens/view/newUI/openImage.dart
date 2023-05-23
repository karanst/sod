import 'package:flutter/material.dart';

class OpenImagePage extends StatefulWidget {
  String? image;
  OpenImagePage({this.image});

  @override
  State<OpenImagePage> createState() => _OpenImagePageState();
}

class _OpenImagePageState extends State<OpenImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height/1,
        width: MediaQuery.of(context).size.width,
        child: Image.network("${widget
            .image}",fit: BoxFit.cover,),
      ),
    );
  }
}
