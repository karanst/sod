/// response_code : "1"
/// message : "Cart Items Found"
/// cart : [{"product_id":"183","cart_id":"928","product_image":"https://sodindia.com/uploads/product_images/63d11097579f5.jpg","product_name":"jhodpuri paneer","selling_price":"335","qty_price":670,"product_price":"336","quantity":"2","vendor_name":"Shivam","vendor_id":"21","vendor_latitude":"22.7470519","vendor_longitude":"75.8980085"},{"product_id":"171","cart_id":"929","product_image":"https://sodindia.com/uploads/product_images/63d0bf2e6100d.jpg","product_name":"Chicken Curry","selling_price":"250","qty_price":250,"product_price":"300","quantity":"1","vendor_name":"test","vendor_id":"15","vendor_latitude":"22.7463481","vendor_longitude":"75.898282"}]
/// cart_total : "920"
/// total_items : "3"
/// status : "success"

class GetUserCartModel {
  GetUserCartModel({
      String? responseCode, 
      String? message, 
      List<Cart>? cart, 
      String? cartTotal, 
      String? totalItems, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _cart = cart;
    _cartTotal = cartTotal;
    _totalItems = totalItems;
    _status = status;
}

  GetUserCartModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart?.add(Cart.fromJson(v));
      });
    }
    _cartTotal = json['cart_total'];
    _totalItems = json['total_items'];
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  List<Cart>? _cart;
  String? _cartTotal;
  String? _totalItems;
  String? _status;
GetUserCartModel copyWith({  String? responseCode,
  String? message,
  List<Cart>? cart,
  String? cartTotal,
  String? totalItems,
  String? status,
}) => GetUserCartModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  cart: cart ?? _cart,
  cartTotal: cartTotal ?? _cartTotal,
  totalItems: totalItems ?? _totalItems,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  List<Cart>? get cart => _cart;
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
    map['cart_total'] = _cartTotal;
    map['total_items'] = _totalItems;
    map['status'] = _status;
    return map;
  }

}

/// product_id : "183"
/// cart_id : "928"
/// product_image : "https://sodindia.com/uploads/product_images/63d11097579f5.jpg"
/// product_name : "jhodpuri paneer"
/// selling_price : "335"
/// qty_price : 670
/// product_price : "336"
/// quantity : "2"
/// vendor_name : "Shivam"
/// vendor_id : "21"
/// vendor_latitude : "22.7470519"
/// vendor_longitude : "75.8980085"

class Cart {
  Cart({
      String? productId, 
      String? cartId, 
      String? productImage, 
      String? productName, 
      String? sellingPrice, 
      num? qtyPrice, 
      String? productPrice, 
      String? quantity, 
      String? vendorName, 
      String? vendorId, 
      String? vendorLatitude, 
      String? vendorLongitude,}){
    _productId = productId;
    _cartId = cartId;
    _productImage = productImage;
    _productName = productName;
    _sellingPrice = sellingPrice;
    _qtyPrice = qtyPrice;
    _productPrice = productPrice;
    _quantity = quantity;
    _vendorName = vendorName;
    _vendorId = vendorId;
    _vendorLatitude = vendorLatitude;
    _vendorLongitude = vendorLongitude;
}

  Cart.fromJson(dynamic json) {
    _productId = json['product_id'];
    _cartId = json['cart_id'];
    _productImage = json['product_image'];
    _productName = json['product_name'];
    _sellingPrice = json['selling_price'];
    _qtyPrice = json['qty_price'];
    _productPrice = json['product_price'];
    _quantity = json['quantity'];
    _vendorName = json['vendor_name'];
    _vendorId = json['vendor_id'];
    _vendorLatitude = json['vendor_latitude'];
    _vendorLongitude = json['vendor_longitude'];
  }
  String? _productId;
  String? _cartId;
  String? _productImage;
  String? _productName;
  String? _sellingPrice;
  num? _qtyPrice;
  String? _productPrice;
  String? _quantity;
  String? _vendorName;
  String? _vendorId;
  String? _vendorLatitude;
  String? _vendorLongitude;
Cart copyWith({  String? productId,
  String? cartId,
  String? productImage,
  String? productName,
  String? sellingPrice,
  num? qtyPrice,
  String? productPrice,
  String? quantity,
  String? vendorName,
  String? vendorId,
  String? vendorLatitude,
  String? vendorLongitude,
}) => Cart(  productId: productId ?? _productId,
  cartId: cartId ?? _cartId,
  productImage: productImage ?? _productImage,
  productName: productName ?? _productName,
  sellingPrice: sellingPrice ?? _sellingPrice,
  qtyPrice: qtyPrice ?? _qtyPrice,
  productPrice: productPrice ?? _productPrice,
  quantity: quantity ?? _quantity,
  vendorName: vendorName ?? _vendorName,
  vendorId: vendorId ?? _vendorId,
  vendorLatitude: vendorLatitude ?? _vendorLatitude,
  vendorLongitude: vendorLongitude ?? _vendorLongitude,
);
  String? get productId => _productId;
  String? get cartId => _cartId;
  String? get productImage => _productImage;
  String? get productName => _productName;
  String? get sellingPrice => _sellingPrice;
  num? get qtyPrice => _qtyPrice;
  String? get productPrice => _productPrice;
  String? get quantity => _quantity;
  String? get vendorName => _vendorName;
  String? get vendorId => _vendorId;
  String? get vendorLatitude => _vendorLatitude;
  String? get vendorLongitude => _vendorLongitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['cart_id'] = _cartId;
    map['product_image'] = _productImage;
    map['product_name'] = _productName;
    map['selling_price'] = _sellingPrice;
    map['qty_price'] = _qtyPrice;
    map['product_price'] = _productPrice;
    map['quantity'] = _quantity;
    map['vendor_name'] = _vendorName;
    map['vendor_id'] = _vendorId;
    map['vendor_latitude'] = _vendorLatitude;
    map['vendor_longitude'] = _vendorLongitude;
    return map;
  }

}