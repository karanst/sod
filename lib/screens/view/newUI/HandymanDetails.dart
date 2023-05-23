import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ez/screens/view/newUI/HandymanServiceDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import '../../../constant/global.dart';
import '../../../models/HandyManModel.dart';

class HandymanDetails extends StatefulWidget {
  const HandymanDetails({Key? key}) : super(key: key);

  @override
  State<HandymanDetails> createState() => _HandymanDetailsState();
}

class _HandymanDetailsState extends State<HandymanDetails> {

  HandyManModel? handyManModel;

  @override
  void initState() {
    super.initState();
    _getHandyManCat();
  }
  _getHandyManCat() async{
    print("Handy Man Detilssssss Apiiiii");
    var headers = {
      'Cookie': 'ci_session=9fc22c802baa4796f3d0a1be128441e4a043fca5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_handy_services'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = HandyManModel.fromJson(json.decode(finalResponse));
      print("handymannnn serivesss in deatks screeen $jsonResponse");
      setState(() {
        handyManModel = HandyManModel.fromJson(json.decode(finalResponse));
      });
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
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: backgroundblack,),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("HANDYMAN SERVICES",
            style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'versailles', decoration: TextDecoration.underline, fontWeight: FontWeight.bold)
        ),
      ),
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
              child: _getCategory(context)
          ),
        ],
      ),
    );
  }

  Widget _getCategory(BuildContext context){
    print("handymann servicess heree ${handyManModel}");
    return handyManModel == null ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1),
    ):
    Container(
      height: 800,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: handyManModel!.imgssss!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 7/7.5,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HandyServiceDetails(h_id: handyManModel!.imgssss![index].id)));
            },
            child: Padding(
              padding: EdgeInsets.all(1),
              child: Card(
                color: Colors.white,
                elevation: 5,
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: appColorBlack, width: 2),
                ),
                // clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 130,
                      // width: double.infinity,
                      child: Stack(
                        children: [
                          handyManModel == null
                              ? Center(
                            child: Image.asset("assets/images/loader1.gif", scale: 1),
                          ) :
                          Image.network("${handyManModel!.imgssss![index].otherImg}", fit: BoxFit.fill),
                          // SizedBox(height: 190,),
                          Center(
                            child: ImageSlideshow(
                              width: double.infinity,
                              // height: 170,
                              initialPage: 0,
                              // indicatorColor: appColorOrange,
                              // indicatorBackgroundColor: Colors.grey,
                              children: handyManModel!.imgssss![index].otherImg!.map((item) =>
                                  CachedNetworkImage(
                                    imageUrl: item, fit: BoxFit.fill,
                                    placeholder: (context, url) => Center(
                                      child: Container(
                                        margin: EdgeInsets.all(70.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      height: 5, width: 5,
                                      child: Icon(
                                        Icons.error,
                                      ),
                                    ),
                                  ),)
                                  .toList(),
                              onPageChanged: (value) {
                                print('Page changed: $value');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7, top: 0),
                            child: Text("${handyManModel!.imgssss![index].cName}"
                                ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 10, fontFamily: 'Afrah')
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: backgroundblack),
                              child: Center(child: Text("View Services", style: TextStyle(fontSize: 10, color: appColorOrange)))),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
