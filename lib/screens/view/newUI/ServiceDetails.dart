import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/global.dart';
import '../../../models/MehndiSevicesModel.dart';
import '../models/AddToCartMehndiServicesModel.dart';
import 'Services_Cart.dart';

class ServiceDetails extends StatefulWidget {
  String? sub_id;
  ServiceDetails({Key? key, this.sub_id}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMehndiServices();
  }

  MehndiSevicesModel? mehndiSevicesModel;
  String? sub_id;
  getMehndiServices() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sub_id = preferences.getString('sub_id');
    print("Sub id herereeeeee ${sub_id}");
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

  AddToCartMehndiServicesModel? addToCartMehndiServicesModel;
  addToCartByServices() async{
    print("Add to cart by services");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    vendor_id = preferences.getString("vendor_id");
    product_id = preferences.getString("product_id");
    user_id= preferences.getString("user_id");

    print("Vendorrrrrrrr ${vendor_id}");
    print("producttttttt ${product_id}");
    print("userrrrr iddddd ${user_id}");

    var headers = {
      'Cookie': 'ci_session=1fe52d62444b2e32c51dac90480cd038a26986a5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/add_to_cart_service'));
    request.fields.addAll({
      'user_id': user_id ?? "",
      'rollid': '5',
      'vendorid': vendor_id ?? "",
      'productid': product_id ?? "",
    });

