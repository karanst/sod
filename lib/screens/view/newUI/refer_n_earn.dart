import 'dart:convert';

import 'package:ez/Helper/helperFunction.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/models/refferal_list_model.dart';
import 'package:ez/screens/view/models/getUserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key? key}) : super(key: key);

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  bool change = true;
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print(change);
  }

  String? uid;
  String? type;
  String? wallet;
  String? referralCode;
  GetUserModel? model;

  // Future getCustomerReviews() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userId = prefs.getString(TokenString.userid);
  //
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('${Apipath.getWalletHistory}'));
  //   request.fields.addAll({'user_id': '${userId.toString()}'
  //     // '${userId.toString()}'
  //   });
  //   print("this is request !! ${request.fields}");
  //
  //   http.StreamedResponse response = await request.send();
  //   print("this is request !! 11111${response}");
  //   if (response.statusCode == 200) {
  //     print("this response @@ ${response.statusCode}");
  //     final str = await response.stream.bytesToString();
  //     var datas = WalletTransactionsModel.fromJson(json.decode(str));
  //     return WalletTransactionsModel.fromJson(json.decode(str));
  //   } else {
  //     return null;
  //   }
  // }

  Future getRefferal(String level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user_id");

    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl()}/referral_list_user'));
    request.fields.addAll({
      'user_id': '${userId.toString()}',
      'booking_type': level.toString()
      // '${userId.toString()}'
    });
    print("this is request !! ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this is request !! 11111${response}");
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      // var datas = RefferalListModel.fromJson(json.decode(str));
      return RefferalListModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  getUserDataApicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user_id");
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userId;

      final response = await client.post(Uri.parse("${baseUrl()}/user_data"),
          headers: headers, body: map);
      print("sddddddd ${map} sdsd ${baseUrl()}/user_data");
      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      print(dic);
      model = GetUserModel.fromJson(userMap);

      setState(() {
        referralCode = model!.user!.refferalCode;
      });
      print("this is referral $referralCode");
    } on Exception {
      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
    }
  }
  // void checkingLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     uid = prefs.getString(TokenString.userid).toString();
  //     type = prefs.getString(TokenString.type).toString();
  //     wallet = prefs.getString(TokenString.walletBalance).toString();
  //     referralCode = prefs.getString(TokenString.referralCode).toString();
  //   });
  //   print("this id uid ${uid.toString()} aand ${type}");
  // }

  @override
  void initState() {
    super.initState();
    // checkingLogin();
    getRefferal('level 1');
    getUserDataApicall();
    // Future.delayed(Duration(milliseconds: 500), () {
    //   return getprofile();
    // });
  }

  // GetProfileModel? profileModel;
  int _selectedIndex = 0;
  String selectedLevel = "level 1";

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Referral Code',
        text: 'Share Referral Code',
        linkUrl: '${referralCode.toString()}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        backgroundColor: colors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text("Referral"),
        // actions: [
        //   InkWell(
        //     onTap: (){
        //       // Navigator.push(context, MaterialPageRoute(builder: (context)=> Wallet()));
        //     },
        //     child:  Padding(
        //       padding: const EdgeInsets.only(right: 10.0),
        //       child: Row(
        //         children: [
        //           Icon(
        //             Icons.account_balance_wallet_outlined,
        //             color: Colors.white,
        //             size: 24,
        //           ),
        //
        //           const SizedBox(width: 5,),
        //           Text(
        //             wallet == null || wallet == ""?
        //             " ₹ 0"
        //                 :  "₹ ${wallet.toString()}",
        //
        //             /*textScaleFactor: 1.3,*/
        //             style: TextStyle(
        //                 fontWeight: FontWeight.w500,
        //                 color: Colors.white
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Container(
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      )),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: InkWell(
                            onTap: () async{
                              share();
                            },
                            child: Card(
                              elevation: 4,
                              child: Container(
                                padding: EdgeInsets.only(left: 15),
                                height: 45,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          //AppColor().colorTextGray(),
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 2,
                                          spreadRadius: 1.0)
                                    ],
                                    // border: Border.all(color: _selectedIndex == 0 ? Colors.amber : AppColor().colorPrimary()),
                                    // color: _selectedIndex == 0
                                    //     ? Colors.amber
                                    //     : Colors.white,
                                    // _selectedIndex == Colors.cyan
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Your Referral Code - ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                    // _selectedIndex == 0 ?
                                                    colors.blackTemp
                                                        // : colors.blackTemp
                                                )),
                                            Text(
                                                referralCode == null || referralCode == '' ?
                                                    ""
                                                : "$referralCode",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                    // _selectedIndex == 0 ?
                                                    colors.primary
                                                  // : colors.blackTemp
                                                )),
                                          ],
                                        ),
                                        Icon(
                                          Icons.exit_to_app,
                                          color: colors.primary,
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8, top: 25, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async{
                                    setState(() {
                                      _selectedIndex = 0;
                                       selectedLevel = "level 1";
                                    });
                                    getRefferal('level 1');
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
                                        border: Border.all(color: _selectedIndex == 0 ? Colors.amber : colors.primary),
                                        color: _selectedIndex == 0
                                            ? Colors.amber
                                            : Colors.white,
                                        // _selectedIndex == Colors.cyan
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text("Level 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: _selectedIndex == 0
                                                    ? colors.primary
                                                    : colors.blackTemp))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async{
                                    setState(() {
                                      _selectedIndex = 1;
                                      selectedLevel = "level 2";
                                    });
                                    getRefferal('level 2');

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
                                        border: Border.all(color: _selectedIndex == 1 ? Colors.amber : colors.primary),
                                        color: _selectedIndex == 1
                                            ? Colors.amber
                                            : Colors.white,
                                        // _selectedIndex == Colors.cyan
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text("Level 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: _selectedIndex == 1
                                                    ? colors.primary
                                                    : colors.blackTemp))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                            future: getRefferal(selectedLevel),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              RefferalListModel? model = snapshot.data;
                              // print("this is moddel ==========>>>>> ${model!.products![0].productPrice.toString()}");
                              if (snapshot.hasData) {
                                return model!.status == true
                                    ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child:
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: model.data!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15)),
                                            child: Container(
                                              padding:
                                              const EdgeInsets.all(10),
                                              // only(left: 85, right: 20),
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: colors.primary),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15)),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                            height: 50,
                                                            child: Image.asset('assets/images/refer.png'),
                                                          decoration: BoxDecoration(
                                                            color: colors.primary,
                                                            shape: BoxShape.circle,

                                                          ),
                                                        ),
                                                        ///Image
                                                        /*Container(
                                                          height: 60,
                                                          width: 60,
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10),
                                                            child: Image
                                                                .network(
                                                              "${model.products![index].profileImage.toString()}",
                                                              fit: BoxFit
                                                                  .fill,
                                                            ),
                                                          ),
                                                        ),*/
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text("${model.data![index].username.toString()}",
                                                                style:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                  14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                              SizedBox(height: 7,),
                                                              Container(
                                                                width: 140,
                                                                child: Text(
                                                                  "${model.data![index].updatedAt.toString()}",
                                                                  maxLines: 3,
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    color: colors.subTxtClr,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Container(
                                                                width: 140,
                                                                child: Text(
                                                                  "₹ ${model.data![index].amount.toString()}",

                                                                  maxLines: 3,
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Text("",),
                                                        //       //"${model.products![index].revStars.toString()}",),
                                                        //     const SizedBox(width: 5,),
                                                        //     // ListView.builder(
                                                        //     //   shrinkWrap: true,
                                                        //     //   scrollDirection: Axis.horizontal,
                                                        //     //   itemBuilder: (context, index){
                                                        //     //     return Icon(Icons.star,
                                                        //     //       color: AppColor().colorSecondary(),
                                                        //     //       size: 16,);
                                                        //     //   },
                                                        //     //   itemCount:
                                                        //     //   model.products![index].revStars.toString() == "1.0"?
                                                        //     //   1 :
                                                        //     //   model.products![index].revStars.toString() == "2.0"?
                                                        //     //   2 :
                                                        //     //   model.products![index].revStars.toString() == "3.0"?
                                                        //     //   3 :
                                                        //     //   model.products![index].revStars.toString() == "4.0"?
                                                        //     //   4 : 5
                                                        //     //   ,
                                                        //     // ),
                                                        //   ],
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                  Text("₹ ${model.data![index].amount.toString()}",
                                                  style: TextStyle(
                                                    fontSize: 26
                                                  ),)

                                                  // Row(
                                                  //   children: [
                                                  //     Card(
                                                  //       elevation: 2,
                                                  //       child: InkWell(
                                                  //           onTap: () {
                                                  //             // Navigator.push(
                                                  //             //     context,
                                                  //             //     MaterialPageRoute(
                                                  //             //         builder: (context) => EditProducts(
                                                  //             //           productsModel: model.products![index],
                                                  //             //         )));
                                                  //           },
                                                  //           child: Icon(
                                                  //             Icons.edit,
                                                  //             color: AppColor
                                                  //                 .PrimaryDark,
                                                  //           )),
                                                  //     ),
                                                  //     SizedBox(
                                                  //       width: 6,
                                                  //     ),
                                                  //     InkWell(
                                                  //       onTap: () {
                                                  //         deleteProduct(model
                                                  //             .products![
                                                  //         index]
                                                  //             .productId
                                                  //             .toString());
                                                  //       },
                                                  //       child: Card(
                                                  //         elevation: 2,
                                                  //         child: Icon(
                                                  //           Icons
                                                  //               .delete_forever_rounded,
                                                  //           color:
                                                  //           Colors.red,
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),

                                                  // Container(
                                                  //   height: 25,
                                                  //   width: 80,
                                                  //   decoration: BoxDecoration(
                                                  //       color: colors.primary,
                                                  //       borderRadius: BorderRadius.circular(30)),
                                                  //   child: const Center(
                                                  //     child: Text(
                                                  //       "View",
                                                  //       style: TextStyle(color: Colors.white),
                                                  //     ),
                                                  //   ),
                                                  // )
                                                  // AppBtn(
                                                  //   title: "View",
                                                  //   onPress: (){
                                                  //
                                                  //   },
                                                  //   height: 15,
                                                  //   width: 70,
                                                  //   fSize: 14,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                        //cardWidget(model, i
                                      }),
                                )
                                    : Container(
                                  height:
                                  MediaQuery.of(context).size.height / 1.5,
                                  child: Center(
                                      child: Text("No Referral Found!!")),
                                );
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error_outline);
                              } else {
                                return Container(
                                    height: 30,
                                    width: 30,
                                    // MediaQuery.of(context).size.height / 1.5,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                          color: colors.primary,
                                        )));
                              }
                            })

                      ],
                    )
                  )),
            ),
          ],
        ),
      ),
    );
  }

  var bankDetails;


}
