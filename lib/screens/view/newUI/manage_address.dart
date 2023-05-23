import 'dart:convert';

import 'package:ez/screens/view/models/add_address_model.dart';
import 'package:ez/screens/view/models/address_model.dart';
import 'package:ez/screens/view/newUI/checkoutService.dart';
import 'package:ez/screens/view/newUI/detail.dart';
import 'package:ez/screens/view/newUI/edit_address.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/global.dart';
import '../../../constant/sizeconfig.dart';
import 'add_address.dart';

class ManageAddress extends StatefulWidget {
  final resid;
 final String? aId;
  final bool? home;
  const ManageAddress({Key? key, this.resid,this.aId, this.home}) : super(key: key);

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  late List<bool> _isChecked;
  int addList = 0;
  var isSelected;
  String checkId = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        backgroundColor: appColorWhite,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(20),
        //         bottomRight: Radius.circular(20)
        //     )
        // ),
        elevation: 0,
        title: Text(
          'Manage Address',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.all(12),
          child: RawMaterialButton(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(0),
            fillColor: appColorOrange,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundblack,
        child: Icon(Icons.add),
        onPressed: ()async{
      var result =  await Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress()));
      setState(() {
        getAddress();
      });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: getAddress(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  AddressModel addModel = snapshot.data;
                  if (snapshot.hasData) {
                    return addModel.data!.isEmpty ?  Container(
                      height: MediaQuery.of(context).size.height/1,
                      child: Center(child: Text("No Address Added",style: TextStyle(color: appColorBlack,fontSize: 16,fontWeight: FontWeight.w600),),),) : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: addModel.data!.length,
                      itemBuilder: (context, index){
                        // List<bool> isChecked = List.generate(addModel.data!.length, (index) => false);
                        return Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top:10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: addModel.data![index].id == widget.aId ? backgroundblack : Colors.transparent,width: 1.5),
                            ),
                            child: Card(
                              elevation: 8,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap:() {
                                        // setState(() {
                                        //   isSelected = addModel.data![index].id;
                                        //   checkId = addModel.data![index].id.toString();
                                        // });
                                        // print("checking selected address here ${isSelected}");
                                        Navigator.pop(context,
                                            [addModel.data![index].address, addModel.data![index].lat,addModel.data![index].lng]);
                                        // Navigator.pushReplacement(context,
                                        //     MaterialPageRoute(builder: (context) => DetailScreen(resId: widget.resid,)), result: addModel.data![index].id);
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Text("${addModel.data![index].name}"),
                                          // Text("${addModel.data![index].altMobile}"),
                                          Container(
                                            width: 220,
                                            child: Text("${addModel.data![index].address}",
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: 2),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     TextButton.icon(
                                    //       onPressed: (){
                                    //         Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddress(
                                    //           name: addModel.data![index].name,
                                    //           mobile: addModel.data![index].altMobile,
                                    //           address: addModel.data![index].address,
                                    //           city: addModel.data![index].city,
                                    //           state: addModel.data![index].state,
                                    //           country: addModel.data![index].country,
                                    //           pincode: addModel.data![index].pincode,
                                    //           building: addModel.data![index].building,
                                    //           isSet: addModel.data![index].isSetFor,
                                    //            phoneCode: addModel.data![index].countryCode,
                                    //           addId: addModel.data![index].id,
                                    //         )));
                                    //       },
                                    //       label: Text("Edit Address"),
                                    //       icon: Icon(Icons.edit_note_outlined),
                                    //       style: TextButton.styleFrom(
                                    //         primary: backgroundblack
                                    //       ),
                                    //     ),
                                    //     TextButton.icon(
                                    //       onPressed: () async {
                                    //         AddAddressModel? delete = await deleteAddress(addModel.data![index].id);
                                    //         if(delete!.responseCode == "1"){
                                    //           Fluttertoast.showToast(
                                    //               msg: "Address Deleted Successfully!",
                                    //               toastLength: Toast.LENGTH_LONG,
                                    //               gravity: ToastGravity.BOTTOM,
                                    //               timeInSecForIosWeb: 1,
                                    //               backgroundColor: backgroundblack,
                                    //               textColor: appColorWhite,
                                    //               fontSize: 13.0);
                                    //           setState(() {
                                    //             getAddress();
                                    //           });
                                    //         }
                                    //       },
                                    //       label: Text("Delete"),
                                    //       icon: Icon(Icons.delete_rounded),
                                    //       style: TextButton.styleFrom(
                                    //           primary: backgroundblack
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }


   String? user_id;
  Future getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}get_address'));
    request.fields.addAll({
      'user_id': user_id ?? "",
    });
    print(request);
    print("get Addressss nowwwwww${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = AddressModel.fromJson(json.decode(str));
      if(jsonResponse.responseCode == "1"){
        String? address_id = jsonResponse.data![0].id!;
        preferences.setString('address_id', address_id);
        print("Addressss iddd issss ${address_id}");
        setState(() {
          addList = jsonResponse.data!.length;
        });
      }
      print("adddressss listtttt${addList}");
      return AddressModel.fromJson(json.decode(str));
    }
    else {
      return null;
    }
  }

  Future<AddAddressModel?> deleteAddress(id) async {
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/delete_address'));
    request.fields.addAll({
      'id': '$id'
    });

    http.StreamedResponse response = await request.send();
    print(request);
    print(request.fields);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return AddAddressModel.fromJson(json.decode(str));
    }
    else {
      return null;
    }
  }
}
