// import 'dart:convert';
//
// import 'package:ez/screens/view/newUI/AllProviderService.dart';
// import 'package:ez/screens/view/newUI/viewCategory.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../../constant/global.dart';
// import '../models/catModel.dart';
// import '../models/categories_model.dart';
//
// class SubCategoryScreen extends StatefulWidget {
//   final name, id, image, description;
//   const SubCategoryScreen({Key? key, this.name, this.id,this.description,this.image}) : super(key: key);
//
//   @override
//   State<SubCategoryScreen> createState() => _SubCategoryScreenState();
// }
//
// class _SubCategoryScreenState extends State<SubCategoryScreen> {
//   bool isLoading = false;
//   AllCateModel? collectionModal;
//
//   @override
//   void initState() {
//     super.initState();
//     // getSubCategory();
//   }
//
//   // getSubCategory() async {
//   //   var uri = Uri.parse('${baseUrl()}/get_all_cat');
//   //   var request = new http.MultipartRequest("POST", uri);
//   //   Map<String, String> headers = {
//   //     "Accept": "application/json",
//   //   };
//   //
//   //   print("checking id here ${widget.id}");
//   //   print(baseUrl.toString());
//   //   request.headers.addAll(headers);
//   //   request.fields['category_id'] = widget.id;
//   //   var response = await request.send();
//   //   print(response.statusCode);
//   //   String responseData = await response.stream.transform(utf8.decoder).join();
//   //   var userData = json.decode(responseData);
//   //   if (mounted) {
//   //     setState(() {
//   //       collectionModal = AllCateModel.fromJson(userData);
//   //     });
//   //   }
//   //   print(responseData);
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   backgroundColor: backgroundblack,
//       //   // elevation: 0,
//       //   // shape: RoundedRectangleBorder(
//       //   //   borderRadius: BorderRadius.only(
//       //   //     bottomLeft: Radius.circular(20),
//       //   //     bottomRight: Radius.circular(20),
//       //   //   ),
//       //   // ),
//       //   // // bottom:
//       //   // title: Text(
//       //   //  "SubCategory",
//       //   //   style: TextStyle(color: appColorWhite),
//       //   // ),
//       //   // centerTitle: true,
//       //   // leading:  Padding(
//       //   //   padding: const EdgeInsets.all(12),
//       //   //   child: RawMaterialButton(
//       //   //     // shape: CircleBorder(),
//       //   //     // padding: const EdgeInsets.all(0),
//       //   //     // fillColor: Colors.white,
//       //   //     // splashColor: Colors.grey[400],
//       //   //     child: Icon(
//       //   //       Icons.arrow_back,
//       //   //       size: 25,
//       //   //       color: Colors.white,
//       //   //     ),
//       //   //     onPressed: () {
//       //   //       Navigator.pop(context);
//       //   //     },
//       //   //   ),
//       //   // ),
//       //   // leading: IconButton(
//       //   //   icon: Icon(
//       //   //     Icons.arrow_back,
//       //   //     color: Colors.black,
//       //   //   ),
//       //   //   onPressed: () {
//       //   //     Navigator.pop(context);
//       //   //   },
//       //   // ),
//       // ),
//         body:
//         // collectionModal == null
//         //     ? Center(
//         //   child: Image.asset("assets/images/loader1.gif", scale: 1,),
//         // ) :
//        SingleChildScrollView(
//          child: Center(
//            child: Column(
//              children: [
//              Text("Bridal Mehndi- Subcategories",
//                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'versailles'
//                ),
//              ),
//            ],
//            ),
//          ),
//        ),
//     );
//   }
//
//   // Widget bestSellerItems(BuildContext context) {
//   //   return collectionModal!.categories!.length != 0
//   //       ? GridView.builder(
//   //     shrinkWrap: true,
//   //     primary: false,
//   //     padding: EdgeInsets.all(10),
//   //     itemCount: collectionModal!.categories!.length,
//   //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //       crossAxisCount: 2,
//   //       mainAxisSpacing: 10.0,
//   //       crossAxisSpacing: 15.0,
//   //       childAspectRatio: 250 / 290,
//   //     ),
//   //     itemBuilder: (BuildContext context, int index) {
//   //       return Padding(
//   //         padding: const EdgeInsets.only(bottom: 30),
//   //         child: InkWell(
//   //           onTap: () {
//   //             Navigator.push(
//   //               context,
//   //               CupertinoPageRoute(
//   //                 builder: (context) => ViewCategory(
//   //                   id: collectionModal!.categories![index].id,
//   //                   name: collectionModal!.categories![index].cName!,
//   //                   catId: widget.id,
//   //                   fromSeller: false,
//   //                 ),
//   //               ),
//   //             );
//   //           },
//   //           child: Card(
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.circular(8)
//   //             ),
//   //             child: Column(
//   //               children: [
//   //                 Container(
//   //                   height: 100,
//   //                   // width: 140,
//   //                   alignment: Alignment.topCenter,
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.black45,
//   //                     borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//   //                     image: DecorationImage(
//   //                       image: NetworkImage(collectionModal!.categories![index].img!),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 Padding(
//   //                   padding: EdgeInsets.only(top: 10),
//   //                   child: Text(
//   //                     collectionModal!.categories![index].cName![0].toUpperCase() + collectionModal!.categories![index].cName!.substring(1),
//   //                     maxLines: 1,
//   //                     style: TextStyle(
//   //                         color: appColorBlack,
//   //                         fontSize: 14,
//   //                         fontWeight: FontWeight.bold),
//   //                   ),
//   //                 ),
//   //                 // Card(
//   //                 //   elevation: 5,
//   //                 //   shape: RoundedRectangleBorder(
//   //                 //     borderRadius: BorderRadius.circular(20),
//   //                 //   ),
//   //                 //   child: Container(
//   //                 //     width: 180,
//   //                 //     child: Padding(
//   //                 //       padding: const EdgeInsets.only(
//   //                 //           bottom: 15, left: 15, right: 5),
//   //                 //       child: Column(
//   //                 //         crossAxisAlignment: CrossAxisAlignment.start,
//   //                 //         mainAxisAlignment: MainAxisAlignment.end,
//   //                 //         children: [
//   //                 //           Text(
//   //                 //             collectionModal!.categories![index].cName!,
//   //                 //             maxLines: 1,
//   //                 //             style: TextStyle(
//   //                 //                 color: appColorBlack,
//   //                 //                 fontSize: 14,
//   //                 //                 fontWeight: FontWeight.bold),
//   //                 //           ),
//   //                 //           Container(height: 10),
//   //                 //           /*Row(
//   //                 //             mainAxisAlignment:
//   //                 //             MainAxisAlignment.spaceBetween,
//   //                 //             crossAxisAlignment:
//   //                 //             CrossAxisAlignment.end,
//   //                 //             children: [
//   //                 //               Column(
//   //                 //                 crossAxisAlignment:
//   //                 //                 CrossAxisAlignment.start,
//   //                 //                 children: [
//   //                 //                   Container(
//   //                 //                     width: 110,
//   //                 //                     child: Text(
//   //                 //                       catModal!.restaurants![index].resDesc!,
//   //                 //                       maxLines: 2,
//   //                 //                       overflow: TextOverflow.ellipsis,
//   //                 //                       style: TextStyle(
//   //                 //                           color: appColorBlack,
//   //                 //                           fontSize: 12,
//   //                 //                           fontWeight: FontWeight.normal),
//   //                 //                     ),
//   //                 //                   ),
//   //                 //                   Text(
//   //                 //                     "₹" + catModal!.restaurants![index].price!,
//   //                 //                     style: TextStyle(
//   //                 //                         color: appColorBlack,
//   //                 //                         fontSize: 16,
//   //                 //                         fontWeight: FontWeight.bold),
//   //                 //                   ),
//   //                 //                   Container(
//   //                 //                     child: Padding(
//   //                 //                         padding: EdgeInsets.all(0),
//   //                 //                         child: Text(
//   //                 //                           "BOOK NOW",
//   //                 //                           style: TextStyle(
//   //                 //                               color: Colors.blue,
//   //                 //                               fontSize: 12),
//   //                 //                         )),
//   //                 //                   ),
//   //                 //                 ],
//   //                 //               ),
//   //                 //
//   //                 //             ],
//   //                 //           ),*/
//   //                 //         ],
//   //                 //       ),
//   //                 //     ),
//   //                 //   ),
//   //                 // ),
//   //                 // Container(
//   //                 //   height: 100,
//   //                 //   width: 140,
//   //                 //   alignment: Alignment.topCenter,
//   //                 //   decoration: BoxDecoration(
//   //                 //     color: Colors.black45,
//   //                 //     borderRadius: BorderRadius.circular(10),
//   //                 //     image: DecorationImage(
//   //                 //       image: NetworkImage(collectionModal!.categories![index].img!),
//   //                 //       fit: BoxFit.cover,
//   //                 //     ),
//   //                 //   ),
//   //                 // ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   )
//   //       : Center(
//   //     child: Text(
//   //       "No Sub Category Available",
//   //       style: TextStyle(
//   //         color: appColorBlack,
//   //         fontStyle: FontStyle.italic,
//   //       ),
//   //     ),
//   //   );
//   // }
// }

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/global.dart';
import '../../../models/MehndiSubCategoryModel.dart';
import 'MehndiServices.dart';
import 'ServiceDetails.dart';

