import 'dart:convert';
import 'dart:io';

import 'package:ez/models/GetProductsModel.dart';
import 'package:ez/models/GetUserCartModel.dart';
import 'package:ez/screens/view/models/address_model.dart';
import 'package:ez/screens/view/newUI/manage_address.dart';
import 'package:ez/screens/view/newUI/paymentSuccess.dart';
import 'package:ez/screens/view/newUI/placeorder_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/global.dart';
import '../../../models/AddToCartModel.dart';
import '../../../models/DeliveryChargeDistanceModel.dart';

class ViewCart extends StatefulWidget {
  String? product_id;
  final bool? show;
  ViewCart({Key? key, this.product_id, this.show}) : super(key: key);
  // final List <Imgssss> allProducts;
  @override
  State<ViewCart> createState() => _ViewCartState();
}

String? isSelected, payMethod = '', selTime, selDate, promocode;
var payment;

class _ViewCartState extends State<ViewCart> {
  String? user_id;
  bool? isLoading = false;
  String? id;
  int _counter = 1;
  bool isVisible = true;
  Position? currentLocation;
  double finalTotal = 0.0;
  double totalAmount = 0.0;
  var allTotal;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrimentConter() {
    setState(() {
      if (_counter <= 1) {
        setState(() {
          isVisible = true;
        });
      }
      _counter--;
    });
  }

  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(27.7089427, 85.3086209);
  //location to show in map

  TextEditingController addressC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController stateC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController pincodeC = TextEditingController();
  double addressLat = 0.0;
  double addressLong = 0.0;
  double? totalLocation;

