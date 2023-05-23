/// status : 1
/// msg : "Main Category Image"
/// data : {"order_food":"https://sodindia.com/uploads/category_images/aap_orderfood_cat_image.png","book_ride":"https://sodindia.com/uploads/category_images/aap_bookride_cat_image.png","send_packge":"https://sodindia.com/uploads/category_images/aap_sendpackage_cat_image.png","handyman":"https://sodindia.com/uploads/category_images/aap_handyman_cat_image.php","mehndi":"https://sodindia.com/uploads/category_images/aap_mehndi_cat_image.png"}

class GetMainCatModel {
  GetMainCatModel({
      num? status, 
      String? msg, 
      Data? data,}){
    _status = status;
    _msg = msg;
    _data = data;
}

  GetMainCatModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _msg;
  Data? _data;
GetMainCatModel copyWith({  num? status,
  String? msg,
  Data? data,
}) => GetMainCatModel(  status: status ?? _status,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get status => _status;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// order_food : "https://sodindia.com/uploads/category_images/aap_orderfood_cat_image.png"
/// book_ride : "https://sodindia.com/uploads/category_images/aap_bookride_cat_image.png"
/// send_packge : "https://sodindia.com/uploads/category_images/aap_sendpackage_cat_image.png"
/// handyman : "https://sodindia.com/uploads/category_images/aap_handyman_cat_image.php"
/// mehndi : "https://sodindia.com/uploads/category_images/aap_mehndi_cat_image.png"

class Data {
  Data({
      String? orderFood, 
      String? bookRide, 
      String? sendPackge, 
      String? handyman, 
      String? mehndi,}){
    _orderFood = orderFood;
    _bookRide = bookRide;
    _sendPackge = sendPackge;
    _handyman = handyman;
    _mehndi = mehndi;
}

  Data.fromJson(dynamic json) {
    _orderFood = json['order_food'];
    _bookRide = json['book_ride'];
    _sendPackge = json['send_packge'];
    _handyman = json['handyman'];
    _mehndi = json['mehndi'];
  }
  String? _orderFood;
  String? _bookRide;
  String? _sendPackge;
  String? _handyman;
  String? _mehndi;
Data copyWith({  String? orderFood,
  String? bookRide,
  String? sendPackge,
  String? handyman,
  String? mehndi,
}) => Data(  orderFood: orderFood ?? _orderFood,
  bookRide: bookRide ?? _bookRide,
  sendPackge: sendPackge ?? _sendPackge,
  handyman: handyman ?? _handyman,
  mehndi: mehndi ?? _mehndi,
);
  String? get orderFood => _orderFood;
  String? get bookRide => _bookRide;
  String? get sendPackge => _sendPackge;
  String? get handyman => _handyman;
  String? get mehndi => _mehndi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_food'] = _orderFood;
    map['book_ride'] = _bookRide;
    map['send_packge'] = _sendPackge;
    map['handyman'] = _handyman;
    map['mehndi'] = _mehndi;
    return map;
  }

}