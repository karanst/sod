import 'dart:convert';

import 'package:ez/Helper/helperFunction.dart';
import 'package:ez/models/my_rides_list_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/global.dart';
import '../../../../constant/sizeconfig.dart';
import '../../../../models/MyServicesModel.dart';
import '../../models/getBookingModel.dart';
import '../../models/getOrder_modal.dart';
import 'package:http/http.dart' as http;
import '../ServiceDetailsDone.dart';
import '../viewOrders.dart';

class ServicesBooking extends StatefulWidget {
  final bool? show;
  const ServicesBooking({Key? key, this.show}) : super(key: key);

  @override
  State<ServicesBooking> createState() => _ServicesBookingState();
}

class _ServicesBookingState extends State<ServicesBooking> {
  String? user_id;
  bool explorScreen = false;
  bool mapScreen = true;
  GetBookingModel? model;
  int _selectedIndex = 0;

  @override
  void initState() {
    getBookingAPICall();
    getRidesBooking();
    super.initState();
  }

  MyServicesModel? myServicesModel;

  MyRidesListModel? ridesList;

  getBookingAPICall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=135f0e23da6d4271968cb856acf94add3c61abee'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl()}get_booking'));
    request.fields.addAll({
      'user_id': user_id.toString(),
    });
    print("user id in my services screen${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("workingg@@@@@@@");
      var finalResponse = await response.stream.bytesToString();
      final finalResult = MyServicesModel.fromJson(jsonDecode(finalResponse));
      print("get my servicessss$finalResult");
      if (finalResult.responseCode == "1") {
        print("My servicesss modellll apiiii workingggg");
        String? booking_id = finalResult.data![0].id ?? "";
        preferences.setString("booking_id", booking_id);
        print("Booking Idddddddd ${booking_id}");
        setState(() {
          myServicesModel =
              MyServicesModel.fromJson(json.decode(finalResponse));
        });
      } else {
        setState(() {});
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getRidesBooking() async {
    print("working");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=135f0e23da6d4271968cb856acf94add3c61abee'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl()}ride_booking_list'));
    request.fields.addAll({
      'user_id': user_id.toString(),
    });
    print("user id in my ride screen${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("workingg@@@@@@@");
      var finalResponse = await response.stream.bytesToString();
      final finalResult = MyRidesListModel.fromJson(jsonDecode(finalResponse));
      setState(() {
        ridesList = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget serviceTab() {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8, top: 25, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                setState(() {
                  _selectedIndex = 0;
                });
                // if(type =="1"){
                //   await  getFoodOrders();
                // }
                // else if(type =="2" || type =="3" ||type =="4"){
                //
                //   await getDeliveryBooking();
                // }else {
                //   await getVendorBooking();
                // }
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          //AppColor().colorTextGray(),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2,
                          spreadRadius: 1.0)
                    ],
                    border: Border.all(
                        color: _selectedIndex == 0
                            ? Colors.amber
                            : colors.primary),
                    color: _selectedIndex == 0 ? Colors.amber : Colors.white,
                    // _selectedIndex == Colors.cyan
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text("My Services",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _selectedIndex == 0
                                ? colors.primary
                                : colors.blackTemp))),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                setState(() {
                  _selectedIndex = 1;
                });
                // if(type =="1"){
                //   await  getFoodOrders();
                // }
                // else if(type =="2" || type =="3" ||type =="4"){
                //
                //   await getDeliveryBooking();
                // }else {
                //   await getVendorBooking();
                // }
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          //AppColor().colorTextGray(),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2,
                          spreadRadius: 1.0)
                    ],
                    border: Border.all(
                        color: _selectedIndex == 1
                            ? Colors.amber
                            : colors.primary),
                    color: _selectedIndex == 1 ? Colors.amber : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text("My Rides",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _selectedIndex == 1
                                ? colors.primary
                                : colors.blackTemp))),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                setState(() {
                  _selectedIndex = 2;
                });
                // if(type =="1"){
                //   await  getFoodOrders();
                // }
                // else if(type =="2" || type =="3" ||type =="4"){
                //
                //   await getDeliveryBooking();
                // }else {
                //   await getVendorBooking();
                // }
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          //AppColor().colorTextGray(),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2,
                          spreadRadius: 1.0)
                    ],
                    border: Border.all(
                        color: _selectedIndex == 2
                            ? Colors.amber
                            : colors.primary),
                    color: _selectedIndex == 2 ? Colors.amber : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "Parcel History",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selectedIndex == 2
                          ? colors.primary
                          : colors.blackTemp),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        child: Scaffold(
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
              title: Text(
                'My Services',
                style: TextStyle(
                    color: backgroundblack, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: widget.show!
                  ? InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: backgroundblack,
                      ),
                    )
                  : SizedBox.shrink()),
          body: Column(
            children: [
              serviceTab(),
              _selectedIndex == 0
                  ? servicesWidget()
                  : _selectedIndex == 1
                      ? deliveryWidget()
                      : parcelWidget(),

              // Expanded(
              //   child: DefaultTabController(
              //     length: 1,
              //     initialIndex: 0,
              //     child: Column(
              //       children: <Widget>[
              //         /*Container(
              //           width: 250,
              //           height: 40,
              //           decoration: new BoxDecoration(
              //               borderRadius: BorderRadius.circular(8),
              //               color: Colors.grey[300]),
              //           child: Center(
              //             child: TabBar(
              //               labelColor: appColorWhite,
              //               unselectedLabelColor: appColorBlack,
              //               labelStyle: TextStyle(
              //                   fontSize: 13.0,
              //                   color: appColorWhite,
              //                   fontWeight: FontWeight.bold),
              //               unselectedLabelStyle: TextStyle(
              //                   fontSize: 13.0,
              //                   color: appColorBlack,
              //                   fontWeight: FontWeight.bold),
              //               indicator: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(8),
              //                   color: Color(0xFF619aa5)),
              //               tabs: <Widget>[
              //                 // Tab(
              //                 //   text: 'Orders',
              //                 // ),
              //                 Tab(
              //                   text: 'Booking',
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),*/
              //         Expanded(
              //           child: TabBarView(
              //             children: <Widget>[
              //               orderWidget(),
              //               // bookingWidget()
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // _refresh(){
  //   getBookingAPICall();
  // }

  Widget servicesWidget() {
    // return Text("l;k;lk;ll;");
    return myServicesModel == null
        ? Center(
            child: Image.asset("assets/images/loader1.gif"),
          )
        : myServicesModel!.responseCode == "1"
            ? Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  itemCount: myServicesModel!.data!.length,
                  //scrollDirection: Axis.horizontal,
                  itemBuilder: (
                    context,
                    int index,
                  ) {
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            height: 220,
                            width: double.infinity,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, top: 10),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Order Id:",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w800,
                                                  color: appColorBlack),
                                            ),
                                            SizedBox(width: 130),
                                            Text(
                                                "${myServicesModel!.data![index].id}"),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Total:",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w800,
                                                    color: appColorBlack)),
                                            SizedBox(width: 130),
                                            Text(
                                                "${myServicesModel!.data![index].total}"),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("OTP:",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w800,
                                                    color: appColorBlack)),
                                            SizedBox(width: 140),
                                            Text(
                                                "${myServicesModel!.data![index].otp}"),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Payment Mode:",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w800,
                                                    color: appColorBlack)),
                                            SizedBox(width: 90),
                                            Text(
                                                "${myServicesModel!.data![index].paymentType}"),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text("Address:",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: appColorBlack)),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                                width: 130,
                                                child: Text(
                                                  "${myServicesModel!.data![index].address}",
                                                  style: TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Service Type:",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w800,
                                                    color: appColorBlack)),
                                            SizedBox(width: 10),
                                            Text(
                                              "${myServicesModel!.data![index].roll}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: backgroundblack),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("booking Status",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w800,
                                                    color: appColorBlack)),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            myServicesModel!
                                                        .data![index].status ==
                                                    "0"
                                                ? Text("Pending")
                                                : myServicesModel!.data![index]
                                                            .status ==
                                                        "1"
                                                    ? Text("Accepted")
                                                    : myServicesModel!
                                                                .data![index]
                                                                .status ==
                                                            "2"
                                                        ? Text("On The Way")
                                                        : myServicesModel!
                                                                    .data![
                                                                        index]
                                                                    .status ==
                                                                "3"
                                                            ? Text("Completed")
                                                            : Text("Cancel")
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        InkWell(
                                          onTap: () {
                                            Fluttertoast.showToast(
                                                msg: "Coming Soon....");
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => MyServicesScreen(booking_id: myServicesModel!.data![index].id)));
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 90),
                                            child: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: backgroundblack),
                                              child: Center(
                                                child: Text(
                                                  "View Bookings",
                                                  style: TextStyle(
                                                      color: appColorWhite),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //   DateFormat('dd').format(
                                        //       DateTime.parse(getOrdersModal!
                                        //           .orders![index].date.toString())),
                                        //   style: TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 22),
                                        // ),
                                        // Text(
                                        //   DateFormat('MMM').format(
                                        //       DateTime.parse(getOrdersModal!
                                        //           .orders![index].date.toString())),
                                        //   style: TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 17),
                                        // ),
                                      ],
                                    ),
                                    Container(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                          left: 10,
                                          right: 10),
                                      // child: DottedLine(
                                      //   direction: Axis.vertical,
                                      //   lineLength: double.infinity,
                                      //   lineThickness: 1.0,
                                      //   dashLength: 4.0,
                                      //   dashColor: Colors.grey[600],
                                      //   dashRadius: 0.0,
                                      //   dashGapLength: 4.0,
                                      //   dashGapColor: Colors.transparent,
                                      //   dashGapRadius: 0.0,
                                      // ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "OrderId: " +
                                          //       getOrdersModal!
                                          //           .orders![index].orderId.toString(),
                                          //   maxLines: 1,
                                          //   style: TextStyle(
                                          //       color: Colors.black,
                                          //       fontSize: 14,
                                          //       fontWeight:
                                          //           FontWeight.bold),
                                          // ),
                                          Container(height: 4),
                                          // Text(
                                          //   "TxnId: " +
                                          //       getOrdersModal!
                                          //           .orders![index].txnId.toString(),
                                          //   maxLines: 1,
                                          //   style: TextStyle(
                                          //       color: Colors.black,
                                          //       fontSize: 12),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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

  Widget deliveryWidget() {
    // return Text("l;k;lk;ll;");
    return ridesList == null
        ? Center(
            child: Image.asset("assets/images/loader1.gif"),
          )
        : ridesList!.status!
            ? Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //physics: const NeverScrollableScrollPhysics(),
                  itemCount: ridesList!.data!.length,
                  //scrollDirection: Axis.horizontal,
                  itemBuilder: (
                    context,
                    int index,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: backgroundblack)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Booking Id : ",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: appColorBlack),
                                      ),
                                      SizedBox(height: 5),
                                      Text("OTP : ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: appColorBlack)),


                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Total : ",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: appColorBlack)),
                                      // SizedBox(height: 5,),
                                      // Row(
                                      //   children: [
                                      //     Text("Order Status:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
                                      //     SizedBox(width: 115),
                                      //     ordersList[index]['order_status'] == "0" ? Text("Pending"):
                                      //     ordersList[index]['order_status'] == "1" ? Text("Preparing"):
                                      //     ordersList[index]['order_status'] == "2" ? Text("Picked Up"):
                                      //     ordersList[index]['order_status'] == "3" ? Text("Delivered"):
                                      //    Text("Cancelled")
                                      //   ],
                                      // ),

                                      //
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 60),
                                      //   child: Container(
                                      //     height: 30,
                                      //     width: 90,
                                      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: backgroundblack),
                                      //       child: Center(
                                      //           child: Text("View Orders", style: TextStyle(color: appColorOrange),))),
                                      // ),
                                      // Text(
                                      //   DateFormat('dd').format(
                                      //       DateTime.parse(getOrdersModal!
                                      //           .orders![index].date.toString())),
                                      //   style: TextStyle(
                                      //       color: Colors.black,
                                      //       fontSize: 22),
                                      // ),
                                      // Text(
                                      //   DateFormat('MMM').format(
                                      //       DateTime.parse(getOrdersModal!
                                      //           .orders![index].date.toString())),
                                      //   style: TextStyle(
                                      //       color: Colors.black,
                                      //       fontSize: 17),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(width: 40,),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${ridesList!.data![index].id}",
                                        style: TextStyle(
                                            color: backgroundblack,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${ridesList!.data![index].otp}",
                                        style: TextStyle(
                                            color: backgroundblack,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5),

                                      Text(
                                        "₹ ${ridesList!.data![index].paidAmount}",
                                        style: TextStyle(
                                            color: backgroundblack,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pickup Location : ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: appColorBlack)),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width /
                                        1.7,
                                    child: Text(
                                      "${ridesList!.data![index].dropAddress}",
                                      style: TextStyle(
                                          color: backgroundblack,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Drop Location : ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: appColorBlack)),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width /
                                        1.7,
                                    child: Text(
                                      "${ridesList!.data![index].dropAddress}",
                                      style: TextStyle(
                                          color: backgroundblack,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order Status : ",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: appColorBlack),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: appColorOrange,
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: backgroundblack)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ridesList!.data![index].acceptReject ==
                                                "0"
                                            ? Text(
                                                "Pending",
                                                style: TextStyle(
                                                    color: backgroundblack,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : ridesList!.data![index]
                                                        .acceptReject ==
                                                    "1"
                                                ? Text(
                                                    "On The Way",
                                                    style: TextStyle(
                                                        color: backgroundblack,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                : ridesList!.data![index]
                                                            .acceptReject ==
                                                        "2"
                                                    ? Text(
                                                        "Picked Up",
                                                        style: TextStyle(
                                                            color:
                                                                backgroundblack,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    : ridesList!.data![index]
                                                                .acceptReject ==
                                                            "3"
                                                        ? Text(
                                                            "Completed",
                                                            style: TextStyle(
                                                                color:
                                                                    backgroundblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        : Text('')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
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

  Widget parcelWidget() {
    // return Text("l;k;lk;ll;");
    return  Container(
      height: MediaQuery.of(context).size.width,
      child: Center(
        child: Text("No Bookings found!"),
      ),
    );

      // ridesList == null
      //   ? Center(
      //       child: Image.asset("assets/images/loader1.gif"),
      //     )
      //   : ridesList!.status!
      //       ? ListView.builder(
      //           padding: EdgeInsets.only(bottom: 10, top: 10),
      //           scrollDirection: Axis.vertical,
      //           shrinkWrap: true,
      //           //physics: const NeverScrollableScrollPhysics(),
      //           itemCount: ridesList!.data!.length,
      //           //scrollDirection: Axis.horizontal,
      //           itemBuilder: (
      //             context,
      //             int index,
      //           ) {
      //             return Padding(
      //               padding:
      //                   const EdgeInsets.only(left: 10.0, right: 10, bottom: 8),
      //               child: Container(
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(15),
      //                     border: Border.all(color: backgroundblack)),
      //                 child: Column(
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.all(10),
      //                       child: Row(
      //                         // mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             // mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Text(
      //                                 "Booking Id : ",
      //                                 style: TextStyle(
      //                                     fontSize: 13,
      //                                     fontWeight: FontWeight.w500,
      //                                     color: appColorBlack),
      //                               ),
      //                               SizedBox(height: 5),
      //                               Text("OTP : ",
      //                                   style: TextStyle(
      //                                       fontSize: 13,
      //                                       fontWeight: FontWeight.w500,
      //                                       color: appColorBlack)),
      //                               SizedBox(height: 5),
      //                               Text("Pickup Location : ",
      //                                   style: TextStyle(
      //                                       fontSize: 13,
      //                                       fontWeight: FontWeight.w500,
      //                                       color: appColorBlack)),
      //                               SizedBox(height: 5),
      //                               Text("Drop Location : ",
      //                                   style: TextStyle(
      //                                       fontSize: 13,
      //                                       fontWeight: FontWeight.w500,
      //                                       color: appColorBlack)),
      //                               SizedBox(
      //                                 height: 5,
      //                               ),
      //                               Text("Total : ",
      //                                   style: TextStyle(
      //                                       fontSize: 13,
      //                                       fontWeight: FontWeight.w500,
      //                                       color: appColorBlack)),
      //                               // SizedBox(height: 5,),
      //                               // Row(
      //                               //   children: [
      //                               //     Text("Order Status:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: appColorBlack)),
      //                               //     SizedBox(width: 115),
      //                               //     ordersList[index]['order_status'] == "0" ? Text("Pending"):
      //                               //     ordersList[index]['order_status'] == "1" ? Text("Preparing"):
      //                               //     ordersList[index]['order_status'] == "2" ? Text("Picked Up"):
      //                               //     ordersList[index]['order_status'] == "3" ? Text("Delivered"):
      //                               //    Text("Cancelled")
      //                               //   ],
      //                               // ),
      //
      //                               //
      //                               // Padding(
      //                               //   padding: const EdgeInsets.only(left: 60),
      //                               //   child: Container(
      //                               //     height: 30,
      //                               //     width: 90,
      //                               //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: backgroundblack),
      //                               //       child: Center(
      //                               //           child: Text("View Orders", style: TextStyle(color: appColorOrange),))),
      //                               // ),
      //                               // Text(
      //                               //   DateFormat('dd').format(
      //                               //       DateTime.parse(getOrdersModal!
      //                               //           .orders![index].date.toString())),
      //                               //   style: TextStyle(
      //                               //       color: Colors.black,
      //                               //       fontSize: 22),
      //                               // ),
      //                               // Text(
      //                               //   DateFormat('MMM').format(
      //                               //       DateTime.parse(getOrdersModal!
      //                               //           .orders![index].date.toString())),
      //                               //   style: TextStyle(
      //                               //       color: Colors.black,
      //                               //       fontSize: 17),
      //                               // ),
      //                             ],
      //                           ),
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text(
      //                                 "${ridesList!.data![index].id}",
      //                                 style: TextStyle(
      //                                     color: backgroundblack,
      //                                     fontWeight: FontWeight.w600),
      //                               ),
      //                               SizedBox(height: 5),
      //                               Text(
      //                                 "${ridesList!.data![index].otp}",
      //                                 style: TextStyle(
      //                                     color: backgroundblack,
      //                                     fontWeight: FontWeight.w600),
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width:
      //                                     MediaQuery.of(context).size.width / 2,
      //                                 child: Text(
      //                                   "${ridesList!.data![index].pickupAddress}",
      //                                   style: TextStyle(
      //                                       color: backgroundblack,
      //                                       fontWeight: FontWeight.w600,
      //                                       overflow: TextOverflow.ellipsis),
      //                                   maxLines: 2,
      //                                 ),
      //                               ),
      //                               SizedBox(height: 5),
      //                               Container(
      //                                 width:
      //                                     MediaQuery.of(context).size.width / 2,
      //                                 child: Text(
      //                                   "${ridesList!.data![index].dropAddress}",
      //                                   style: TextStyle(
      //                                       color: backgroundblack,
      //                                       fontWeight: FontWeight.w600,
      //                                       overflow: TextOverflow.ellipsis),
      //                                   maxLines: 2,
      //                                 ),
      //                               ),
      //                               SizedBox(height: 5),
      //                               Text(
      //                                 "₹ ${ridesList!.data![index].paidAmount}",
      //                                 style: TextStyle(
      //                                     color: backgroundblack,
      //                                     fontWeight: FontWeight.w600),
      //                               ),
      //                             ],
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(
      //                           left: 10.0, right: 10, bottom: 5),
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Text(
      //                             "Order Status : ",
      //                             style: TextStyle(
      //                                 fontSize: 13,
      //                                 fontWeight: FontWeight.w500,
      //                                 color: appColorBlack),
      //                           ),
      //                           Container(
      //                             width: 120,
      //                             height: 40,
      //                             decoration: BoxDecoration(
      //                                 color: appColorOrange,
      //                                 borderRadius: BorderRadius.circular(8),
      //                                 border:
      //                                     Border.all(color: backgroundblack)),
      //                             child: Column(
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.center,
      //                               children: [
      //                                 ridesList!.data![index].acceptReject ==
      //                                         "0"
      //                                     ? Text(
      //                                         "Pending",
      //                                         style: TextStyle(
      //                                             color: backgroundblack,
      //                                             fontWeight: FontWeight.w600),
      //                                       )
      //                                     : ridesList!.data![index]
      //                                                 .acceptReject ==
      //                                             "1"
      //                                         ? Text(
      //                                             "On The Way",
      //                                             style: TextStyle(
      //                                                 color: backgroundblack,
      //                                                 fontWeight:
      //                                                     FontWeight.w600),
      //                                           )
      //                                         : ridesList!.data![index]
      //                                                     .acceptReject ==
      //                                                 "2"
      //                                             ? Text(
      //                                                 "Picked Up",
      //                                                 style: TextStyle(
      //                                                     color:
      //                                                         backgroundblack,
      //                                                     fontWeight:
      //                                                         FontWeight.w600),
      //                                               )
      //                                             : ridesList!.data![index]
      //                                                         .acceptReject ==
      //                                                     "3"
      //                                                 ? Text(
      //                                                     "Completed",
      //                                                     style: TextStyle(
      //                                                         color:
      //                                                             backgroundblack,
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .w600),
      //                                                   )
      //                                                 : Text('')
      //                               ],
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         )
      //       : Center(
      //           child: Container(
      //             height: MediaQuery.of(context).size.width,
      //             child: Text(
      //               "Don't have any Bookings",
      //               style: TextStyle(
      //                 color: appColorBlack,
      //                 fontStyle: FontStyle.italic,
      //               ),
      //             ),
      //           ),
      //         );
  }

// Widget bookingWidget() {
//   return model == null
//       ? Center(
//           child: Image.asset("assets/images/loader1.gif"),
//         )
//       : model!.booking!.isNotEmpty
//           ? ListView.builder(
//               padding: EdgeInsets.only(bottom: 10, top: 10),
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               //physics: const NeverScrollableScrollPhysics(),
//               itemCount: model!.booking!.length,
//               //scrollDirection: Axis.horizontal,
//               itemBuilder: (context, int index,) {
//                 var dateFormate =  DateFormat("dd/MM/yyyy").format(DateTime.parse(model!.booking![index].date ?? ""));
//                 return InkWell(
//                     onTap: () async {
//                       bool result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BookingDetailScreen(model!.booking![index]),
//                       ));
//                       if(result == true){
//                         setState(() {
//                           getBookingAPICall();
//                         });
//                       }
//                     },
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: 25, right: 25, top: 15),
//                             child: Container(
//                               height: 130,
//                               width: double.infinity,
//                               child: Card(
//                                 elevation: 5,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 15, right: 15),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                     children: [
//                                       Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             DateFormat('dd').format(
//                                                 DateTime.parse(model!
//                                                     .booking![index].date.toString())),
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 22),
//                                           ),
//                                           Text(
//                                             DateFormat('MMM').format(
//                                                 DateTime.parse(model!
//                                                     .booking![index].date.toString())),
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 17),
//                                           ),
//                                         ],
//                                       ),
//                                       Container(width: 10),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             top: 20,
//                                             bottom: 20,
//                                             left: 10,
//                                             right: 10),
//                                         // child: DottedLine(
//                                         //   direction: Axis.vertical,
//                                         //   lineLength: double.infinity,
//                                         //   lineThickness: 1.0,
//                                         //   dashLength: 4.0,
//                                         //   dashColor: Colors.grey[600],
//                                         //   dashRadius: 0.0,
//                                         //   dashGapLength: 4.0,
//                                         //   dashGapColor: Colors.transparent,
//                                         //   dashGapRadius: 0.0,
//                                         // ),
//                                       ),
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                              "Booking Id - ${ model!.booking![index].id.toString()}",
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 14,
//                                                   fontWeight:
//                                                   FontWeight.bold),
//                                             ),
//                                             Container(height: 2),
//                                             Text(
//                                               model!.booking![index].service!
//                                                   .resName.toString(),
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 14,
//                                                   fontWeight:
//                                                       FontWeight.bold),
//                                             ),
//                                             Container(height: 2),
//                                             Text(
//                                               "${dateFormate}",
//                                               // model!.booking![index].date!,
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 12),
//                                             ),
//                                             Container(height: 2),
//                                             Text(
//                                               model!.booking![index].slot!,
//                                               maxLines: 1,
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 12),
//                                             )
//                                             // model!.booking![index].status == "Completed"
//                                             //     ? Container(
//                                             //  // width: 80,
//                                             //   height: 30,
//                                             //   alignment: Alignment.center,
//                                             //   decoration: BoxDecoration(
//                                             //     borderRadius: BorderRadius.circular(10.0),
//                                             //     color: Colors.green
//                                             //   ),
//                                             //   child: Text(
//                                             //     model!.booking![index].status!,
//                                             //     maxLines: 1,
//                                             //     textAlign: TextAlign.center,
//                                             //     style: TextStyle(
//                                             //         color: Colors.white,
//                                             //         fontSize: 12),
//                                             //   ),
//                                             // )
//                                             //     : model!.booking![index].status == "Cancelled by user" ? Container(
//                                             //   //width: 80,
//                                             //   height: 30,
//                                             //   alignment: Alignment.center,
//                                             //   decoration: BoxDecoration(
//                                             //       borderRadius: BorderRadius.circular(10.0),
//                                             //       color: Colors.red
//                                             //   ),
//                                             //   child: Text(
//                                             //     model!.booking![index].status!,
//                                             //     maxLines: 1,
//                                             //     textAlign: TextAlign.center,
//                                             //     style: TextStyle(
//                                             //         color: Colors.white,
//                                             //         fontSize: 12),
//                                             //   ),
//                                             // ) : model!.booking![index].status == "Cancelled by vendor" ?
//                                             // Container(
//                                             //   //width: 80,
//                                             //   height: 30,
//                                             //   alignment: Alignment.center,
//                                             //   decoration: BoxDecoration(
//                                             //       borderRadius: BorderRadius.circular(10.0),
//                                             //       color: Colors.red
//                                             //   ),
//                                             //   child: Text(
//                                             //     model!.booking![index].status!,
//                                             //     maxLines: 1,
//                                             //     textAlign: TextAlign.center,
//                                             //     style: TextStyle(
//                                             //         color: appColorWhite,
//                                             //         fontSize: 12),
//                                             //   ),
//                                             // ) :
//                                             // Container(
//                                             // //  width: 80,
//                                             //   height: 30,
//                                             //   alignment: Alignment.center,
//                                             //   decoration: BoxDecoration(
//                                             //       borderRadius: BorderRadius.circular(10.0),
//                                             //       color: backgroundblack
//                                             //   ),
//                                             //   child: Text(
//                                             //     model!.booking![index].status!,
//                                             //     maxLines: 1,
//                                             //     textAlign: TextAlign.center,
//                                             //     style: TextStyle(
//                                             //         color: appColorWhite,
//                                             //         fontSize: 12),
//                                             //   ),
//                                             // ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(100),
//                                           color: backgroundblack,
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.all(5.0),
//                                           child: Icon(Icons.arrow_forward,color: appColorWhite,),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ));
//               },
//             )
//           : Center(
//               child: Text(
//                 "Don't have any Booking",
//                 style: TextStyle(
//                   color: appColorBlack,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             );
// }
}
