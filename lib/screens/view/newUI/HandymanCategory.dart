import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constant/global.dart';
import '../models/HandySubCategoryModel.dart';
import 'HandymanServices.dart';

class HandymanCategory extends StatefulWidget {
  String? h_id;
  HandymanCategory({Key? key, this.h_id}) : super(key: key);

  @override
  State<HandymanCategory> createState() => _HandymanCategoryState();
}

class _HandymanCategoryState extends State<HandymanCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubCategory();
  }

  String? h_id;

  HandySubCategoryModel? handySubCategoryModel;
  getSubCategory() async {
    print("handyman sub category api");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    h_id = preferences.getString("h_id");
    print("handyman cat is now here on sub cat screen ${h_id}");
    var headers = {
      'Cookie': 'ci_session=1f575dfd7ea4f6be896869c532b2391f85d1cb80'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}get_categories_list'));
    request.fields.addAll({
      'type_id': '7',
      'p_id': widget.h_id.toString() ?? '',
    });
    print("get handyman cat list here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = HandySubCategoryModel.fromJson(json.decode(finalResponse));
      print("handyman sub categoriessssss$jsonResponse");
      if(jsonResponse.responseCode == '1'){
        String? handymansub_id = jsonResponse.data![0].id ?? "";
        preferences.setString('handymansub_id', handymansub_id);
        print("handyman id here nowwww ${handymansub_id.toString()}");
        setState(() {
          handySubCategoryModel = HandySubCategoryModel.fromJson(json.decode(finalResponse));
        });
      } else{
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: backgroundblack, size: 20)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("HANDYMAN -CATOGRIES",
              style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold)
          )),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/back.png"),
                  fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            child: handySubCategoryModel == null ? Center(
              child: Text("Category Does Not Exist", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: backgroundblack),)
            ): ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: handySubCategoryModel!.data!.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HandymanServices(handymansub_id: handySubCategoryModel!.data![index].id)));
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: backgroundblack, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Container(
                              height: 140,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network("${handySubCategoryModel!.data![index].img}", fit: BoxFit.fitWidth, width: double.infinity,height: 150,)),
                            ),
                          ),
                          Container(
                              height: 50,
                              child: Center(child: Text("${handySubCategoryModel!.data![index].cName}", style: TextStyle(fontSize: 15, color: backgroundblack, fontWeight: FontWeight.w800,
                                  fontFamily: 'Afrah')),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                // Card(
                //   // color: Colors.white,
                //   elevation: 1,
                //   // semanticContainer: true,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20.0),
                //     side: BorderSide(
                //         color:  Colors.red, width: 2
                //     ),
                //   ),
                //   // clipBehavior: Clip.antiAlias,
                //   child: Column(
                //     // crossAxisAlignment: CrossAxisAlignment.start,
                //     // mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       // Center(
                //       //   child: Container(
                //       //     decoration: BoxDecoration(
                //       //         color: appColorOrange,
                //       //         borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                //       //     height: 80,width: 5,
                //       //   ),
                //       // ),
                //       // SizedBox(width: 5),
                //       Container(
                //           // height: 140,
                //           // width: MediaQuery.of(context).size.width/1.7,
                //           child: Image.network("${mehndiSubCategoryModel!.data![index].img}")
                //       ),
                //       SizedBox(height: 5,),
                //       Column(
                //         // crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 7, top: 0),
                //             child: Center(
                //               child: Text("${mehndiSubCategoryModel!.data![index].cName}"
                //                   ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 16, fontFamily: 'Afrah')
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Spacer(),
                //       // Center(
                //       //   child: Container(
                //       //     decoration: BoxDecoration(
                //       //         color: appColorOrange,
                //       //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
                //       //     height: 80,width: 8),
                //       // ),
                //     ],
                //   ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