  List<TextEditingController> controller = [];
  List<int> count = [];
  String? paymentMethod;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (int i = 0; i < controller.length; i++) controller[i].dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUserCart();
    inIt();
  }

  inIt() async {
    await getUserCurrentLocation();
  }

  Future getUserCurrentLocation() async {
    print("Lat Long hereeeeeeee ${homelat} ${homeLong}");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          homelat = currentLocation?.latitude;
          homeLong = currentLocation?.longitude;
        });
    });
  }

  var homelat;
  var homeLong;


  // double calculateDistance(lat, long, homelat, homeLong) {
  //   print("Alll lat lonssss ${lat} ${long} ${homelat} ${homeLong}");
  //   try {
  //     var p = 0.017453292519943295;
  //     var c = cos;
  //     var a = 0.5 - c((homelat - lat) * p) / 2 +
  //         c(lat * p) * c(homelat * p) * (1 - c((homeLong - long) * p)) / 2;
  //     totalLocation = 12742 * asin(sqrt(a));
  //     print("total location ${totalLocation}");
  //     return 12742 * asin(sqrt(a));
  //   } on Exception {
  //     return 0; // only executed if error is of type Exception
  //   } catch (error) {
  //     return 0; // executed for errors of all types other than Exception
  //   }
  // }

  double calculateDistance(addressLat, addressLong, vendorLat, vendorLong) {
    print("Alll lat lonssss ${addressLat} ${addressLong} ${vendorLat} ${vendorLong}");
    try {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((vendorLat - addressLat) * p) / 2 +
          c(addressLat * p) * c(vendorLat * p) * (1 - c((vendorLong - addressLong) * p)) / 2;
      totalLocation = 12742 * asin(sqrt(a));
      print("total location ${totalLocation}");
      return 12742 * asin(sqrt(a));
    } on Exception {
      return 0; // only executed if error is of type Exception
    } catch (error) {
      return 0; // executed for errors of all types other than Exception
    }
  }


  AddToCartModel? addToCartModel;
  addToCart(String productId, String? qty) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    id = preferences.getString("id");
    var headers = {
      'Cookie': 'ci_session=76282680e65886d44b5d7a8a0b61ac57d57ba3b3'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl()}/add_to_cart'));
    request.fields.addAll({
      'user_id': user_id ?? '',
      'product_id': productId,
      'quantity': "${qty}",
      'vendor_id': id ?? "",
    });
    print("Add To Cart Requset%%%%%%%%%%%% ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddToCartModel.fromJson(json.decode(finalResponse));
      print("Get Userrrrr**************$jsonResponse");
      setState(() {
        addToCartModel = AddToCartModel.fromJson(json.decode(finalResponse));
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  double deliveryCharge = 0;
  double gstCharge = 0;
  double vendorLat = 0.0;
  double vendoLong = 0.0;

  GetUserCartModel? getUserCartModel;

  List productIds = [];
  String productId = '';

  _getUserCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=a4f7eded0ae55693b27377b39c0d806fc3fd3588'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl()}/get_cart_items'));
    request.fields.addAll({
      'user_id': user_id ?? '',
    });
    print("Get User Cartt ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("hjhjjhhhhhhhhhhhhhhh");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      GetUserCartModel.fromJson(json.decode(finalResponse));
      print("Get Userrrrr cartttt $jsonResponse");
      if (jsonResponse.responseCode == '1') {
        setState(() {
          load = false;
        });
        print("cart&&&&&&&&&&&");
        String? cart_total = jsonResponse.cartTotal ?? "";
        preferences.setString('cart_total', cart_total);
        print("cartt Total@@@@@ ${cart_total}");
        var finalAmount = jsonResponse.cartTotal ?? "";
        String? vendor_lat = jsonResponse.cart![0].vendorLatitude;
        preferences.setString("vendor_lat", vendor_lat ??"");
        String? vendor_long = jsonResponse.cart![0].vendorLongitude;
        preferences.setString("vendor_long", vendor_long ?? "");

        print("vendorrr lattt and longg herer nowww ${vendor_lat} ${vendor_long}");

        // vendorLat = double.parse(vendor_lat);
        setState(() {
          vendorLat = double.parse(vendor_lat ?? "");
          vendoLong = double.parse(vendor_long ?? "");
          getUserCartModel = GetUserCartModel.fromJson(json.decode(finalResponse));
        });
        for(var i = 0; i <= getUserCartModel!.cart!.length; i ++){
          productIds.add(getUserCartModel!.cart![i].productId);
          setState(() {
            productId = productIds.join(',');
          });
        }
      } else {
        print("kkkkkkkkk");

        setState(() {
          load = false;
          getUserCartModel = null;

        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? cart_total;
  DeliveryChargeDistanceModel? deliveryChargeDistanceModel;
  String? deliveryGstPrice;
  String? deliver_charge;
  String? subTotalGstPrice ;
  String? gstTotal;
  String? total;
  String? subTotalGstPerc,
      deliveryGstPer;

  getDeliveryCahrge() async {
    print("Delivery Charge Apiiii");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cart_total = preferences.getString('cart_total');
    print("Crat Total######### ${cart_total}");
    var headers = {
      'Cookie': 'ci_session=f73c5c046fd411d547789e1923e08203dca73e79'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl()}/price_culculation_food'));
    request.fields.addAll({
      'distance': calculateDistance(
          double.parse(
              getUserCartModel!.cart![0].vendorLatitude.toString()),
          double.parse(
              getUserCartModel!.cart![0].vendorLongitude.toString()),
          addressLat,
          addressLong)
          .toStringAsFixed(2),
      'subTotal': cart_total ?? ''
    });
    print("Delivery charge by distance ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      DeliveryChargeDistanceModel.fromJson(json.decode(finalResponse));
      print("Delievry charge diatance responseeee$jsonResponse");
      if (jsonResponse.status == true) {
        String? vendor_delivery_charge =
            jsonResponse.vendorDeliveryCharge ?? "";
        String? vendor_gst = jsonResponse.vendorGst ?? "";
        String? deliver_charge = jsonResponse.deliverCharge ?? '';
        String? deliveryGst = jsonResponse.gst ?? '';
        String? deliveryGstPercent = jsonResponse.gstCharge ?? '';
        String? subTotalGst = jsonResponse.subtotalGstCharge ?? '';
        String? total = jsonResponse.total ?? '';
        String? subtotal_gst_percentage = jsonResponse.subtotalGstPercentage.toString();

        preferences.setString('gst', deliveryGst);
        preferences.setString('deliver_charge', deliver_charge);
        preferences.setString('vendor_gst', vendor_gst);
        preferences.setString('vendor_delivery_charge', vendor_delivery_charge);
        preferences.setString('total', total);
        preferences.setString('subtotal_gst_percentage', subtotal_gst_percentage.toString());

        print("vendor delivery charge ${vendor_delivery_charge}");
        print("vendor gst ${vendor_gst}");
        print("Delivery Charge ${deliver_charge}");
        print("Delivery gst ammount ${gst}");
        print("Total Hereeeee ${total}");
        print("Sub Gst Percentage ${subtotal_gst_percentage}");
        setState(() {
          deliveryCharge = double.parse(deliver_charge);
          gstCharge = double.parse(deliveryGst) + double.parse(subTotalGst);
          subTotalGstPrice = subTotalGst;
          subTotalGstPerc = subtotal_gst_percentage;
          deliveryGstPrice = deliveryGst;
          deliveryGstPer = deliveryGstPercent;
        });
        /*finalTotal = double.parse(cart_total.toString()) +
            double.parse(total) +
            deliveryCharge +
            gstCharge;*/
        finalTotal = double.parse(total);
        print("Finalllll Totalllllll ${finalTotal}");
        print("this is my del charge $deliveryCharge and $gstCharge and $finalTotal");
        // finalTotal = cart_total ?? "" + total ?? '';
        // print("Final total here value here  ${finalTotal}");
        totalAmount = double.parse(finalTotal.toString());
        //+ double.parse(deliver_charge)
        print("price with delivery charge and total amount ${totalAmount}");
        setState(() {
          deliveryChargeDistanceModel = DeliveryChargeDistanceModel.fromJson(json.decode(finalResponse));
        });
        showBottomsheet();
      } else {
        setState(() {});
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String? vendor_delivery_charge;
  String? vendor_gst;
  // String? deliver_charge;
  String? gst;
  String? address_id;


  placeOrder() async {
    print("Place Order Apiii");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    vendor_delivery_charge = preferences.getString('vendor_delivery_charge');
    vendor_gst = preferences.getString('vendor_gst');
    deliver_charge = preferences.getString('deliver_charge');
    gst = preferences.getString('gst');
    cart_total = preferences.getString('cart_total');
    id = preferences.getString("id");
    address_id = preferences.getString("address_id");
    var headers = {
      'Cookie': 'ci_session=956e5677c489a7ef30077af5aeef1273dac21384'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl()}/place_order'));
    request.fields.addAll({
      'product_id': productId.toString(),
      'quantity': qty.toString(),
      'subTotal':getUserCartModel!.cartTotal.toString(),
      'total_price': finalTotal.toStringAsFixed(2),
      'username': userName,
      'vendor_id': getUserCartModel!.cart![0].vendorId.toString() ?? '',
      'address_mobile': userMobile,
      'address': addressC.text,
      'address_id': address_id ?? "",
      'paymentMethod': 'Cod',
      'sub_gst_amount': subTotalGstPrice.toString(),
      'user_id': user_id ?? "",
      'distance':  calculateDistance(
          double.parse(getUserCartModel!
              .cart![0].vendorLatitude
              .toString()),
          double.parse(getUserCartModel!
              .cart![0].vendorLongitude
              .toString()),
          addressLat,
          addressLong).toStringAsFixed(2),
      'dilivery_gst_amount': deliveryGstPrice ?? '',
      'delivery_charge': deliveryCharge.toString() ?? '',
      'vendor_gst': vendor_gst ?? "",
      'vendor_delivery_charge': vendor_delivery_charge ?? "",
    });

    print("Place Order Parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if (jsonResponse['status'] == true) {
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        setState(() {
          load = false;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceOrderSuccess()));
      } else {
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        setState(() {
          load = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  removeCart(String productId) async {
    print("Remove cart apiii");
    var headers = {
      'Cookie': 'ci_session=fd7962a8fe5db9e0a60b132cf74e978025ae84fc'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl()}/remove_to_cart'));
    request.fields.addAll({'productid': productId, 'user_id': user_id ?? ""});
    print("Remove Carttt ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if (jsonResponse['status'] == true) {
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        // Navigator.pop(context);
        setState(() {
          load = true;
        });
        _getUserCart();
      } else {
        _getUserCart();
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    } else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  void confirmDialog() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  content: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                                child: Text("CONFIRM ORDER",
                                  style: Theme.of(this.context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                  ),
                                )),
                            Divider(
                                color: Colors.black),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sub Total ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14)),
                                        Text(getUserCartModel!.cartTotal == null || getUserCartModel!.cartTotal == null?
                                        "0.00":
                                        "₹${double.parse(getUserCartModel!.cartTotal.toString()).toStringAsFixed(2) ?? ""}",
                                            style: TextStyle(
                                                color: backgroundblack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Delivery Charge",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14)),
                                        // addressC.text.isEmpty ? Text("0.0") :
                                        Text(
                                          deliveryCharge == 0 ?
                                          "0.00":
                                          "₹${deliveryCharge.toStringAsFixed(2) ?? ""}",
                                          style: TextStyle(
                                              color: backgroundblack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Gst & Services",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14)),
                                        // addressC.text.isEmpty ? Text("0.0") :
                                        Text( gstCharge == 0 ?
                                        "0.00":
                                        "₹${gstCharge.toStringAsFixed(2) ?? ""}",
                                          style: TextStyle(
                                              color: backgroundblack,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(color: backgroundblack,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0, right: 10, top: 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            getUserCartModel!.cartTotal == null || getUserCartModel!.cartTotal == null?
                                            "GST On Subtotal":
                                            "GST On Subtotal" + "   ₹${double.parse(getUserCartModel!.cartTotal.toString()).toStringAsFixed(2)} @ ${double.parse(subTotalGstPerc.toString()).toStringAsFixed(2)}% ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10)),
                                        // addressC.text.isEmpty ? Text("0.0") :
                                        // Text(getUserCartModel!.cartTotal == null || getUserCartModel!.cartTotal == null?
                                        // "0.00":
                                        // "₹${double.parse(getUserCartModel!.cartTotal.toString()).toStringAsFixed(2)} @ ${double.parse(subTotalGstPerc.toString()).toStringAsFixed(2)}%  ",
                                        //     style: TextStyle(
                                        //         // color: backgroundblack,
                                        //         fontSize: 10,
                                        //         fontWeight: FontWeight.w400)),
                                        Text(
                                          subTotalGstPrice == '' || subTotalGstPrice == null ?
                                          "0.00":
                                          "₹${double.parse(subTotalGstPrice.toString()).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: backgroundblack,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0, right: 10, top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            deliveryCharge == 0 || deliveryCharge == ''?
                                            "GST On Delivery Charge    ":
                                            "GST On Delivery Charge    ₹${deliveryCharge.toStringAsFixed(2)} @ ${double.parse(deliveryGstPer.toString()).toStringAsFixed(2)}%",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10)),
                                        // addressC.text.isEmpty ? Text("0.0") :
                                        // Text(deliveryCharge == 0 || deliveryCharge == ''?
                                        // "0.00":
                                        // "₹${deliveryCharge.toStringAsFixed(2)} @ ${double.parse(deliveryGstPer.toString()).toStringAsFixed(2)}% ",
                                        //     style: TextStyle(
                                        //         // color: backgroundblack,
                                        //         fontSize: 10,
                                        //         fontWeight: FontWeight.w500)),
                                        Text(
                                          deliveryGstPrice == '' || deliveryGstPrice == null ?
                                          "0.00":
                                          "₹${double.parse(deliveryGstPrice.toString()).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: backgroundblack,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(color: backgroundblack,),

                                  const SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.all(.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18)),
                                        // addressC.text.isEmpty ? Text("0.0") :
                                        Text(
                                          finalTotal == 0 ?
                                          "0.00":
                                          "₹${finalTotal.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: backgroundblack,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ]),
                      // load ?
                      // CircularProgressIndicator(color: backgroundblack, backgroundColor: appColorOrange,)
                      //  : SizedBox.shrink(),
                    ],
                  ),
                  actions: <Widget>[
                    new TextButton(
                        child: Text("CANCEL",
                            style: TextStyle(
                                color: appColorOrange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.pop(context);
                          // checkoutState!(() {
                          //   _placeOrder = true;
                          // });
                          // placeOrder();


                        }),
                    new TextButton(
                        child: Text("DONE",
                            style: TextStyle(
                                color: backgroundblack,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          setState(() {
                            load = true;
                          });
                          placeOrder();
                          Navigator.pop(context);

                          // doPayment();
                        })
                  ],
                )),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
  bool load = false;
  @override
  Widget build(BuildContext context) {
    // print("Vendor lat ${getUserCartModel!.cart![0].vendorLatitude}");
    // print("vendor long ${getUserCartModel!.cart![0].vendorLongitude}");
    // print("Get uuser cart ${getUserCartModel!.cart![0].sellingPrice}");
    // print("Get&&&&&&& ${getUserCartModel!.cart![0].quantity}");
    // print("kjjkjjjjlljklkklkj ${getUserCartModel!.cart![0].productId}");
    return Scaffold(
      backgroundColor: Color(0xffF1F5F8),
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: !widget.show!,
        backgroundColor: Colors.white38,
        title: Text(
          "Cart",
          style: TextStyle(
              color: backgroundblack,
              fontWeight: FontWeight.w900,
              fontSize: 22),
        ),
        leading: !widget.show! ?
        SizedBox.shrink()
            : IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(Icons.arrow_back_ios, color: backgroundblack),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [

                      //Center(child: Text("Cart Is Empty!!!", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),))
                      getUserCartModel != null ?
                      getUserCartModel!.cart!.isNotEmpty ?
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: getUserCartModel!.cart!.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            return productItem(index);
                          })
                          :   Center(
                        child: Image.asset("assets/images/loader1.gif", scale: 2.5),
                      )
                          : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Image.asset(
                                "assets/images/emptyCart.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              "Cart is Empty",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      isLoading == null
                          ? Center(
                        child: Image.asset("assets/images/loader1.gif", scale: 2.5),
                      )
                          : Container()
                    ],
                  ),
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height/40,
                //   // height: MediaQuery.of(context).size.height-85.0-75,
                //   width: MediaQuery.of(context).size.width,
                //   decoration: const BoxDecoration(
                //       color: appColorOrange,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(45),
                //         topRight: Radius.circular(45),
                //       ),
                //   ),
                // child: Padding(
                //   padding: const EdgeInsets.only(top:70, left: 30.0, right: 30),
                //   child: SingleChildScrollView(
                //     child: Text("khjjhj"),
                //   ),
                // ),
                // ),
                // Container(
                //   height: 500,
                //   width: MediaQuery.of(context).size.width/1,
                //   child: getUserCartModel == null ? Center(
                //     child: Image.asset("assets/images/loader1.gif"),
                //   ) : ListView.builder(
                //     scrollDirection: Axis.vertical,
                //     itemCount: getUserCartModel!.cart!.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return
                //         Padding(
                //           padding: EdgeInsets.all(15),
                //           child: Scrollbar(
                //             thickness: 10,
                //             trackVisibility: true,
                //             // isAlwaysShown: true,
                //             thumbVisibility: true,
                //             radius: Radius.circular(10),
                //             child: Card(
                //                 elevation: 10,
                //                 semanticContainer: true,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(20.0),
                //                 ),
                //                 clipBehavior: Clip.antiAlias,
                //                 child: Row(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   children: <Widget>[
                //                     Center(
                //                       child: Container(
                //                           decoration: BoxDecoration(
                //                               color: appColorOrange,
                //                               borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                //                           height: 80,width: 5),
                //                     ),
                //                     SizedBox(width: 5),
                //                     Center(
                //                       child: ClipRRect(
                //                           borderRadius: BorderRadius.circular(100),
                //                           // radius: 40,
                //                           child: getUserCartModel == null ? Center(
                //                             child: Image.asset("assets/images/loader1.gif"),
                //                           ) : Image.network("${getUserCartModel!.cart![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,)
                //                       ),
                //                     ),
                //                     Padding(
                //                       padding: const EdgeInsets.only(top: 15.0, left: 7),
                //                       child: Column(
                //                         crossAxisAlignment: CrossAxisAlignment.start,
                //                         children: [
                //                           Text("${getUserCartModel!.cart![index].productName}",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14),),
                //                           Text("Qty ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
                //                           Text("₹ ${getUserCartModel!.cart![index].qtyPrice}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
                //                         ],
                //                       ),
                //                     ),
                //                     SizedBox(width: 50,),
                //                     Container(
                //                       child: Row(
                //                         children: [
                //                           Padding(
                //                             padding: const EdgeInsets.only(top: 28.0),
                //                             // child:  InkWell(
                //                             //   onTap: () {
                //                             //     if (_counter >= 1) {
                //                             //       _counter -= 1;
                //                             //       setState(() {});
                //                             //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                //                             //     }
                //                             //   },
                //                             //   child: Card(
                //                             //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                //                             //     child: ClipRRect(
                //                             //         borderRadius:
                //                             //         BorderRadius.all(Radius.circular(6)),
                //                             //         child: Container(
                //                             //             // padding: EdgeInsets.all(6),
                //                             //             // color: isDark
                //                             //             //     ? AppThemes.smoothBlack
                //                             //             //     : AppThemes
                //                             //             //     .lightTextFieldBackGroundColor,
                //                             //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                //                             //         ),
                //                             //     ),
                //                             //   ),
                //                             // ),
                //                             child: InkWell(
                //                               onTap: () {
                //                                 // if (_counter >= 1) {
                //                                 //   _counter -= 1;
                //                                 //   setState(() {});
                //                                 //   addToCart(getUserCartModel!.cart![index].productId ??'');
                //                                 // }
                //                                 //   setState((){
                //                                 //   });
                //                                 //   count[index] -= 1;
                //                                 //     addToCart(getUserCartModel!.cart![index].productId ??'');
                //                                 // },
                //                                 if (qty[index] >= 1) {
                //                                   qty[index] -= 1;
                //                                   print("kkkkkkk ${qty[index]}");
                //                                   print("ooooo ${qty[index]}");
                //                                   addToCart(
                //                                     getUserCartModel!.cart![index]
                //                                         .productId.toString(),
                //                                     // getUserCartModel.cart[index].productPrice ?? "",
                //                                     // qty[index].toString());
                //                                   );
                //                                 }
                //                               },
                //                               // onTap:() {
                //                               //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                //                               //   _decrimentConter;
                //                               // },
                //                               child: Container(
                //                                 decoration: BoxDecoration(
                //                                     color:backgroundblack,
                //                                     borderRadius: BorderRadius.circular(5)),
                //                                 height: 24,
                //                                 width: 25,
                //                                 child:(
                //                                     Center(
                //                                         child: Icon(Icons.remove,size: 20,color: Colors.white))
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                           // Container(
                //                           //     child: Text("${count[index]}",)),
                //                           SizedBox(width: 4),
                //                           Padding(
                //                             padding: const EdgeInsets.only(top: 28.0),
                //                             child: Text(
                //                               '$_counter',
                //                               // "${qty[index].toString()}",
                //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                //                             ),
                //                           ),
                //                           SizedBox(width: 4),
                //                           // SizedBox(width: 60,),
                //                           Padding(
                //                             padding: const EdgeInsets.only(top: 28.0),
                //                             child: InkWell(
                //                               onTap: () {
                //                                 setState(() {});
                //                                 print("kkkkkkk ${qty[index]}");
                //                                 qty[index] = qty[index] + 1;
                //                                 print("ooooo ${qty[index]}");
                //                                 addToCart(getUserCartModel!.cart![index].productId ??'');
                //                               },
                //                               child: Container(
                //                                 decoration: BoxDecoration(
                //                                     color:backgroundblack,
                //                                     borderRadius: BorderRadius.circular(5)),
                //                                 height: 24,
                //                                 width: 25,
                //                                 child:(
                //                                     Center(child: const Icon(Icons.add,size: 20,color: Colors.white))),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                     // Container(
                //                     //   child: Row(children: [
                //                     //     Padding(
                //                     //       padding: const EdgeInsets.only(top: 30.0),
                //                     //       child: InkWell(
                //                     //         onTap: _decrimentConter,
                //                     //         child: Container(
                //                     //           decoration: BoxDecoration(
                //                     //               color:backgroundblack,
                //                     //               borderRadius: BorderRadius.circular(5)),
                //                     //           height: 24,
                //                     //           width: 27,
                //                     //           child: (Center(child: const Icon(Icons.remove,size: 20,color: Colors.white,))
                //                     //           ),
                //                     //         ),
                //                     //       ),
                //                     //     ),
                //                     //     SizedBox(width: 3,),
                //                     //     Padding(
                //                     //       padding: const EdgeInsets.only(top: 23.0),
                //                     //       child: Text(
                //                     //         '$_counter',
                //                     //         style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                //                     //       ),
                //                     //     ),
                //                     //     SizedBox(width: 3),
                //                     //     Padding(
                //                     //       padding: const EdgeInsets.only(top: 30.0),
                //                     //       child: InkWell(
                //                     //         onTap: _incrementCounter,
                //                     //         child: Container(
                //                     //           decoration: BoxDecoration(
                //                     //               color:backgroundblack,
                //                     //               borderRadius: BorderRadius.circular(5)),
                //                     //           height: 24,
                //                     //           width: 27,
                //                     //           child: (Center(child: const Icon(Icons.add,size: 20,color: Colors.white,))
                //                     //           ),
                //                     //         ),
                //                     //       ),
                //                     //     ),
                //                     //   ],),
                //                     // ),
                //                     SizedBox(width: 8),
                //                     Align(
                //                       alignment: Alignment.topLeft,
                //                       child: InkWell(
                //                         onTap: (){
                //                           removeCart(getUserCartModel!.cart![index].productId ??'');
                //                         },
                //                         child: Icon(
                //                             Icons.highlight_remove_rounded, color: backgroundblack,
                //                         ),
                //                       ),
                //                     ),
                //                     Spacer(),
                //                     Center(
                //                       child: Padding(
                //                         padding: const EdgeInsets.only(top: 8.0),
                //                         child: Container(
                //                           decoration: BoxDecoration(
                //                               color: appColorOrange,
                //                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                //                           ),
                //                           height: 80,width: 8),
                //                       ),
                //                     ),
                //                   ],
                //                 )),
                //           ));
                //     },
                //   ),
                // ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCartScreeen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getUserCartModel?.cartTotal == null ||
                        getUserCartModel?.cartTotal == ""
                        ? SizedBox.shrink()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub Total:",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: appColorBlack),
                        ),
                        Text("₹${getUserCartModel!.cartTotal ?? ""}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: appColorBlack)),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 20,),
                getUserCartModel?.cartTotal == null ||
                    getUserCartModel?.cartTotal == ""
                    ? SizedBox.shrink()
                    :
                InkWell(
                  onTap: () {
                    showBottomsheet();
                    // getDeliveryCahrge();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCartScreeen()));
                  },
                  child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(15),
                          color: Colors.green),
                      child: Center(
                          child: Text("Processed To CheckOut",
                              style: TextStyle(
                                  color: appColorBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)))),
                ),
              ],
            ),
          ),
          load ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: backgroundblack, backgroundColor: appColorOrange,),
            ],
          )
              : SizedBox.shrink()
        ],
      ),
    );
  }

  showBottomsheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return
          Container(
            height: 400,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(
                    //     height: 60,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.white,
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(left: 10),
                    //       child: TextFormField(
                    //         controller: addressC,
                    //         maxLines: 2,
                    //         style: TextStyle(overflow: TextOverflow.ellipsis),
                    //       ),
                    //     )
                    //     // InkWell(
                    //     //   // onTap: () {
                    //     //   //   Navigator.push(
                    //     //   //     context,
                    //     //   //     MaterialPageRoute(
                    //     //   //       builder: (context) => PlacePicker(
                    //     //   //         apiKey: Platform.isAndroid
                    //     //   //             ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
                    //     //   //             : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
                    //     //   //         onPlacePicked: (result) {
                    //     //   //           print(result.formattedAddress);
                    //     //   //           setState(() {
                    //     //   //             addressC.text = result.formattedAddress.toString();
                    //     //   //             lat = result.geometry!.location.lat;
                    //     //   //             long = result.geometry!.location.lng;
                    //     //   //           });
                    //     //   //           Navigator.of(context).pop();
                    //     //   //           // distnce();
                    //     //   //         },
                    //     //   //         initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                    //     //   //         useCurrentLocation: true,
                    //     //   //       ),
                    //     //   //     ),
                    //     //   //   );
                    //     //   //   // _getLocation();
                    //     //   // },
                    //     //   child: Row(
                    //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     //     children: [
                    //     //       Padding(
                    //     //         padding: const EdgeInsets.only(left: 10, top: 1),
                    //     //         child: Text(
                    //     //             "Add Address", style: TextStyle(fontSize: 18, color: backgroundblack)
                    //     //         ),
                    //     //       ),
                    //     //       // Padding(
                    //     //       //   padding: const EdgeInsets.only(right: 5),
                    //     //       //   child: Icon(Icons.my_location, color: backgroundblack),
                    //     //       // ),
                    //     //     ],
                    //     //   ),
                    //     // ),
                    //     ),
                    // Divider(
                    //   color: backgroundblack,
                    //   thickness: 1.5,
                    //   indent : 10,
                    //   endIndent : 10,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10.0, top: 8),
                    //   child: InkWell(
                    //       onTap: () async {
                    //         var result1 = await Navigator.pushReplacement(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) =>
                    //                     ManageAddress(home: false)));
                    //         print(
                    //             "address result in cart pageeeee ${result1}");
                    //         if (result1 == null || result1 == "") {
                    //           print("addresss result herereee ${result1}");
                    //         } else {
                    //           // addressC.text = result1.toString();
                    //           setState(() {
                    //             addressC.text = result1[0];
                    //             addressLat = double.parse(result1[1]);
                    //             addressLong = double.parse(result1[2]);
                    //             print("userrr long__________________ ${addressLong}");
                    //             print("userrrr lat__________________ ${addressLat}");
                    //           });
                    //           calculateDistance(
                    //               double.parse(getUserCartModel!
                    //                   .cart![0].vendorLatitude
                    //                   .toString()),
                    //               double.parse(getUserCartModel!
                    //                   .cart![0].vendorLatitude
                    //                   .toString()),
                    //               addressLat,
                    //               addressLong);
                    //           print("this is my actual distance ${ calculateDistance(
                    //               double.parse(getUserCartModel!
                    //                   .cart![0].vendorLatitude
                    //                   .toString()),
                    //               double.parse(getUserCartModel!
                    //                   .cart![0].vendorLongitude
                    //                   .toString()),
                    //               addressLat,
                    //               addressLong)}");
                    //           getDeliveryCahrge();
                    //           // showBottomsheet();
                    //         }
                    //       },
                    //       child: Container(
                    //         width: MediaQuery.of(context).size.width - 30,
                    //         height: 40,
                    //         child: Text("Change Address",
                    //             style: TextStyle(
                    //                 color: backgroundblack,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold)),
                    //       )),
                    // ),
                    InkWell(
                      onTap: () async {
                        var result1 = await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ManageAddress(home: false)));
                        print(
                            "address result in cart pageeeee ${result1}");
                        if (result1 == null || result1 == "") {
                          print("addresss result herereee ${result1}");
                        } else {
                          // addressC.text = result1.toString();
                          setState(() {
                            addressC.text = result1[0];
                            addressLat = double.parse(result1[1]);
                            addressLong = double.parse(result1[2]);
                            print("userrr long__________________ ${addressLong}");
                            print("userrrr lat__________________ ${addressLat}");
                          });
                          calculateDistance(
                              double.parse(getUserCartModel!
                                  .cart![0].vendorLatitude
                                  .toString()),
                              double.parse(getUserCartModel!
                                  .cart![0].vendorLatitude
                                  .toString()),
                              addressLat,
                              addressLong);
                          print("this is my actual distance ${ calculateDistance(
                              double.parse(getUserCartModel!
                                  .cart![0].vendorLatitude
                                  .toString()),
                              double.parse(getUserCartModel!
                                  .cart![0].vendorLongitude
                                  .toString()),
                              addressLat,
                              addressLong)}");
                          getDeliveryCahrge();
                          // showBottomsheet();
                        }
                        setState(() {});
                      },
                      child: Container(
                        // height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Change Address",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: backgroundblack)),
                                  // Text("${paymentMethod}", style: TextStyle(fontSize: 16, color: backgroundblack, fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_forward_ios,
                                      color: backgroundblack),
                                ],
                              ),
                              Divider(color: backgroundblack,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  enabled: false,
                                  controller: addressC,
                                  maxLines: 2,
                                  style: TextStyle(overflow: TextOverflow.ellipsis),
                                  decoration: InputDecoration(
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              addressC.text.isEmpty ?
                              SizedBox.shrink() :
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, top: 10),
                                child: Text("Distance : ${   calculateDistance(
                                    double.parse(getUserCartModel!
                                        .cart![0].vendorLatitude
                                        .toString()),
                                    double.parse(getUserCartModel!
                                        .cart![0].vendorLongitude
                                        .toString()),
                                    addressLat,
                                    addressLong).toStringAsFixed(2)} Kms", style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600
                                ),),
                              ),
                              // paymentMethod == null && paymentMethod == ''
                              //     ? SizedBox.shrink():
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [Divider( color: backgroundblack,), Text(
                              //       paymentMethod == null || paymentMethod == '' ?
                              //       '':
                              //       paymentMethod!, style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w600),)],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       // TextFormField(
                    //       //   decoration: InputDecoration(border: InputBorder.none),
                    //       //   controller: addressC,
                    //       //   maxLines: 2,
                    //       //   style: TextStyle(overflow: TextOverflow.ellipsis),
                    //       // ),
                    //       // Text("A/5 Ratanpuri Indore"),
                    //       // Text('+9109599773')
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        var payment = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PaymentScreen(home: false)));
                        setState(() {
                          paymentMethod = payment;
                        });
                        print("paymentt method ${paymentMethod}  $payment");
                      },
                      child: Container(
                        // height: 65,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            color: appColorOrange),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Select Payment Method ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: backgroundblack)),
                                  // Text("${paymentMethod}", style: TextStyle(fontSize: 16, color: backgroundblack, fontWeight: FontWeight.bold)),
                                  Icon(Icons.arrow_forward_ios,
                                      color: backgroundblack),
                                ],
                              ),
                              // paymentMethod == null && paymentMethod == ''
                              //     ? SizedBox.shrink():
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Divider( color: backgroundblack,), Text(
                                    paymentMethod == null || paymentMethod == '' ?
                                    '':
                                    paymentMethod.toString(), style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w600),)],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order Summary",
                              style:
                              TextStyle(fontSize: 16, color: Colors.black)),
                          Padding(
                            padding: const EdgeInsets.all(.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sub Total ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                Text(getUserCartModel!.cartTotal == null || getUserCartModel!.cartTotal == null?
                                "0.00":
                                "₹${double.parse(getUserCartModel!.cartTotal.toString()).toStringAsFixed(2) ?? ""}",
                                    style: TextStyle(
                                        color: backgroundblack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Gst & Services",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                // addressC.text.isEmpty ? Text("0.0") :
                                Text( gstCharge == 0 ?
                                "0.00":
                                "₹${gstCharge.toStringAsFixed(2) ?? ""}",
                                  style: TextStyle(
                                      color: backgroundblack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Charge",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                // addressC.text.isEmpty ? Text("0.0") :
                                Text(
                                  deliveryCharge == 0 ?
                                  "0.00":
                                  "₹ ${deliveryCharge.toStringAsFixed(2) ?? ""}",
                                  style: TextStyle(
                                      color: backgroundblack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // deliveryChargeDistanceModel?.total == null|| deliveryChargeDistanceModel?.total== ""? Text("Total : ₹${double.parse(getUserCartModel!.cartTotal.toString()).toStringAsFixed(2) ?? ""}",
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //     color: backgroundblack,
                                //     fontWeight: FontWeight.w500),):
                                // addressC.text.isEmpty ? Text("Total: ${getUserCartModel!.cartTotal?? ""}",  style: TextStyle(fontSize: 15, color: backgroundblack, fontWeight: FontWeight.w500),):
                                Text(
                                  finalTotal == 0  ?
                                  "Total: ₹ 0.00"
                                  // "Total: ₹${finalTotal > 0 ? finalTotal : getUserCartModel!.cartTotal ?? ""}",
                                      :"Total: ₹${finalTotal.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: backgroundblack,
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (addressC.text.isEmpty ||
                                        addressC.text.toString() == '') {
                                      Fluttertoast.showToast(
                                          msg: "Please select address",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: backgroundblack,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      var result1 =
                                      await Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) =>
                                                  ManageAddress(
                                                      home: false)));
                                      if (result1 == null || result1 == "") {
                                        print(
                                            "addresss result herereee ${result1}");
                                      } else {
                                        setState(() {
                                          addressC.text = result1[0];
                                          addressLat = double.parse(result1[1]);
                                          addressLong = double.parse(result1[2]);
                                          print("____________ ${addressLong}");
                                        });
                                        calculateDistance(
                                            double.parse(getUserCartModel!
                                                .cart![0].vendorLatitude
                                                .toString()),
                                            double.parse(getUserCartModel!
                                                .cart![0].vendorLongitude
                                                .toString()),
                                            addressLat,
                                            addressLong);
                                        getDeliveryCahrge();
                                        // calculateDistance(double.parse(getUserCartModel!.cart![0].vendorLatitude.toString()), double.parse(getUserCartModel!.cart![0].vendorLatitude.toString()), homelat, homeLong);
                                        print(
                                            "else address result ${addressC.text}");
                                        setState(() {});
                                      }
                                    }
                                    else if (paymentMethod == null || paymentMethod!.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: "Please select payment method",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: backgroundblack,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PaymentScreen(
                                                  home: false,
                                                )),
                                      );
                                      if(result != null){
                                        setState(() {
                                          paymentMethod = result;
                                        });
                                        Future.delayed(Duration(seconds: 1), (){
                                          confirmDialog();
                                        });
                                        print("this is payment result $result");
                                      }
                                    }else{
                                      placeOrder();
                                    }
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> PlaceOrderSuccess()));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: appColorOrange),
                                    child: Center(
                                        child: Text(
                                          "Place Order",
                                          style: TextStyle(
                                              color: backgroundblack, fontSize: 15),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                load ?
                CircularProgressIndicator(color: backgroundblack, backgroundColor: appColorOrange,)
                    : SizedBox.shrink(),
              ],
            ),
          );
        // return StatefulBuilder(builder: (context, setState) {
        // },);
      },
    );
  }

  // address() {
  //   return Card(
  //     elevation: 0,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Row(
  //             children: [
  //               Icon(Icons.location_on),
  //               Padding(
  //                   padding: const EdgeInsetsDirectional.only(start: 8.0),
  //                   child: Text(
  //                     "Select Address",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.black,
  //                   )), ),
  //             ],
  //           ),
  //           Divider(),
  //           addressList.length > 0
  //               ? Padding(
  //             padding: const EdgeInsetsDirectional.only(start: 8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                         child:
  //                         Text(addressList[selectedAddress!].name!)),
  //                     InkWell(
  //                       child: Padding(
  //                         padding:
  //                         const EdgeInsets.symmetric(horizontal: 8.0),
  //                         child: Text(
  //                           getTranslated(context, 'CHANGE')!,
  //                           style: TextStyle(
  //                             color: colors.primary,
  //                           ),
  //                         ),
  //                       ),
  //                       onTap: () async {
  //                         await Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (BuildContext context) =>
  //                                     ManageAddress(
  //                                       home: false,
  //                                     )));
  //                         checkoutState!(() {
  //                           deliverable = false;
  //                         });
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //                 Text(
  //                   addressList[selectedAddress!].address! +
  //                       ", " +
  //                       addressList[selectedAddress!].area! +
  //                       ", " +
  //                       addressList[selectedAddress!].city! +
  //                       ", " +
  //                       addressList[selectedAddress!].state! +
  //                       ", " +
  //                       addressList[selectedAddress!].country! +
  //                       ", " +
  //                       addressList[selectedAddress!].pincode!,
  //                   style: Theme.of(context).textTheme.caption!.copyWith(
  //                       color: Colors.black),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 5.0),
  //                   child: Row(
  //                     children: [
  //                       Text(
  //                           addressList[selectedAddress!].mobile!,
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .caption!
  //                               .copyWith(
  //                               color: Theme.of(context)
  //                                   .colorScheme
  //                                   .lightBlack), d
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           )
  //               : Padding(
  //             padding: EdgeInsetsDirectional.only(start: 8.0),
  //             child: GestureDetector(
  //               child: Text(
  //                 getTranslated(context, 'ADDADDRESS')!,
  //                 style: TextStyle(
  //                   color: Theme.of(context).colorScheme.fontColor,
  //                 ),
  //               ),
  //               onTap: () async {
  //                 ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => AddAddress(
  //                       update: false,
  //                       index: addressList.length,
  //                     ),
  //                   ),
  //                 );
  //                 if (mounted) setState(() {});
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  List<int> qty = [];
  Widget productItem(index) {
    if (qty.length < index + 1) qty.add(1);
    qty[index] = int.parse(getUserCartModel!.cart![index].quantity.toString());
    return Padding(
        padding: EdgeInsets.all(15),
        child: Scrollbar(
          thickness: 10,
          trackVisibility: true,
          // isAlwaysShown: true,
          thumbVisibility: true,
          radius: Radius.circular(10),
          child: SizedBox(
            height: 120,
            child: Card(
              // elevation: 10,
              semanticContainer: true,
              clipBehavior: Clip.antiAlias,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 5),
                  Center(
                    child: getUserCartModel == null
                        ? Center(child: Text("No Image To show"))
                        : Image.network(
                        "${getUserCartModel!.cart![index].productImage}",
                        height: 70,
                        width: 70,
                        fit: BoxFit.fill),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getUserCartModel!.cart![index].productName}",
                            style: TextStyle(
                                color: backgroundblack,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // Text("Qty ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
                          Text("₹ ${getUserCartModel!.cart![index].sellingPrice}",
                              style: TextStyle(
                                  color: appColorBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 0),
                                  //   // child:  InkWell(
                                  //   //   onTap: () {
                                  //   //     if (_counter >= 1) {
                                  //   //       _counter -= 1;
                                  //   //       setState(() {});
                                  //   //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                                  //   //     }
                                  //   //   },
                                  //   //   child: Card(
                                  //   //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                                  //   //     child: ClipRRect(
                                  //   //         borderRadius:
                                  //   //         BorderRadius.all(Radius.circular(6)),
                                  //   //         child: Container(
                                  //   //             // padding: EdgeInsets.all(6),
                                  //   //             // color: isDark
                                  //   //             //     ? AppThemes.smoothBlack
                                  //   //             //     : AppThemes
                                  //   //             //     .lightTextFieldBackGroundColor,
                                  //   //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                                  //   //         ),
                                  //   //     ),
                                  //   //   ),
                                  //   // ),
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       // if (_counter >= 1) {
                                  //       //   _counter -= 1;
                                  //       //   setState(() {});
                                  //       //   addToCart(getUserCartModel!.cart![index].productId ??'');
                                  //       // }
                                  //       //   setState((){
                                  //       //   });
                                  //       //   count[index] -= 1;
                                  //       //     addToCart(getUserCartModel!.cart![index].productId ??'');
                                  //       // },
                                  //       if (qty[index] >= 1) {
                                  //         qty[index] -= 1;
                                  //         print("kkkkkkk ${qty[index]}");
                                  //         print("ooooo ${qty[index]}");
                                  //         addToCart(getUserCartModel!.cart![index].productId.toString(), qty[index].toString()
                                  //           // getUserCartModel.cart[index].productPrice ?? "",
                                  //           // qty[index].toString());
                                  //         );
                                  //       }
                                  //     },
                                  //     // onTap:() {
                                  //     //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                                  //     //   _decrimentConter;
                                  //     // },
                                  //     child: (
                                  //         Center(child: Icon(Icons.remove,size: 18,color: Colors.black))
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(
                                  //     child: Text("${count[index]}",)),
                                  SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(top: .0),
                                    child: Text("Qty : ${qty[index].toString()}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ),
                                  // SizedBox(width: 11),
                                  // SizedBox(width: 60,),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top:.0),
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       setState(() {});
                                  //       print("kkkkkkk ${qty[index]}");
                                  //       qty[index] = qty[index] + 1;
                                  //       print("ooooo ${qty[index]}");
                                  //       addToCart(getUserCartModel!.cart![index].productId ??'', qty[index].toString());
                                  //     },
                                  //     child: (
                                  //         Center(child: const Icon(Icons.add,size: 18,color: Colors.black))
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(width: 100),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      removeCart(getUserCartModel!
                                          .cart![index].productId ??
                                          '');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Image.asset(
                                          "assets/images/delete.png",
                                          color: Colors.black,
                                          scale: 1.4),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                  // Container(
                  //   child: Row(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 28.0),
                  //           // child:  InkWell(
                  //           //   onTap: () {
                  //           //     if (_counter >= 1) {
                  //           //       _counter -= 1;
                  //           //       setState(() {});
                  //           //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                  //           //     }
                  //           //   },
                  //           //   child: Card(
                  //           //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                  //           //     child: ClipRRect(
                  //           //         borderRadius:
                  //           //         BorderRadius.all(Radius.circular(6)),
                  //           //         child: Container(
                  //           //             // padding: EdgeInsets.all(6),
                  //           //             // color: isDark
                  //           //             //     ? AppThemes.smoothBlack
                  //           //             //     : AppThemes
                  //           //             //     .lightTextFieldBackGroundColor,
                  //           //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                  //           //         ),
                  //           //     ),
                  //           //   ),
                  //           // ),
                  //           child: InkWell(
                  //             onTap: () {
                  //               // if (_counter >= 1) {
                  //               //   _counter -= 1;
                  //               //   setState(() {});
                  //               //   addToCart(getUserCartModel!.cart![index].productId ??'');
                  //               // }
                  //               //   setState((){
                  //               //   });
                  //               //   count[index] -= 1;
                  //               //     addToCart(getUserCartModel!.cart![index].productId ??'');
                  //               // },
                  //               if (qty[index] >= 1) {
                  //                 qty[index] -= 1;
                  //                 print("kkkkkkk ${qty[index]}");
                  //                 print("ooooo ${qty[index]}");
                  //                 addToCart(getUserCartModel!.cart![index].productId.toString(),
                  //                   // getUserCartModel.cart[index].productPrice ?? "",
                  //                   // qty[index].toString());
                  //                 );
                  //               }
                  //             },
                  //             // onTap:() {
                  //             //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                  //             //   _decrimentConter;
                  //             // },
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                   color:backgroundblack,
                  //                   borderRadius: BorderRadius.circular(5)),
                  //               height: 24,
                  //               width: 25,
                  //               child:(
                  //                   Center(
                  //                       child: Icon(Icons.remove,size: 20,color: Colors.white))
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         // Container(
                  //         //     child: Text("${count[index]}",)),
                  //         SizedBox(width: 4),
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 28.0),
                  //           child:Text("Qty: ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                  //
                  //         ),
                  //         SizedBox(width: 4),
                  //         // SizedBox(width: 60,),
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 28.0),
                  //           child: InkWell(
                  //             onTap: () {
                  //               setState(() {});
                  //               print("kkkkkkk ${qty[index]}");
                  //               qty[index] = qty[index] + 1;
                  //               print("ooooo ${qty[index]}");
                  //               addToCart(getUserCartModel!.cart![index].productId ??'');
                  //             },
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                   color:backgroundblack,
                  //                   borderRadius: BorderRadius.circular(5)),
                  //               height: 24,
                  //               width: 25,
                  //               child:(
                  //                   Center(child: const Icon(Icons.add,size: 20,color: Colors.white))),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //   ),
                  // ),
                  // // Container(
                  // //   child: Row(children: [
                  // //     Padding(
                  // //       padding: const EdgeInsets.only(top: 30.0),
                  // //       child: InkWell(
                  // //         onTap: _decrimentConter,
                  // //         child: Container(
                  // //           decoration: BoxDecoration(
                  // //               color:backgroundblack,
                  // //               borderRadius: BorderRadius.circular(5)),
                  // //           height: 24,
                  // //           width: 27,
                  // //           child: (Center(child: const Icon(Icons.remove,size: 20,color: Colors.white,))
                  // //           ),
                  // //         ),
                  // //       ),
                  // //     ),
                  // //     SizedBox(width: 3,),
                  // //     Padding(
                  // //       padding: const EdgeInsets.only(top: 23.0),
                  // //       child: Text(
                  // //         '$_counter',
                  // //         style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  // //       ),
                  // //     ),
                  // //     SizedBox(width: 3),
                  // //     Padding(
                  // //       padding: const EdgeInsets.only(top: 30.0),
                  // //       child: InkWell(
                  // //         onTap: _incrementCounter,
                  // //         child: Container(
                  // //           decoration: BoxDecoration(
                  // //               color:backgroundblack,
                  // //               borderRadius: BorderRadius.circular(5)),
                  // //           height: 24,
                  // //           width: 27,
                  // //           child: (Center(child: const Icon(Icons.add,size: 20,color: Colors.white,))
                  // //           ),
                  // //         ),
                  // //       ),
                  // //     ),
                  // //   ],),
                  // // ),
                  // SizedBox(width: 8),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: InkWell(
                  //       onTap: (){
                  //         removeCart(getUserCartModel!.cart![index].productId ??'');
                  //       },
                  //       child: Icon(
                  //         Icons.delete, color: backgroundblack,
                  //       ),
                  //   ),
                  // ),
                  // Spacer(),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 8.0),
                  //     child: Container(
                  //         decoration: BoxDecoration(
                  //             color: appColorOrange,
                  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                  //         ),
                  //         height: 80,width: 8),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }

// _getLocation() async {
// LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) => PlacePicker(
//       "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
//     )));
// print("Deliveryyyyyy lat long ${lat} and ${long}");
// print("Adddressss herrrr nowwww ${addressC}");
// print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
// setState(() {
//   addressC.text = result.formattedAddress.toString();
//   cityC.text = result.locality.toString();
//   stateC.text = result.administrativeAreaLevel1!.name.toString();
//   countryC.text = result.country!.name.toString();
//   lat = result.latLng!.latitude;
//   long = result.latLng!.longitude;
//   pincodeC.text = result.postalCode.toString();
// });
// }
}
