/// response_code : "1"
/// message : "Cart Items Found"
/// cart : [{"product_id":"13","cart_id":"20","product_image":"https://sodindia.com/uploads/644418454b0e8.jpg","product_name":"MEHNDI","selling_price":"5500","product_price":"7000","vendor_name":"Ekta Gurjar","vendor_id":"40","cart_final_total":"12980","cart_no_of_person":"2"},{"product_id":"14","cart_id":"21","product_image":"https://sodindia.com/uploads/64478a84eb5e1.png","product_name":"Legs mehndi ","selling_price":"5568","product_price":"68686","vendor_name":"Ekta Gurjar","vendor_id":"40","cart_final_total":"6570.24","cart_no_of_person":"1"}]
/// cart_sub_total : "16568"
/// gst_sum : "2982.24"
/// cart_total : "19550.24"
/// total_items : "0"
/// status : "success"

class GetCartServiceModel {
  GetCartServiceModel({
      String? responseCode, 
      String? message, 
      List<Cart>? cart, 
      String? cartSubTotal, 
      String? gstSum, 
      String? cartTotal, 
      String? totalItems, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _cart = cart;
    _cartSubTotal = cartSubTotal;
    _gstSum = gstSum;
    _cartTotal = cartTotal;
    _totalItems = totalItems;
    _status = status;
}

  GetCartServiceModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart?.add(Cart.fromJson(v));
      });
    }
    _cartSubTotal = json['cart_sub_total'];
    _gstSum = json['gst_sum'];
    _cartTotal = json['cart_total'];
    _totalItems = json['total_items'];
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  List<Cart>? _cart;
  String? _cartSubTotal;
  String? _gstSum;
  String? _cartTotal;
  String? _totalItems;
  String? _status;
GetCartServiceModel copyWith({  String? responseCode,
  String? message,
  List<Cart>? cart,
  String? cartSubTotal,
  String? gstSum,
  String? cartTotal,
  String? totalItems,
  String? status,
}) => GetCartServiceModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  cart: cart ?? _cart,
  cartSubTotal: cartSubTotal ?? _cartSubTotal,
  gstSum: gstSum ?? _gstSum,
  cartTotal: cartTotal ?? _cartTotal,
  totalItems: totalItems ?? _totalItems,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  List<Cart>? get cart => _cart;
  String? get cartSubTotal => _cartSubTotal;
  String? get gstSum => _gstSum;
  String? get cartTotal => _cartTotal;
  String? get totalItems => _totalItems;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_cart != null) {
      map['cart'] = _cart?.map((v) => v.toJson()).toList();
    }
    map['cart_sub_total'] = _cartSubTotal;
    map['gst_sum'] = _gstSum;
    map['cart_total'] = _cartTotal;
    map['total_items'] = _totalItems;
    map['status'] = _status;
    return map;
  }

}

/// product_id : "13"
/// cart_id : "20"
/// product_image : "https://sodindia.com/uploads/644418454b0e8.jpg"
/// product_name : "MEHNDI"
/// selling_price : "5500"
/// product_price : "7000"
/// vendor_name : "Ekta Gurjar"
/// vendor_id : "40"
/// cart_final_total : "12980"
/// cart_no_of_person : "2"

class Cart {
  Cart({
      String? productId, 
      String? cartId, 
      String? productImage, 
      String? productName, 
      String? sellingPrice, 
      String? productPrice, 
      String? vendorName, 
      String? vendorId, 
      String? cartFinalTotal, 
      String? cartNoOfPerson, double? finalAmt, int? totalAmt}){
    _productId = productId;
    _cartId = cartId;
    _productImage = productImage;
    _productName = productName;
    _sellingPrice = sellingPrice;
    _productPrice = productPrice;
    _vendorName = vendorName;
    _vendorId = vendorId;
    _cartFinalTotal = cartFinalTotal;
    _cartNoOfPerson = cartNoOfPerson;
    finalAmt = finalAmt ;
    totalAmt = totalAmt;
}

  Cart.fromJson(dynamic json) {
    _productId = json['product_id'];
    _cartId = json['cart_id'];
    _productImage = json['product_image'];
    _productName = json['product_name'];
    _sellingPrice = json['selling_price'];
    _productPrice = json['product_price'];
    _vendorName = json['vendor_name'];
    _vendorId = json['vendor_id'];
    _cartFinalTotal = json['cart_final_total'];
    _cartNoOfPerson = json['cart_no_of_person'];
    finalAmt = 0.0;
    totalAmt = 00;
  }
  String? _productId;
  String? _cartId;
  String? _productImage;
  String? _productName;
  String? _sellingPrice;
  String? _productPrice;
  String? _vendorName;
  String? _vendorId;
  String? _cartFinalTotal;
  String? _cartNoOfPerson;
  double?  finalAmt;
  int? totalAmt;
Cart copyWith({  String? productId,
  String? cartId,
  String? productImage,
  String? productName,
  String? sellingPrice,
  String? productPrice,
  String? vendorName,
  String? vendorId,
  String? cartFinalTotal,
  String? cartNoOfPerson,
  double?  finalAmt,
  int? totalAmt
}) => Cart(  productId: productId ?? _productId,
  cartId: cartId ?? _cartId,
  productImage: productImage ?? _productImage,
  productName: productName ?? _productName,
  sellingPrice: sellingPrice ?? _sellingPrice,
  productPrice: productPrice ?? _productPrice,
  vendorName: vendorName ?? _vendorName,
  vendorId: vendorId ?? _vendorId,
  cartFinalTotal: cartFinalTotal ?? _cartFinalTotal,
  cartNoOfPerson: cartNoOfPerson ?? _cartNoOfPerson,
);
  String? get productId => _productId;
  String? get cartId => _cartId;
  String? get productImage => _productImage;
  String? get productName => _productName;
  String? get sellingPrice => _sellingPrice;
  String? get productPrice => _productPrice;
  String? get vendorName => _vendorName;
  String? get vendorId => _vendorId;
  String? get cartFinalTotal => _cartFinalTotal;
  String? get cartNoOfPerson => _cartNoOfPerson;
  //double? get finalAmt  => _finalAmt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['cart_id'] = _cartId;
    map['product_image'] = _productImage;
    map['product_name'] = _productName;
    map['selling_price'] = _sellingPrice;
    map['product_price'] = _productPrice;
    map['vendor_name'] = _vendorName;
    map['vendor_id'] = _vendorId;
    map['cart_final_total'] = _cartFinalTotal;
    map['cart_no_of_person'] = _cartNoOfPerson;
    return map;
  }

}