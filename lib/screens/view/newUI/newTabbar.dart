import 'dart:convert';
import 'package:ez/constant/push_notification_service.dart';
import 'package:ez/screens/view/newUI/SupportScreen.dart';
import 'package:ez/screens/view/newUI/cart_new.dart';
import 'package:ez/screens/view/newUI/chat/MyServicesScreen.dart';
import 'package:ez/screens/view/newUI/serviceScreenNew.dart';
import 'package:ez/screens/view/newUI/storeScreen.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/newUI/profile.dart';
import 'package:ez/screens/view/newUI/booking.dart';
import 'package:ez/screens/view/newUI/home1.dart';
import 'package:ez/share_preference/preferencesKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categoriesScreen.dart';

// ignore: must_be_immutable
class TabbarScreen extends StatefulWidget {
  int? currentIndex;

  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  int _currentIndex = 0;

  List<dynamic> _handlePages = [
    HomeScreen(),
    // StoreScreenNew(),
    // StoreScreen(),
    ViewCart(show: false,),
    BookingScreen(show: false,),
    SupportScreen(),
    ServicesBooking(show: false,)
    // Profile(),
  ];

  @override
  void initState() {
    getUserDataFromPrefs();
    super.initState();
    PushNotificationService pushNotificationService = new PushNotificationService(context: context,
        // onResult: (result){
        //   //  if(mounted&&result=="yes")
        //   if(result=="accept"){
        //     // getCurrentInfo();
        //   } }
         );
    pushNotificationService.initialise();
  }

  getUserDataFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataStr =
    preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    Map<String, dynamic> userData = json.decode(userDataStr!);
    print(userData);
    setState(() {
      userID = userData['user_id'];
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundblack,
      body: _handlePages[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          topLeft: Radius.circular(0),
        ),
        child: SizedBox(
          height: 35,
          child: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: appColorOrange),
            selectedItemColor: appColorOrange,
            unselectedItemColor: Colors.black,
            selectedFontSize: 8,
            unselectedFontSize: 8,
            selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, color: appColorOrange),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: <BottomNavigationBarItem>[
              _currentIndex == 0
                  ? BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/home2.png',
                    height: 17,
                    color: appColorOrange,
                  ),
                  label: "Home")
                  : BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/home.png',
                    height: 17,
                    color: Colors.grey,
                  ),
                  label: "Home"),
              /* _currentIndex == 1
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/service2.png',
                        height: 25,
                        color: appColorOrange,
                      ),
                      label: "Services")
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/service1.png',
                        height: 25,
                      ),
                      label: "Services"),*/
              _currentIndex == 1
                  ? BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/order2.png',
                    height: 17,
                    // color: appColorOrange,
                  ),
                  label: "My Cart")
                  : BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/order.png',
                    height: 17,
                    color: Colors.grey,
                  ),
                  label: "My Cart"),
              _currentIndex == 2
                  ? BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/myservices.png',
                    height: 17,

                  ),
                  label: "My Services")
                  : BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/myservices.png',
                    color: Colors.grey,
                    height: 17,
                    // color: appColorOrange,
                  ),
                  label: "My Services"),
              _currentIndex == 3
                  ? BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/support2.png',
                    height: 18, color: appColorOrange,
                    // color: appColorOrange,
                  ),
                  label: "Chat")
                  : BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/support2.png',
                    height: 18,color: Colors.grey,
                  ),
                  label: "Chat"),
              _currentIndex == 4
                  ? BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/summary2.png',
                    height: 17,
                    // color: appColorOrange,
                  ),
                  label: "Summary")
                  : BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/summary2.png',color: Colors.grey,
                    height: 17,
                  ),
                  label: "Summary"
              ),
            ],
          ),
        ),
      ),
    );
  }
}
