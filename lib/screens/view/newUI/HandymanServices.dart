import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/global.dart';
import 'package:http/http.dart' as http;
import '../../../models/AddToCartHandyServicesModel.dart';
import '../models/HandyServicesModel.dart';
import 'HandyServicesModel.dart';
import 'HandymanServiceDetails.dart';

class HandymanServices extends StatefulWidget {
  String? handymansub_id;
  String? h_id;
  HandymanServices({Key? key, this.handymansub_id, this.h_id}) : super(key: key);

  @override
  State<HandymanServices> createState() => _HandymanServicesState();
}

class _HandymanServicesState extends State<HandymanServices> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHandymanServices();
  }

  HandyServicesModel? handyServicesModel;
  getHandymanServices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("Hnadyman servicesss apiii");
    var headers = {
      'Cookie': 'ci_session=af2dc1bbecadd5cfcab5140f29313a2baf600ff6'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_services_by_id'));
    request.fields.addAll({
      'id': widget.h_id ?? "",
      'roll': '7'
    });
    print("get handyman services by id in servicee pageeeeeeeeee ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = HandyServicesModel.fromJson(json.decode(finalResponse));
      print("handyman sub categoriessssss$jsonResponse");
      if(jsonResponse.status == 1){
        print("here@@@@@@@@@@@");
        String? vendor_id = jsonResponse.data![0].vId ?? '';
        String? product_id = jsonResponse.data![0].id ?? '';
        preferences.setString('product_id', product_id);
        preferences.setString('vendor_id', vendor_id);
        print("handymann product id@@@@@ ${product_id}");
        print("handymannn vendor id@@@@ ${vendor_id}");
        setState(() {
          handyServicesModel = HandyServicesModel.fromJson(json.decode(finalResponse));
        });
      }
      else{
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: backgroundblack)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appColorWhite,
        title:Text("HANDYMAN SERVICES", style: TextStyle(color: appColorBlack, fontSize: 13, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold )),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/back.png"),
                  fit: BoxFit.cover
                // fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            child: handyServicesModel == null ? Center(
              child: Image.asset("assets/images/loader1.gif", scale: 1),
            ):
            Container(
              height: 700,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: handyServicesModel!.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 7/7.2,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.all(1),
                      child: Card(
                          color: Colors.white,
                          elevation: 5,
                          semanticContainer: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: appColorBlack, width: 2),
                          ),
                          // clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width/1.7,
                                  child: Image.network("${handyServicesModel!.data![index].profileImage}", height: 80, width: 50, fit: BoxFit.fill,)
                              ),
                              SizedBox(height: 9),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7, top: 0),
                                  child: Text("${handyServicesModel!.data![index].artistName}"
                                      ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 10, fontFamily: 'Afrah')
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HandyServiceDetails()));
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5, top: 10),
                                    child: Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: backgroundblack),
                                        child: Center(child: Text("View Services", style: TextStyle(fontSize: 10, color: appColorOrange)))),
                                  ),
                                ),
                              ),
                             Spacer(),
                            ],
                          ),
                      ),
                  );
                },
              ),
            )
          ),
        ],
      ),
    );
  }
}
