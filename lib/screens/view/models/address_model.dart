/// response_code : "1"
/// msg : "User address list"
/// data : [{"id":"181","user_id":"3","address":"Kishanpole Bazar Rd, Jayanti Market, Pink City, Jaipur, Rajasthan 302002, India","building":"","city":"","pincode":"0","state":"","country":"","is_default":"0","is_set_for":"Home","lat":"26.917907","lng":"75.81682889999999","alt_mobile":null,"created_at":"2023-04-17 13:24:42","updated_at":"2023-04-17 13:24:42","name":null},{"id":"179","user_id":"3","address":"F112, near Tejas Nursing Home, Sector F, LIG Colony, Indore, Madhya Pradesh 452008, India","building":"","city":"","pincode":"0","state":"","country":"","is_default":"0","is_set_for":"Home","lat":"22.7378479","lng":"75.8882395","alt_mobile":null,"created_at":"2023-04-14 11:40:31","updated_at":"2023-04-14 11:40:31","name":""},{"id":"178","user_id":"3","address":"1, Tonk Rd, Dev Nagar, Tonk Phatak, Jaipur, Rajasthan 302015, India","building":"","city":"","pincode":"0","state":"","country":"","is_default":"0","is_set_for":"Home","lat":"26.8675657","lng":"75.79648759999999","alt_mobile":null,"created_at":"2023-04-13 18:54:13","updated_at":"2023-04-13 18:54:13","name":""},{"id":"177","user_id":"3","address":"1, Tonk Fatak Rd, Chitragupta Nagar-II, Ambedkar Nagar, Tonk Phatak, Jaipur, Rajasthan 302015, India","building":"","city":"","pincode":"0","state":"","country":"","is_default":"0","is_set_for":"Home","lat":"26.8837205","lng":"75.7913433","alt_mobile":null,"created_at":"2023-04-13 18:54:02","updated_at":"2023-04-13 18:54:02","name":""},{"id":"176","user_id":"3","address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","building":"","city":"","pincode":"0","state":"","country":"","is_default":"0","is_set_for":"Home","lat":"22.7532848","lng":"75.8936962","alt_mobile":null,"created_at":"2023-04-13 17:00:40","updated_at":"2023-04-13 17:00:40","name":""}]

class AddressModel {
  AddressModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  AddressModel.fromJson(dynamic json) {
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
AddressModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => AddressModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "181"
/// user_id : "3"
/// address : "Kishanpole Bazar Rd, Jayanti Market, Pink City, Jaipur, Rajasthan 302002, India"
/// building : ""
/// city : ""
/// pincode : "0"
/// state : ""
/// country : ""
/// is_default : "0"
/// is_set_for : "Home"
/// lat : "26.917907"
/// lng : "75.81682889999999"
/// alt_mobile : null
/// created_at : "2023-04-17 13:24:42"
/// updated_at : "2023-04-17 13:24:42"
/// name : null

class Data {
  Data({
      String? id, 
      String? userId, 
      String? address, 
      String? building, 
      String? city, 
      String? pincode, 
      String? state, 
      String? country, 
      String? isDefault, 
      String? isSetFor, 
      String? lat, 
      String? lng, 
      dynamic altMobile, 
      String? createdAt, 
      String? updatedAt, 
      dynamic name,}){
    _id = id;
    _userId = userId;
    _address = address;
    _building = building;
    _city = city;
    _pincode = pincode;
    _state = state;
    _country = country;
    _isDefault = isDefault;
    _isSetFor = isSetFor;
    _lat = lat;
    _lng = lng;
    _altMobile = altMobile;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _address = json['address'];
    _building = json['building'];
    _city = json['city'];
    _pincode = json['pincode'];
    _state = json['state'];
    _country = json['country'];
    _isDefault = json['is_default'];
    _isSetFor = json['is_set_for'];
    _lat = json['lat'];
    _lng = json['lng'];
    _altMobile = json['alt_mobile'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _name = json['name'];
  }
  String? _id;
  String? _userId;
  String? _address;
  String? _building;
  String? _city;
  String? _pincode;
  String? _state;
  String? _country;
  String? _isDefault;
  String? _isSetFor;
  String? _lat;
  String? _lng;
  dynamic _altMobile;
  String? _createdAt;
  String? _updatedAt;
  dynamic _name;
Data copyWith({  String? id,
  String? userId,
  String? address,
  String? building,
  String? city,
  String? pincode,
  String? state,
  String? country,
  String? isDefault,
  String? isSetFor,
  String? lat,
  String? lng,
  dynamic altMobile,
  String? createdAt,
  String? updatedAt,
  dynamic name,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  address: address ?? _address,
  building: building ?? _building,
  city: city ?? _city,
  pincode: pincode ?? _pincode,
  state: state ?? _state,
  country: country ?? _country,
  isDefault: isDefault ?? _isDefault,
  isSetFor: isSetFor ?? _isSetFor,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  altMobile: altMobile ?? _altMobile,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  name: name ?? _name,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get address => _address;
  String? get building => _building;
  String? get city => _city;
  String? get pincode => _pincode;
  String? get state => _state;
  String? get country => _country;
  String? get isDefault => _isDefault;
  String? get isSetFor => _isSetFor;
  String? get lat => _lat;
  String? get lng => _lng;
  dynamic get altMobile => _altMobile;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['address'] = _address;
    map['building'] = _building;
    map['city'] = _city;
    map['pincode'] = _pincode;
    map['state'] = _state;
    map['country'] = _country;
    map['is_default'] = _isDefault;
    map['is_set_for'] = _isSetFor;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['alt_mobile'] = _altMobile;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['name'] = _name;
    return map;
  }

}