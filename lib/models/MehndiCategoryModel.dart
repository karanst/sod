/// status : 1
/// msg : "Categories Found"
/// imgssss : [{"id":"1","c_name":"Bridal Mehndi Design","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63cfe33d5f35e.jpg","other_img":["https://sodindia.com/uploads/16745719551291697-mehandi.jpg","https://sodindia.com/uploads/1674571955maxresdefault1.jpg","https://sodindia.com/uploads/1674571955ss20220515-2695-qbvcc7.jpg"],"type":"vip","p_id":"0","service_type":"5"},{"id":"2","c_name":"Tattoo Mehndi Design","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63cfe382c4540.jpg","other_img":["https://sodindia.com/uploads/1674568578download4.jpg"],"type":"vip","p_id":"0","service_type":"5"},{"id":"5","c_name":"Jewellery Mehndi Design","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63cfe40535443.jpg","other_img":["https://sodindia.com/uploads/1674572083725c20f67280712c8bc35beb3b6eaa23.jpg","https://sodindia.com/uploads/1674572083982c743ead599f841437462e17c836f7.jpg","https://sodindia.com/uploads/1674572083unnamed.png"],"type":"vip","p_id":"0","service_type":"5"},{"id":"7","c_name":"Marwadi Mehndi Design","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63cfe42620b22.jpg","other_img":["https://sodindia.com/uploads/16745721274481ba67c31aa39476dac19682365bef.jpg","https://sodindia.com/uploads/1674572127images33.jpg","https://sodindia.com/uploads/1674572127Unique-and-beautiful-mehndi-designs-for-front-hand-7.jpg"],"type":"vip","p_id":"0","service_type":"5"},{"id":"57","c_name":"test","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63e10ead3e98e.jpeg","other_img":["https://sodindia.com/uploads/1675693741WhatsAppImage2023-01-25at7_00_17PM.jpeg"],"type":"vip","p_id":"0","service_type":"5"},{"id":"74","c_name":"Bridal Mehndi","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ecbc052365.jpeg","other_img":["https://sodindia.com/uploads/16807884161.jpeg","https://sodindia.com/uploads/16807884162.jpeg"],"type":"vip","p_id":"0","service_type":"5"}]

class MehndiCategoryModel {
  MehndiCategoryModel({
      num? status, 
      String? msg, 
      List<Imgssss>? imgssss,}){
    _status = status;
    _msg = msg;
    _imgssss = imgssss;
}

  MehndiCategoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['imgssss'] != null) {
      _imgssss = [];
      json['imgssss'].forEach((v) {
        _imgssss?.add(Imgssss.fromJson(v));
      });
    }
  }
  num? _status;
  String? _msg;
  List<Imgssss>? _imgssss;
MehndiCategoryModel copyWith({  num? status,
  String? msg,
  List<Imgssss>? imgssss,
}) => MehndiCategoryModel(  status: status ?? _status,
  msg: msg ?? _msg,
  imgssss: imgssss ?? _imgssss,
);
  num? get status => _status;
  String? get msg => _msg;
  List<Imgssss>? get imgssss => _imgssss;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_imgssss != null) {
      map['imgssss'] = _imgssss?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// c_name : "Bridal Mehndi Design"
/// c_name_a : ""
/// icon : ""
/// sub_title : null
/// description : null
/// img : "https://sodindia.com/uploads/63cfe33d5f35e.jpg"
/// other_img : ["https://sodindia.com/uploads/16745719551291697-mehandi.jpg","https://sodindia.com/uploads/1674571955maxresdefault1.jpg","https://sodindia.com/uploads/1674571955ss20220515-2695-qbvcc7.jpg"]
/// type : "vip"
/// p_id : "0"
/// service_type : "5"

class Imgssss {
  Imgssss({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      dynamic subTitle, 
      dynamic description, 
      String? img, 
      List<String>? otherImg, 
      String? type, 
      String? pId, 
      String? serviceType,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _otherImg = otherImg;
    _type = type;
    _pId = pId;
    _serviceType = serviceType;
}

  Imgssss.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _otherImg = json['other_img'] != null ? json['other_img'].cast<String>() : [];
    _type = json['type'];
    _pId = json['p_id'];
    _serviceType = json['service_type'];
  }
  String? _id;
  String? _cName;
  String? _cNameA;
  String? _icon;
  dynamic _subTitle;
  dynamic _description;
  String? _img;
  List<String>? _otherImg;
  String? _type;
  String? _pId;
  String? _serviceType;
Imgssss copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  dynamic subTitle,
  dynamic description,
  String? img,
  List<String>? otherImg,
  String? type,
  String? pId,
  String? serviceType,
}) => Imgssss(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  otherImg: otherImg ?? _otherImg,
  type: type ?? _type,
  pId: pId ?? _pId,
  serviceType: serviceType ?? _serviceType,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  dynamic get subTitle => _subTitle;
  dynamic get description => _description;
  String? get img => _img;
  List<String>? get otherImg => _otherImg;
  String? get type => _type;
  String? get pId => _pId;
  String? get serviceType => _serviceType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['other_img'] = _otherImg;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['service_type'] = _serviceType;
    return map;
  }

}