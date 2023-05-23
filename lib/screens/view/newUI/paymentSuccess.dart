import 'package:flutter/material.dart';

import '../../../constant/global.dart';

class PaymentScreen extends StatefulWidget {
  final bool? home;
  const PaymentScreen({Key? key, this.home}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var selectedPayment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundblack,
        title: Text("Payment", style: TextStyle(color: backgroundgrey, fontWeight: FontWeight.w500, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top:0),
          child : Column(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height/45,
                // // height: MediaQuery.of(context).size.height-85.0-75,
                // width: MediaQuery.of(context).size.width,
                // decoration: const BoxDecoration(
                //     color: appColorOrange,
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(45),
                //       topRight: Radius.circular(45),
                //     ),
                // ),
                // child: Padding(
                //   padding: const EdgeInsets.only(top:70, left: 30.0, right: 30),
                //   child: SingleChildScrollView(
                //     child: Text("khjjhj"),
                //   ),
                // ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  Navigator.pop(context, 'Cash On Delivery');
                },
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white, border: Border.all(color: backgroundblack)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Image.asset("assets/images/cash.png"),
                    ),
                    Text("Cash Payment", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                    IconButton(
                        onPressed: () {
                    }, icon: Icon(Icons.arrow_forward_ios, color: backgroundblack)),
                  ],
                  ),
                ),
              ),
              // SizedBox(height: 20,),
              // Container(
              //   height: 90,
              //   width: MediaQuery.of(context).size.width/1.2,
              //   decoration:
              //   BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white, border: Border.all(color: backgroundblack)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(left: 10),
              //         child: Image.asset("assets/images/onlinepayment.png"),
              //       ),
              //       Text("Online Payment", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
              //       IconButton(onPressed: () {
              //         Navigator.pop(context);
              //       }, icon: Icon(Icons.arrow_forward_ios, color: backgroundblack,)),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20,),
              // Container(
              //   height: 90,
              //   width: MediaQuery.of(context).size.width/1.2,
              //   decoration:
              //   BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white, border: Border.all(color: backgroundblack)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(left: 10),
              //         child: Image.asset("assets/images/wallet.png"),
              //       ),
              //       Text("Wallet", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
              //       IconButton(onPressed: () {
              //         Navigator.pop(context);
              //       }, icon: Icon(Icons.arrow_forward_ios, color: backgroundblack,)),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
