// import 'package:ez/constant/global.dart';
// import 'package:ez/screens/view/models/getOrder_modal.dart';
// import 'package:ez/screens/view/newUI/productDetails.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// // ignore: must_be_immutable
// class ViewOrders extends StatefulWidget {
//   // Orders? orders;
//   ViewOrders({});
//   @override
//   _GetCartState createState() => new _GetCartState();
// }
//
// class _GetCartState extends State<ViewOrders> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         backgroundColor: appColorWhite,
//         appBar: AppBar(
//           backgroundColor: appColorWhite,
//           elevation: 2,
//           title: Text(
//             "Order Details",
//             style: TextStyle(
//                 fontSize: 20,
//                 color: appColorBlack,
//                 fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: appColorBlack,
//               )),
//           actions: [],
//         ),
//         body: Stack(
//           children: [
//             widget.orders == null
//                 ? Center(
//                     child: loader(),
//                   )
//                 : ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: widget.orders!.products!.length,
//                     itemBuilder: (context, index) {
//                       return Text("hjhjhjh");
//                         // _itmeList(widget.orders!.products![index], index);
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget _itmeList(Products products, int index) {
//   //   return InkWell(
//   //     onTap: () {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //             builder: (context) => ProductDetails(
//   //                   productId: products.productId,
//   //                 )),
//   //       );
//   //     },
//   //     child: Padding(
//   //       padding: const EdgeInsets.only(left: 20, right: 20),
//   //       child: Column(
//   //         children: [
//   //           Container(
//   //             height: 130,
//   //             width: double.infinity,
//   //             margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//   //             child: Container(
//   //               child: Row(
//   //                 mainAxisAlignment: MainAxisAlignment.start,
//   //                 children: [
//   //                   ClipRRect(
//   //                     borderRadius: BorderRadius.circular(
//   //                       0.0,
//   //                     ),
//   //                     child: Image.network(
//   //                       products.productImage!,
//   //                       height: 90,
//   //                       width: 90,
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                   ),
//   //                   Container(
//   //                     width: 20,
//   //                   ),
//   //                   Column(
//   //                     mainAxisAlignment: MainAxisAlignment.center,
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Text(
//   //                         products.productName!,
//   //                         style: TextStyle(
//   //                             fontSize: 16,
//   //                             color: appColorBlack,
//   //                             fontWeight: FontWeight.bold),
//   //                         maxLines: 2,
//   //                         softWrap: true,
//   //                         overflow: TextOverflow.ellipsis,
//   //                       ),
//   //                       Container(height: 5),
//   //                       Text(
//   //                         "₹${products.productPrice}",
//   //                         style: TextStyle(
//   //                             color: appColorBlack,
//   //                             fontWeight: FontWeight.bold,
//   //                             fontSize: 16),
//   //                       ),
//   //                       Container(height: 5),
//   //                       Text(
//   //                         "Qty : ${products.quantity}",
//   //                         style: TextStyle(
//   //                             color: Colors.black45,
//   //                             fontWeight: FontWeight.bold),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //           Container(
//   //             height: 1,
//   //             color: Colors.grey[300],
//   //           )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }

///jjhuygyg/////uihyugyg////
// import 'dart:convert';
//
// import 'package:ez/constant/global.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../models/getOrder_modal.dart';
//
// class Vieworders extends StatefulWidget {
//   var data;
//   Vieworders({this.data});
//   @override
//   State<Vieworders> createState() => _ViewordersState();
// }
//
// class _ViewordersState extends State<Vieworders> {
//
//   GetOrderModal? getOrdersModal;
//
//   @override
//   void initState() {
//     getOrderApi();
//     super.initState();
//     // getBookingAPICall();
//   }
//
//   String? user_id;
//   getOrderApi() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     user_id= preferences.getString("user_id");
//     try {
//       Map<String, String> headers = {
//         'content-type': 'application/x-www-form-urlencoded',
//       };
//       var map = new Map<String, dynamic>();
//       map['user_id'] = user_id.toString();
//
//       final response = await client.post(Uri.parse("${baseUrl()}/get_orders"),
//           headers: headers, body: map);
//       Map<String, dynamic> userMap = jsonDecode(response.body);
//       setState(() {
//         getOrdersModal = GetOrderModal.fromJson(userMap);
//       });
//     } on Exception {
//       Fluttertoast.showToast(msg: "No Internet connection");
//       throw Exception('No Internet connection');
//     }
//   }
//   late TabController _tabController;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appColorWhite,
//    appBar: AppBar(
//      leading: InkWell(
//        onTap: () {
//          Navigator.pop(context);
//        },
//          child: Icon(Icons.arrow_back, color: backgroundblack)
//      ),
//      backgroundColor: appColorWhite,
//      centerTitle: true,
//      elevation: 0,
//      title: Text("Order Details", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: backgroundblack),),
//    ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Container(
//                 height: 50,
//                 child: Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Row(
//                       children: [
//                         Text("Order No.",
//                           style: TextStyle(fontWeight: FontWeight.w800, color: appColorBlack, fontSize: 12)),
//                         getOrdersModal?.data![0].orderId== null || getOrdersModal?.data![0].orderId =="" ?
//                         Text("890",  style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 12),):
//                         Text("${getOrdersModal?.data![0].orderId}",
//                           style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 12)),
//                         SizedBox(width: 9),
//                         Text("OTP:",
//                           style: TextStyle(fontWeight: FontWeight.w800, color: appColorBlack, fontSize: 12)),
//                         Text("#${getOrdersModal?.data![0].otp}",
//                           style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 12)),
//                         SizedBox(width: 9,),
//                         Text("Restaurant Name:",
//                           style: TextStyle(fontWeight: FontWeight.w800, color: appColorBlack, fontSize: 12)),
//                         Text("${getOrdersModal?.data![0].storeName}",
//                           style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 12)),
//                         SizedBox(width: 9),
//                         Text("Status:",
//                           style: TextStyle(fontWeight: FontWeight.w800, color: appColorBlack, fontSize: 12)),
//                         Text("${getOrdersModal?.data![0].orderStatus}",
//                           style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 12)),
//                       ]
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10,),
//             Text("Items Summary", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),),
//             itemSummary(context),
//             SizedBox(height: 10,),
//             Text("Order Summary", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),),
//             orderSummary(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget itemSummary(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: Scrollbar(
//         thickness: 10,
//         trackVisibility: true,
//         // isAlwaysShown: true,
//         thumbVisibility: true,
//         radius: Radius.circular(10),
//         child: Container(
//           height: 150,
//           child: Card(
//             elevation: 10,
//             semanticContainer: true,
//             // shape: RoundedRectangleBorder(
//             //   borderRadius: BorderRadius.circular(20.0),
//             // ),
//             clipBehavior: Clip.antiAlias,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 // Center(
//                 //   child: Container(
//                 //       decoration: BoxDecoration(
//                 //           color: appColorOrange,
//                 //           borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
//                 //       height: 90,width: 5),
//                 // ),
//                 SizedBox(width: 10),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20, bottom: 20),
//                   child: Container(
//                     // color: Colors.white,
//                     height: 100,
//                     width: 100,
//                     child: Image.network("${getOrdersModal?.data![0].productsDetails![0].productImage}", height: 70, width: 70, fit: BoxFit.fill,),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 24.0, left: 5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           width: 125,
//                           child: Text("${getOrdersModal?.data![0].productsDetails![0].productName}", maxLines: 2,style: TextStyle(color: backgroundblack, overflow: TextOverflow.ellipsis,
//                               fontWeight: FontWeight.bold,fontSize: 15))),
//                       SizedBox(height: 5),
//                       Text("${getOrdersModal?.data![0].productsDetails![0].variantName}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13),),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Text("Price",style: TextStyle(color: appColorOrange,fontSize: 13,)),
//                           SizedBox(width: 7),
//                           Text("₹ ${getOrdersModal?.data![0].productsDetails![0].productPrice}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Qty:",style: TextStyle(color: appColorOrange,fontSize: 13,)),
//                           SizedBox(width: 7),
//                           Text("${getOrdersModal?.data![0].items![0].quantity}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Total Price",style: TextStyle(color: appColorOrange,fontSize: 13,)),
//                           SizedBox(width: 7),
//                           Text("₹ ${getOrdersModal?.data![0].subtotal}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
//                         ],
//                       ),
//                       // foodCategoryModel!.product![index].restoType.toString() == null ||
//                       //     foodCategoryModel!.product![index].restoType.toString() == "" ? Center(child: Image.asset("assets/images/loader1.gif", scale: 1)):
//                       // foodCategoryModel!.product![index].restoType.toString() == 'Veg' ? Image.asset("assets/images/veg.png", scale: 2.5,)
//                       // :foodCategoryModel!.product![index].restoType.toString() == 'Non-Veg'? Image.asset("assets/images/nonveg.png", scale: 2.5,)
//                       // :foodCategoryModel!.product![index].restoType.toString() == 'Both' ? Image.asset("assets/images/veg.png", scale: 2.5,):Image.asset("assets/images/nonveg.png", scale: 2.5,)
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget orderSummary() {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: Scrollbar(
//         thickness: 10,
//         trackVisibility: true,
//         // isAlwaysShown: true,
//         thumbVisibility: true,
//         radius: Radius.circular(10),
//         child: Container(
//           height: 150,
//           child: Card(
//             elevation: 10,
//             semanticContainer: true,
//             // shape: RoundedRectangleBorder(
//             //   borderRadius: BorderRadius.circular(20.0),
//             // ),
//             clipBehavior: Clip.antiAlias,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 // Center(
//                 //   child: Container(
//                 //       decoration: BoxDecoration(
//                 //           color: appColorOrange,
//                 //           borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
//                 //       height: 90,width: 5),
//                 // ),
//                 SizedBox(width: 5),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0, left: 5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           width: 125,
//                           child: Text("${getOrdersModal?.data![0].productsDetails![0].productName}", maxLines: 2,style: TextStyle(color: backgroundblack, overflow: TextOverflow.ellipsis,
//                               fontWeight: FontWeight.bold,fontSize: 15))),
//                       SizedBox(height: 5),
//                       Text("${getOrdersModal?.data![0].productsDetails![0].variantName}", style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13),),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Text("Price",style: TextStyle(color: appColorOrange,fontSize: 13)),
//                           SizedBox(width: 7),
//                           Text("₹ ${getOrdersModal?.data![0].productsDetails![0].productPrice}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Qty:",style: TextStyle(color: appColorOrange,fontSize: 13)),
//                           SizedBox(width: 7),
//                           Text("${getOrdersModal?.data![0].items![0].quantity}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("Total Price",style: TextStyle(color: appColorOrange,fontSize: 13,)),
//                           SizedBox(width: 7),
//                           Text("₹ ${getOrdersModal?.data![0].subtotal}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
//                         ],
//                       ),
//                       // foodCategoryModel!.product![index].restoType.toString() == null ||
//                       //     foodCategoryModel!.product![index].restoType.toString() == "" ? Center(child: Image.asset("assets/images/loader1.gif", scale: 1)):
//                       // foodCategoryModel!.product![index].restoType.toString() == 'Veg' ? Image.asset("assets/images/veg.png", scale: 2.5,)
//                       // :foodCategoryModel!.product![index].restoType.toString() == 'Non-Veg'? Image.asset("assets/images/nonveg.png", scale: 2.5,)
//                       // :foodCategoryModel!.product![index].restoType.toString() == 'Both' ? Image.asset("assets/images/veg.png", scale: 2.5,):Image.asset("assets/images/nonveg.png", scale: 2.5,)
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
