import 'dart:async';
import 'dart:convert';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/push_notification_service.dart';
import 'package:ez/screens/view/Ride/ride_booked_model.dart';
import 'package:ez/screens/view/Ride/ride_booked_screen.dart';
// import 'package:ez/screens/RideBooking/map_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'map_page.dart';
import 'package:http/http.dart' as http;

class FindingRidePage extends StatefulWidget {
  LatLng source, destination;
  String pickAddress,dropAddress,paymentType,bookingId;
  String amount,km;
  FindingRidePage(this.source, this.destination, this.pickAddress,
      this.dropAddress, this.paymentType,this.bookingId,this.amount,this.km);
  @override
  _FindingRidePageState createState() => _FindingRidePageState();
}

class _FindingRidePageState extends State<FindingRidePage>
    with SingleTickerProviderStateMixin {
  final List<double> sizes = [120, 160, 200];

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )
      ..repeat()
      ..addListener(() {
      });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    PushNotificationService pushNotificationService = new PushNotificationService(context: context,
        onResult: (result){
      print("this is ride notification $result");
      //  if(mounted&&result=="yes")
      if(result=="1"){
        getCurrentBooking();
      }
    });
    pushNotificationService.initialise();
    //   if(mounted)
    /* Future.delayed(Duration(seconds: 4),
        () => Navigator.pushNamed(context, PageRoutes.rideBookedPage));*/
  }

  String? userId;
  RideBookedModel? rideCalcData;
  getCurrentBooking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId= preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=d9be05064d0216a7432b621660dc26feb4d030ed'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_current_ride_booking'));
    request.fields.addAll({
     'user_id': userId.toString()
    });
    print("this is ride calculation param ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Working Nowwwww");
      var finalResponse = await response.stream.bytesToString();
       rideCalcData = RideBookedModel.fromJson(jsonDecode(finalResponse));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RideBookedPage(rideCalcData!.data!)));
      // await confirmRideDialog(context);
      // print("this is ride calculation data ${rideCalcData!.subTotal.toString()}");
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  bool loading = true;
  bool saveStatus = true;
  // ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  // MyRideModel? model1;

  // getCurrentInfo() async {
  //   try {
  //     setState(() {
  //       saveStatus = false;
  //     });
  //     Map params = {
  //       "user_id": curUserId,
  //     };
  //     Map response = await apiBase.postAPICall(
  //         Uri.parse(baseUrl1 + "Payment/get_current_boooking"), params);
  //     setState(() {
  //       saveStatus = true;
  //     });
  //     if (response['status']) {
  //       var v = response["data"];
  //       setState(() {
  //         model1 = MyRideModel.fromJson(v);
  //       });
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) =>
  //                   RideBookedPage(model1!)));
  //       /* showConfirm(RidesModel(v['id'], v['user_id'], v['username'], v['uneaque_id'], v['purpose'], v['pickup_area'],
  //           v['pickup_date'], v['drop_area'], v['pickup_time'], v['area'], v['landmark'], v['pickup_address'], v['drop_address'],
  //           v['taxi_type'], v['departure_time'], v['departure_date'], v['return_date'], v['flight_number'], v['package'],
  //           v['promo_code'], v['distance'], v['amount'], v['paid_amount'], v['address'], v['transfer'], v['item_status'],
  //           v['transaction'], v['payment_media'], v['km'], v['timetype'], v['assigned_for'], v['is_paid_advance'], v['status'], v['latitude'], v['longitude'], v['date_added'],
  //           v['drop_latitude'], v['drop_longitude'], v['booking_type'], v['accept_reject'], v['created_date']));*/
  //
  //       //print(data);
  //     } else {
  //       // setSnackbar(response['message'], context);
  //     }
  //   } on TimeoutException catch (_) {
  //     setSnackbar(getTranslated(context, "WRONG")!, context);
  //     setState(() {
  //       saveStatus = true;
  //     });
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      // FadedSlideAnimation(
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: backgroundblack,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)),
          title: Text(
            "FINDING RIDE",
            // getTranslated(context,'FINDING_RIDE')!.toUpperCase() + '...',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            widget.source.longitude != 0
                ? MapPage(
              true,
              pick: widget.pickAddress,
              dest: widget.dropAddress,
              // driveList: [],
              SOURCE_LOCATION: widget.source,
              DEST_LOCATION: widget.destination,
              live: false,
            )
                : Center(child: CircularProgressIndicator()),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: sizes
                    .map((element) => CircleAvatar(
                  radius: element * _animation.value,
                  backgroundColor: Theme.of(context)
                      .primaryColor
                      .withOpacity(1 - _animation.value as double),
                ))
                    .toList(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: boxDecoration(radius: 5,bgColor: Colors.white,showShadow: true),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: boxDecoration(
                              radius: 100,bgColor: Colors.green
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: text(widget.pickAddress,fontSize: 12,fontFamily: "Regular",textColor: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: boxDecoration(
                              radius: 100,bgColor: Colors.red
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: text(widget.dropAddress,fontSize: 12,fontFamily: "Regular",textColor: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Amount",fontSize: 12,textColor: Colors.black),
                        text("₹"+widget.amount,fontSize: 12,textColor: Colors.black),
                        text("|",fontSize: 12,textColor: Colors.black),
                        text("Distance",fontSize: 12,textColor: Colors.black),
                        text(widget.km+" km" ,fontSize: 12,textColor: Colors.black),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                         // cancelRide(widget.bookingId);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 40,
                        decoration: boxDecoration(
                            radius: 10,
                            bgColor: backgroundblack),
                        child: Center(
                            child: text("Cancel Ride",
                                fontSize: 14,
                                isCentered: true,
                                textColor: appColorOrange)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    //   beginOffset: Offset(0, 0.3),
    //   endOffset: Offset(0, 0),
    //   slideCurve: Curves.linearToEaseOut,
    // );
  }

  // ApiBaseHelper apiBaseHelper = new ApiBaseHelper();

  // cancelRide(bookingId)async{
  //   Map data = {
  //     "booking_id" : bookingId,
  //   };
  //   print("CANCEL RIDE ======= $data");
  //   Map response = await apiBaseHelper.postAPICall(Uri.parse(baseUrl1+"payment/cancel_ride"), data);
  //   if(response['status']){
  //     Navigator.pop(context);
  //     setSnackbar("Booking Cancelled", context);
  //   }else{
  //
  //   }
  // }
}

Widget text(String text,
    {var fontSize = 14,
      textColor = const Color(0xffffffff),
      var fontFamily = "Regular",
      var isCentered = false,
      var isEnd = false,
      var maxLine = 2,
      var latterSpacing = 0.25,
      var textAllCaps = false,
      var isLongText = false,
      var overFlow = false,
      var decoration = false,
      var under = false,
      fontWeight}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered
        ? TextAlign.center
        : isEnd
        ? TextAlign.end
        : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    softWrap: true,
    overflow: overFlow ? TextOverflow.ellipsis : TextOverflow.clip,
    style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily,
        fontSize: double.parse(fontSize.toString()),
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration: decoration
            ? TextDecoration.lineThrough
            : under
            ? TextDecoration.underline
            : TextDecoration.none),
  );
}

BoxDecoration boxDecoration(
    {double radius = 10.0,
      Color color = Colors.transparent,
      Color bgColor = Colors.white,
      var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [
      BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 4,
          spreadRadius: 1)
    ]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}