import 'package:ez/constant/global.dart';
import 'package:flutter/material.dart';

class PrivancyPolicy extends StatefulWidget {
  const PrivancyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivancyPolicy> createState() => _PrivancyPolicyState();
}

class _PrivancyPolicyState extends State<PrivancyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: backgroundblack,
        appBar: AppBar(
          backgroundColor: backgroundblack,
          elevation: 0,
          centerTitle: true,
          title: Text("Privacy Policy"),
          // actions: [
          //   InkWell(
          //     onTap: (){
          //       // Navigator.push(context, MaterialPageRoute(builder: (context)=> Wallet()));
          //     },
          //   ),
          // ],
        ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: appColorOrange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
          ),
          child: Container(
            // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: appColorOrange,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )
              ),
              child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, right: 20),
                  // child: Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 15.0),
                  //       child: InkWell(
                  //         onTap: () async{
                  //           share();
                  //         },
                  //         child: Card(
                  //           elevation: 4,
                  //           child: Container(
                  //             padding: EdgeInsets.only(left: 15),
                  //             height: 45,
                  //             decoration: BoxDecoration(
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                       color: Colors.white,
                  //                       //AppColor().colorTextGray(),
                  //                       offset: Offset(1.0, 1.0),
                  //                       blurRadius: 2,
                  //                       spreadRadius: 1.0)
                  //                 ],
                  //                 // border: Border.all(color: _selectedIndex == 0 ? Colors.amber : AppColor().colorPrimary()),
                  //                 // color: _selectedIndex == 0
                  //                 //     ? Colors.amber
                  //                 //     : Colors.white,
                  //                 // _selectedIndex == Colors.cyan
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             child: Center(
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         Text("Your Referral Code - ",
                  //                             style: TextStyle(
                  //                                 fontWeight: FontWeight.w600,
                  //                                 color:
                  //                                 // _selectedIndex == 0 ?
                  //                                 colors.blackTemp
                  //                               // : colors.blackTemp
                  //                             )),
                  //                         Text("$referralCode",
                  //                             style: TextStyle(
                  //                                 fontWeight: FontWeight.w600,
                  //                                 color:
                  //                                 // _selectedIndex == 0 ?
                  //                                 colors.primary
                  //                               // : colors.blackTemp
                  //                             )),
                  //                       ],
                  //                     ),
                  //                     Icon(
                  //                       Icons.exit_to_app,
                  //                       color: AppColor.PrimaryDark,
                  //                     )
                  //                   ],
                  //                 )),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.only(left: 8.0, right: 8, top: 25, bottom: 15),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Expanded(
                  //             child: InkWell(
                  //               onTap: () async{
                  //                 setState(() {
                  //                   _selectedIndex = 0;
                  //                 });
                  //                 // if(type =="1"){
                  //                 //   await  getFoodOrders();
                  //                 // }
                  //                 // else if(type =="2" || type =="3" ||type =="4"){
                  //                 //
                  //                 //   await getDeliveryBooking();
                  //                 // }else {
                  //                 //   await getVendorBooking();
                  //                 // }
                  //               },
                  //               child: Container(
                  //                 height: 30,
                  //                 decoration: BoxDecoration(
                  //                     boxShadow: [
                  //                       BoxShadow(
                  //                           color: Colors.grey,
                  //                           //AppColor().colorTextGray(),
                  //                           offset: Offset(1.0, 1.0),
                  //                           blurRadius: 2,
                  //                           spreadRadius: 1.0)
                  //                     ],
                  //                     border: Border.all(color: _selectedIndex == 0 ? Colors.amber : AppColor().colorPrimary()),
                  //                     color: _selectedIndex == 0
                  //                         ? Colors.amber
                  //                         : Colors.white,
                  //                     // _selectedIndex == Colors.cyan
                  //                     borderRadius: BorderRadius.circular(10)),
                  //                 child: Center(
                  //                     child: Text("Level 1",
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w600,
                  //                             color: _selectedIndex == 0
                  //                                 ? colors.primary
                  //                                 : colors.blackTemp))),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 15,
                  //           ),
                  //           Expanded(
                  //             child: InkWell(
                  //               onTap: () async{
                  //                 setState(() {
                  //                   _selectedIndex = 1;
                  //                 });
                  //                 // if(type =="1"){
                  //                 //   await  getFoodOrders();
                  //                 // }
                  //                 // else if(type =="2" || type =="3" ||type =="4"){
                  //                 //
                  //                 //   await getDeliveryBooking();
                  //                 // }else {
                  //                 //   await getVendorBooking();
                  //                 // }
                  //               },
                  //               child: Container(
                  //                 height: 30,
                  //                 decoration: BoxDecoration(
                  //                     boxShadow: [
                  //                       BoxShadow(
                  //                           color: Colors.grey,
                  //                           //AppColor().colorTextGray(),
                  //                           offset: Offset(1.0, 1.0),
                  //                           blurRadius: 2,
                  //                           spreadRadius: 1.0)
                  //                     ],
                  //                     border: Border.all(color: _selectedIndex == 1 ? Colors.amber : AppColor().colorPrimary()),
                  //                     color: _selectedIndex == 1
                  //                         ? Colors.amber
                  //                         : Colors.white,
                  //                     // _selectedIndex == Colors.cyan
                  //                     borderRadius: BorderRadius.circular(10)),
                  //                 child: Center(
                  //                     child: Text("Level 2",
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w600,
                  //                             color: _selectedIndex == 1
                  //                                 ? colors.primary
                  //                                 : colors.blackTemp))),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     // FutureBuilder(
                  //     //     future: getCustomerReviews(),
                  //     //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //     //       CustomerReviewsModel? model = snapshot.data;
                  //     //       // print("this is moddel ==========>>>>> ${model!.products![0].productPrice.toString()}");
                  //     //       if (snapshot.hasData) {
                  //     //         return model!.status == "0"
                  //     //             ? Container(
                  //     //           decoration: BoxDecoration(
                  //     //               borderRadius: BorderRadius.circular(20)),
                  //     //           child:
                  //     ListView.builder(
                  //         shrinkWrap: true,
                  //         physics: ScrollPhysics(),
                  //         itemCount: 8,
                  //         //model.products!.length,
                  //         itemBuilder: (context, index) {
                  //           return Padding(
                  //             padding: const EdgeInsets.only(
                  //                 left: 15,
                  //                 right: 15,
                  //                 bottom: 10.0),
                  //             child: Card(
                  //               elevation: 0,
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius:
                  //                   BorderRadius.circular(
                  //                       15)),
                  //               child: Container(
                  //                 padding:
                  //                 const EdgeInsets.all(10),
                  //                 // only(left: 85, right: 20),
                  //                 height: 90,
                  //                 width: MediaQuery.of(context)
                  //                     .size
                  //                     .width,
                  //                 decoration: BoxDecoration(
                  //                     border: Border.all(color: AppColor().colorPrimary()),
                  //                     borderRadius:
                  //                     BorderRadius.circular(
                  //                         15)),
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                   MainAxisAlignment
                  //                       .start,
                  //                   crossAxisAlignment:
                  //                   CrossAxisAlignment.center,
                  //                   children: [
                  //                     Container(
                  //                       child: Row(
                  //                         mainAxisAlignment:
                  //                         MainAxisAlignment
                  //                             .spaceBetween,
                  //                         crossAxisAlignment:
                  //                         CrossAxisAlignment.center,
                  //                         children: [
                  //                           Container(
                  //                             width: 50,
                  //                             height: 50,
                  //                             child: Image.asset('images/refer.png'),
                  //                             decoration: BoxDecoration(
                  //                               color: AppColor.PrimaryDark,
                  //                               shape: BoxShape.circle,
                  //
                  //                             ),
                  //                           ),
                  //                           ///Image
                  //                           /*Container(
                  //                                           height: 60,
                  //                                           width: 60,
                  //                                           decoration:
                  //                                           BoxDecoration(
                  //                                             borderRadius:
                  //                                             BorderRadius
                  //                                                 .circular(
                  //                                                 10),
                  //                                           ),
                  //                                           child: ClipRRect(
                  //                                             borderRadius:
                  //                                             BorderRadius
                  //                                                 .circular(
                  //                                                 10),
                  //                                             child: Image
                  //                                                 .network(
                  //                                               "${model.products![index].profileImage.toString()}",
                  //                                               fit: BoxFit
                  //                                                   .fill,
                  //                                             ),
                  //                                           ),
                  //                                         ),*/
                  //                           SizedBox(
                  //                             width: 10,
                  //                           ),
                  //                           Padding(
                  //                             padding: const EdgeInsets.only(top: 10.0),
                  //                             child: Column(
                  //                               crossAxisAlignment:
                  //                               CrossAxisAlignment
                  //                                   .start,
                  //                               mainAxisAlignment:
                  //                               MainAxisAlignment
                  //                                   .center,
                  //                               children: [
                  //                                 Text("Anuj Bhagora",
                  //                                   //"${model.products![index].username.toString()}",
                  //                                   style:
                  //                                   TextStyle(
                  //                                     color: Colors
                  //                                         .black,
                  //                                     fontSize:
                  //                                     14,
                  //                                     fontWeight:
                  //                                     FontWeight
                  //                                         .bold,
                  //                                   ),
                  //                                 ),
                  //                                 SizedBox(height: 7,),
                  //                                 Container(
                  //                                   width: 140,
                  //                                   child: Text(
                  //                                     "05 Jan 2023",
                  //                                     // "${model.products![index].productName.toString()}",
                  //                                     maxLines: 3,
                  //                                     style: TextStyle(
                  //                                       fontSize: 14,
                  //                                       color: colors.subTxtClr,
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                                 SizedBox(
                  //                                     height: 5),
                  //                                 Container(
                  //                                   width: 140,
                  //                                   child: Text(
                  //                                     "",
                  //                                     // "${model.products![index].revText.toString()}",
                  //                                     maxLines: 3,
                  //                                     style: TextStyle(
                  //                                       fontSize: 12,
                  //                                       color: Colors.black,
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //
                  //                               ],
                  //                             ),
                  //                           ),
                  //                           // Row(
                  //                           //   children: [
                  //                           //     Text("",),
                  //                           //       //"${model.products![index].revStars.toString()}",),
                  //                           //     const SizedBox(width: 5,),
                  //                           //     // ListView.builder(
                  //                           //     //   shrinkWrap: true,
                  //                           //     //   scrollDirection: Axis.horizontal,
                  //                           //     //   itemBuilder: (context, index){
                  //                           //     //     return Icon(Icons.star,
                  //                           //     //       color: AppColor().colorSecondary(),
                  //                           //     //       size: 16,);
                  //                           //     //   },
                  //                           //     //   itemCount:
                  //                           //     //   model.products![index].revStars.toString() == "1.0"?
                  //                           //     //   1 :
                  //                           //     //   model.products![index].revStars.toString() == "2.0"?
                  //                           //     //   2 :
                  //                           //     //   model.products![index].revStars.toString() == "3.0"?
                  //                           //     //   3 :
                  //                           //     //   model.products![index].revStars.toString() == "4.0"?
                  //                           //     //   4 : 5
                  //                           //     //   ,
                  //                           //     // ),
                  //                           //   ],
                  //                           // )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     Text("₹ 50",
                  //                       style: TextStyle(
                  //                           fontSize: 26
                  //                       ),)
                  //
                  //                     // Row(
                  //                     //   children: [
                  //                     //     Card(
                  //                     //       elevation: 2,
                  //                     //       child: InkWell(
                  //                     //           onTap: () {
                  //                     //             // Navigator.push(
                  //                     //             //     context,
                  //                     //             //     MaterialPageRoute(
                  //                     //             //         builder: (context) => EditProducts(
                  //                     //             //           productsModel: model.products![index],
                  //                     //             //         )));
                  //                     //           },
                  //                     //           child: Icon(
                  //                     //             Icons.edit,
                  //                     //             color: AppColor
                  //                     //                 .PrimaryDark,
                  //                     //           )),
                  //                     //     ),
                  //                     //     SizedBox(
                  //                     //       width: 6,
                  //                     //     ),
                  //                     //     InkWell(
                  //                     //       onTap: () {
                  //                     //         deleteProduct(model
                  //                     //             .products![
                  //                     //         index]
                  //                     //             .productId
                  //                     //             .toString());
                  //                     //       },
                  //                     //       child: Card(
                  //                     //         elevation: 2,
                  //                     //         child: Icon(
                  //                     //           Icons
                  //                     //               .delete_forever_rounded,
                  //                     //           color:
                  //                     //           Colors.red,
                  //                     //         ),
                  //                     //       ),
                  //                     //     ),
                  //                     //   ],
                  //                     // ),
                  //
                  //                     // Container(
                  //                     //   height: 25,
                  //                     //   width: 80,
                  //                     //   decoration: BoxDecoration(
                  //                     //       color: AppColor.PrimaryDark,
                  //                     //       borderRadius: BorderRadius.circular(30)),
                  //                     //   child: const Center(
                  //                     //     child: Text(
                  //                     //       "View",
                  //                     //       style: TextStyle(color: Colors.white),
                  //                     //     ),
                  //                     //   ),
                  //                     // )
                  //                     // AppBtn(
                  //                     //   title: "View",
                  //                     //   onPress: (){
                  //                     //
                  //                     //   },
                  //                     //   height: 15,
                  //                     //   width: 70,
                  //                     //   fSize: 14,
                  //                     // )
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           );
                  //           //cardWidget(model, i
                  //         }),
                  //     //     )
                  //     //         : Container(
                  //     //       height:
                  //     //       MediaQuery.of(context).size.height / 1.5,
                  //     //       child: Center(
                  //     //           child: Text("No Reviews Found!!")),
                  //     //     );
                  //     //   } else if (snapshot.hasError) {
                  //     //     return Icon(Icons.error_outline);
                  //     //   } else {
                  //     //     return Container(
                  //     //         height: 30,
                  //     //         width: 30,
                  //     //         // MediaQuery.of(context).size.height / 1.5,
                  //     //         child: Center(
                  //     //             child: CircularProgressIndicator(
                  //     //               color: AppColor.PrimaryDark,
                  //     //             )));
                  //     //   }
                  //     // })
                  //
                  //   ],
                  // )
              )),
        ),
      ),
    );
  }
}
