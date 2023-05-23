import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/models/GetParcelCategoryModel.dart';
import 'package:ez/screens/view/models/ParcelPriceModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ez/screens/view/newUI/paymentSuccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Sendpackage extends StatefulWidget {

  @override
  State<Sendpackage> createState() => _SendpackageState();
}

var packageLat;
var packageLong;

class _SendpackageState extends State<Sendpackage> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController dropController = TextEditingController();
  TextEditingController pickUpController1 = TextEditingController();
  TextEditingController dropController1 = TextEditingController();
  TextEditingController pickUpController3 = TextEditingController();
  TextEditingController dropController4 = TextEditingController();
  TextEditingController unitCtr = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? dropValue;
  double pickLat = 0;
  double pickLong = 0;
  double dropLat = 0;
  double dropLong = 0;
  double totalDistance = 0;
  Position? currentLocation;
  //Position? currentLocation;
  distnce (){
    // totalDistance =  calculateDistance(pickLat, pickLong, dropLat, dropLong);
  }

  Future getUserCurrentLocation() async {

    var status = await Permission.location.request();
    if(status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd nowwwwww");
    }else if(status.isGranted){
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
        if (mounted)
          setState(() {
            currentLocation = position;
            packageLat = currentLocation?.latitude;
            packageLong = currentLocation?.longitude;
          });
      });
      print("LOCATION in send packageee" +currentLocation.toString());
    } else if(status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    getUserCurrentLocation();
    parcelPrice();
   // Future.delayed(Duration(milliseconds: 300),(){
   //   return parcelPrice();
   // });
  }

  GetParcelCategoryModel? getParcelCategoryModel;
  Data2? selectCategory;
  getParcelCategory() async{
    var headers = {
      'Cookie': 'ci_session=2d4a2ee3ad5355a6452bca6690a7ccd26e6f7cb8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/parcel_category'));
    request.fields.addAll({
      'vehicle_type': selectVehicle.toString(),
    });
    print("get Category Premeter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetParcelCategoryModel.fromJson(json.decode(finalResponse));
      print("get parcel categoryyyy$jsonResponse");
      setState(() {
        getParcelCategoryModel = GetParcelCategoryModel.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  ParcelPriceModel? parcelPriceModel;
  String? gst;
  String? finalTotal;
  String? sub_total;

  parcelPrice() async {
    print("parcel price apiiii");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=7cabc04f855d67ec073e1c4277b8a8f641520367'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/price_culculation_parcel'));
    request.fields.addAll({
      'distance': calculateDistance(pickLat, pickLong, dropLat, dropLong).toStringAsFixed(2),
      'pickup_flor': pickUpController.text,
      'drop_floor': dropController.text,
      'unit': unitCtr.text,
      'vehicle_type': selectVehicle.toString(),
    });
    print("parcel Price Calculation parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = ParcelPriceModel.fromJson(json.decode(finalResponse));
      gst = jsonResponse.gst ?? "";
      finalTotal = jsonResponse.finalTotal ?? "";
      sub_total = jsonResponse.subTotal ?? "";

      preferences.setString("gst", gst ?? "");
      preferences.setString("finalTotal", finalTotal ?? "");
      preferences.setString("sub_total", sub_total ??"");
      print("alll chargess herereee ${gst}  ${finalTotal} ${sub_total}");
    }
    else {
    print(response.reasonPhrase);
    }
  }

  String? user_id;

  parceLBooking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=2b9ad460cc3db7246d5b4c9e7d3bd2e194d533ff'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/book_parcel_delivery'));
    request.fields.addAll({
      'user_id': user_id ?? '',
      'pickup_location': pickUpController.text,
      'drop_location': dropController.text,
      'date': dateinput.text,
      'slot': startTimeController.text,
      'unit': unitCtr.text,
      'paymentMethod': 'CASH',
      'pickup_lat': pickLat.toStringAsFixed(2),
      'pickup_lang': pickLong.toStringAsFixed(2),
      'drop_lat': dropLat.toStringAsFixed(2),
      'drop_lang': dropLong.toStringAsFixed(2),
      'taxi_type': selectVehicle.toString(),
      'final_total_amount': '75.52',
      'sub_total': '64',
      'gst_d_charge': '11.52',
      'tabclick': '1',
      'category_id': selectCategory.toString(),
      'address_distance': calculateDistance(pickLat, pickLong, dropLat, dropLong).toStringAsFixed(2),
    });
    print("parcel Bookng Api parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  double? totalLocation;
  double calculateDistance(pickLat, pickLong, dropLat, dropLong) {
    print("Alll lat lonssss ${pickLat} ${pickLong} ${dropLat} ${dropLong}");
    try {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((dropLat - pickLat) * p) / 2 +
          c(pickLat * p) * c(dropLat * p) * (1 - c((dropLong - pickLong) * p)) / 2;
      totalLocation = 12742 * asin(sqrt(a));
      print("All location in send packageee${totalLocation}");
      return 12742 * asin(sqrt(a));
    } on Exception {
      return 0; // only executed if error is of type Exception
    } catch (error) {
      return 0; // executed for errors of all types other than Exception
    }
  }


  var selectedTime1;
  _selectStartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        useRootNavigator: true,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: Colors.black),
                buttonTheme: ButtonThemeData(
                    colorScheme: ColorScheme.light(primary: Colors.black))),
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!),
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime1) {
      setState(() {
        selectedTime1 = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
        startTimeController.text = selectedTime1!.format(context);
      });
    }
    var per = selectedTime1!.period.toString().split(".");
    print(
        "selected time here ${selectedTime1!.format(context).toString()} and ${per[1]}");
  }

  TextEditingController dateinput = TextEditingController();

  TextEditingController startTimeController = TextEditingController();

  String? selectVehicle;
  String? selectVehicle1;
  bool isSelected = false;
  int val=0;
  int val1=0;
  List<String> items = [
    '2 wheeler',
    '3 wheeler',
    '4 wheeler',

  ];

  List<String> items1 = [
    '2 wheeler',
    '3 wheeler',
    '4 wheeler',
  ];

  List<String> itemCategory = [
    'Gift',
    'Document',
  ];

  List<String> itemCategory1 = [
    'Gift',
    'Document',
  ];
  // bool isSelected = false;
  // String? dropdownvalue;

  // List of items in our dropdown menu
  // var items = [
  //   '2wheeler',
  //   '3wheeler',
  //   '4wheeler',
  // ];
  var item = ['Select Category'];

  Widget currentBookingWidget() {
    return Container();
  }

  Widget scheduleWidget() {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Date",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: dateinput,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? datePicked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2024));
                      if (datePicked != null) {
                        print('Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                        String formettedDate =
                        DateFormat('dd-MM-yyyy').format(datePicked);
                         setState(() {
                           dateinput.text = formettedDate;
                         });
                      }
                    },
                    icon: Icon(Icons.calendar_today_outlined)),
                hintText: 'dd-mm-yyyy',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Time",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: startTimeController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _selectStartTime(context);
                    },
                    icon: Icon(
                      Icons.access_time_outlined,
                    )),
                hintText: '--:--',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 20),
        //   child: Text(
        //     "Pickup From",
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //     textAlign: TextAlign.left,
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 20),
        //   child: TextFormField(
        //     validator: (ele){
        //       if(ele!.isEmpty){
        //         return 'Please fill all field';
        //       }
        //     },
        //     //readOnly: true,
        //     // onTap: () {
        //     //   Navigator.push(
        //     //     context,
        //     //     MaterialPageRoute(
        //     //       // builder: (context) => PlacePicker(
        //     //       //   apiKey: Platform.isAndroid
        //     //       //       ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
        //     //       //       : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
        //     //       //   onPlacePicked: (result) {
        //     //       //     print(result.formattedAddress);
        //     //       //     setState(() {
        //     //       //       pickUpController.text = result.formattedAddress.toString();
        //     //       //       pickLat = result.geometry!.location.lat;
        //     //       //       pickLong = result.geometry!.location.lng;
        //     //       //     });
        //     //       //     Navigator.of(context).pop();
        //     //       //     distnce();
        //     //       //   },
        //     //       //   initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        //     //       //   useCurrentLocation: true,
        //     //       // ),
        //     //     ),
        //     //   );
        //     // },
        //     controller: pickUpController,
        //     decoration: InputDecoration(
        //         hintText: 'Pickup From',
        //         border:
        //         OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20),
        //   child: Text(
        //     "Drop To",
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //     textAlign: TextAlign.left,
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 20),
        //   child: TextFormField(
        //     validator: (ele){
        //       if(ele!.isEmpty){
        //         return 'Please fill all field';
        //       }
        //     },
        //     controller: dropController,
        //     decoration: InputDecoration(
        //         hintText: 'Drop To',
        //         border:
        //         OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 20),
        //   child: Text(
        //     'Selected Vehicle',
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // SizedBox(
        //   height: 60,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 20, right: 20),
        //     child: DropdownButtonFormField<String>(
        //         decoration: InputDecoration(
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide:
        //                 BorderSide(color: Color.fromARGB(255, 87, 86, 86)),
        //                 borderRadius: BorderRadius.circular(10))),
        //         borderRadius: BorderRadius.circular(10),
        //         itemHeight: 60,
        //         hint: const Text('Selected Vehicle'),
        //         value: selectVehicle1,
        //         icon: const Icon(Icons.keyboard_arrow_down),
        //         items: items1.map((String item) {
        //           return DropdownMenuItem(
        //             value: item,
        //             child: Text(item),
        //           );
        //         }).toList(),
        //         onChanged: (String? newValue) {
        //           val1 = items1.indexWhere((element) => element==newValue);
        //           print('MY INDEX---${val1}');
        //           setState(() {
        //             selectVehicle1 = newValue!;
        //           });
        //         }),
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 20),
        //   child: Text(
        //     'Category',
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // SizedBox(
        //   height: 60,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 20, right: 20),
        //     child: DropdownButtonFormField<String>(
        //         decoration: InputDecoration(
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide:
        //                 BorderSide(color: Color.fromARGB(255, 92, 91, 91)),
        //                 borderRadius: BorderRadius.circular(10))),
        //         borderRadius: BorderRadius.circular(10),
        //         itemHeight: 60,
        //         hint: Text('Selected category'),
        //         value: selectCategory1,
        //         icon: const Icon(Icons.keyboard_arrow_down),
        //         items: itemCategory1.map((String item) {
        //           return DropdownMenuItem(
        //             value: item,
        //             child: Text(item),
        //           );
        //         }).toList(),
        //         onChanged: (String? newValue) {
        //           setState(() {
        //             selectCategory1 = newValue!;
        //           });
        //         }),
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // val1== 1 || val1==2? Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const Padding(
        //       padding: EdgeInsets.only(left: 20),
        //       child: Text(
        //         "Pickup From",
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //         textAlign: TextAlign.left,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 20, right: 20),
        //       child: TextFormField(
        //         controller: pickUpController1,
        //         decoration: InputDecoration(
        //             hintText: 'Pickup From',
        //             border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(10))),
        //       ),
        //     ),
        //     SizedBox(height: 10,),
        //     const Padding(
        //       padding: EdgeInsets.only(left: 20),
        //       child: Text(
        //         "Drop To",
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //         textAlign: TextAlign.left,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 20, right: 20),
        //       child: TextFormField(
        //         validator: (ele){
        //           if(ele!.isEmpty){
        //             return 'Please fill all field';
        //           }
        //         },
        //         controller: dropController1,
        //         decoration: InputDecoration(
        //             hintText: 'Drop To',
        //             border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(10))),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 20,
        //     ),
        //     const Padding(
        //       padding: EdgeInsets.only(left: 20),
        //       child: Text(
        //         "Unit",
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //         textAlign: TextAlign.left,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 20, right: 20),
        //       child: TextFormField(
        //         validator: (ele){
        //           if(ele!.isEmpty){
        //             return 'Please fill all field';
        //           }
        //         },
        //         decoration: InputDecoration(
        //             hintText: 'Enter Quantity',
        //             border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(10))),
        //       ),
        //     ),
        //   ],
        // )
        //     : Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const Padding(
        //       padding: EdgeInsets.only(left: 20),
        //       child: Text(
        //         "Unit",
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //         textAlign: TextAlign.left,
        //       ),
        //     ),
        //     SizedBox(height: 20,),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 20, right: 20),
        //       child: TextFormField(
        //         validator: (ele){
        //           if(ele!.isEmpty){
        //             return 'Please fill all field';
        //           }
        //         },
        //         decoration: InputDecoration(
        //             hintText: 'Enter Quantity',
        //             border: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(10))),
        //       ),
        //     ),
        //   ],
        // ),
      ]),
    );
  }

  int? value=0;
  String? selectedOption;
  showBottomsheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            height:MediaQuery.of(context).size.height/1,
            child:  Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,top:10),
                    child: Container(child: Text('Summery',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),)),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Source location',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                      SizedBox(width: 10,),
                      Container(
                          width:MediaQuery.of(context).size.width/2,
                          child: Text(pickUpController.text,overflow: TextOverflow.ellipsis,maxLines:1,style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),))
                    ],),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Destination location',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                      Container(
                          width:MediaQuery.of(context).size.width/2,
                          child: Text(dropController1.text,overflow: TextOverflow.ellipsis,maxLines:1,style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),))
                    ],),
                  SizedBox(height: 20),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 100,),
                        Text('${dateinput}',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  SizedBox(height: 20,),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Distance',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 10,),
                        Text('8.9 KM',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  SizedBox(height: 20,),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Unit',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 10,),
                        Text('1 Unit',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  SizedBox(height: 20,),
                  val==0? SizedBox():Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pickup Floor',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 10,),
                        Text(pickUpController3.text,style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  val==0?SizedBox(): Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Drop Floor',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 10,),
                        Text(dropController.text,style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  SizedBox(height: 20,),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 10,),
                        Text('Document',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  SizedBox(height: 20,),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sub Total',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 10,),
                        Text('₹120',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('GST',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 10,),
                        Text('₹21.6',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  SizedBox(height: 20,),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Payment',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(width: 10,),
                        Text('₹141.6',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 12),)
                      ],),
                  ),
                  SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentScreen()));
                      }, child:Text('Submit')),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Send Package',
          style: TextStyle(color:Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.black
        ),
        centerTitle: true,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     color: appColorWhite,
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          // margin: EdgeInsets.only(top: 10),
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = true;
                          });
                        },
                        child: Container(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Text(
                                'Current booking',
                                style: TextStyle(
                                  color: isSelected
                                      ? Color(0xffffffff)
                                      : Color(0xff0047af),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? Color(0xff0047af)
                                    : Colors.transparent,
                                border: Border.all(color: Color(0xff0047af)),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => NextPage(),
                            // ));
                            isSelected = false;
                          });
                        },
                        child: Container(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Text(
                                'Schedule',
                                style: TextStyle(
                                  color: isSelected
                                      ? Color(0xff0047af)
                                      : Color(0xffffffff),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.transparent
                                    : Color(0xff0047af),
                                border: Border.all(color: Color(0xff0047af)),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                isSelected ? currentBookingWidget() : scheduleWidget(),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Pickup From",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        child: TextFormField(
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  apiKey: Platform.isAndroid
                                      ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
                                      : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
                                  onPlacePicked: (result) {
                                    print(result.formattedAddress);
                                    setState(() {
                                      pickUpController.text = result.formattedAddress.toString();
                                      pickLat = result.geometry!.location.lat;
                                      pickLong = result.geometry!.location.lng;
                                    });
                                    print("pickup lat long in send package ${pickLat} ${pickLong}");
                                    Navigator.of(context).pop();
                                    distnce();
                                  },
                                  initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                                  useCurrentLocation: true,
                                ),
                              ),
                            );
                          },
                          validator: (ele){
                            if(ele!.isEmpty){
                              return 'Please fill all field';
                            }
                          },
                          controller: pickUpController,
                          decoration: InputDecoration(
                              hintText: 'Pickup From',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Drop To",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        readOnly: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  apiKey: Platform.isAndroid
                                      ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
                                      : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
                                  onPlacePicked: (result) {
                                    print(result.formattedAddress);
                                    setState(() {
                                      dropController.text = result.formattedAddress.toString();
                                      dropLat = result.geometry!.location.lat;
                                      dropLong = result.geometry!.location.lng;
                                    });
                                    print("drop lat long in send package ${dropLat} ${dropLong}");
                                    Navigator.of(context).pop();
                                  },
                                  initialPosition: dropLat != 0
                                      ? LatLng(dropLat, dropLong)
                                      : LatLng(currentLocation!.latitude, currentLocation!.longitude),
                                  useCurrentLocation: true,
                                ),
                              ),
                            );
                          },
                        validator: (ele){
                          if(ele!.isEmpty){
                            return 'Please fill all field';
                          }
                        },
                        controller: dropController,
                        decoration: InputDecoration(
                            hintText: 'Drop To',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Selected Vehicle',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color.fromARGB(255, 87, 86, 86)),
                                    borderRadius: BorderRadius.circular(10))),
                            borderRadius: BorderRadius.circular(10),
                            itemHeight: 60,
                            hint: Text('Selected Vehicle'),
                            value: selectVehicle,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              val = items.indexWhere((element) => element==newValue);
                              setState(() {
                                selectVehicle = newValue!;
                              });
                              getParcelCategory();
                              print("Vechileee ${selectVehicle}");
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Category',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                        SizedBox(
                      height: 60,
                      child: Padding(
                        padding:EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonFormField<Data2>(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Color.fromARGB(255, 92, 91, 91)),
                                    borderRadius: BorderRadius.circular(10))),
                            borderRadius: BorderRadius.circular(10),
                            itemHeight: 60,
                            hint: Text('Selected category'),
                            value: selectCategory,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: getParcelCategoryModel?.data?.map((Data2 items) {
                              return DropdownMenuItem<Data2>(
                                value: items,
                                child: Text(items.name ?? ""),
                              );
                            }).toList(),
                            onChanged: (Data2? newValue) {
                              setState(() {
                                selectCategory = newValue!;
                              });
                              print("select category valueeee ${selectCategory}");
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    val== 1 || val== 2? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Pickup From",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (ele){
                              if(ele!.isEmpty){
                                return 'Please fill all field';
                              }
                            },
                            controller: pickUpController3,
                            decoration: InputDecoration(
                                hintText: 'Pickup Floor',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Drop Floor",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (ele){
                              if(ele!.isEmpty){
                                return 'Please fill all field';
                              }
                            },
                            controller: dropController,
                            decoration: InputDecoration(
                                hintText: 'Drop Floor',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Unit",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: unitCtr,
                            keyboardType: TextInputType.number,
                            validator: (ele){
                              if(ele!.isEmpty){
                                return 'Please fill all field';
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter Quantity',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))
                            ),
                          ),
                        ),
                      ],
                    ): Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Unit",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (ele){
                              if(ele!.isEmpty){
                                return 'Please fill all field';
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter Quantity',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //         //   height: 30,
                    //         // ),
                    // Center(
                    //   child: InkWell(
                    //     onTap: () {},
                    //     child: Container(
                    //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff0047af)),
                    //       height: 50,
                    //       width: MediaQuery.of(context).size.width/1.7,
                    //       child: Center(
                    //           child: Text(
                    //             "Submit",
                    //             style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.w400),
                    //           )),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(height: 30,),
                Center(
                  child: InkWell(
                    onTap: () {
                      if(pickLat != 0 && pickLong != 0 && dropLat != 0 && dropLong != 0) {
                      }
                      else{
                        Fluttertoast.showToast(msg: "Please select pick and drop locations first!");
                      }
                      showBottomsheet();
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff0047af)),
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.7,
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



