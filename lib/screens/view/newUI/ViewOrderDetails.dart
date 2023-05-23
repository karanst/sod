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


import 'dart:convert';
import 'package:ez/constant/global.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/getOrder_modal.dart';

class Vieworders extends StatefulWidget {
  var data;
  Vieworders({this.data});
  @override
  State<Vieworders> createState() => _ViewordersState();
}

class _ViewordersState extends State<Vieworders> {

  List ordersList = [];
  GetOrderModal? getOrdersModal;
  @override
  void initState() {
    getOrderApi();
    super.initState();
    // getBookingAPICall();
  }

  String? user_id;
  getOrderApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = user_id.toString();
      final response = await client.post(Uri.parse("${baseUrl()}/get_orders"),
          headers: headers, body: map);
      var userMap = json.decode(response.body);
      // setState(() {
      //   var finalResponse = GetOrderModal.fromJson(userMap);
      setState(() {
        ordersList = userMap['data'];
      });
      // });
    } on Exception {
      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
    }
  }


  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: backgroundblack)
        ),
        backgroundColor: appColorWhite,
        centerTitle: true,
        elevation: 0,
        title: Text("Order Details", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: backgroundblack),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 60,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: backgroundblack, //<-- SEE HERE
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, left: 10),
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order No: ",
                                  style: TextStyle(fontWeight: FontWeight.w800, color: appColorBlack, fontSize: 14)),
                              widget.data['order_id']== null ||  widget.data['order_id'] =="" ?
                              Text("--",  style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 12),):
                              Text("${widget.data['order_id']}",
                                  style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 14)),
                              SizedBox(width: 20),
                              Text("OTP: ",
                                  style: TextStyle(fontWeight: FontWeight.w800, color: appColorBlack, fontSize: 14)),
                              Text("${widget.data['otp']}",
                                  style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 14)),
                              // SizedBox(width: 15,),
                            ],
                        ),
                        SizedBox(height: 6,),
                        Column(
                          children: [
                            Row(children: [
                              Text("Restaurant:  ",
                                  style: TextStyle(fontWeight: FontWeight.w800, color: appColorBlack, fontSize: 14)),
                              Text("${widget.data['store_name']}",
                                  style: TextStyle(fontWeight: FontWeight.w800, color: backgroundblack, fontSize: 14)),
                            ],)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Items Summary", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),),
            itemSummary(context),
            SizedBox(height: 10,),
            Text("Delivery Location", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),),
            SizedBox(height: 10,),
            deliveryLocation(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Summary", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),),
                  // Text("Cancel Order", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.red, decoration: TextDecoration.underline),),
                ],
              ),
            ),
            orderSummary(),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  Widget itemCard(int index){

 double itemTotal = double.parse(widget.data['products_details'][index]['selling_price'].toString()) * double.parse(widget.data['products_details'][index]['quantity']);

    return Padding(
      padding: EdgeInsets.all(5),
      child: Scrollbar(
        thickness: 10,
        trackVisibility: true,
        // isAlwaysShown: true,
        thumbVisibility: true,
        radius: Radius.circular(10),
        child: Container(
          height: 140,
          child: Card(
            elevation: 5,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: backgroundblack, //<-- SEE HERE
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  child: Container(
                    // color: Colors.white,
                    height: 100,
                    width: 100,
                    child: Image.network("${widget.data['products_details'][index]['product_image']}", height: 70, width: 70, fit: BoxFit.fill,),
                  ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 125,
                        child: Text("${widget.data['products_details'][index]['product_name']}", maxLines: 2,style: TextStyle(color: backgroundblack, overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,fontSize: 15)
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("${widget.data['products_details'][index]['variant_name']}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13),),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Price",style: TextStyle(color: appColorOrange,fontSize: 13)),
                          SizedBox(width: 7),
                          Text("₹ ${widget.data['products_details'][index]['selling_price']}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Qty:",style: TextStyle(color: appColorOrange,fontSize: 13)),
                          SizedBox(width: 7),
                          Text("${widget.data['products_details'][index]['quantity']}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Total Price",style: TextStyle(color: appColorOrange,fontSize: 13)),
                          SizedBox(width: 7),
                          Text("₹ ${itemTotal.toStringAsFixed(2)}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
                        ],
                      ),
                      SizedBox(height: 3,),
                      widget.data['products_details'][index]['product_type'] == null || widget.data['products_details'][index]['product_type'] == "" ? Center(child: Image.asset("assets/images/loader1.gif", scale: 1)):
                      widget.data['products_details'][index]['product_type'] == 'Veg' ? Image.asset("assets/images/veg.png", scale: 2.5,):
                      widget.data['products_details'][index]['product_type'] == 'Non-Veg'? Image.asset("assets/images/nonveg.png", scale: 2.5,):
                      widget.data['products_details'][index]['product_type'] == 'Both' ? Image.asset("assets/images/veg.png", scale: 2.5,):Image.asset("assets/images/nonveg.png", scale: 2.5,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemSummary(BuildContext context) {
    return widget.data['products_details'].isEmpty
        ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 3,),
    )
        : widget.data['products_details'].isNotEmpty
        ? ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.data['products_details'].length,
        itemBuilder: (BuildContext context, int index) {
       return  itemCard(index);
     }):  Center(
      child: Text(
        "Don't have any Orders",
        style: TextStyle(
          color: appColorBlack,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget orderSummary() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: backgroundblack)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("SubTotal: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack),),
                        SizedBox(height: 7),
                        Text("GST: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                        SizedBox(width: 130),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Text("Delivery Charge: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                          ],
                        ),
                        SizedBox(height: 7),
                        Text("Delivery GST Charge: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                        SizedBox(height: 7),
                        Text("Distance: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                        SizedBox(height: 7),
                        Text("Total: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                        SizedBox(height: 7),
                        Text("Payment Method: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                        SizedBox(height: 7),
                        Text("Status: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                      ],
                    ),
                  ),
                  // SizedBox(width: 150,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("₹ ${widget.data['subtotal']}",
                        style: TextStyle(
                            color: backgroundblack,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("₹ ${widget.data['user_pay_gst']}",  style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 5),
                      Text("₹ ${widget.data['delivery_charge']}",  style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),maxLines: 2),
                      SizedBox(height: 5),
                      Text("₹ ${widget.data['user_gst']}",  style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),maxLines: 2),
                      SizedBox(height: 5),
                      Text("${widget.data['distance']}",  style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 5),
                      Text("₹ ${widget.data['total']}", style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 5),
                      Text("${widget.data['payment_mode']}",  style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),maxLines: 2),
                      SizedBox(height: 5),
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                            color: appColorOrange,
                            borderRadius: BorderRadius.circular(8), border: Border.all(color: backgroundblack)),
                        child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                         widget.data['order_status'] == "0" ? Text("Pending", style: TextStyle(
                             color: backgroundblack,
                             fontWeight: FontWeight.w600
                         ),):
                         widget.data['order_status'] == "1" ? Text("Preparing",  style: TextStyle(
                             color: backgroundblack,
                             fontWeight: FontWeight.w600
                         ),):
                         widget.data['order_status'] == "2" ? Text("Picked Up",  style: TextStyle(
                             color: backgroundblack,
                             fontWeight: FontWeight.w600
                         ),):
                         widget.data['order_status'] == "3" ? Text("Delivered",  style: TextStyle(
                             color: backgroundblack,
                             fontWeight: FontWeight.w600
                         ),): Text(''),
                       ],)
                      )
                    ],
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text("Order Status : ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack),),
            //       Padding(
            //         padding: const EdgeInsets.only(right: 120),
            //         child: Container(
            //           width: 100,
            //           height: 40,
            //           decoration: BoxDecoration(
            //               color: appColorOrange,
            //               borderRadius: BorderRadius.circular(8), border: Border.all(color: backgroundblack)),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               ordersList[index]['order_status'] == "0" ? Text("Pending", style: TextStyle(
            //                   color: backgroundblack,
            //                   fontWeight: FontWeight.w600
            //               ),):
            //               ordersList[index]['order_status'] == "1" ? Text("Preparing",  style: TextStyle(
            //                   color: backgroundblack,
            //                   fontWeight: FontWeight.w600
            //               ),):
            //               ordersList[index]['order_status'] == "2" ? Text("Picked Up",  style: TextStyle(
            //                   color: backgroundblack,
            //                   fontWeight: FontWeight.w600
            //               ),):
            //               ordersList[index]['order_status'] == "3" ? Text("Delivered",  style: TextStyle(
            //                   color: backgroundblack,
            //                   fontWeight: FontWeight.w600
            //               ),): Text('')
            //             ],
            //           ),
            //         ),
            //       ),
            //       // InkWell(
            //       //   onTap: () {
            //       //     Navigator.push(context, MaterialPageRoute(builder: (context) => ));
            //       //   },
            //       //   child: Container(
            //       //       width: 100,
            //       //       height: 40,
            //       //       decoration: BoxDecoration(
            //       //           color: appColorOrange,
            //       //           borderRadius: BorderRadius.circular(8), border: Border.all(color: backgroundblack)),
            //       //       child: Center(
            //       //           child: Text("View Orders", style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w600),))),
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget deliveryLocation() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: backgroundblack)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("User: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack),),
                      SizedBox(height: 10),
                      Text("Address: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                      SizedBox(width: 130),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Mobile: ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.data['username']}",
                        style: TextStyle(
                            color: backgroundblack,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width/2.5,
                        child: Text("${widget.data['address']}",  style: TextStyle(
                            color: backgroundblack,
                            fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis,
                        ), maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("${widget.data['mobile_no']}",  style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
