// import 'dart:async';
// import 'package:ez/constant/constant.dart';
// import 'package:ez/constant/push_notification_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ez/constant/global.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   SplashScreenState createState() => new SplashScreenState();
// }
//
// class SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   var _visible = true;
//
//   AnimationController? animationController;
//   Animation<double>? animation;
//
//   startTime() async {
//     var _duration = new Duration(seconds: 3);
//     return new Timer(_duration, navigationPage);
//   }
//
//   void navigationPage() {
//     Navigator.of(context).pushReplacementNamed(App_Screen);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     animationController = new AnimationController(
//         vsync: this, duration: new Duration(seconds: 2));
//     animation =
//         new CurvedAnimation(parent: animationController!, curve: Curves.easeOut);
//
//     animation!.addListener(() => this.setState(() {}));
//     animationController!.forward();
//
//     setState(() {
//       _visible = !_visible;
//     });
//     startTime();
//
//     getCurrentLocation().then((_) async {
//       setState(() {});
//     });
//     PushNotificationService pushNotificationService = PushNotificationService(context: context);
//    pushNotificationService.initialise();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: appColorWhite,
//       child: Center(
//         child: Image.asset(
//           'assets/images/Transparent_white.png',
//           // height: 200,
//           fit: BoxFit.fill,
//           // width: SizeConfig.blockSizeHorizontal * 50,
//         ),
//       ),
//     );
//   }
// }


// import 'dart:async';
// import 'package:ez/screens/view/newUI/home1.dart';
// import 'package:ez/screens/view/newUI/newTabbar.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../constant/global.dart';
// import 'login.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   String? user_id;
//   void checkLogin()async{
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     user_id = pref.getString('user_id');
//     print("this is is user is${user_id}");
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // Timer(Duration(seconds: 3), () {
//     //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));}
//     // );
//     super.initState();
//     Future.delayed(Duration(milliseconds: 2),(){
//       return checkLogin();
//     });
//     Future.delayed(Duration(seconds: 3),(){
//       print("Conditions@@@@@@@@ ${user_id == null || user_id == ""}");
//       if(user_id == null || user_id == ""){
//         print("this is is user is${user_id}");
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
//       }
//       else{
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabbarScreen()));
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: appColorWhite,
//       child: Center(
//         child: Image.asset(
//           'assets/images/Transparent_white.png',
//           // height: 200,
//           fit: BoxFit.fill,
//           // width: SizeConfig.blockSizeHorizontal * 50,
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:ez/constant/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'login.dart';
import 'newTabbar.dart';


class SplashPage extends StatefulWidget {
  // SplashPage({ Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;
  bool _visible = false;
  notificationPermission() async{
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      PushNotificationService notificationService =  PushNotificationService(context: context, onResult: (value) {  });
      notificationService.initialise();
      FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
    }
    else {
      openAppSettings();
    }
  }
  @override
  void initState() {
    super.initState();
    // notificationPermission();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller = VideoPlayerController.asset("assets/video/splash.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });
    // notificationPermission();
    Future.delayed(Duration(milliseconds: 2),(){
      return checkLogin();
    });
    Future.delayed(Duration(seconds: 4),(){
      print("Conditions@@@@@@@@ ${user_id == null || user_id == ""}");
      if(user_id == null || user_id == ""){
        print("this is is user is${user_id}");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabbarScreen()));
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      // _controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {

    return Container(color: Colors.transparent //.withAlpha(120),
    );
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,

    );
  }
  String? user_id;
  void checkLogin()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    user_id = pref.getString('user_id');
    print("this is is user is${user_id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
          ],
        ),
      ),
    );
  }
}