    print("add to cart by mehndi services ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddToCartMehndiServicesModel.fromJson(json.decode(finalResponse));
      if(jsonResponse.status == true){
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesCart()));
        setState(() {
          addToCartMehndiServicesModel = AddToCartMehndiServicesModel.fromJson(json.decode(finalResponse));
        });
      } else{
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
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
        actions: [
         InkWell(
           onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesCart()));
           },
             child: Image.asset("assets/images/service.png", scale: 1.9,))
        ],
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: backgroundblack)
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appColorWhite,
        title:Text("MEHNDI SERVICE DETAILS", style: TextStyle(color: appColorBlack, fontSize: 10, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold )),
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
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: mehndiSevicesModel!.data!.length,
              itemBuilder: (BuildContext context, int index){
                return   Padding(
                    padding: EdgeInsets.all(15),
                    child: Scrollbar(
                        thickness: 10,
                        trackVisibility: true,
                        // isAlwaysShown: true,
                        thumbVisibility: true,
                        radius: Radius.circular(10),
                        child: SizedBox(
                            height: 120,
                            child: Card(
                                elevation: 6,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAlias,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(width: 2),
                                    Center(
                                      child: mehndiSevicesModel == null ? Center(
                                        child: Image.asset("assets/images/loader1.gif"),
                                      ) : Image.network("${mehndiSevicesModel!.data![index].profileImage}", height: 100, width: 100, fit: BoxFit.fill,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${mehndiSevicesModel!.data![index].artistName}",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 13),),
                                          Text("${mehndiSevicesModel!.data![index].serDesc}", style: TextStyle(color: appColorBlack,fontSize: 13)),
                                          Row(
                                            children: [
                                              Text("₹${mehndiSevicesModel!.data![index].mrpPrice}", style: TextStyle(color: appColorOrange, fontSize: 13, decoration: TextDecoration.lineThrough),),
                                              SizedBox(width: 4,),
                                              Text("₹${mehndiSevicesModel!.data![index].specialPrice}", style: TextStyle(color: appColorBlack,fontSize: 13, fontWeight: FontWeight.bold)
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Service Provider:", style: TextStyle(fontSize: 13, color: appColorBlack),
                                              ),
                                              Text("${mehndiSevicesModel!.data![index].uname}", style: TextStyle(fontSize: 13, color: appColorBlack, fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesCart()));
                                                  addToCartByServices();
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 90,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: backgroundblack),
                                                  child: Center(child: Text("Booking", style: TextStyle(fontSize: 14, color: appColorWhite, fontWeight: FontWeight.bold),)),
                                                ),
                                              ),
                                              SizedBox(width: 80),
                                              mehndiSevicesModel!.data![index].gender == 'Female' ? Image.asset("assets/images/girl.png", scale: 2) :
                                              mehndiSevicesModel!.data![index].gender == 'Male' ? Image.asset("asssets/images/boy.png", scale: 2,) :
                                              mehndiSevicesModel!.data![index].gender == 'Both' ? Image.asset("assets/images/girl.png", scale: 2,): Image.asset("assets/images/boy.png", scale: 2,)
                                            ],
                                          ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //   crossAxisAlignment: CrossAxisAlignment.end,
                                          //   children: [
                                          //     Row(
                                          //       children: [
                                          //         Padding(
                                          //           padding: const EdgeInsets.only(top: 0),
                                          //           // child:  InkWell(
                                          //           //   onTap: () {
                                          //           //     if (_counter >= 1) {
                                          //           //       _counter -= 1;
                                          //           //       setState(() {});
                                          //           //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                                          //           //     }
                                          //           //   },
                                          //           //   child: Card(
                                          //           //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                                          //           //     child: ClipRRect(
                                          //           //         borderRadius:
                                          //           //         BorderRadius.all(Radius.circular(6)),
                                          //           //         child: Container(
                                          //           //             // padding: EdgeInsets.all(6),
                                          //           //             // color: isDark
                                          //           //             //     ? AppThemes.smoothBlack
                                          //           //             //     : AppThemes
                                          //           //             //     .lightTextFieldBackGroundColor,
                                          //           //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                                          //           //         ),
                                          //           //     ),
                                          //           //   ),
                                          //           // ),
                                          //           child: InkWell(
                                          //             onTap: () {
                                          //               // if (_counter >= 1) {
                                          //               //   _counter -= 1;
                                          //               //   setState(() {});
                                          //               //   addToCart(getUserCartModel!.cart![index].productId ??'');
                                          //               // }
                                          //               //   setState((){
                                          //               //   });
                                          //               //   count[index] -= 1;
                                          //               //     addToCart(getUserCartModel!.cart![index].productId ??'');
                                          //               // },
                                          //               if (qty[index] >= 1) {
                                          //                 qty[index] -= 1;
                                          //                 print("kkkkkkk ${qty[index]}");
                                          //                 print("ooooo ${qty[index]}");
                                          //                 addToCart(getUserCartModel!.cart![index].productId.toString(),
                                          //                   // getUserCartModel.cart[index].productPrice ?? "",
                                          //                   // qty[index].toString());
                                          //                 );
                                          //               }
                                          //             },
                                          //             // onTap:() {
                                          //             //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                                          //             //   _decrimentConter;
                                          //             // },
                                          //             child: (
                                          //                 Center(
                                          //                     child: Icon(Icons.remove,size: 18,color: Colors.black))
                                          //             ),
                                          //           ),
                                          //         ),
                                          //         // Container(
                                          //         //     child: Text("${count[index]}",)),
                                          //         SizedBox(width: 14),
                                          //         Padding(
                                          //           padding: const EdgeInsets.only(top: .0),
                                          //           child:Text("Qty: ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13)),
                                          //         ),
                                          //         SizedBox(width: 11),
                                          //         // SizedBox(width: 60,),
                                          //         Padding(
                                          //           padding: const EdgeInsets.only(top:.0),
                                          //           child: InkWell(
                                          //             onTap: () {
                                          //               setState(() {});
                                          //               print("kkkkkkk ${qty[index]}");
                                          //               qty[index] = qty[index] + 1;
                                          //               print("ooooo ${qty[index]}");
                                          //               addToCart(getUserCartModel!.cart![index].productId ??'');
                                          //             },
                                          //             child: (
                                          //                 Center(child: const Icon(Icons.add,size: 18,color: Colors.black))),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     SizedBox(width: 90),
                                          //     Row(
                                          //       mainAxisAlignment: MainAxisAlignment.end,
                                          //       crossAxisAlignment: CrossAxisAlignment.end,
                                          //       children: [
                                          //         InkWell(
                                          //           onTap:(){
                                          //             removeCart(getUserCartModel!.cart![index].productId ??'');
                                          //           },
                                          //           child: Padding(
                                          //             padding: const EdgeInsets.only(top: 10),
                                          //             child: Image.asset("assets/images/delete.png", color: Colors.black, scale: 1.4),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   child: Row(
                                    //       children: [
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(top: 28.0),
                                    //           // child:  InkWell(
                                    //           //   onTap: () {
                                    //           //     if (_counter >= 1) {
                                    //           //       _counter -= 1;
                                    //           //       setState(() {});
                                    //           //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                                    //           //     }
                                    //           //   },
                                    //           //   child: Card(
                                    //           //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                                    //           //     child: ClipRRect(
                                    //           //         borderRadius:
                                    //           //         BorderRadius.all(Radius.circular(6)),
                                    //           //         child: Container(
                                    //           //             // padding: EdgeInsets.all(6),
                                    //           //             // color: isDark
                                    //           //             //     ? AppThemes.smoothBlack
                                    //           //             //     : AppThemes
                                    //           //             //     .lightTextFieldBackGroundColor,
                                    //           //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                                    //           //         ),
                                    //           //     ),
                                    //           //   ),
                                    //           // ),
                                    //           child: InkWell(
                                    //             onTap: () {
                                    //               // if (_counter >= 1) {
                                    //               //   _counter -= 1;
                                    //               //   setState(() {});
                                    //               //   addToCart(getUserCartModel!.cart![index].productId ??'');
                                    //               // }
                                    //               //   setState((){
                                    //               //   });
                                    //               //   count[index] -= 1;
                                    //               //     addToCart(getUserCartModel!.cart![index].productId ??'');
                                    //               // },
                                    //               if (qty[index] >= 1) {
                                    //                 qty[index] -= 1;
                                    //                 print("kkkkkkk ${qty[index]}");
                                    //                 print("ooooo ${qty[index]}");
                                    //                 addToCart(getUserCartModel!.cart![index].productId.toString(),
                                    //                   // getUserCartModel.cart[index].productPrice ?? "",
                                    //                   // qty[index].toString());
                                    //                 );
                                    //               }
                                    //             },
                                    //             // onTap:() {
                                    //             //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                                    //             //   _decrimentConter;
                                    //             // },
                                    //             child: Container(
                                    //               decoration: BoxDecoration(
                                    //                   color:backgroundblack,
                                    //                   borderRadius: BorderRadius.circular(5)),
                                    //               height: 24,
                                    //               width: 25,
                                    //               child:(
                                    //                   Center(
                                    //                       child: Icon(Icons.remove,size: 20,color: Colors.white))
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         // Container(
                                    //         //     child: Text("${count[index]}",)),
                                    //         SizedBox(width: 4),
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(top: 28.0),
                                    //           child:Text("Qty: ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                    //
                                    //         ),
                                    //         SizedBox(width: 4),
                                    //         // SizedBox(width: 60,),
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(top: 28.0),
                                    //           child: InkWell(
                                    //             onTap: () {
                                    //               setState(() {});
                                    //               print("kkkkkkk ${qty[index]}");
                                    //               qty[index] = qty[index] + 1;
                                    //               print("ooooo ${qty[index]}");
                                    //               addToCart(getUserCartModel!.cart![index].productId ??'');
                                    //             },
                                    //             child: Container(
                                    //               decoration: BoxDecoration(
                                    //                   color:backgroundblack,
                                    //                   borderRadius: BorderRadius.circular(5)),
                                    //               height: 24,
                                    //               width: 25,
                                    //               child:(
                                    //                   Center(child: const Icon(Icons.add,size: 20,color: Colors.white))),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //   ),
                                    // ),
                                    // // Container(
                                    // //   child: Row(children: [
                                    // //     Padding(
                                    // //       padding: const EdgeInsets.only(top: 30.0),
                                    // //       child: InkWell(
                                    // //         onTap: _decrimentConter,
                                    // //         child: Container(
                                    // //           decoration: BoxDecoration(
                                    // //               color:backgroundblack,
                                    // //               borderRadius: BorderRadius.circular(5)),
                                    // //           height: 24,
                                    // //           width: 27,
                                    // //           child: (Center(child: const Icon(Icons.remove,size: 20,color: Colors.white,))
                                    // //           ),
                                    // //         ),
                                    // //       ),
                                    // //     ),
                                    // //     SizedBox(width: 3,),
                                    // //     Padding(
                                    // //       padding: const EdgeInsets.only(top: 23.0),
                                    // //       child: Text(
                                    // //         '$_counter',
                                    // //         style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                    // //       ),
                                    // //     ),
                                    // //     SizedBox(width: 3),
                                    // //     Padding(
                                    // //       padding: const EdgeInsets.only(top: 30.0),
                                    // //       child: InkWell(
                                    // //         onTap: _incrementCounter,
                                    // //         child: Container(
                                    // //           decoration: BoxDecoration(
                                    // //               color:backgroundblack,
                                    // //               borderRadius: BorderRadius.circular(5)),
                                    // //           height: 24,
                                    // //           width: 27,
                                    // //           child: (Center(child: const Icon(Icons.add,size: 20,color: Colors.white,))
                                    // //           ),
                                    // //         ),
                                    // //       ),
                                    // //     ),
                                    // //   ],),
                                    // // ),
                                    // SizedBox(width: 8),
                                    // Align(
                                    //   alignment: Alignment.topLeft,
                                    //   child: InkWell(
                                    //       onTap: (){
                                    //         removeCart(getUserCartModel!.cart![index].productId ??'');
                                    //       },
                                    //       child: Icon(
                                    //         Icons.delete, color: backgroundblack,
                                    //       ),
                                    //   ),
                                    // ),
                                    // Spacer(),
                                    // Center(
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(top: 8.0),
                                    //     child: Container(
                                    //         decoration: BoxDecoration(
                                    //             color: appColorOrange,
                                    //             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                                    //         ),
                                    //         height: 80,width: 8),
                                    //   ),
                                    // ),
                                  ],
                                )))));
                //   Padding(
                //     padding: EdgeInsets.all(5),
                //     child: Container(
                //       height: 130,
                //       child: Card(
                //           elevation: 3,
                //           semanticContainer: true,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(5.0),
                //             side: BorderSide(
                //                 color: backgroundgrey, width: 2
                //             ),
                //           ),
                //           clipBehavior: Clip.antiAlias,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: <Widget>[
                //               Container(
                //                 height: 122,
                //                 width: 150,
                //                 // width: double.infinity,
                //                 child: mehndiSevicesModel == null
                //                     ? Image.asset("assets/images/loader1.gif", scale: 1) :
                //                 Image.network("${mehndiSevicesModel!.data![index].profileImage}", fit: BoxFit.fill),
                //               ),
                //               // Column(
                //               //   children: [
                //               //     Text("${mehndiSevicesModel!.data![index].artistName}"),
                //               //     Text("${mehndiSevicesModel!.data![index].serDesc}"),
                //               //   ],
                //               // ),
                //               // // Spacer(),
                //               // // Row(
                //               // //   mainAxisAlignment: MainAxisAlignment.center,
                //               // //   children: [
                //               // //     Text("${mehndiSevicesModel!.data![index].artistName}"
                //               // //       ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 11, fontFamily:'Afrah'),
                //               // //     ),
                //               // //   ],
                //               // // ),
                //               // Spacer(),
                //             ],
                //           ),
                //       ),
                //     ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
