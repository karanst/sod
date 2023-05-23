/// status : true
/// message : "Add to Cart Service Successfully"
/// cart_count : 2

class AddToCartMehndiServicesModel {
  AddToCartMehndiServicesModel({
      bool? status, 
      String? message, 
      num? cartCount,}){
    _status = status;
    _message = message;
    _cartCount = cartCount;
}

  AddToCartMehndiServicesModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _cartCount = json['cart_count'];
  }
  bool? _status;
  String? _message;
  num? _cartCount;
AddToCartMehndiServicesModel copyWith({  bool? status,
  String? message,
  num? cartCount,
}) => AddToCartMehndiServicesModel(  status: status ?? _status,
  message: message ?? _message,
  cartCount: cartCount ?? _cartCount,
);
  bool? get status => _status;
  String? get message => _message;
  num? get cartCount => _cartCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['cart_count'] = _cartCount;
    return map;
  }

}