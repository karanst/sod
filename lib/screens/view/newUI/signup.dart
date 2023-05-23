import 'dart:convert';

import 'package:ez/screens/view/newUI/Testing.dart';
import 'package:ez/screens/view/newUI/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home1.dart';
import 'newTabbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final mobileController = TextEditingController();
  final codeController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? password, email, userid, message, userTocken, responseCode;
  // late int? otp;

  bool _isNetworkAvail = true;
  // Animation? buttonSqueezeanimation;
  // AnimationController? buttonController;

  int _value = 1;
  bool isMobile = false;
  bool isSendOtp = false;
  num? otp;
  bool isLoading = false;


  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  void initState() {
    super.initState();
    getToken();
  }


  bool? Error;
  String? msg;

   registerUser() async {
     print("Api working");
     var headers = {
       'Cookie': 'ci_session=7554a59accd7556c34c335c5b340fe327147e52a'
     };
     var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/insertUser'));
     request.fields.addAll({
       'userName': nameController.text,
       'userEmail':  emailController.text,
       'userMobile': mobileController.text,
       'password': passwordController.text,
       'confirm_password': confirmController.text,
     });
      print("Register Parameter ${request.fields}");
     request.headers.addAll(headers);
     http.StreamedResponse response = await request.send();
     if (response.statusCode == 200) {
       print("Working Nowwwww");
       var finalResponse = await response.stream.bytesToString();
       final jsonResponse = json.decode(finalResponse);
       if(jsonResponse['status'] == true){
         print("Working@@@@@@@@");
         Fluttertoast.showToast(msg: '${jsonResponse['message']}');
         print("json response ${jsonResponse}");
         setState(() {
           print("final response>>>>> ${finalResponse}");
         });
         Fluttertoast.showToast(msg: "${jsonResponse['message']}");
         print("Working*********");
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
       }
       else{
         Fluttertoast.showToast(msg: "${jsonResponse['message']}");
         // setState(() {});
       }
     }
     else {
       setState(() {});
       print(response.reasonPhrase);
       // var finalResponse = await response.stream.bytesToString();
       // final jsonResponse = json.decode(finalResponse);
       // print("Finallll${finalResponse}");
       // print(jsonResponse.toString());
     }
   }


  Map toMap() {
    var map = <String, dynamic>{};
    map["mobile"] = mobileController.text.toString();
    return map;
  }

  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  bool _isHidden1 = true;
  void _togglePasswordView1() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return true;
          },
          child:
          SafeArea(
            top: true,
            bottom: false,
            child: Scaffold(
              backgroundColor: backgroundblack,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      child: Image.asset(
                        'assets/images/splash_bg.png',
                        // 'assets/images/login_logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/Splashscreen.png'))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 33,
                              color: backgroundgrey,
                            ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 0, left: 20, right: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundgrey,
                                      //Theme.of(context).colorScheme.gray,
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: nameController,
                                        validator: (msg) {
                                          if (msg!.isEmpty) {
                                            return "Please Enter Name!";
                                          }
                                        },
                                        // validator: FormValidation.emailVeledetion,
                                        keyboardType:
                                        TextInputType.text,
                                        // maxLength: 10,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Enter Name",
                                          // labelText: "Enter Email id",
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: backgroundblack,
                                            size: 24,
                                          ),
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundgrey,
                                      //Theme.of(context).colorScheme.gray,
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: emailController,
                                        validator: (msg) {
                                          if (msg!.isEmpty) {
                                            return "Please Enter Email!";
                                          }

                                        },
                                        // validator: FormValidation.emailVeledetion,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        // maxLength: 10,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Enter Email",
                                          // labelText: "Enter Email id",
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: backgroundblack,
                                            size: 24,
                                          ),
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundgrey,
                                      //Theme.of(context).colorScheme.gray,
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: mobileController,
                                        validator: (msg) {
                                          if (msg!.isEmpty) {
                                            return "Please Enter Mobile No.!";
                                          }

                                        },
                                        // validator: FormValidation.emailVeledetion,
                                        keyboardType:
                                        TextInputType.number,
                                        maxLength: 10,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Mobile",
                                          // labelText: "Enter Email id",
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: backgroundblack,
                                            size: 24,
                                          ),
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundgrey,
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: _isHidden ? true : false,
                                        keyboardType: TextInputType.text,
                                        validator: (msg) {
                                          if (msg!.isEmpty) {
                                            return "Please Enter Valid Password!";
                                          }
                                          // else if(msg.length<7) {
                                          //   print("Password Must be more than 6 characters");
                                          // }
                                        },
                                        // maxLength: 10,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Password",
                                          // labelText: "Pass",
                                          prefixIcon: InkWell(
                                            onTap: _togglePasswordView,
                                            child: Icon(
                                              _isHidden
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: _isHidden
                                                  ? backgroundblack
                                                  : backgroundblack,
                                            ),
                                          ),
                                          // prefixIcon: Icon(Icons.lock),
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundgrey,
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: confirmController,
                                        obscureText: _isHidden1 ? true : false,
                                        keyboardType: TextInputType.text,
                                        validator: (msg) {
                                          if (msg!.isEmpty) {
                                            return "Please Enter Valid Password!";
                                          }
                                        },
                                        // maxLength: 10,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Confirm Password",
                                          // labelText: "Pass",
                                          prefixIcon: InkWell(
                                            onTap: _togglePasswordView1,
                                            child: Icon(
                                              _isHidden1
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: _isHidden1
                                                  ? backgroundblack
                                                  : backgroundblack,
                                            ),
                                          ),
                                          // prefixIcon: Icon(Icons.lock),
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0,),
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundgrey,
                                      //Theme.of(context).colorScheme.gray,
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        // controller: nameController,
                                        // validator: FormValidation.emailVeledetion,
                                        keyboardType:
                                        TextInputType.text,
                                        // maxLength: 10,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Referal Code(Optional)",
                                          // labelText: "Enter Email id",
                                          prefixIcon: Image.asset("assets/images/referal.png", color: backgroundblack, scale: 1.6,)
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child:
                              InkWell(
                                onTap: (){
                                  setState((){
                                    isLoading = true;
                                  });
                                  if(_formKey.currentState!.validate()){
                                    // sendOtp();
                                    registerUser();
                                  }else{
                                    setState((){
                                      isLoading = false;
                                    });
                                    Fluttertoast.showToast(msg: "All Fields Are Required!");
                                  }
                                },
                                child: Container(
                                    height: 43,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),  color: appColorOrange),
                                    child:
                                    // isLoading ?
                                    // loadingWidget():
                                    Center(child: Text("Sign Up", style: TextStyle(fontSize: 18, color: backgroundblack)))
                                ),
                              ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Allready have an account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color:backgroundgrey,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              GestureDetector(
                                //   onTap: (){},
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                      color: backgroundgrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Login()
                                      //     VendorRegisteration(
                                      //   role: "0",
                                      // ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      );
  }
}
