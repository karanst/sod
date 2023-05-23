import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/global.dart';
import '../models/GeneralSettingModel.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {

  GeneralSettingModel? generalSettingModel;
  generalSetting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("General Setting Apiiii");
    var headers = {
      'Cookie': 'ci_session=64b5be22e11728a4d01189e9af5b2b9cc15aef28'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/general_setting'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GeneralSettingModel.fromJson(json.decode(finalResponse));
      if(jsonResponse.status == 1){
        String? mehndi_gst = jsonResponse.setting!.mehndiGstCharge ?? " ";
        preferences.setString('mehndi_gst', mehndi_gst);
        print("Mehndi Gst hereee ${mehndi_gst}");
        setState(() {
          generalSettingModel = GeneralSettingModel.fromJson(json.decode(finalResponse));
          print("Images Urllllll $imgUrl ${generalSettingModel!.setting!.aapProfileBackImage}");
        });
      } else{
        setState(() {});
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    generalSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar:AppBar(
        backgroundColor: backgroundblack,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            )
        ),
        elevation: 2,
        title: Text(
          "Support",
          style: TextStyle(
            fontSize: 20,
            color: appColorWhite,
          ),
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.all(12),
          child: RawMaterialButton(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(0),
            fillColor: Colors.white,
            splashColor: Colors.grey[400],
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: appColorBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
         child: generalSettingModel == null ? Center(
           child: Image.asset("assets/images/loader1.gif", scale: 1),
         ): Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             children: [
               Row(
                 children: [
                   Text("Email:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, ),),
                   SizedBox(width: 7,),
                   Text("${generalSettingModel!.setting!.email}"),
                 ],
               ),
               SizedBox(height: 10,),
               Row(children: [
                 Text("Our Location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, ),),
                 SizedBox(width: 7,),
                 Text("${generalSettingModel!.setting!.address}"),
               ],
               ),
               SizedBox(height: 10,),
               Row(children: [
                 Text("Mobile No.",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, ), ),
                 SizedBox(width: 7,),
                 Text("${generalSettingModel!.setting!.contactNo}")
               ],)
             ],
           ),
         ),
      ),
    );
  }
}
