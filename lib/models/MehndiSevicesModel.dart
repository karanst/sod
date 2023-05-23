/// status : 1
/// msg : "Services Found"
/// data : [{"id":"13","artist_name":"MEHNDI","category_id":"1","sub_id":"16","services_image":"https://sodindia.com/uploads/1682184261Screenshot_20230422-225252_Instagram.jpg","profile_image":"https://sodindia.com/uploads/644418454b0e8.jpg","mrp_price":"7000","special_price":"5500","v_id":"40","roll":"5","ser_desc":"full hand full legs","service_status":"1","tax_status":"0","gst_amount":"0","per_day_charge":"","uname":"Ekta Gurjar","gender":"Female"}]

class MehndiSevicesModel {
  MehndiSevicesModel({
      num? status, 
      String? msg, 
      List<Data>? data,}){
    _status = status;
    _msg = msg;
    _data = data;
}

  MehndiSevicesModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  String? _msg;
  List<Data>? _data;
MehndiSevicesModel copyWith({  num? status,
  String? msg,
  List<Data>? data,
}) => MehndiSevicesModel(  status: status ?? _status,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get status => _status;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "13"
/// artist_name : "MEHNDI"
/// category_id : "1"
/// sub_id : "16"
/// services_image : "https://sodindia.com/uploads/1682184261Screenshot_20230422-225252_Instagram.jpg"
/// profile_image : "https://sodindia.com/uploads/644418454b0e8.jpg"
/// mrp_price : "7000"
/// special_price : "5500"
/// v_id : "40"
/// roll : "5"
/// ser_desc : "full hand full legs"
/// service_status : "1"
/// tax_status : "0"
/// gst_amount : "0"
/// per_day_charge : ""
/// uname : "Ekta Gurjar"
/// gender : "Female"

class Data {
  Data({
      String? id, 
      String? artistName, 
      String? categoryId, 
      String? subId, 
      String? servicesImage, 
      String? profileImage, 
      String? mrpPrice, 
      String? specialPrice, 
      String? vId, 
      String? roll, 
      String? serDesc, 
      String? serviceStatus, 
      String? taxStatus, 
      String? gstAmount, 
      String? perDayCharge, 
      String? uname, 
      String? gender,}){
    _id = id;
    _artistName = artistName;
    _categoryId = categoryId;
    _subId = subId;
    _servicesImage = servicesImage;
    _profileImage = profileImage;
    _mrpPrice = mrpPrice;
    _specialPrice = specialPrice;
    _vId = vId;
    _roll = roll;
    _serDesc = serDesc;
    _serviceStatus = serviceStatus;
    _taxStatus = taxStatus;
    _gstAmount = gstAmount;
    _perDayCharge = perDayCharge;
    _uname = uname;
    _gender = gender;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _artistName = json['artist_name'];
    _categoryId = json['category_id'];
    _subId = json['sub_id'];
    _servicesImage = json['services_image'];
    _profileImage = json['profile_image'];
    _mrpPrice = json['mrp_price'];
    _specialPrice = json['special_price'];
    _vId = json['v_id'];
    _roll = json['roll'];
    _serDesc = json['ser_desc'];
    _serviceStatus = json['service_status'];
    _taxStatus = json['tax_status'];
    _gstAmount = json['gst_amount'];
    _perDayCharge = json['per_day_charge'];
    _uname = json['uname'];
    _gender = json['gender'];
  }
  String? _id;
  String? _artistName;
  String? _categoryId;
  String? _subId;
  String? _servicesImage;
  String? _profileImage;
  String? _mrpPrice;
  String? _specialPrice;
  String? _vId;
  String? _roll;
  String? _serDesc;
  String? _serviceStatus;
  String? _taxStatus;
  String? _gstAmount;
  String? _perDayCharge;
  String? _uname;
  String? _gender;
Data copyWith({  String? id,
  String? artistName,
  String? categoryId,
  String? subId,
  String? servicesImage,
  String? profileImage,
  String? mrpPrice,
  String? specialPrice,
  String? vId,
  String? roll,
  String? serDesc,
  String? serviceStatus,
  String? taxStatus,
  String? gstAmount,
  String? perDayCharge,
  String? uname,
  String? gender,
}) => Data(  id: id ?? _id,
  artistName: artistName ?? _artistName,
  categoryId: categoryId ?? _categoryId,
  subId: subId ?? _subId,
  servicesImage: servicesImage ?? _servicesImage,
  profileImage: profileImage ?? _profileImage,
  mrpPrice: mrpPrice ?? _mrpPrice,
  specialPrice: specialPrice ?? _specialPrice,
  vId: vId ?? _vId,
  roll: roll ?? _roll,
  serDesc: serDesc ?? _serDesc,
  serviceStatus: serviceStatus ?? _serviceStatus,
  taxStatus: taxStatus ?? _taxStatus,
  gstAmount: gstAmount ?? _gstAmount,
  perDayCharge: perDayCharge ?? _perDayCharge,
  uname: uname ?? _uname,
  gender: gender ?? _gender,
);
  String? get id => _id;
  String? get artistName => _artistName;
  String? get categoryId => _categoryId;
  String? get subId => _subId;
  String? get servicesImage => _servicesImage;
  String? get profileImage => _profileImage;
  String? get mrpPrice => _mrpPrice;
  String? get specialPrice => _specialPrice;
  String? get vId => _vId;
  String? get roll => _roll;
  String? get serDesc => _serDesc;
  String? get serviceStatus => _serviceStatus;
  String? get taxStatus => _taxStatus;
  String? get gstAmount => _gstAmount;
  String? get perDayCharge => _perDayCharge;
  String? get uname => _uname;
  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['artist_name'] = _artistName;
    map['category_id'] = _categoryId;
    map['sub_id'] = _subId;
    map['services_image'] = _servicesImage;
    map['profile_image'] = _profileImage;
    map['mrp_price'] = _mrpPrice;
    map['special_price'] = _specialPrice;
    map['v_id'] = _vId;
    map['roll'] = _roll;
    map['ser_desc'] = _serDesc;
    map['service_status'] = _serviceStatus;
    map['tax_status'] = _taxStatus;
    map['gst_amount'] = _gstAmount;
    map['per_day_charge'] = _perDayCharge;
    map['uname'] = _uname;
    map['gender'] = _gender;
    return map;
  }

}