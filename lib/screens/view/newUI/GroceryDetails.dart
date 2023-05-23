import 'dart:convert';

import 'package:ez/constant/global.dart';
import 'package:ez/models/AddToCartModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/FoodCategoryModel.dart';
import '../../../models/GetProductsModel.dart';
import '../../../models/GetUserCartModel.dart';
import '../../../models/OfferBannerModel.dart';
import '../../../models/car_model.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';
import 'cart_new.dart';

class GD1 extends StatefulWidget {
  String? id;
  String? product_id;
  final String? name;
  GD1({Key? key, this.id, this.product_id, this.name}) : super(key: key);
  @override
  State<GD1> createState() => _GD1State();
}

var homelat;
var homeLong;

class _GD1State extends State<GD1> {

  String? user_id;
  int _counter = 0;
  bool isVisible =true;
  bool noCount = true;
  bool  loading = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }  void _decrimentConter() {
    setState(() {
      if(_counter<=1){
        setState(() {
          isVisible=true;
        });
      }
      _counter--;
    });
  }

  Position? currentLocation;
  FoodCategoryModel? foodCategoryModel;

  Future getUserCurrentLocation() async {
    print("Home latttt and longg ${homelat} ${homeLong}");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          homelat = currentLocation?.latitude;
          homeLong = currentLocation?.longitude;
        });
    });
    print("LOCATION===" +currentLocation.toString());
  }

  @override
  void initState() {
    super.initState();
    // getProductsModel != null ?
    // _getProduct():
    //     Text("No Item Found");
    callApis();
    _getCategories();

    //addToCart();
  }

  callApis(){
    _getUserCart();
    _getProduct();
  }
  Future _refresh(){
    return callApis();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  List<TextEditingController> controller = [];
  List<int> count = [0];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (int i = 0; i < controller.length; i++) controller[i].dispose();
    super.dispose();
  }


  GetProductsModel? getProductsModel;

  _getCategories() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await  getUserCurrentLocation();
    print("Food,Grocery Api");
    var headers = {
      'Cookie': 'ci_session=19ae37817b8d23863ef9b269b178b64435cd91ea'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/grocery_services'));
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

  List<Imgssss> products = [];

  _getProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=7c15c6fc740d1ef52dc736a240a59131cfd99144'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_product_by_id'));
    request.fields.addAll({
      'v_id': widget.id.toString(),
    });
    print("Product vendrorr ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetProductsModel.fromJson(json.decode(finalResponse));
      print("Products response here nowwww $jsonResponse");
      print("final responseeee ${finalResponse}");
      if(jsonResponse.status == 1){
        String product_id = jsonResponse.imgssss![0].productId.toString();
        preferences.setString('product_id', product_id);
        print("Product id is ${product_id}");
        setState(() {
          getProductsModel = GetProductsModel.fromJson(json.decode(finalResponse));
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

  List<String> idList = [];
  GetUserCartModel? getUserCartModel;

  _getUserCart() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=a4f7eded0ae55693b27377b39c0d806fc3fd3588'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_cart_items'));
    request.fields.addAll({
      'user_id': user_id ?? '',
    });
    print("Get User Cartt ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      print("hjhjjhhhhhhhhhhhhhhh");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetUserCartModel.fromJson(json.decode(finalResponse));
      print("Get Userrrrr cartttt $jsonResponse");
      if(jsonResponse.responseCode == '1'){
        print("cart&&&&&&&&&&&");
        String? cart_total = jsonResponse.cartTotal ?? "";
        preferences.setString('cart_total', cart_total);
        print("cartt Total@@@@@@@@@@@@ ${cart_total}");
        setState(() {
          getUserCartModel = GetUserCartModel.fromJson(json.decode(finalResponse));
        });
        idList.clear();
        for( var i=0; i<getUserCartModel!.cart!.length; i++)
        {idList.add(getUserCartModel!.cart![0].productId.toString());
        }
      } else{
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  AddToCartModel? addToCartModel;
  double total = 0;
  addToCart(String productId, String? qty) async {
    print("qtyyyyyy ${qty}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=76282680e65886d44b5d7a8a0b61ac57d57ba3b3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/add_to_cart'));
    request.fields.addAll({
      'user_id': user_id ?? '',
      'product_id': productId,
      'quantity':  "${qty}",
      'vendor_id': widget.id.toString(),
    });
    print("Add To Cart Requset ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddToCartModel.fromJson(json.decode(finalResponse));
      print("Get Userrrrr cartttt$jsonResponse");
      setState(() {
        loading = false;
        addToCartModel = AddToCartModel.fromJson(json.decode(finalResponse));
        total = double.parse(addToCartModel!.price.toString());
      });
      callApis();
      print("tnhis is $total");
    }
    else {
      setState(() {
        loading = false;
      });
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    // callApis();
    // print("Products here nowww ${getProductsModel!.imgssss![0].productImage}");
    // print("Products here_________ ${getProductsModel!.imgssss![0].catName}");
    // print("Products here%%%%%%%%%% ${getProductsModel!.imgssss![0].variantName}");
    // print("service found ${getProductsModel!.msg}");
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: Color(0xffF1F5F8),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white38,
          title: Text(widget.name == null || widget.name == "" ? "Food" : widget.name.toString() , style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w900, fontSize: 22),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: backgroundblack),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(onPressed: () async{
              var result = await  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart(show: true,)));
              print("this is result $result");
               if(result != null){
                 // setState(() {
               // Future.delayed(Duration(milliseconds: 1200), (){
               //   _getProduct();
               // });
                 callApis();

                 // });
               }

              }, icon: Icon(Icons.shopping_cart, color: backgroundblack),
              ),
            ),
          ],
        ),
        bottomSheet: total == 0 ?
            SizedBox.shrink() :
        Padding(
          padding: const EdgeInsets.all(4),
          child:
          // addToCartModel!.price == null || addToCartModel!.price.toString() == '' || addToCartModel!.price.toString() == ''?
          //     SizedBox.shrink():
          InkWell(
            onTap: () async {
              var result = await  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart(show: true,)));
              if(result != null){
                print("this is final result $result");
                callApis();
                // setState(() {
                //   _getProduct();
                // });
              }

            },
            child:
            // addToCartModel == null  ? CircularProgressIndicator(color: Color(0xffF1F5F8), strokeWidth: 1,) :
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                  borderRadius: BorderRadius.circular(10),
                  color: appColorOrange),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text("2 iTEMS |",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack),),
                    // SizedBox(width: 5),
                    loading ?
                    Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: backgroundblack,
                        ))
                        :  Text("₹ ${total.toStringAsFixed(2)}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: backgroundblack)),
                    Text("View Cart >",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body:
        // Container(
        //            decoration: BoxDecoration(
        //           border: Border(top: BorderSide(width: 5)),
        //           borderRadius: const BorderRadius.only(
        //           topLeft: Radius.circular(30.0),
        //           topRight: Radius.circular(30.0),
        //    ), ),
        // ),
        // SingleChildScrollView(
        //   child: Column(
        //     children: [
              // Container(
              //   height: MediaQuery.of(context).size.height/40,
              //   // height: MediaQuery.of(context).size.height-85.0-75,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: const BoxDecoration(
              //       color: appColorOrange,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(45),
              //         topRight: Radius.circular(45),
              //       )),
              //   // child: Padding(
              //   //   padding: const EdgeInsets.only(top:70, left: 30.0, right: 30),
              //   //   child: SingleChildScrollView(
              //   //     child: Text("khjjhj"),
              //   //   ),
              //   // ),
              // ),
              getProductsModel == null  || getProductsModel == ""  ? Center(
                child: CircularProgressIndicator(color: backgroundblack,),
              ): Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: getProductsModel!.imgssss!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return productItem(context, index);
                  },
                ),
              ),


        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget productItem(context, index){
    if (controller.length < index + 1)
      controller.add(new TextEditingController());
    controller[index].text = "0";
    if(count.length < index + 1)
      count.add(0);
    // if(cartModel == null){
    //
    // }
    // else{
    //   if(cartModel!.getCartList!.orderProductData == null){
    //
    //   }
    //   else{
    //     if(cartModel!.getCartList!.orderProductData!.length > 1){
    //
    //       count[index] = int.parse(cartModel!.getCartList!.orderProductData![index].quatity.toString());
    //       countValue = count[index];
    //     }
    //   }
    // }
    if(getUserCartModel == null){
    }
    else{
      if(getUserCartModel!.cart == null){
      }
      else{
        if(getUserCartModel!.cart!.length > 1){
          for(var i=0;i< getUserCartModel!.cart!.length;i++){
            count[index] = int.parse(getUserCartModel!.cart![index].quantity ?? "");
          }
          // count[index] = int.parse(cartModel!.getCartList!.orderProductData![index].quatity.toString());
        }
      }
    }
    return Padding(
      padding: EdgeInsets.all(15),
      child: Scrollbar(
        thickness: 10,
        trackVisibility: true,
        // isAlwaysShown: true,
        thumbVisibility: true,
        radius: Radius.circular(10),
        child: Container(
          height: 130,
          child: Card(
            elevation: 10,
            semanticContainer: true,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(20.0),
            // ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Center(
                //   child: Container(
                //       decoration: BoxDecoration(
                //           color: appColorOrange,
                //           borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                //       height: 90,width: 5),
                // ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    // color: Colors.white,
                    height: 90,
                    width: 90,
                    child: Image.network("${getProductsModel!.imgssss![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,),
                  ),
                ),
                // Center(
                //   child: ClipRRect(
                //       borderRadius: BorderRadius.circular(100),
                //       // radius: 40,
                //       child: getProductsModel == null ? Center(
                //         child: Image.asset("assets/images/loader1.gif"),
                //       ) : Image.network("${getProductsModel!.imgssss![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,)
                //   ),
                // ),
                // Text("Imageee ${getProductsModel!.imgssss![index].productImage}"),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 125,
                          child: Text("${getProductsModel!.imgssss![index].productName}", maxLines: 2,style: TextStyle(color: backgroundblack, overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,fontSize: 15),)),
                      SizedBox(height: 5),
                      Text("${getProductsModel!.imgssss![index].variantName}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13),),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text("₹ ${getProductsModel!.imgssss![index].productPrice}",style: TextStyle(color: appColorOrange,fontSize: 13, decoration: TextDecoration.lineThrough)),
                          SizedBox(width: 7),
                          Text("₹ ${getProductsModel!.imgssss![index].sellingPrice}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
                        ],
                      ),
                      // foodCategoryModel!.product![index].restoType.toString() == null ||
                      //     foodCategoryModel!.product![index].restoType.toString() == "" ? Center(child: Image.asset("assets/images/loader1.gif", scale: 1)):
                      // foodCategoryModel!.product![index].restoType.toString() == 'Veg' ? Image.asset("assets/images/veg.png", scale: 2.5,)
                      // :foodCategoryModel!.product![index].restoType.toString() == 'Non-Veg'? Image.asset("assets/images/nonveg.png", scale: 2.5,)
                      // :foodCategoryModel!.product![index].restoType.toString() == 'Both' ? Image.asset("assets/images/veg.png", scale: 2.5,):Image.asset("assets/images/nonveg.png", scale: 2.5,)
                    ],
                  ),
                ),
                SizedBox(width: 30),
                count[index] == 0 ?
                GestureDetector(
                  onTap: () {
                    setState(() {
                      count[index] = 1;
                      addToCart(getProductsModel!.imgssss![index].productId ?? "", count[index].toString());
                      print("add countingg ${getProductsModel!.imgssss![index].noCount}");
                      // products.add(getProductsModel!.imgssss![index]);
                    });
                    print("adddd count inder ${count[index].toString()}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Container(
                      height:30,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundblack,
                      ),
                      child: Center(
                          child: Text("Add",style: TextStyle(color: Colors.white, fontSize: 16))
                      ),
                    ),
                  ),
                  // Card(
                  //   elevation: 2,
                  //   child: Container(
                  //     height:40,
                  //     width: 70,
                  //     decoration: BoxDecoration(border: Border.all(color:Colors.blue)),
                  //     child: Center(child: Text('Add',style: TextStyle(color:Colors.green),)),
                  //   ),
                  // ),
                ):
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      // child:  InkWell(
                      //   onTap: () {
                      //     if (_counter >= 1) {
                      //       _counter -= 1;
                      //       setState(() {});
                      //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                      //     }
                      //   },
                      //   child: Card(
                      //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                      //     child: ClipRRect(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(6)),
                      //         child: Container(
                      //             // padding: EdgeInsets.all(6),
                      //             // color: isDark
                      //             //     ? AppThemes.smoothBlack
                      //             //     : AppThemes
                      //             //     .lightTextFieldBackGroundColor,
                      //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                      //         ),
                      //     ),
                      //   ),
                      // ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                          });
                          count[index] -= 1;
                          addToCart(getProductsModel!.imgssss![index].productId ?? "",
                              count[index].toString()
                          );
                          // if (_counter >= 1) {
                          //   _counter -= 1;
                          //   setState(() {});
                          //   addToCart(getProductsModel!.imgssss![index].productId ??'');
                          // }
                        },
                        // onTap:() {
                        //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                        //   _decrimentConter;
                        // },
                        child:(
                            Center(
                                child: Icon(Icons.remove,size: 18, color: appColorBlack))
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        '${count[index]}',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 6),
                    // SizedBox(width: 60,),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {});
                          count[index] += 1;
                          addToCart(getProductsModel!.imgssss![index].productId ?? "", count[index].toString());
                          // addToCart(getProductsModel!.imgssss![index].productId ??'');
                          print("conuterrrrrr hereeeee ${count[index]}");
                        },
                        child: (
                            Center(child: const Icon(Icons.add,size: 18,color: appColorBlack))),
                      ),
                    ),
                  ],
                ),
                // Spacer(),
                // Center(
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: appColorOrange,
                //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
                //     height: 80,width: 8),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // Widget productItem(context, index){
  //   if (controller.length < index + 1)
  //     controller.add(new TextEditingController());
  //   controller[index].text = "0";
  //   if(count.length < index + 1)
  //     count.add(0);
  //   if(getUserCartModel == null){
  //   }
  //   else{
  //     if(getUserCartModel!.cart == null){
  //     }
  //     else{
  //       if(getUserCartModel!.cart!.length > 1){
  //         for(var i=0;i< getUserCartModel!.cart!.length;i++){
  //           count[index] = int.parse(getUserCartModel!.cart![i].quantity ?? "");
  //         }
  //         // count[index] = int.parse(cartModel!.getCartList!.orderProductData![index].quatity.toString());
  //       }
  //     }
  //   }
  //   // if(cartModel == null){
  //   //
  //   // }
  //   // else{
  //   //   if(cartModel!.getCartList!.orderProductData == null){
  //   //
  //   //   }
  //   //   else{
  //   //     if(cartModel!.getCartList!.orderProductData!.length > 1){
  //   //
  //   //       count[index] = int.parse(cartModel!.getCartList!.orderProductData![index].quatity.toString());
  //   //       countValue = count[index];
  //   //     }
  //   //   }
  //   // }
  //   // if(getUserCartModel == null){
  //   // }
  //   // else{
  //   //   if(getUserCartModel!.cart == null){
  //   //   }
  //   //   else{
  //   //
  //   //     if(getUserCartModel!.cart!.length > 1){
  //   //       for(var i=0;i< getUserCartModel!.cart!.length;i++){
  //   //         // if(getProductsModel!.imgssss![index].productId == getUserCartModel!.cart![i].productId){
  //   //            count[index] = int.parse(getUserCartModel!.cart![i].quantity ?? "");
  //   //
  //   //         // }
  //   //        print("this is cart count ${count[index]}");
  //   //       }
  //   //       // count[index] = int.parse(cartModel!.getCartList!.orderProductData![index].quatity.toString());
  //   //     }
  //   //   }
  //   // }
  //   return Padding(
  //     padding: EdgeInsets.all(15),
  //     child: Scrollbar(
  //       thickness: 10,
  //       trackVisibility: true,
  //       // isAlwaysShown: true,
  //       thumbVisibility: true,
  //       radius: Radius.circular(10),
  //       child: Container(
  //         height: 130,
  //         child: Card(
  //           elevation: 10,
  //           semanticContainer: true,
  //           // shape: RoundedRectangleBorder(
  //           //   borderRadius: BorderRadius.circular(20.0),
  //           // ),
  //           clipBehavior: Clip.antiAlias,
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: <Widget>[
  //               // Center(
  //               //   child: Container(
  //               //       decoration: BoxDecoration(
  //               //           color: appColorOrange,
  //               //           borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
  //               //       height: 90,width: 5),
  //               // ),
  //               SizedBox(width: 5),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 20, bottom: 20),
  //                 child: Container(
  //                   // color: Colors.white,
  //                   height: 90,
  //                   width: 90,
  //                   child: Image.network("${getProductsModel!.imgssss![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,),
  //                 ),
  //               ),
  //               // Center(
  //               //   child: ClipRRect(
  //               //       borderRadius: BorderRadius.circular(100),
  //               //       // radius: 40,
  //               //       child: getProductsModel == null ? Center(
  //               //         child: Image.asset("assets/images/loader1.gif"),
  //               //       ) : Image.network("${getProductsModel!.imgssss![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,)
  //               //   ),
  //               // ),
  //               // Text("Imageee ${getProductsModel!.imgssss![index].productImage}"),
  //               SizedBox(width: 5),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 24.0, left: 5),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       width: 125,
  //                         child: Text("${getProductsModel!.imgssss![index].productName}", maxLines: 2,style: TextStyle(color: backgroundblack, overflow: TextOverflow.ellipsis,
  //                             fontWeight: FontWeight.bold,fontSize: 15),)),
  //                     SizedBox(height: 5),
  //                     Text("${getProductsModel!.imgssss![index].variantName}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13),),
  //                     SizedBox(height: 5),
  //                     Row(
  //                       children: [
  //                         Text("₹ ${getProductsModel!.imgssss![index].productPrice}",style: TextStyle(color: appColorOrange,fontSize: 13, decoration: TextDecoration.lineThrough)),
  //                         SizedBox(width: 7),
  //                         Text("₹ ${getProductsModel!.imgssss![index].sellingPrice}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
  //                       ],
  //                     ),
  //                         // foodCategoryModel!.product![index].restoType.toString() == null ||
  //                         //     foodCategoryModel!.product![index].restoType.toString() == "" ? Center(child: Image.asset("assets/images/loader1.gif", scale: 1)):
  //                         // foodCategoryModel!.product![index].restoType.toString() == 'Veg' ? Image.asset("assets/images/veg.png", scale: 2.5,)
  //                         // :foodCategoryModel!.product![index].restoType.toString() == 'Non-Veg'? Image.asset("assets/images/nonveg.png", scale: 2.5,)
  //                         // :foodCategoryModel!.product![index].restoType.toString() == 'Both' ? Image.asset("assets/images/veg.png", scale: 2.5,):Image.asset("assets/images/nonveg.png", scale: 2.5,)
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(width: 30),
  //               count[index] == 0 ?
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     loading = true;
  //                     count[index] = 1;
  //                     addToCart(getProductsModel!.imgssss![index].productId ?? "", count[index].toString());
  //                     print("add countingg ${getProductsModel!.imgssss![index].noCount}");
  //                     // products.add(getProductsModel!.imgssss![index]);
  //                   });
  //                   print("adddd count inder ${count[index].toString()}");
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(top: 35.0),
  //                   child: Container(
  //                     height:30,
  //                     width: 55,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       color: backgroundblack,
  //                     ),
  //                     child: Center(
  //                         child:
  //                         Text("Add",style: TextStyle(color: Colors.white, fontSize: 16))
  //                     ),
  //                   ),
  //                 ),
  //
  //               ):
  //               Row(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 5.0),
  //                     // child:  InkWell(
  //                     //   onTap: () {
  //                     //     if (_counter >= 1) {
  //                     //       _counter -= 1;
  //                     //       setState(() {});
  //                     //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
  //                     //     }
  //                     //   },
  //                     //   child: Card(
  //                     //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
  //                     //     child: ClipRRect(
  //                     //         borderRadius:
  //                     //         BorderRadius.all(Radius.circular(6)),
  //                     //         child: Container(
  //                     //             // padding: EdgeInsets.all(6),
  //                     //             // color: isDark
  //                     //             //     ? AppThemes.smoothBlack
  //                     //             //     : AppThemes
  //                     //             //     .lightTextFieldBackGroundColor,
  //                     //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
  //                     //         ),
  //                     //     ),
  //                     //   ),
  //                     // ),
  //                     child: InkWell(
  //                       onTap: () {
  //                         setState(() {
  //                           loading = true;
  //                         });
  //                         count[index] -= 1;
  //                         addToCart(getProductsModel!.imgssss![index].productId ?? "",
  //                             count[index].toString()
  //                         );
  //                         // if (_counter >= 1) {
  //                         //   _counter -= 1;
  //                         //   setState(() {});
  //                         //   addToCart(getProductsModel!.imgssss![index].productId ??'');
  //                         // }
  //                       },
  //                       // onTap:() {
  //                       //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
  //                       //   _decrimentConter;
  //                       // },
  //                       child:(
  //                           Center(
  //                               child: Icon(Icons.remove,size: 18, color: appColorBlack))
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(width: 6),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 5.0),
  //                     child:
  //                     Text(
  //                       '${count[index]}',
  //                       style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                   SizedBox(width: 6),
  //                   // SizedBox(width: 60,),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 5.0),
  //                     child: InkWell(
  //                       onTap: () {
  //                         setState(() {
  //                           loading = false;
  //                         });
  //                         count[index] += 1;
  //                         addToCart(getProductsModel!.imgssss![index].productId ?? "", count[index].toString());
  //                         // addToCart(getProductsModel!.imgssss![index].productId ??'');
  //                         print("conuterrrrrr hereeeee ${count[index]}");
  //                       },
  //                       child: (
  //                           Center(child: const Icon(Icons.add,size: 18,color: appColorBlack))),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               // Spacer(),
  //               // Center(
  //               //   child: Container(
  //               //     decoration: BoxDecoration(
  //               //         color: appColorOrange,
  //               //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
  //               //     height: 80,width: 8),
  //               // ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

