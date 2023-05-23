import 'dart:convert';
// import 'package:dotted_line/dotted_line.dart';
import 'package:ez/screens/view/models/getOrder_modal.dart';
import 'package:ez/screens/view/newUI/booking_details.dart';
import 'package:ez/screens/view/newUI/viewBookingNotification.dart';
import 'package:ez/screens/view/newUI/viewOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/models/getBookingModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewOrderDetails.dart';
// import 'package:toast/toast.dart';

// ignore: must_be_immutable
class BookingScreen extends StatefulWidget {
  bool? back;
  final bool? show;
  BookingScreen({this.back, this.show});
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  String? user_id;
  bool explorScreen = false;
  bool mapScreen = true;

  List ordersList = [];

  @override
  void initState() {
    getOrderApi();
    super.initState();
    // getBookingAPICall();
  }

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(20),
        //         bottomRight: Radius.circular(20)
        //     )
        // ),
        backgroundColor: appColorWhite,
        elevation: 0,
        automaticallyImplyLeading: widget.show!,
        title: Text(
          'My Orders',
          style: TextStyle(color: backgroundblack, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: widget.show! ? InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
                Icons.arrow_back,
                size: 20,
                color: backgroundblack,
              ),
        )
            : SizedBox.shrink()
      ),
      body: orderWidget()
    );
  }

  Widget orderWidget() {
    return ordersList.isEmpty
        ? Center(
            child: Image.asset("assets/images/loader1.gif"),
          )
        : ordersList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ordersList.length,
                itemBuilder: (context, int index,) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Vieworders(data: ordersList[index],)));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => Vieworders(
                        //           orders: getOrdersModal!.orders![index])),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: backgroundblack)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 13),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Order Id : ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack),),
                                          SizedBox(height: 7),
                                          Text("Total : ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                                            SizedBox(width: 130),
                                          SizedBox(height: 7),
                                         Row(
                                           children: [
                                             Text("OTP : ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                                           ],
                                         ),
                                          SizedBox(height: 7),
                                          Text("Payment Mode : ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                                          SizedBox(height: 7),
                                          Text("Address : ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${ordersList[index]['order_id']}",
                                          style: TextStyle(
                                          color: backgroundblack,
                                          fontWeight: FontWeight.w600
                                        ),
                                        ),
                                        SizedBox(height: 5),
                                        Text("₹ ${ordersList[index]['total']}",  style: TextStyle(
                                            color: backgroundblack,
                                            fontWeight: FontWeight.w600
                                        ),),
                                        SizedBox(height: 5),
                                        Text("${ordersList[index]['otp']}",  style: TextStyle(
                                            color: backgroundblack,
                                            fontWeight: FontWeight.w600
                                        ),),
                                        SizedBox(height: 5),
                                        Text("${ordersList[index]['payment_mode']}",  style: TextStyle(
                                            color: backgroundblack,
                                            fontWeight: FontWeight.w600
                                        ),),
                                        SizedBox(height: 5),
                                        Container(
                                          width: MediaQuery.of(context).size.width/2,
                                          child: Text("${ordersList[index]['address']}",  style: TextStyle(
                                              color: backgroundblack,
                                              fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis),maxLines: 2),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Order Status : ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack),),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 140),
                                      child: Container(
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: appColorOrange,
                                            borderRadius: BorderRadius.circular(8), border: Border.all(color: backgroundblack)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ordersList[index]['order_status'] == "0" ? Text("Pending", style: TextStyle(
                                                color: backgroundblack,
                                                fontWeight: FontWeight.w600
                                            ),):
                                            ordersList[index]['order_status'] == "1" ? Text("Preparing",  style: TextStyle(
                                                color: backgroundblack,
                                                fontWeight: FontWeight.w600
                                            ),):
                                            ordersList[index]['order_status'] == "2" ? Text("Picked Up",  style: TextStyle(
                                                color: backgroundblack,
                                                fontWeight: FontWeight.w600
                                            ),):
                                            ordersList[index]['order_status'] == "3" ? Text("Delivered",  style: TextStyle(
                                                color: backgroundblack,
                                                fontWeight: FontWeight.w600
                                            ),): Text('')
                                          ],
                                        ),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => ));
                                    //   },
                                    //   child: Container(
                                    //       width: 100,
                                    //       height: 40,
                                    //       decoration: BoxDecoration(
                                    //           color: appColorOrange,
                                    //           borderRadius: BorderRadius.circular(8), border: Border.all(color: backgroundblack)),
                                    //       child: Center(
                                    //           child: Text("View Orders", style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w600),))),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              )
            : Center(
                child: Text(
                  "Don't have any Orders",
                  style: TextStyle(
                    color: appColorBlack,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }
}
