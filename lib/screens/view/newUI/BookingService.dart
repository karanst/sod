
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../constant/global.dart';

class BookingService extends StatefulWidget {
  const BookingService({Key? key}) : super(key: key);

  @override
  State<BookingService> createState() => _BookingServiceState();
}

class _BookingServiceState extends State<BookingService> {
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
  TextEditingController addressCtr = TextEditingController();
  TextEditingController noteCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  String? dropdownvalue;
  Position? currentLocation;
  bool isSelected = true;


  Widget currentBookingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      ],
    );
  }

  // bookingService() async {
  //   var headers = {
  //     'Cookie': 'ci_session=51c4dc59dbe42674616d36fe001576c57df507b9'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/services_orders'));
  //   request.fields.addAll({
  //     'user_id': '1',
  //     'v_id': '40',
  //     'sub_total': '12980',
  //     'date': '2023-05-11',
  //     'payment_type': 'COD',
  //     'total_amount': '12980.00',
  //     'username': 'Dev',
  //     'mobile': '8855224466',
  //     'slot': '12:54',
  //     'no_of_people': '2',
  //     'address': 'indore',
  //     's_total': '11000',
  //     'address': 'indore',
  //     's_total': '11000',
  //     'total_gst_charge': '1980',
  //     'address_id': '213'
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

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
        height: 10,
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
        height: 10,
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: backgroundblack,)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appColorWhite,
        title:Text("Book Your Service", style: TextStyle(color: appColorBlack, fontSize: 13, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold )),
      ),
      body: SingleChildScrollView(
        child:
        Column(
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
                        isSelected = false;
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
                        isSelected = true;
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
              height: 30,
            ),
            isSelected ? currentBookingWidget() : scheduleWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter Note",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: noteCtr,
                decoration: InputDecoration(
                    hintText: 'Note',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter Username",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: nameCtr,
                decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter Mobile",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: mobileCtr,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                    hintText: 'Mobile',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Enter Address",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 10,
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
                //             // pickUpController.text = result.formattedAddress.toString();
                //             // pickLat = result.geometry!.location.lat;
                //             // pickLong = result.geometry!.location.lng;
                //           });
                //           Navigator.of(context).pop();
                //           // distance();
                //         },
                //         initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                //         useCurrentLocation: true,
                //       ),
                //     ),
                //   );
                // },
                controller: addressCtr,
                decoration: InputDecoration(
                    hintText: 'Select Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                    ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),  color: Color(0xff0047af),
                  ),
                  height: 40,
                  width: MediaQuery.of(context).size.width/1.5,
                  child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.w400),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