class SubCategoryScreen extends StatefulWidget {
  String? m_id;
  SubCategoryScreen({Key? key, this.m_id}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubCategory();
  }

  String? m_id;

  MehndiSubCategoryModel? mehndiSubCategoryModel;
  getSubCategory() async {
    print("Mehndi sub category api");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    m_id = preferences.getString("m_id");
    print("Mehndi cat is now here on sub cat screen ${m_id}");
    var headers = {
      'Cookie': 'ci_session=1f575dfd7ea4f6be896869c532b2391f85d1cb80'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}get_categories_list'));
    request.fields.addAll({
      'type_id': '5',
      'p_id': widget.m_id.toString() ?? '',
    });
     print("get menhdi cat list here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = MehndiSubCategoryModel.fromJson(json.decode(finalResponse));
      print("Mehndi sub categoriessssss$jsonResponse");
      if(jsonResponse.responseCode == '1'){
       String? sub_id = jsonResponse.data![0].id ?? "";
       preferences.setString('sub_id', sub_id);
       print("mehndi id here nowwww ${sub_id.toString()}");
       setState(() {
         mehndiSubCategoryModel = MehndiSubCategoryModel.fromJson(json.decode(finalResponse));
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
              child: Icon(Icons.arrow_back_ios, color: backgroundblack, size: 20,)),
        centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("BRIDAL MEHNDI -SUBCATOGRIES",
          style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold)
      )),
      body: Stack(
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
            child: mehndiSubCategoryModel == null ? Center(
              child: Text("Category Does Not Exist", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: backgroundblack),)
            ): ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: mehndiSubCategoryModel!.data!.length,
              itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetails(sub_id: mehndiSubCategoryModel!.data![index].id)));

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MehndiServices(sub_id: mehndiSubCategoryModel!.data![index].id)));
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
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            height: 140,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network("${mehndiSubCategoryModel!.data![index].img}", fit: BoxFit.fitWidth, width: double.infinity,height: 150,)),
                          ),
                        ),
                        Container(
                          // width: double.infinity,
                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: appColorOrange,width: 2)),
                          height: 50,
                            child: Center(child: Text("${mehndiSubCategoryModel!.data![index].cName}", style: TextStyle(fontSize: 15, color: backgroundblack, fontWeight: FontWeight.w800,
                                fontFamily: 'Afrah'))
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
