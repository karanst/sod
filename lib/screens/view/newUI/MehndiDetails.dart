import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:ez/screens/view/newUI/MehndiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/global.dart';
import 'package:http/http.dart' as http;

import '../../../models/MehndiCategoryModel.dart';
import 'ServiceDetails.dart';


class MehndiDetails extends StatefulWidget {
  const MehndiDetails({Key? key}) : super(key: key);

  @override
  State<MehndiDetails> createState() => _MehndiDetailsState();
}

class _MehndiDetailsState extends State<MehndiDetails> {
  @override
  void initState() {
    super.initState();
    _getMehndiCat();
  }

  MehndiCategoryModel? mehndiCategoryModel;
  _getMehndiCat() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("Mehndi details Api in detailsssss paggggeeeeee");
    var headers = {
      'Cookie': 'ci_session=bc683ce5943cc87d6c193ab40ea1077028ba3ca9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_mehndi_services'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = MehndiCategoryModel.fromJson(json.decode(finalResponse));
      print("Mehndi serivesss$jsonResponse");
      if(jsonResponse.status == 1) {
        //String m_id = jsonResponse.imgssss![index].id.toString();
        // preferences.setString('m_id', m_id);
        // print("Mehndi cat id is here ${m_id}");
        setState(() {
          mehndiCategoryModel = MehndiCategoryModel.fromJson(json.decode(finalResponse));
        });
      }
      else {
        setState(() {});
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
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: backgroundblack,),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("MEHNDI SERVICES",
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
    print("mehndi servicess heree ${mehndiCategoryModel}");
    return mehndiCategoryModel == null ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1),
    ):
    Container(
      height: 800,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: mehndiCategoryModel!.imgssss!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 7/7.6,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetails(sub_id: mehndiCategoryModel!.imgssss![index].id)));
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
                          height: 140,
                          // width: double.infinity,
                          child: Stack(
                            children: [
                              mehndiCategoryModel == null
                                  ? Center(
                                child: Image.asset("assets/images/loader1.gif", scale: 1),
                              ) :
                              Image.network("${mehndiCategoryModel!.imgssss![index].otherImg}", fit: BoxFit.fill),
                              // SizedBox(height: 190,),
                              Center(
                                child: ImageSlideshow(
                                  width: double.infinity,
                                  initialPage: 0,
                                  children: mehndiCategoryModel!.imgssss![index].otherImg!.map((item) =>
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
                                child: Text("${mehndiCategoryModel!.imgssss![index].cName}"
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
