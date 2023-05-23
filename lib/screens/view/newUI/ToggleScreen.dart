
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleButtonScreen extends StatefulWidget {
  @override
  _ToggleButtonScreenState createState() => _ToggleButtonScreenState();
}

class _ToggleButtonScreenState extends State<ToggleButtonScreen> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _value ? AssetImage("assets/images/cash.png") : AssetImage("assets/images/order.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _normalToggleButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _normalToggleButton () {
    return Container(
      child: Transform.scale(
        scale: 6.0,
        child: Switch(
          activeColor : Colors.greenAccent,
          inactiveThumbColor: Colors.redAccent,
          value: _value,
          activeThumbImage: AssetImage("assets/images/cash.png"),
          inactiveThumbImage : AssetImage("assets/images/bke.png"),
          onChanged: (bool value){
            setState(() {
              _value = value;
            });
          },
        ),
      ),
    );
  }
}