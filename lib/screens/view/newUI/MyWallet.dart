import 'dart:convert';

import 'package:ez/screens/view/models/getUserModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../constant/global.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController amtC = TextEditingController();
  TextEditingController msgC = TextEditingController();
  Razorpay _razorpay = Razorpay();

    @override
    void initState(){
      super.initState();
      // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      Future.delayed(Duration(milliseconds: 500),(){
        return getUserDataApicall();
      });
    }

    GetUserModel? model;
    String? walletAmount;

  getUserDataApicall() async {
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userID;

      final response = await client.post(Uri.parse("${baseUrl()}/user_data"),
          headers: headers, body: map);
      print("sddddddd ${map} sdsd ${baseUrl()}/user_data");
      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      model = GetUserModel.fromJson(userMap);

      userEmail = model!.user!.email!;
      userMobile = model!.user!.mobile!;
      userName = model!.user!.username!;
      userPic = model!.user!.profilePic!;
      print("Get User Data Model Here ${model}");
      // walletAmount = model!.user!.wallet.toString();
      // print("wallet balance here ${walletAmount}");
      // _username.text = model!.user!.username!;
      // _mobile.text = model!.user!.mobile!;
      // _address.text = model!.user!.address!;
      print("GetUserData>>>>>>");
      print(dic);
        setState(() {
        });
    } on Exception {
      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
    }
  }


  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // var userId = await MyToken.getUserID();
      Fluttertoast.showToast(msg:"Payment Successful");
    //purchasePlan("$userId", planI,"${response.paymentId}");

      addMoneyToWallet();
      //addWalletMoney(response.paymentId);

    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("FAILURE === ${response.message}");
    // UtilityHlepar.getToast("${response.message}");
  Fluttertoast.showToast(msg: "Payment Failed");
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  checkOut() {
    int amount  = int.parse(amtC.text.toString()) * 100;
    var options = {
      'key': "rzp_test_CpvP0qcfS4CSJD",
      'amount': amount,
      'currency': 'INR',
      'name': 'Antsnest',
      'description': '',
      // 'prefill': {'contact': userMobile, 'email': userEmail},
    };
    print("OPTIONS ===== $options");
    _razorpay.open(options);
  }

  addMoneyToWallet()async{
    var headers = {
      'Cookie': 'ci_session=6529f44b19772c7e68705f973c1e1fb967bf6aba'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}update_wallet_amount'));
    request.fields.addAll({
      'user_id': '${userID}',
      'total': amtC.text,
      'txn_id': 'ADDTOWALLET'
    });
    print("Add wallet paraa ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =  json.decode(finalResult);
      print("checking final result ${jsonResponse}");
      setState(() {
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
        getUserDataApicall();
        amtC.clear();
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }


  _showDialog() async {
    bool payWarn = false;
    await showDialog(context: context, builder: (context){
      return  AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                child: Text("Add Money",
                  // getTranslated(context, 'ADD_MONEY')!,
                  style: Theme.of(this.context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: backgroundblack),
                  //  Theme.of(context).colorScheme.fontColor),
                ),
              ),
              Divider(),
              Form(
                key: _formKey,
                child: Flexible(
                  child: SingleChildScrollView(
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (val){
                                    if(val!.isEmpty){
                                      return "Enter amount";
                                    }
                                  },
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Amount",
                                    // getTranslated(context, "AMOUNT"),
                                    hintStyle: Theme.of(this.context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(

                                        fontWeight: FontWeight.normal),
                                  ),
                                  controller: amtC,
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  style: TextStyle(
                                    color:Colors.black,
                                  ),
                                  decoration: new InputDecoration(
                                    hintText: "Message",
                                    //(context, 'MSG'),
                                    hintStyle: Theme.of(this.context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                        color: Colors.black,
                                        // Theme.of(context)
                                        //     .colorScheme
                                        //     .lightBlack,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  controller: msgC,
                                )),
                            //Divider(),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                            //   child: Text("Select Payment Method",
                            //     //getTranslated(context, 'SELECT_PAYMENT')!,
                            //     style: Theme.of(context).textTheme.subtitle2,
                            //   ),
                            // ),
                            Divider(),
                            payWarn
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
                              child: Text("Please Select Payment Method..!!",
                                //  getTranslated(context, 'payWarning')!,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.red),
                              ),
                            )
                                : Container(),
                            // paypal == null
                            //     ? Center(child: CircularProgressIndicator())
                            //     : Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: getPayList()),
                          ]
                      ),
                  ),
                ),
              )
            ]),
        actions: <Widget>[
          new ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: backgroundblack
              ),
              child: Text("Cancel",
                // getTranslated(context, 'CANCEL')!,
                style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                  // color: AppColor().colorTextSecondary(),
                  // Theme.of(context).colorScheme.lightBlack,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // amtC.clear();
                msgC.clear();
                Navigator.pop(context);
              }),
          new ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: backgroundblack
              ),
              child: Text("Send",
                // getTranslated(context, 'SEND')!,
                style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                    color: Colors.black,
                    //Theme.of(context).colorScheme.fontColor,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                final form = _formKey.currentState!;
                if (form.validate() && amtC.text != '0') {
                  form.save();
                  print("purchase Plan");
                  // print("purchase Plan2 ==== $price");
                  // price = int.parse(item.price.toString()) * 100;
                  checkOut();
                  // amtC.clear();
                  msgC.clear();
                  // if (payMethod == null) {
                  //   dialogState!(() {
                  //     payWarn = true;
                  //   });
                  // } else {
                  //   if (payMethod!.trim() ==
                  //       getTranslated(context, 'STRIPE_LBL')!.trim()) {
                  //     stripePayment(int.parse(amtC.text));
                  //   } else if (payMethod!.trim() ==
                  //       getTranslated(context, 'RAZORPAY_LBL')!.trim())
                  //     razorpayPayment(double.parse(amtC.text));
                  //   else if (payMethod!.trim() ==
                  //       "Pay Now"){
                  //     CashFreeHelper cashFreeHelper = new CashFreeHelper(amtC.text.toString(), context, (result){
                  //       print(result['txMsg']);
                  //       // setSnackbar(result['txMsg'], _checkscaffoldKey);
                  //       if(result['txStatus']=="SUCCESS"){
                  //         sendRequest(result['signature'], "CashFree");
                  //       }else{
                  //         setSnackbar1("Transaction cancelled and failed",context );
                  //       }
                  //       //placeOrder(result.paymentId);
                  //     });
                  //
                  //     cashFreeHelper.init();
                  //   }
                  //   else if (payMethod!.trim() ==
                  //       getTranslated(context, 'PAYSTACK_LBL')!.trim())
                  //     paystackPayment(context, int.parse(amtC.text));
                  //   else if (payMethod == getTranslated(context, 'PAYTM_LBL'))
                  //     paytmPayment(double.parse(amtC.text));
                  //   else if (payMethod ==
                  //       getTranslated(context, 'PAYPAL_LBL')) {
                  //     paypalPayment((amtC.text).toString());
                  //   } else if (payMethod ==
                  //       getTranslated(context, 'FLUTTERWAVE_LBL'))
                  //     flutterwavePayment(amtC.text);
                  Navigator.pop(context);
                }
              }
            // }
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: backgroundblack,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            )
        ),
        elevation: 0,
        title: Text(
          'My Wallet',
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.all(12),
          child: RawMaterialButton(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(0),
            fillColor: Colors.white,
            splashColor: Colors.grey[400],
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: appColorBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              // color: Theme.of(context).colorScheme.fontColor,
                            ),
                            Text(
                              "Current Balance ",
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: walletAmount == null || walletAmount == "" ? Text(
                            "₹ 0.0",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ) : Text(
                            "₹ ${walletAmount}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top:15, bottom: 15),
                            child: InkWell(
                              onTap: () {
                                Fluttertoast.showToast(msg: "Coming Soon....");
                                // _showDialog();
                                // print("okkkkkkkkkkkkk");
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: backgroundblack
                                ),
                                child: Text("Add Money",style: TextStyle(color: Colors.white),),
                              ),
                            )),
                        // Container(
                        //     margin: EdgeInsets.only(top:15, bottom: 15),
                        //     child: InkWell(
                        //       onTap: () {
                        //         _showDialog1();
                        //       },
                        //       child: UtilityWidget.lodingButton(
                        //           buttonLogin: buttonLogin, btntext: 'Withdrawal Money'),
                        //     )),
                      ],
                    ),
                  ),
                ),
              ),
              // FutureBuilder<WalletHistory>(
              //     future: getWalletHistory(),
              //     builder: (context, snapshot){
              //       if(snapshot.hasData){
              //         return Container(
              //           height: 400,
              //           child: ListView.builder(
              //               itemCount: walletHistory.length,
              //               itemBuilder: (context, index){
              //                 return Card(
              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             Container(
              //                               width: 60,
              //                               height: 60,
              //                               color: Colors.white,
              //                               child: ClipRRect(
              //                                   borderRadius:
              //                                   BorderRadius.circular(10.0),
              //                                   child:
              //                                   Image.asset(
              //                                     "images/wallet_icon.png",
              //                                     fit: BoxFit.cover,
              //                                     width: 100,
              //                                     height: 200,)
              //                               ),
              //                             ),
              //                             Column(
              //                               crossAxisAlignment: CrossAxisAlignment.start,
              //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                               children: [
              //
              //                                 Text(
              //                                   "Amount added",
              //                                   //  ['amount'].toString(),
              //                                   style: TextStyle(
              //                                     color: Colors.green,
              //                                     fontSize: 15,
              //                                     fontWeight: FontWeight.w500,
              //
              //                                   ),
              //                                 ),
              //                                 Text(
              //                                   walletHistory[index].createdAt.toString(),
              //                                   //  ['amount'].toString(),
              //                                   style: TextStyle(
              //                                     color: AppColor().colorTextPrimary(),
              //                                     fontSize: 13,
              //                                     fontWeight: FontWeight.w500,
              //
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ],
              //                         ),
              //                         Text(
              //                           "₹ " + walletHistory[index].amount.toString(),
              //                           //  ['amount'].toString(),
              //                           style: TextStyle(
              //                             color: AppColor().colorPrimary(),
              //                             fontSize: 18,
              //                             fontWeight: FontWeight.w600,
              //
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 );
              //               }),
              //         );
              //       }
              //       return Container(child: Center(child: Image.asset("images/icons/loader.gif"),),);
              //     }
              //
              // )
            ]),
      ),
    );
  }
}
