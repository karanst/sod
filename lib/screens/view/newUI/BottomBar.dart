import 'package:ez/constant/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_new.dart';
import 'home1.dart';

class BottomBar extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomBar>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            ViewCart(),
            HomeScreen(),

            // FavouritesPage(),
            // MyProfilePage(),
            // HomePage(),
          ],
          // If you want to disable swiping in tab the use below code
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
        ),
        bottomNavigationBar: TabBar(
          labelColor: backgroundblack,
          unselectedLabelColor: appColorGreen,
          labelStyle: TextStyle(fontSize: 10.0),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.black54, width: 0.0),
            // insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
          ),
          //For Indicator Show and Customization
          indicatorColor: Colors.black54,
          tabs: <Widget>[
            Tab(
              icon:ImageIcon(
                AssetImage('assets/icons/footer menu/ic_home.png',),
              ),
              text: "Home",
            ),
            Tab(
              icon: Image.asset(
                'assets/icons/ic_bus.png',
                scale: 3.5,
              ),
              text: "My Booking",
            ),
            Tab(
              icon: Image.asset(
                'assets/icons/footer menu/ic_account.png',
                scale: 2.5,
              ),
              text: "Account",
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}