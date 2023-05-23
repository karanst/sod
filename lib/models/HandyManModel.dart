/// status : 1
/// msg : "Categories Found"
/// imgssss : [{"id":"23","c_name":"Plumber","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63d0cda63a731.jpg","other_img":["https://sodindia.com/uploads/1680760171download.png"],"type":"vip","p_id":"0","service_type":"7"},{"id":"28","c_name":"Bath Tub Fitting","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63d3b26f8acbd.jpg","other_img":["https://sodindia.com/uploads/1680760277download.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"36","c_name":"RO Repairing","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63d3c4b02a117.jpg","other_img":["https://sodindia.com/uploads/1680760429images1.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"65","c_name":"Security","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642e5cdf1559a.jpeg","other_img":["https://sodindia.com/uploads/1680760487security.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"66","c_name":"Carpenter","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642e5eff0003f.jpeg","other_img":["https://sodindia.com/uploads/1680760575images2.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"67","c_name":"Gardner","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642e5f76526e6.jpeg","other_img":["https://sodindia.com/uploads/1680760694images4.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"68","c_name":"Electrician","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642e6035e5366.jpeg","other_img":["https://sodindia.com/uploads/1680761139images7.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"69","c_name":"A.C Service","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642e6080a98ca.jpeg","other_img":["https://sodindia.com/uploads/1680760960download2.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"70","c_name":"Refrigeretor Service","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642e60d3840c0.jpeg","other_img":["https://sodindia.com/uploads/1680761043images6.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"76","c_name":"Cook","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ee2e82529c.jpeg","other_img":["https://sodindia.com/uploads/1680794344images.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"77","c_name":"Water proofing","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ee32f12530.jpeg","other_img":["https://sodindia.com/uploads/1680794415download.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"78","c_name":"TV Repairing","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ee38b00b52.jpeg","other_img":["https://sodindia.com/uploads/1680794507download1.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"79","c_name":"Washing Machine Service/Repair","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ee3d365c3c.jpeg","other_img":["https://sodindia.com/uploads/1680794579download2.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"80","c_name":"Tile Grouting","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ee432a8e12.jpeg","other_img":["https://sodindia.com/uploads/1680794674download3.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"82","c_name":"Wi-Fi & Broadband ","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ee506ac4b6.jpeg","other_img":["https://sodindia.com/uploads/1680794886images1.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"83","c_name":"House Keeping ","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ee56557bfb.jpeg","other_img":["https://sodindia.com/uploads/1680794981download4.jpeg"],"type":"vip","p_id":"0","service_type":"7"},{"id":"84","c_name":"Helper","c_name_a":"","icon":"","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/642ee5ad9ff27.jpeg","other_img":["https://sodindia.com/uploads/1680795053images2.jpeg"],"type":"vip","p_id":"0","service_type":"7"}]

class HandyManModel {
  HandyManModel({
      num? status, 
      String? msg, 
      List<Imgssss>? imgssss,}){
    _status = status;
    _msg = msg;
    _imgssss = imgssss;
}

  HandyManModel.fromJson(dynamic json) {
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
HandyManModel copyWith({  num? status,
  String? msg,
  List<Imgssss>? imgssss,
}) => HandyManModel(  status: status ?? _status,
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

/// id : "23"
/// c_name : "Plumber"
/// c_name_a : ""
/// icon : ""
/// sub_title : null
/// description : null
/// img : "https://sodindia.com/uploads/63d0cda63a731.jpg"
/// other_img : ["https://sodindia.com/uploads/1680760171download.png"]
/// type : "vip"
/// p_id : "0"
/// service_type : "7"

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