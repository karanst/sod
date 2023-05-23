/// status : 1
/// msg : "Service Found"
/// imgssss : [{"cat_id":"4","cat_name":"Fast Food","product_id":"233","subcat_id":"14","product_name":"dummy","product_description":"dummy","product_price":"400","product_image":"https://sodindia.com/uploads/product_images/6437e56842c24.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"300","product_create_date":"2023-04-13 16:50:09","vendor_id":"26","other_image":"6437e5683fa27.jpg","product_status":"1","variant_name":"Half Plate","product_type":"Veg","tax":"0"}]

class GetProductsModel {
  GetProductsModel({
      num? status, 
      String? msg, 
      List<Imgssss>? imgssss,}){
    _status = status;
    _msg = msg;
    _imgssss = imgssss;
}

  GetProductsModel.fromJson(dynamic json) {
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
GetProductsModel copyWith({  num? status,
  String? msg,
  List<Imgssss>? imgssss,
}) => GetProductsModel(  status: status ?? _status,
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

/// cat_id : "4"
/// cat_name : "Fast Food"
/// product_id : "233"
/// subcat_id : "14"
/// product_name : "dummy"
/// product_description : "dummy"
/// product_price : "400"
/// product_image : "https://sodindia.com/uploads/product_images/6437e56842c24.jpg"
/// pro_ratings : "0.0"
/// role_id : "0"
/// selling_price : "300"
/// product_create_date : "2023-04-13 16:50:09"
/// vendor_id : "26"
/// other_image : "6437e5683fa27.jpg"
/// product_status : "1"
/// variant_name : "Half Plate"
/// product_type : "Veg"
/// tax : "0"

class Imgssss {
  Imgssss({
       bool? isSelected,
      String? catId, 
      String? catName, 
      String? productId, 
      String? subcatId, 
      String? productName, 
      String? productDescription, 
      String? productPrice, 
      String? productImage, 
      String? proRatings, 
      String? roleId, 
      String? sellingPrice, 
      String? productCreateDate, 
      String? vendorId, 
      String? otherImage, 
      String? productStatus, 
      String? variantName, 
      String? productType, String? noCount,
      String? tax,}){
    _isSelected = isSelected;
    _catId = catId;
    _catName = catName;
    _productId = productId;
    _subcatId = subcatId;
    _productName = productName;
    _productDescription = productDescription;
    _productPrice = productPrice;
    _productImage = productImage;
    _proRatings = proRatings;
    _roleId = roleId;
    _sellingPrice = sellingPrice;
    _productCreateDate = productCreateDate;
    _vendorId = vendorId;
    _otherImage = otherImage;
    _productStatus = productStatus;
    _variantName = variantName;
    _productType = productType;
    _tax = tax;
    _noCount = noCount;
}

  Imgssss.fromJson(dynamic json) {
    _isSelected = false;
    _catId = json['cat_id'];
    _catName = json['cat_name'];
    _productId = json['product_id'];
    _subcatId = json['subcat_id'];
    _productName = json['product_name'];
    _productDescription = json['product_description'];
    _productPrice = json['product_price'];
    _productImage = json['product_image'];
    _proRatings = json['pro_ratings'];
    _roleId = json['role_id'];
    _sellingPrice = json['selling_price'];
    _productCreateDate = json['product_create_date'];
    _vendorId = json['vendor_id'];
    _otherImage = json['other_image'];
    _productStatus = json['product_status'];
    _variantName = json['variant_name'];
    _productType = json['product_type'];
    _tax = json['tax'];
    _noCount = json['no_count'];
  }
  String? _catId;
  bool? _isSelected;
  String? _catName;
  String? _productId;
  String? _subcatId;
  String? _productName;
  String? _productDescription;
  String? _productPrice;
  String? _productImage;
  String? _proRatings;
  String? _roleId;
  String? _sellingPrice;
  String? _productCreateDate;
  String? _vendorId;
  String? _otherImage;
  String? _productStatus;
  String? _variantName;
  String? _productType;
  String? _tax;
  String? _noCount;
Imgssss copyWith({String? catId,
  bool? isSelected,
  String? catName,
  String? productId,
  String? subcatId,
  String? productName,
  String? productDescription,
  String? productPrice,
  String? productImage,
  String? proRatings,
  String? roleId,
  String? sellingPrice,
  String? productCreateDate,
  String? vendorId,
  String? otherImage,
  String? productStatus,
  String? variantName,
  String? productType,
  String? tax,
  String? noCount,
}) => Imgssss(  catId: catId ?? _catId,
  catName: catName ?? _catName,
  productId: productId ?? _productId,
  subcatId: subcatId ?? _subcatId,
  productName: productName ?? _productName,
  productDescription: productDescription ?? _productDescription,
  productPrice: productPrice ?? _productPrice,
  productImage: productImage ?? _productImage,
  proRatings: proRatings ?? _proRatings,
  roleId: roleId ?? _roleId,
  sellingPrice: sellingPrice ?? _sellingPrice,
  productCreateDate: productCreateDate ?? _productCreateDate,
  vendorId: vendorId ?? _vendorId,
  otherImage: otherImage ?? _otherImage,
  productStatus: productStatus ?? _productStatus,
  variantName: variantName ?? _variantName,
  productType: productType ?? _productType,
  tax: tax ?? _tax,
  noCount: noCount ?? _noCount,
);
  String? get catId => _catId;
  bool? get isSelected =>_isSelected;
  String? get catName => _catName;
  String? get productId => _productId;
  String? get subcatId => _subcatId;
  String? get productName => _productName;
  String? get productDescription => _productDescription;
  String? get productPrice => _productPrice;
  String? get productImage => _productImage;
  String? get proRatings => _proRatings;
  String? get roleId => _roleId;
  String? get sellingPrice => _sellingPrice;
  String? get productCreateDate => _productCreateDate;
  String? get vendorId => _vendorId;
  String? get otherImage => _otherImage;
  String? get productStatus => _productStatus;
  String? get variantName => _variantName;
  String? get productType => _productType;
  String? get tax => _tax;
  String? get noCount => _noCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSelected'] = _isSelected;
    map['cat_id'] = _catId;
    map['cat_name'] = _catName;
    map['product_id'] = _productId;
    map['subcat_id'] = _subcatId;
    map['product_name'] = _productName;
    map['product_description'] = _productDescription;
    map['product_price'] = _productPrice;
    map['product_image'] = _productImage;
    map['pro_ratings'] = _proRatings;
    map['role_id'] = _roleId;
    map['selling_price'] = _sellingPrice;
    map['product_create_date'] = _productCreateDate;
    map['vendor_id'] = _vendorId;
    map['other_image'] = _otherImage;
    map['product_status'] = _productStatus;
    map['variant_name'] = _variantName;
    map['product_type'] = _productType;
    map['tax'] = _tax;
    map['no_count'] = _noCount;
    return map;
  }

}