/// response_code : "1"
/// message : "Cart Updated"
/// status : "success"
/// price : 2010

class AddToCartModel {
  AddToCartModel({
      String? responseCode, 
      String? message, 
      String? status, 
      num? price,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _price = price;
}

  AddToCartModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _price = json['price'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  num? _price;
AddToCartModel copyWith({  String? responseCode,
  String? message,
  String? status,
  num? price,
}) => AddToCartModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  price: price ?? _price,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    map['price'] = _price;
    return map;
  }

}