/// status : false
/// message : "You Are Contains Items From Other Restauran."
/// productid : "15"
/// vendorid : "40"
/// rollid : "7"
/// data : {"service_id":"15","user_id":"62","amount":"120","roll_id":"7","v_id":"40","subtotal":"120"}

class AddToCartHandyServicesModel {
  AddToCartHandyServicesModel({
      bool? status, 
      String? message, 
      String? productid, 
      String? vendorid, 
      String? rollid, 
      Data? data,}){
    _status = status;
    _message = message;
    _productid = productid;
    _vendorid = vendorid;
    _rollid = rollid;
    _data = data;
}

  AddToCartHandyServicesModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _productid = json['productid'];
    _vendorid = json['vendorid'];
    _rollid = json['rollid'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  String? _productid;
  String? _vendorid;
  String? _rollid;
  Data? _data;
AddToCartHandyServicesModel copyWith({  bool? status,
  String? message,
  String? productid,
  String? vendorid,
  String? rollid,
  Data? data,
}) => AddToCartHandyServicesModel(  status: status ?? _status,
  message: message ?? _message,
  productid: productid ?? _productid,
  vendorid: vendorid ?? _vendorid,
  rollid: rollid ?? _rollid,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  String? get productid => _productid;
  String? get vendorid => _vendorid;
  String? get rollid => _rollid;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['productid'] = _productid;
    map['vendorid'] = _vendorid;
    map['rollid'] = _rollid;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// service_id : "15"
/// user_id : "62"
/// amount : "120"
/// roll_id : "7"
/// v_id : "40"
/// subtotal : "120"

class Data {
  Data({
      String? serviceId, 
      String? userId, 
      String? amount, 
      String? rollId, 
      String? vId, 
      String? subtotal,}){
    _serviceId = serviceId;
    _userId = userId;
    _amount = amount;
    _rollId = rollId;
    _vId = vId;
    _subtotal = subtotal;
}

  Data.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _userId = json['user_id'];
    _amount = json['amount'];
    _rollId = json['roll_id'];
    _vId = json['v_id'];
    _subtotal = json['subtotal'];
  }
  String? _serviceId;
  String? _userId;
  String? _amount;
  String? _rollId;
  String? _vId;
  String? _subtotal;
Data copyWith({  String? serviceId,
  String? userId,
  String? amount,
  String? rollId,
  String? vId,
  String? subtotal,
}) => Data(  serviceId: serviceId ?? _serviceId,
  userId: userId ?? _userId,
  amount: amount ?? _amount,
  rollId: rollId ?? _rollId,
  vId: vId ?? _vId,
  subtotal: subtotal ?? _subtotal,
);
  String? get serviceId => _serviceId;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get rollId => _rollId;
  String? get vId => _vId;
  String? get subtotal => _subtotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['roll_id'] = _rollId;
    map['v_id'] = _vId;
    map['subtotal'] = _subtotal;
    return map;
  }

}