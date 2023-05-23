import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/newUI/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/MehndiSevicesModel.dart';
import '../models/AddToCartMehndiServicesModel.dart';
import 'ServiceDetails.dart';
import 'Services_Cart.dart';

class MehndiServices extends StatefulWidget {
  String? sub_id;
  MehndiServices({Key? key, this.sub_id}) : super(key: key);

  @override
  State<MehndiServices> createState() => _MehndiServicesState();
}

class _MehndiServicesState extends State<MehndiServices> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMehndiServices();
  }

  MehndiSevicesModel? mehndiSevicesModel;
  // String? sub_id;
  getMehndiServices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // sub_id = preferences.getString('sub_id');
    // print("Sub id herereeeeee ${sub_id}");
    print("Mehndi servicesss apiii");
    var headers = {
      'Cookie': 'ci_session=af2dc1bbecadd5cfcab5140f29313a2baf600ff6'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_services_by_id'));
    request.fields.addAll({
      'id': widget.sub_id ?? "",
      'roll': '5'
    });
    print("get Mehndi services by id ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = MehndiSevicesModel.fromJson(json.decode(finalResponse));
      print("Mehndi sub categoriessssss$jsonResponse");
      if(jsonResponse.status == 1){
        print("here&&&&&&&&&&&&&&&&&");
        String? vendor_id = jsonResponse.data![0].vId ?? '';
        String? product_id = jsonResponse.data![0].id ?? '';
        preferences.setString('product_id', product_id);
        preferences.setString('vendor_id', vendor_id);
        print("mejndi product id@@@@@ ${product_id}");
        print("mehndi vendor id@@@@ ${vendor_id}");
        setState(() {
          mehndiSevicesModel = MehndiSevicesModel.fromJson(json.decode(finalResponse));
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

  String? vendor_id;
  String? product_id;
  String? user_id;

  // AddToCartMehndiServicesModel? addToCartMehndiServicesModel;
  // addToCartByServices() async{
  //   print("Add to cart by services");
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   vendor_id = preferences.getString("vendor_id");
  //   product_id = preferences.getString("product_id");
  //   user_id= preferences.getString("user_id");
  //
  //   print("Vendorrrrrrrr ${vendor_id}");
  //   print("producttttttt ${product_id}");
  //   print("userrrrr iddddd ${user_id}");
  //
  //   var headers = {
  //     'Cookie': 'ci_session=1fe52d62444b2e32c51dac90480cd038a26986a5'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/add_to_cart_service'));
  //   request.fields.addAll({
  //     'user_id': user_id ?? "",
  //     'rollid': '5',
  //     'vendorid': vendor_id ?? "",
  //     'productid': product_id ?? "",
  //   });
  //
  //   print("add to cart by mehndi services ${request.fields}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalResponse = await response.stream.bytesToString();
  //     final jsonResponse = AddToCartMehndiServicesModel.fromJson(json.decode(finalResponse));
  //     if(jsonResponse.status == true){
  //       Fluttertoast.showToast(msg: "${jsonResponse.message}");
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesCart()));
  //       setState(() {
  //         addToCartMehndiServicesModel = AddToCartMehndiServicesModel.fromJson(json.decode(finalResponse));
  //       });
  //     }
  //     else{
  //       Fluttertoast.showToast(msg: "${jsonResponse.message}");
  //       setState(() {
  //       });
  //     }
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

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
         title:Text("MEHNDI SERVICES", style: TextStyle(color: appColorBlack, fontSize: 13, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold )),
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
            child: mehndiSevicesModel == null ? Center(
              child: Image.asset("assets/images/loader1.gif", scale: 1),
            ):
            Container(
              child: GridView.builder(gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 8
              ),
                itemCount: mehndiSevicesModel!.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12)
                      ),
                      child: Column(
                        children: [
                          Container(
                            child:
                            mehndiSevicesModel == null
                                ? Center(
                              child: Image.asset("assets/images/loader1.gif", scale: 1),
                            ):Image.network("${mehndiSevicesModel!.data![index].profileImage}", height: 122, width: 300,),
                          ), Padding(
                            padding: const EdgeInsets.only(top:0,),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.yellow,width: 2)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3,),
                                  Center(child: Text("${mehndiSevicesModel!.data![index].uname}",
                                      style: TextStyle(fontSize: 13, color: appColorBlack,)
                                  )
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetails()));
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: backgroundblack),
                                            child: Center(
                                              child: Text("View Services", style: TextStyle(fontSize: 10, color: appColorWhite)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 22),
                                      mehndiSevicesModel!.data![index].gender == 'Female' ? Image.asset("assets/images/girl.png", scale: 2.2) :
                                      mehndiSevicesModel!.data![index].gender == 'Male' ? Image.asset("asssets/images/boy.png", scale: 2.2,) :
                                      mehndiSevicesModel!.data![index].gender == 'Both' ? Image.asset("assets/images/girl.png", scale: 2,): Image.asset("assets/images/boy.png", scale: 2.2,)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },),
            ),
          ),
        ],
      ),
    );
  }
}
