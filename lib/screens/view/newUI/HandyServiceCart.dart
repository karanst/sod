import 'dart:convert';

import 'package:ez/screens/view/newUI/paymentSuccess.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/global.dart';
import '../../../models/AddToCartHandyServicesModel.dart';
import '../../../models/HoursModel.dart';
import '../models/GeneralSettingModel.dart';
import '../models/GetCartServiceModel.dart';
import 'bookingSuccess.dart';
import 'manage_address.dart';

class HandyManCart extends StatefulWidget {
  const HandyManCart({Key? key}) : super(key: key);

  @override
  State<HandyManCart> createState() => _HandyManCartState();
}

class _HandyManCartState extends State<HandyManCart> {
  TextEditingController personCtr = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController noteCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();

  var result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartMehndiservice();
    getHours();
    getuserdata();
    // bookingService();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // set_address = preferences.getString("set_address");
    // bookingService();
    // removeServiceCart();
  }

  String? handy_fixed_amount;
  getuserdata() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    handy_fixed_amount = preferences.getString('handy_fixed_amount');
    print("get handy man setiing api charge here ${handy_fixed_amount}");
  }

  String? selected,  payMethod = '';
  GetCartServiceModel? getCartServiceModel;
  String? user_id;
  String? mehndi_gst;
  int? totalAmt;
  int? taxAmt;
  double? finalAmt;
  String? vendor_id;
  bool isSelected = false;
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
    print("selected time here ${selectedTime1!.format(context).toString()} and ${per[1]}");
  }


  HoursModel? hoursModel;
  Data1? hours;

  getHours() async{
    print("Get Hours apiii Workingg");
    var headers = {
      'Cookie': 'ci_session=99f889ba09a90343d8ae0342cc0bfcde3fcc2ff0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_hours'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = HoursModel.fromJson(json.decode(finalResponse));
      if(jsonResponse.status == 1){
        setState(() {
          hoursModel = HoursModel.fromJson(json.decode(finalResponse));
        });
        print("Hours is here noww ${hoursModel!.data![0].hours}");
      } else{
      }
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  getCartMehndiservice() async{
    print("handyman cart Servicess api");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    mehndi_gst = preferences.getString("mehndi_gst");
    print("handyman Gst valueeeee ${mehndi_gst}");
    var headers = {
      'Cookie': 'ci_session=82b90487f1f683e57c2d0a5dfca61d1173b8f1ef'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_cart_items_services'));
    request.fields.addAll({
      'user_id': user_id ?? '',
    });

    print("User iddd in this page ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetCartServiceModel.fromJson(json.decode(finalResponse));
      if(jsonResponse.responseCode == '1'){
        print("Final Responseeeeeeee ${finalResponse}");
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        String? cart_id = jsonResponse.cart![0].cartId ?? "";
        String? cart_sub_total = jsonResponse.cartSubTotal;
        String? gst_sum = jsonResponse.gstSum;
        String? cart_total = jsonResponse.cartTotal;

        preferences.setString("cart_sub_total", cart_sub_total!);
        preferences.setString("gst_sum", gst_sum!);
        preferences.setString("cart_total", cart_total!);
        preferences.setString("cart_id", cart_id);
        print("Service cart id here ${cart_id}");
        print("Cart final responseee ${finalResponse}");
        print("cart totalllll${cart_total}");
        print("cart sub totalllll ${cart_sub_total}");
        print("gst sum totalllll ${gst_sum}");
        setState(() {
          getCartServiceModel = GetCartServiceModel.fromJson(json.decode(finalResponse));
        });
        print("Get cart itemmsssss ${getCartServiceModel!.cart![0].productName}");
      } else{
        // Fluttertoast.showToast(msg: "${jsonResponse.message}");
        // setState(() {
        // });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String dropdownvalue = '1 hour';

  // List of items in our dropdown menu
  var items = [
    '1 hour',
    '2 hour',
    '3 hour',
    'Full day'
  ];

  String? cart_id;
  removeServiceCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cart_id = preferences.getString("cart_id");
    print("cart id in remove cart api ${cart_id}");
    var headers = {
      'Cookie': 'ci_session=ac153ec8eb3011b0f91dd56757bd6222ee8bda78'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/remove_service_cart_items'));
    request.fields.addAll({
      'cart_id': cart_id ?? ""
    });
    print("Remove cart paraaaa ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if(jsonResponse['status'] == "success"){
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        Navigator.pop(context);
      } else{
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  saveForLater() async {
    print("Save For Laterr Apii");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cart_id = preferences.getString("cart_id");
    var headers = {
      'Cookie': 'ci_session=ac153ec8eb3011b0f91dd56757bd6222ee8bda78'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/save_for_later_service'));
    request.fields.addAll({
      'cart_id': cart_id ?? "",
      'status': '0/1'
    });

    print("save for later parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if(jsonResponse['status'] == "success"){
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        Navigator.pop(context);
      } else{
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  updateServiceCart({String? cart_id, String? hours, String? final_total}) async{
    print("Update service cart apii");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cart_id = preferences.getString("cart_id");
    print("cart id in update service cart apiii ${cart_id}");
    var headers = {
      'Cookie': 'ci_session=d799e50aba6123b2fc20b076914eb578c2d51a09'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/update_service_cart'));
    request.fields.addAll({
      'cart_id': cart_id ?? "",
      'final_total': final_total.toString(),
      'hours': hours ?? "",
    });
    print("Update service cart parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if(jsonResponse['status'] == "success"){
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        // Navigator.pop(context);
      } else{
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  String? cart_sub_total;
  String? gst_sum;
  String? cart_total;
  String? address_id;

  final _formKey = GlobalKey<FormState>();

  bookingService({String? hours}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    vendor_id = preferences.getString("vendor_id");
    cart_sub_total = preferences.getString("cart_total");
    cart_total = preferences.getString("cart_total");
    gst_sum = preferences.getString("gst_sum");
    address_id = preferences.getString("address_id");
    print("carttttt Totallllll ${cart_total}");
    print("cart sub totallll ${cart_sub_total}");
    var headers = {
      'Cookie': 'ci_session=51c4dc59dbe42674616d36fe001576c57df507b9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/services_orders'));
    request.fields.addAll({
      'user_id': user_id ?? "",
      'v_id': vendor_id ?? "",
      'sub_total': grandTotal.toString(),
      'date': dateinput.text,
      'payment_type': 'COD',
      'total_amount': grandTotal.toString(),
      'username': nameCtr.text,
      'mobile': mobileCtr.text,
      'slot': startTimeController.text,
      'hours': hours ?? "",
      'address': addressCtr.text,
      's_total': grandTotal.toString(),
      'total_gst_charge': gst_sum ?? "",
      'address_id': address_id ?? "",
      'note': noteCtr.text,
    });

    print("boking services apiii parameter in handyman servicess ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if(jsonResponse['status'] == true){
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSccess()));
        // Navigator.pop(context);
      } else{
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  Widget scheduleWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
            height: 40,
            child: Padding(
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
                          if(datePicked != null) {
                            print('Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                            String formettedDate = DateFormat('dd-MM-yyyy').format(datePicked);
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
          Container(
            height: 40,
            child: Padding(
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
          ),
          SizedBox(
            height: 10,
          ),
        ]);
  }

  FocusNode myfocus = FocusNode();

  Widget currentBookingWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }

  double grandTotal = 0.0;

  Future<Null> refreshFunction()async{
    await getCartMehndiservice();
  }

  @override
  Widget build(BuildContext context) {
    // print("cartttttttt finallllll totalllll ${getCartServiceModel!.cartTotal}");
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: backgroundblack),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appColorWhite,
        title:Text("SERVICES CART", style: TextStyle(color: appColorBlack, fontSize: 13, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold )),
      ),
      body: Form(
        key: _formKey,
        child: RefreshIndicator(
          onRefresh: refreshFunction,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/back.png"),
                      fit: BoxFit.cover
                    // fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Positioned(
                child: getCartServiceModel == null ? Center(
                  child: Image.asset("assets/images/loader1.gif", scale: 1),
                ):
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: getCartServiceModel!.cart!.length,
                  itemBuilder: (BuildContext context, int index){
                    var item = getCartServiceModel!.cart![index] ;
                    return   Padding(
                      padding: EdgeInsets.all(15),
                      child: Scrollbar(
                        thickness: 10,
                        trackVisibility: true,
                        // isAlwaysShown: true,
                        thumbVisibility: true,
                        radius: Radius.circular(10),
                        child: SizedBox(
                          height: 180,
                          child: Card(
                            elevation: 6,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAlias,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 2),
                                getCartServiceModel == null ? Center(
                                    child: Text("Image Found")
                                ): Image.network("${getCartServiceModel!.cart![index].productImage}", height: 120, width: 115, fit: BoxFit.fill,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0, left: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          // Text("Service Name: ", style: TextStyle(color: appColorBlack)),
                                          Text("${getCartServiceModel!.cart![index].productName}", style: TextStyle(color: backgroundblack)),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Text("Price: "),
                                          Text("${getCartServiceModel!.cart![index].sellingPrice}", style: TextStyle(fontSize: 13, color: appColorBlack, fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Text("Sub Total: ", style: TextStyle(color: appColorBlack, fontSize: 13),),
                                          item.totalAmt!=null ? Text(item.totalAmt.toString(), style: TextStyle(fontSize: 13, color: appColorBlack, fontWeight: FontWeight.bold)):
                                          Text(getCartServiceModel!.cart![index].sellingPrice ?? "", style: TextStyle(fontSize: 13, color: appColorBlack, fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Text("GST: ", style: TextStyle(color: appColorBlack, fontSize: 13),),
                                          Text(mehndi_gst ?? " ", style: TextStyle(fontSize: 13, color: appColorBlack, fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Text("Final Total: ", style: TextStyle(color: appColorBlack, fontSize: 13)),
                                          item.finalAmt!=null ? Text(item.finalAmt.toString(), style: TextStyle(fontSize: 13, color: appColorBlack, fontWeight: FontWeight.bold))
                                              :Text(getCartServiceModel!.cart![index].sellingPrice ?? "", style: TextStyle(fontSize: 13, color: appColorBlack, fontWeight: FontWeight.bold)) ,
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 90,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                color: Colors.white54, border: Border.all(color: Colors.black54)),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 4),
                                              child: DropdownButton<Data1>(
                                                focusNode: myfocus,
                                                hint: Text("Hours:"),
                                                underline: SizedBox(),
                                                isExpanded: true,
                                                elevation: 0,
                                                // Initial Value
                                                value: hours,
                                                // Down Arrow Icon
                                                icon: Padding(
                                                  padding:EdgeInsets.only(left: 8),
                                                  child: Icon(Icons.keyboard_arrow_down),
                                                ),
                                                items: hoursModel!.data!.map((Data1 items) {
                                                  return DropdownMenuItem <Data1>(
                                                    value: items,
                                                    child: Text(items.hours ?? ''),
                                                  );
                                                }).toList(),
                                                onChanged:(Data1? newValue) {
                                                  setState(() {
                                                    hours = newValue!;
                                                  });
                                                  int inputValue = int.parse(hours!.hours??'');
                                                  int totalAmt = inputValue *  int.parse(getCartServiceModel!.cart![index].sellingPrice ?? "") + int.parse(handy_fixed_amount ?? "");
                                                  double taxAmt = totalAmt * int.parse(mehndi_gst ?? "") /100;
                                                  finalAmt = totalAmt + taxAmt;
                                                  item.finalAmt = finalAmt;
                                                  item.totalAmt = totalAmt;
                                                  print('${item.finalAmt}___________');
                                                  print("${item.totalAmt}____________");
                                                  print("final amountt $finalAmt");
                                                  print("total amountt $totalAmt");
                                                  print("tax Amount with calculation $taxAmt");
                                                  print("Input valueeee $inputValue");
                                                  setState((){
                                                  });
                                                  Future.delayed(Duration (milliseconds: 200),() {
                                                    return updateServiceCart(final_total:item.totalAmt.toString(), cart_id: item.cartId.toString(),hours: hours!.hours??'');
                                                  });
                                                },
                                              ),
                                            ),
                                            // TextFormField(
                                            //   focusNode: myfocus,
                                            //   onChanged: (value) {
                                            //     int inputValue = int.parse(value);
                                            //     int totalAmt = inputValue *  int.parse(getCartServiceModel!.cart![index].sellingPrice ?? "");
                                            //     double taxAmt = totalAmt * int.parse(mehndi_gst ?? "") /100;
                                            //     finalAmt = totalAmt + taxAmt;
                                            //     item.finalAmt = finalAmt;
                                            //     item.totalAmt = totalAmt;
                                            //     print('${item.finalAmt}___________');
                                            //     print("${item.totalAmt}____________");
                                            //     print("final amountt $finalAmt");
                                            //     print("total amountt $totalAmt");
                                            //     print("tax Amount with calculation $taxAmt");
                                            //     print("Input valueeee $inputValue");
                                            //     setState(() {
                                            //     });
                                            //     Future.delayed(Duration (milliseconds: 200),
                                            //             (){
                                            //       return updateServiceCart(final_total:item.totalAmt.toString(), cart_id: item.cartId.toString(),no_of_people: value);
                                            //         });
                                            //   },
                                            //   keyboardType: TextInputType.number,
                                            //   textAlign: TextAlign.center,
                                            //   decoration: InputDecoration(
                                            //       border: InputBorder.none,
                                            //       hintText: 'a hours:', hintStyle: TextStyle(fontSize: 13)
                                            //   ),
                                            // ),
                                          ),
                                          SizedBox(width: 70),
                                          InkWell(
                                            onTap: (){
                                              removeServiceCart();
                                            },
                                            child: Image.asset("assets/images/delete.png", scale: 2),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          saveForLater();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 30),
                                          child: Container(
                                              height: 30,
                                              width: 110,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backgroundblack),
                                              child: Center(
                                                  child: Text("Save For later", style: TextStyle(fontSize: 10, color: appColorWhite, fontWeight: FontWeight.w800)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 600, left: 30),
              //   child: Container(
              //     height: 35,
              //       width: MediaQuery.of(context).size.width/1.2,
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: backgroundblack),
              //       child: InkWell(
              //         onTap: () {
              //           Navigator.push(context, MaterialPageRoute(builder: (context) => BookingService()));
              //         },
              //         child: Center(
              //             child: Text("Go To Checkout", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: appColorWhite),
              //         ))),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 550, left: 25, right: 20),
                child: InkWell(
                  onTap: (){
                    myfocus.unfocus();
                    for(var i=0;i<getCartServiceModel!.cart!.length;i++){
                      grandTotal = grandTotal +  double.parse(getCartServiceModel!.cart![i].finalAmt.toString());
                      print("ddddddddddddd ${grandTotal}");
                    }
                    // getCartMehndiservice();
                    bottomSheet();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCartScreeen()));
                  },
                  child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width/ 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundblack),
                      child: Center(child: Text("Go To Checkout",style: TextStyle(color: appColorWhite,fontSize: 15,fontWeight: FontWeight.w600)))
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheet(){
    showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        print("finalllllll Totalllllllllll nowwwww ${getCartServiceModel!.cartTotal}");
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return
                Container(
                  height: MediaQuery.of(context).size.height/1.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10, left: 20),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10, right: 10),
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
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSelected = false;
                                    });
                                  },
                                  child: Container(
                                      height: 30,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                            height: 10,
                          ),
                          isSelected ? currentBookingWidget() : scheduleWidget(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 175,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    controller: nameCtr,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 13),
                                      hintText: 'Enter Username',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 175,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    controller: noteCtr,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(fontSize: 13,),
                                        hintText: 'Enter Note',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: mobileCtr,
                                maxLength: 10,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 13),
                                    hintText: 'Enter Mobile',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5))),
                              ),
                            ),
                          ),
                          SizedBox(height: 9,),
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                autofocus: false,
                                onTap: () {
                                  // set_address;
                                },
                                controller: addressCtr,
                                readOnly: true,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis, color: appColorBlack, fontWeight: FontWeight.bold),
                                  hintText: 'Address',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              var paymentmode = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentScreen(home: false)));
                              setState(() {
                                payMethod = paymentmode;
                              });
                              print("paymentt method ${payMethod}  $paymentmode");
                            },
                            child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width/1.1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Select Payment Method",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: backgroundblack)),
                                        SizedBox(width:15,),
                                        // Text("${paymentMethod}", style: TextStyle(fontSize: 16, color: backgroundblack, fontWeight: FontWeight.bold)),
                                        Divider( color: backgroundblack), Text(
                                            payMethod == null || payMethod == '' ?
                                            '':
                                            payMethod.toString(), style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w600, fontSize: 14)),
                                        SizedBox(width: 14),
                                        Icon(Icons.arrow_forward_ios,
                                            color: backgroundblack),
                                      ],
                                    ),
                                    // paymentMethod == null && paymentMethod == ''
                                    //     ? SizedBox.shrink():
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text("Final Total:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600), ),
                              ),
                              SizedBox(width: 6),
                              Text("${grandTotal.toStringAsFixed(2)}", style: TextStyle(fontSize: 12, color: backgroundblack, fontWeight: FontWeight.w600),),
                              SizedBox(width: 60),
                              InkWell(
                                onTap: () async{
                                  if(addressCtr.text.isEmpty || addressCtr.text.toString() == ''){
                                    Fluttertoast.showToast(
                                        msg: "Select address",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: backgroundblack,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    var result = await Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ManageAddress(home: false)));
                                    print("Reslttttttttttt in service cart ${result}");
                                    if(result == null || result == ""){
                                      print("addresss result in service cart ${result}");
                                    }
                                    else{
                                      addressCtr.text = result.toString();
                                      print("else address result in service cart${addressCtr.text}");
                                      bottomSheet();
                                    }
                                  }
                                  if(payMethod == null || payMethod!.isEmpty){
                                    // Fluttertoast.showToast(
                                    //   msg: "Select payment method",
                                    //   toastLength: Toast.LENGTH_SHORT,
                                    //   gravity: ToastGravity.CENTER,
                                    //   timeInSecForIosWeb: 1,
                                    //   backgroundColor: backgroundblack,
                                    //   textColor: Colors.white,
                                    //   fontSize: 16.0,
                                    // );
                                    var paymentmode = Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => PaymentScreen(home: false)),
                                    );
                                  }
                                  bookingService();
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> PlaceOrderSuccess()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff0047af),
                                  ),
                                  height: 30,
                                  width: MediaQuery.of(context).size.width/2.5,
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
            });
      },
    );
  }

}