// import 'dart:convert';
//
// import 'package:ez/constant/global.dart';
// import 'package:ez/models/AddToCartModel.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../models/FoodCategoryModel.dart';
// import '../../../models/GetProductsModel.dart';
// import '../../../models/GetUserCartModel.dart';
// import '../../../models/OfferBannerModel.dart';
// import '../../../models/car_model.dart';
// import 'package:http/http.dart' as http;
// import 'cart.dart';
// import 'cart_new.dart';



class GroceryDetails extends StatefulWidget {
  String? id;
  String? product_id;
  final String? name;
  GroceryDetails({Key? key, this.id, this.product_id, this.name}) : super(key: key);
  @override
  State<GroceryDetails> createState() => _GroceryDetailsState();
}



class _GroceryDetailsState extends State<GroceryDetails> {

  String? user_id;
  int _counter = 0;
  bool isVisible =true;
  bool noCount = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }  void _decrimentConter() {
    setState(() {
      if(_counter<=1){
        setState(() {
          isVisible=true;
        });
      }
      _counter--;
    });
  }

  Position? currentLocation;
  FoodCategoryModel? foodCategoryModel;

  Future getUserCurrentLocation() async {
    print("Home latttt and longg ${homelat} ${homeLong}");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          homelat = currentLocation?.latitude;
          homeLong = currentLocation?.longitude;
        });
    });
    print("LOCATION===" +currentLocation.toString());
  }

  @override
  void initState() {
    super.initState();
    // getProductsModel != null ?
    // _getProduct():
    //     Text("No Item Found");
    callApis();
    _getProduct();
    _getCategories();
    //addToCart();
  }

  Future _refresh(){
    return callApis();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  List<TextEditingController> controller = [];
  List<int> count = [0];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (int i = 0; i < controller.length; i++) controller[i].dispose();
    super.dispose();
  }

  callApis(){
    _getUserCart();
    _getProduct();
  }

  GetProductsModel? getProductsModel;

  _getCategories() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await  getUserCurrentLocation();
    print("Food,Grocery Api");
    var headers = {
      'Cookie': 'ci_session=19ae37817b8d23863ef9b269b178b64435cd91ea'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/grocery_services'));
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

  List<Imgssss> products = [];

  _getProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=7c15c6fc740d1ef52dc736a240a59131cfd99144'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_product_by_id'));
    request.fields.addAll({
      'v_id': widget.id.toString(),
    });
    print("Product vendrorr ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetProductsModel.fromJson(json.decode(finalResponse));
      print("Products response here nowwww $jsonResponse");
      print("final responseeee ${finalResponse}");
      if(jsonResponse.status == 1){
        String product_id = jsonResponse.imgssss![0].productId.toString();
        preferences.setString('product_id', product_id);
        print("Product id is ${product_id}");
        setState(() {
          getProductsModel = GetProductsModel.fromJson(json.decode(finalResponse));
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

  List<String> idList = [];
  GetUserCartModel? getUserCartModel;

  _getUserCart() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=a4f7eded0ae55693b27377b39c0d806fc3fd3588'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_cart_items'));
    request.fields.addAll({
      'user_id': user_id ?? '',
    });
    print("Get User Cartt ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      print("hjhjjhhhhhhhhhhhhhhh");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetUserCartModel.fromJson(json.decode(finalResponse));
      print("Get Userrrrr cartttt $jsonResponse");
      if(jsonResponse.responseCode == '1'){
        print("cart&&&&&&&&&&&");
        String? cart_total = jsonResponse.cartTotal ?? "";
        preferences.setString('cart_total', cart_total);
        print("cartt Total@@@@@@@@@@@@ ${cart_total}");
        setState(() {
          getUserCartModel = GetUserCartModel.fromJson(json.decode(finalResponse));
        });
        idList.clear();
        for( var i=0; i<getUserCartModel!.cart!.length; i++)
        {idList.add(getUserCartModel!.cart![0].productId.toString());
        }
      } else{
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  void replaceCartDialog(String msg, String productId, String qty) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  content: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                                child: Text("REPLACE RESTAURANT",
                                  style: Theme.of(this.context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                  ),
                                )),
                            Divider(
                                color: Colors.black),
                            Text(msg),
                            Text("Are you sure you want replace these items!"),

                          ]),
                      // load ?
                      // CircularProgressIndicator(color: backgroundblack, backgroundColor: appColorOrange,)
                      //  : SizedBox.shrink(),
                    ],
                  ),
                  actions: <Widget>[
                    new TextButton(
                        child: Text("NO",
                            style: TextStyle(
                                color: appColorOrange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pop(context);
                          // checkoutState!(() {
                          //   _placeOrder = true;
                          // });
                          // placeOrder();


                        }),
                    new TextButton(
                        child: Text("REPLACE",
                            style: TextStyle(
                                color: backgroundblack,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          replaceItemCart(productId, qty);
                          // setState(() {
                          //   load = true;
                          // });
                          // placeOrder();
                          // Navigator.pop(context);

                          // doPayment();
                        })
                  ],
                )),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  AddToCartModel? addToCartModel;

  addToCart(String productId, String? qty) async {
    print("qtyyyyyy ${qty}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=76282680e65886d44b5d7a8a0b61ac57d57ba3b3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/add_to_cart'));
    request.fields.addAll({
      'user_id': user_id ?? '',
      'product_id': productId,
      'quantity':  "${qty}",
      'vendor_id': widget.id.toString(),
    });
    print("Add To Cart Requset ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddToCartModel.fromJson(json.decode(finalResponse));
      if(jsonResponse.responseCode == "1"){
        // if(isAdd){
          setState(() {
            addToCartModel = AddToCartModel.fromJson(json.decode(finalResponse));
            total = double.parse(addToCartModel!.price.toString());
            // count[index] += 1;
          });
        // }else{
        //   setState(() {
        //     addToCartModel = AddToCartModel.fromJson(json.decode(finalResponse));
        //     total = double.parse(addToCartModel!.price.toString());
        //     count[index] -= 1;
        //   });
        // }

        Fluttertoast.showToast(msg: jsonResponse.message.toString());
        print("this is add to cart response ${addToCartModel!.price}");
      }else{
        replaceCartDialog(jsonResponse.message.toString(), productId.toString(), qty.toString());
        // Fluttertoast.showToast(msg: jsonResponse.message.toString());
      }


    }
    else {
      print(response.reasonPhrase);
    }
  }

  replaceItemCart(String productId, String? qty) async {
    print("qtyyyyyy ${qty}");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=76282680e65886d44b5d7a8a0b61ac57d57ba3b3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/add_to_cart_another_vendor'));
    request.fields.addAll({
      'user_id': user_id ?? '',
      'product_id': productId,
      'quantity':  "${qty}",
      'vendor_id': widget.id.toString(),
    });
    print("Add To Cart Requset ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddToCartModel.fromJson(json.decode(finalResponse));
      if(jsonResponse.responseCode == "1"){
        setState(() {
          addToCartModel = AddToCartModel.fromJson(json.decode(finalResponse));
          total = double.parse(addToCartModel!.price.toString());
        });
        Fluttertoast.showToast(msg: jsonResponse.message.toString());
        print("this is add to cart response ${addToCartModel!.price}");
      }else{
        replaceCartDialog(jsonResponse.message.toString(), productId.toString(), qty.toString());
        // Fluttertoast.showToast(msg: jsonResponse.message.toString());


      }


    }
    else {
      print(response.reasonPhrase);
    }
  }

  double total = 0 ;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // print("Products here nowww ${getProductsModel!.imgssss![0].productImage}");
    // print("Products here_________ ${getProductsModel!.imgssss![0].catName}");
    // print("Products here%%%%%%%%%% ${getProductsModel!.imgssss![0].variantName}");
    // print("service found ${getProductsModel!.msg}");
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: Color(0xffF1F5F8),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white38,
          title: Text(widget.name == null || widget.name == "" ? "Food" : widget.name.toString() , style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w900, fontSize: 22),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: backgroundblack),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart(show: true,)));
              }, icon: Icon(Icons.shopping_cart, color: backgroundblack),
              ),
            ),
          ],
        ),
        bottomSheet: total == 0 ?
        SizedBox.shrink() :
        Padding(
          padding: const EdgeInsets.all(4),
          child:
          // addToCartModel!.price == null || addToCartModel!.price.toString() == '' || addToCartModel!.price.toString() == ''?
          //     SizedBox.shrink():
          InkWell(
            onTap: () async {
              var result = await  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart(show: true,)));
              if(result != null){
                print("this is final result $result");

                // setState(() {
                //   _getProduct();
                // });
              }

            },
            child:
            // addToCartModel == null  ? CircularProgressIndicator(color: Color(0xffF1F5F8), strokeWidth: 1,) :
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                  borderRadius: BorderRadius.circular(10),
                  color: appColorOrange),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text("2 iTEMS |",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack),),
                    // SizedBox(width: 5),
                    loading ?
                    Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: backgroundblack,
                        ))
                        :  Text("₹ ${total.toStringAsFixed(2)}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: backgroundblack)),
                    Text("View Cart >",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body:
        // Container(
        //            decoration: BoxDecoration(
        //           border: Border(top: BorderSide(width: 5)),
        //           borderRadius: const BorderRadius.only(
        //           topLeft: Radius.circular(30.0),
        //           topRight: Radius.circular(30.0),
        //    ), ),
        // ),
        // SingleChildScrollView(
        //   child: Padding(
        //     padding:  EdgeInsets.only(top:0),
        //     child : Column(
        //       children: [
        //         // Container(
        //         //   height: MediaQuery.of(context).size.height/40,
        //         //   // height: MediaQuery.of(context).size.height-85.0-75,
        //         //   width: MediaQuery.of(context).size.width,
        //         //   decoration: const BoxDecoration(
        //         //       color: appColorOrange,
        //         //       borderRadius: BorderRadius.only(
        //         //         topLeft: Radius.circular(45),
        //         //         topRight: Radius.circular(45),
        //         //       )),
        //         //   // child: Padding(
        //         //   //   padding: const EdgeInsets.only(top:70, left: 30.0, right: 30),
        //         //   //   child: SingleChildScrollView(
        //         //   //     child: Text("khjjhj"),
        //         //   //   ),
        //         //   // ),
        //         // ),
        //         Container(
        //           height: MediaQuery.of(context).size.height/1.4,
        //           width: MediaQuery.of(context).size.width,
        //           child:
                  getProductsModel == null  || getProductsModel == ""  ? Center(
                    child: CircularProgressIndicator(color: backgroundblack,),
                  ):
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: getProductsModel!.imgssss!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return productItem(context, index);
                    },
                  ),
                ),
        //         SizedBox(height: 50,),
        //         InkWell(
        //           onTap: (){
        //             Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewCart()));
        //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewCart(allProducts: products,)));
        //           },
        //           child: addToCartModel == null  ? CircularProgressIndicator(color: Color(0xffF1F5F8), strokeWidth: 1,) : Container(
        //             height: 45,
        //             width: MediaQuery.of(context).size.width/1.1,
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(15),
        //                 color: appColorOrange),
        //             child: Padding(
        //               padding: const EdgeInsets.all(10.0),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   // Text("2 iTEMS |",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack),),
        //                   // SizedBox(width: 5),
        //                   Text("₹ ${addToCartModel!.price}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: backgroundblack)),
        //                   Text("View Cart >",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack)
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      // ),
    );
  }

  Widget productItem(context, index){
    if (controller.length < index + 1)
      controller.add(new TextEditingController());
    controller[index].text = "0";
    if(count.length < index + 1)
      count.add(0);
    // if(cartModel == null){
    //
    // }
    // else{
    //   if(cartModel!.getCartList!.orderProductData == null){
    //
    //   }
    //   else{
    //     if(cartModel!.getCartList!.orderProductData!.length > 1){
    //
    //       count[index] = int.parse(cartModel!.getCartList!.orderProductData![index].quatity.toString());
    //       countValue = count[index];
    //     }
    //   }
    // }
    if(getUserCartModel == null){
    }
    else{
      if(getUserCartModel!.cart == null){
      }
      else{
        if(getUserCartModel!.cart!.length > 1){
          // for(var i=0;i< getUserCartModel!.cart!.length;i++){
          //   count[index] = int.parse(getUserCartModel!.cart![index].quantity ?? "");
          // }
          // count[index] = int.parse(cartModel!.getCartList!.orderProductData![index].quatity.toString());
        }
      }
    }
    return Padding(
      padding: EdgeInsets.all(15),
      child: Scrollbar(
        thickness: 10,
        trackVisibility: true,
        // isAlwaysShown: true,
        thumbVisibility: true,
        radius: Radius.circular(10),
        child: Container(
          height: 130,
          child: Card(
            elevation: 10,
            semanticContainer: true,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(20.0),
            // ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Center(
                //   child: Container(
                //       decoration: BoxDecoration(
                //           color: appColorOrange,
                //           borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                //       height: 90,width: 5),
                // ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    // color: Colors.white,
                    height: 90,
                    width: 90,
                    child: Image.network("${getProductsModel!.imgssss![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,),
                  ),
                ),
                // Center(
                //   child: ClipRRect(
                //       borderRadius: BorderRadius.circular(100),
                //       // radius: 40,
                //       child: getProductsModel == null ? Center(
                //         child: Image.asset("assets/images/loader1.gif"),
                //       ) : Image.network("${getProductsModel!.imgssss![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,)
                //   ),
                // ),
                // Text("Imageee ${getProductsModel!.imgssss![index].productImage}"),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 125,
                          child: Text("${getProductsModel!.imgssss![index].productName}", maxLines: 2,style: TextStyle(color: backgroundblack, overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,fontSize: 15),)),
                      SizedBox(height: 5),
                      Text("${getProductsModel!.imgssss![index].variantName}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13),),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text("₹ ${getProductsModel!.imgssss![index].productPrice}",style: TextStyle(color: appColorOrange,fontSize: 13, decoration: TextDecoration.lineThrough)),
                          SizedBox(width: 7),
                          Text("₹ ${getProductsModel!.imgssss![index].sellingPrice}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
                        ],
                      ),
                      // foodCategoryModel!.product![index].restoType.toString() == null ||
                      //     foodCategoryModel!.product![index].restoType.toString() == "" ? Center(child: Image.asset("assets/images/loader1.gif", scale: 1)):
                      // foodCategoryModel!.product![index].restoType.toString() == 'Veg' ? Image.asset("assets/images/veg.png", scale: 2.5,)
                      // :foodCategoryModel!.product![index].restoType.toString() == 'Non-Veg'? Image.asset("assets/images/nonveg.png", scale: 2.5,)
                      // :foodCategoryModel!.product![index].restoType.toString() == 'Both' ? Image.asset("assets/images/veg.png", scale: 2.5,):Image.asset("assets/images/nonveg.png", scale: 2.5,)
                    ],
                  ),
                ),
                SizedBox(width: 30),
                count[index] == 0 ?
                GestureDetector(
                  onTap: () {
                    setState(() {
                      count[index] += 1;
                      print("add countingg ${getProductsModel!.imgssss![index].noCount}");
                      // products.add(getProductsModel!.imgssss![index]);
                    });
                    addToCart(getProductsModel!.imgssss![index].productId ?? "", count[index].toString());
                    print("adddd count inder ${count[index].toString()}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Container(
                      height:30,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundblack,
                      ),
                      child: Center(
                          child: Text("Add",style: TextStyle(color: Colors.white, fontSize: 16))
                      ),
                    ),
                  ),
                  // Card(
                  //   elevation: 2,
                  //   child: Container(
                  //     height:40,
                  //     width: 70,
                  //     decoration: BoxDecoration(border: Border.all(color:Colors.blue)),
                  //     child: Center(child: Text('Add',style: TextStyle(color:Colors.green),)),
                  //   ),
                  // ),
                ):
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      // child:  InkWell(
                      //   onTap: () {
                      //     if (_counter >= 1) {
                      //       _counter -= 1;
                      //       setState(() {});
                      //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                      //     }
                      //   },
                      //   child: Card(
                      //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                      //     child: ClipRRect(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(6)),
                      //         child: Container(
                      //             // padding: EdgeInsets.all(6),
                      //             // color: isDark
                      //             //     ? AppThemes.smoothBlack
                      //             //     : AppThemes
                      //             //     .lightTextFieldBackGroundColor,
                      //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                      //         ),
                      //     ),
                      //   ),
                      // ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                          });
                          count[index] -= 1;

                          addToCart(getProductsModel!.imgssss![index].productId ?? "",
                              count[index].toString()
                          );
                          // if (_counter >= 1) {
                          //   _counter -= 1;
                          //   setState(() {});
                          //   addToCart(getProductsModel!.imgssss![index].productId ??'');
                          // }
                        },
                        // onTap:() {
                        //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                        //   _decrimentConter;
                        // },
                        child:(
                            Center(
                                child: Icon(Icons.remove,size: 18, color: appColorBlack))
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        '${count[index]}',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 6),
                    // SizedBox(width: 60,),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {});
                          count[index] += 1;
                          addToCart(getProductsModel!.imgssss![index].productId ?? "", count[index].toString());
                          // addToCart(getProductsModel!.imgssss![index].productId ??'');
                          print("conuterrrrrr hereeeee ${count[index]}");
                        },
                        child: (
                            Center(child: const Icon(Icons.add,size: 18,color: appColorBlack))),
                      ),
                    ),
                  ],
                ),
                // Spacer(),
                // Center(
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: appColorOrange,
                //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
                //     height: 80,width: 8),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}