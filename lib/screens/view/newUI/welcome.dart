import 'package:ez/screens/view/newUI/welcome2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';

import 'login.dart';
bool isIamOnline = true;


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController phoneController = new TextEditingController();
  bool status = false;
  bool selected = false, enabled = false, edit = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    changePage();
  }

  changePage() async {
    setState(() {
      status = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      body: Container(
        height: double.infinity,
          width: double.infinity,
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home1.png"),
               fit: BoxFit.fill,
            ),
          ),
        child: Stack(
          children: [
            Positioned(
              top: 520,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 220,
                      left: 20),
                      child: Text("Service", style: TextStyle(fontSize: 25, color: backgroundgrey, fontWeight: FontWeight.w800),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 220,left: 20),
                      child: Text("On Demand", style: TextStyle(fontSize: 25, color: backgroundgrey, fontWeight: FontWeight.w800),),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(right: 220,left: 20),
                      child: Text("Sod hai na!", style: TextStyle(fontSize: 18, color: backgroundgrey, ),),
                    ),
                    SizedBox(height: 80,),
                    Padding(
                      padding: const EdgeInsets.only(left:30),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:appColorOrange),
                          child:  Center(child: Text("Get Started", style: TextStyle(color: backgroundblack, fontSize: 18))),
                        ),
                      ),
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
}