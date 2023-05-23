import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/global.dart';
import '../../../models/FoodCategoryModel.dart';
import 'GroceryDetails.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({Key? key}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

var homelat;
var homeLong;
// var resto_type = true;

class _FoodDetailsState extends State<FoodDetails> {

  Position? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  FoodCategoryModel? foodCategoryModel;
  Future getUserCurrentLocation() async {
    var status = await Permission.location.request();
    if(status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    }else if(status.isGranted){
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
        if (mounted)
          setState(() {
            currentLocation = position;
            homelat = currentLocation?.latitude;
            homeLong = currentLocation?.longitude;
          });
      });
      print("LOCATION===" +currentLocation.toString());
    } else if(status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  _getCategories() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await  getUserCurrentLocation();
    print("Food,Grocery Api");
    var headers = {
      'Cookie': 'ci_session=19ae37817b8d23863ef9b269b178b64435cd91ea'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}grocery_services'));
    print("Current KLat Lokn ${currentLocation?.latitude}");
    print("GFhhghfgffg ${homeLong}",);
    print("kjkhkjhjkhjhk ${homelat}");
    request.fields.addAll({
      'lat': '${currentLocation!.latitude}',
      'long': '${currentLocation!.longitude}'
    });
    print("LatLonggggg ${request.fields}");
    // request.fields.add({
    //   'lat': '${currentLocation!.latitude}',
    //   'long': '${currentLocation!.longitude}'
    // });
    print("Lat Long Parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = FoodCategoryModel.fromJson(json.decode(finalResponse));
      if(jsonResponse.status == 1){
        print("Food Servicesss$jsonResponse");
        String id = jsonResponse.product![0].id.toString();
        preferences.setString("id", id);
        print("Varient id is ${id.toString()}");
        setState(() {
          foodCategoryModel = FoodCategoryModel.fromJson(json.decode(finalResponse));
        });
      } else{
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: backgroundblack,),
        ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Food -NearBy Vendors",
              style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold)
          ),
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
              child: _getCategory(context)
          ),
        ],
      ),
    );
  }

  Widget _getCategory(BuildContext context){
    print("Food Services near by heree ${foodCategoryModel}");
    return foodCategoryModel == null ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1),
    ):
    Container(
      height: 800,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: foodCategoryModel!.product!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 7/7.9,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails(id: foodCategoryModel!.product![index].id)));
            },
            child: Padding(
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
                            child: Image.network("${foodCategoryModel!.product![index].profileImage}", height: 80, width: 50, fit: BoxFit.fill,)
                        ),
                        SizedBox(height: 5),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 7, top: 0),
                             child: Center(
                               child: Text("${foodCategoryModel!.product![index].storeName}"
                                   ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 10, fontFamily: 'Afrah')
                               ),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(right: 5),
                             child: Container(
                                height: 30,
                                 width: 80,
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: backgroundblack),
                                 child: Center(child: Text("View Product", style: TextStyle(fontSize: 10, color: appColorOrange)))),
                           ),
                         ],
                       ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 7, top: 0),
                          child: Text("${foodCategoryModel!.product![index].storeDescription}"
                              ,style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 10, fontFamily: 'Afrah')
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              Image.asset("assets/images/location2.png", color: backgroundblack, height: 14, width: 14),
                              SizedBox(width: 3),
                              Container(
                                width: 70,
                                child:
                                Text("${foodCategoryModel!.product![index].address}",
                                  overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, color: appColorBlack),
                                ),
                              ),
                              SizedBox(width: 75,),
                                  foodCategoryModel!.product![index].restoType.toString() == 'Veg' ? Image.asset("assets/images/veg.png", scale: 2.5,)
                                  :foodCategoryModel!.product![index].restoType.toString() == 'Non-Veg'? Image.asset("assets/images/nonveg.png", scale: 2.5,)
                                  : foodCategoryModel!.product![index].restoType.toString() == 'Both' ? Image.asset("assets/images/veg.png", scale: 2.5,): Image.asset("assets/images/nonveg.png", scale: 2.5,)
                            ],
                          ),
                        ),
                            SizedBox(height: 6,),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: foodCategoryModel!.product![index].onlineStatus.toString() == '1' ? Row(
                                children: [
                                  Image.asset("assets/images/online.png", scale: 2.8,),
                                  SizedBox(width: 2,),
                                  Text("Online", style: TextStyle(color: Colors.green, fontSize: 13),)
                              ],)
                              :foodCategoryModel!.product![index].onlineStatus.toString() == '0'? Row(
                                children: [
                                  Image.asset("assets/images/offline.png", scale: 2.8,),
                                  SizedBox(width: 2,),
                                  Text("Offline", style: TextStyle(color: Colors.red, fontSize: 13),)
                                ],):
                        Spacer(),
                            ),
                        // Center(
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: appColorOrange,
                        //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
                        //     height: 80,width: 8),
                        // ),
                      ],
                    ))),
          );
        },
      ),
    );
  }
}
