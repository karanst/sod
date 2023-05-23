

import 'package:ez/constant/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/widgets/place_picker.dart';

class Sendpackage extends StatefulWidget {

  @override
  State<Sendpackage> createState() => _SendpackageState();
}

class _SendpackageState extends State<Sendpackage> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController dropController = TextEditingController();

  double pickLat = 0;
  double pickLong = 0;
  double dropLat = 0;
  double dropLong = 0;
  double totalDistance = 0;
  Position? currentLocation;
  distnce (){
    // totalDistance =  calculateDistance(pickLat, pickLong, dropLat, dropLong);
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
  @override
  void initState() {
    dateinput.text = "";

    super.initState();
  }

  TextEditingController startTimeController = TextEditingController();

  String? dropdownvalue;
  bool isSelected = false;
  var items = [
    '2wheeler',
    '3wheeler',
    '4wheeler',
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
    return Column(
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
          child: TextFormField(
            controller: pickUpController,
            decoration: InputDecoration(
                hintText: 'Pickup From',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        SizedBox(
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
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: dropController,
            decoration: InputDecoration(
                hintText: 'Drop To',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
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
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color.fromARGB(255, 92, 91, 91)),
                        borderRadius: BorderRadius.circular(10))),
                borderRadius: BorderRadius.circular(10),
                itemHeight: 60,
                hint: Text('Selected category'),
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                }),
          ),
        ),
        SizedBox(
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
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Quantity',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
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
    );
  }

  Widget scheduleWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
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
                      print(
                          'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
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
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          "Time",
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
      SizedBox(
        height: 10,
      ),
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
        child: TextFormField(
          readOnly: true,
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       // builder: (context) => PlacePicker(
          //       //   apiKey: Platform.isAndroid
          //       //       ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
          //       //       : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
          //       //   onPlacePicked: (result) {
          //       //     print(result.formattedAddress);
          //       //     setState(() {
          //       //       pickUpController.text = result.formattedAddress.toString();
          //       //       pickLat = result.geometry!.location.lat;
          //       //       pickLong = result.geometry!.location.lng;
          //       //     });
          //       //     Navigator.of(context).pop();
          //       //     distnce();
          //       //   },
          //       //   initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
          //       //   useCurrentLocation: true,
          //       // ),
          //     ),
          //   );
          // },
          controller: pickUpController,
          decoration: InputDecoration(
              hintText: 'Pickup From',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
      SizedBox(
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
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          readOnly: true,
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => PlacePicker(
          //         apiKey: Platform.isAndroid
          //             ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
          //             : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
          //         onPlacePicked: (result) {
          //           print(result.formattedAddress);
          //           setState(() {
          //             dropController.text = result.formattedAddress.toString();
          //             dropLat = result.geometry!.location.lat;
          //             dropLong = result.geometry!.location.lng;
          //           });
          //           Navigator.of(context).pop();
          //         },
          //         initialPosition: dropLat != 0
          //             ? LatLng(dropLat, dropLong)
          //             : LatLng(currentLocation!.latitude, currentLocation!.longitude),
          //         useCurrentLocation: true,
          //       ),
          //     ),
          //   );
          // },
          controller: dropController,
          decoration: InputDecoration(
              hintText: 'Drop To',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
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
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
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
                      BorderSide(color: Color.fromARGB(255, 92, 91, 91)),
                      borderRadius: BorderRadius.circular(10))),
              borderRadius: BorderRadius.circular(10),
              itemHeight: 60,
              hint: Text('Selected category'),
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              }),
        ),
      ),
      SizedBox(
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
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: 'Enter Quantity',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
      // SizedBox(
      //   height: 20,
      // ),
      // Center(
      //   child: InkWell(
      //     onTap: () {},
      //     child: Container(
      //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),  color: Color(0xff0047af),
      //       ),
      //       height: 50,
      //       width: MediaQuery.of(context).size.width/1.7,
      //       child: Center(
      //           child: Text(
      //             "Submit",
      //             style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.w400),
      //           )),
      //     ),
      //   ),
      // ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Send Package',
          style: TextStyle(color: backgroundblack),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: backgroundblack
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
                    SizedBox(
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
                SizedBox(
                  height: 50,
                ),
                isSelected ? currentBookingWidget() : scheduleWidget(),
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: InkWell(
                    onTap: () {},
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

// class NextPage extends StatefulWidget {
//   const NextPage({super.key});

//   @override
//   State<NextPage> createState() => _NextPageState();
// }

// class _NextPageState extends State<NextPage> {
//    @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }



//   height: MediaQuery.of(context).size.height,
//   margin: EdgeInsets.only(top: 30),
//   decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(40), topRight: Radius.circular(40))),
//   child: SingleChildScrollView(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 20, left: 20),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).pop(MaterialPageRoute(
//                     builder: (context) => Home(),
//                   ));
//                   setState(() {
//                     isSelected = true;
//                   });
//                 },
//                 child: Container(
//                     height: 40,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           top: 10, left: 10, right: 10),
//                       child: Text(
//                         'Current booking',
//                         style: TextStyle(
//                           color: isSelected
//                               ? Color(0xffffffff)
//                               : Color(0xff0047af),
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: isSelected
//                             ? Color(0xff0047af)
//                             : Colors.transparent,
//                         border: Border.all(color: Color(0xff0047af)),
//                         borderRadius: BorderRadius.circular(5))),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => NextPage(),
//                     ));
//                     isSelected = false;
//                   });
//                 },
//                 child: Container(
//                     height: 40,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           top: 10, left: 10, right: 10),
//                       child: Text(
//                         'Schedule',
//                         style: TextStyle(
//                           color: isSelected
//                               ? Color(0xff0047af)
//                               : Color(0xffffffff),
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: isSelected
//                             ? Colors.transparent
//                             : Color(0xff0047af),
//                         border: Border.all(color: Color(0xff0047af)),
//                         borderRadius: BorderRadius.circular(5))),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 50,
//         ),

