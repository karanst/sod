import 'package:ez/constant/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyServicesScreen extends StatefulWidget {
  String? booking_id;
  MyServicesScreen({Key? key, this.booking_id}) : super(key: key);

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  @override
  void initState() {
    super.initState();
    getBookingDetails();
  }

  getBookingDetails() async{
    var headers = {
      'Cookie': 'ci_session=ddc8f3df5c1338ac205a49f612a25fb17a901914'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_booking_by_id_user'));
    request.fields.addAll({
      'booking_id': widget.booking_id ?? "",
    });
    print("Boking details parameter${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
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
        backgroundColor: appColorWhite,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back, color: backgroundblack)),
        title: Text("Services Details", style: TextStyle(color: backgroundblack, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            serviceDetails(),
          ],
        ),
      ),
    );
  }
  Widget serviceDetails() {
    return Column(children: [

    ],
    );
  }
}
