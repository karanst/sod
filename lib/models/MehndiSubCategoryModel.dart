/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"16","c_name":"Hands","c_name_a":"","icon":"https://sodindia.com/uploads/","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63d0b90be8178.jpg","other_img":"1674625544images1.jpg,1674625544images.jpg,16746255441291697-mehandi.jpg,1674625544maxresdefault1.jpg","type":"vip","p_id":"1","service_type":"5"},{"id":"17","c_name":"Palm Art","c_name_a":"","icon":"https://sodindia.com/uploads/","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63d0b9aaa335c.jpg","other_img":"1674623402images1.jpg,1674623402images.jpg,1674623402download6.jpg","type":"vip","p_id":"1","service_type":"5"},{"id":"18","c_name":"Legs Art","c_name_a":"","icon":"https://sodindia.com/uploads/","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/63d0ba8225141.jpg","other_img":"1674623618images2.jpg,1674623618download8.jpg,1674623618download7.jpg","type":"vip","p_id":"1","service_type":"5"},{"id":"135","c_name":"LEG'S","c_name_a":"","icon":"https://sodindia.com/uploads/","sub_title":null,"description":null,"img":"https://sodindia.com/uploads/6447897804c2e.jpeg","other_img":"1682409848download7.jpeg","type":"vip","p_id":"1","service_type":"5"}]

class MehndiSubCategoryModel {
  MehndiSubCategoryModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  MehndiSubCategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
MehndiSubCategoryModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => MehndiSubCategoryModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "16"
/// c_name : "Hands"
/// c_name_a : ""
/// icon : "https://sodindia.com/uploads/"
/// sub_title : null
/// description : null
/// img : "https://sodindia.com/uploads/63d0b90be8178.jpg"
/// other_img : "1674625544images1.jpg,1674625544images.jpg,16746255441291697-mehandi.jpg,1674625544maxresdefault1.jpg"
/// type : "vip"
/// p_id : "1"
/// service_type : "5"

class Data {
  Data({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      dynamic subTitle, 
      dynamic description, 
      String? img, 
      String? otherImg, 
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

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _otherImg = json['other_img'];
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
  String? _otherImg;
  String? _type;
  String? _pId;
  String? _serviceType;
Data copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  dynamic subTitle,
  dynamic description,
  String? img,
  String? otherImg,
  String? type,
  String? pId,
  String? serviceType,
}) => Data(  id: id ?? _id,
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
  String? get otherImg => _otherImg;
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