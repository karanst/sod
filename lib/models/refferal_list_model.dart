/// status : true
/// message : "Referral list"
/// data : [{"id":"5","user_id":"4","user_type":"2","amount":"30.00","transaction_id":"Refferal Amount Transfer-30","created_at":"2023-04-07 16:59:06","updated_at":"2023-04-07 16:59:59","refferal_status":"0","level":"level 1","refferal_id":"5","status":"1","username":"Chotu2","email":"Chotu2@gmail.com","countrycode":"91","mobile":"9988774455","password":"9368f13fc37646984ecd239f2511294e","profile_pic":"","facebook_id":"","type":"","isGold":"0","address":"","city":"","country":"","device_token":"","agreecheck":"0","otp":"4650","wallet":"80.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"refferal_code":"SOD402763","friend_code":"SOD550446","refferal_date":"2023-04-07 16:59:06"}]

class RefferalListModel {
  RefferalListModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RefferalListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
RefferalListModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => RefferalListModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "5"
/// user_id : "4"
/// user_type : "2"
/// amount : "30.00"
/// transaction_id : "Refferal Amount Transfer-30"
/// created_at : "2023-04-07 16:59:06"
/// updated_at : "2023-04-07 16:59:59"
/// refferal_status : "0"
/// level : "level 1"
/// refferal_id : "5"
/// status : "1"
/// username : "Chotu2"
/// email : "Chotu2@gmail.com"
/// countrycode : "91"
/// mobile : "9988774455"
/// password : "9368f13fc37646984ecd239f2511294e"
/// profile_pic : ""
/// facebook_id : ""
/// type : ""
/// isGold : "0"
/// address : ""
/// city : ""
/// country : ""
/// device_token : ""
/// agreecheck : "0"
/// otp : "4650"
/// wallet : "80.00"
/// oauth_provider : null
/// oauth_uid : null
/// last_login : null
/// refferal_code : "SOD402763"
/// friend_code : "SOD550446"
/// refferal_date : "2023-04-07 16:59:06"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? userType, 
      String? amount, 
      String? transactionId, 
      String? createdAt, 
      String? updatedAt, 
      String? refferalStatus, 
      String? level, 
      String? refferalId, 
      String? status, 
      String? username, 
      String? email, 
      String? countrycode, 
      String? mobile, 
      String? password, 
      String? profilePic, 
      String? facebookId, 
      String? type, 
      String? isGold, 
      String? address, 
      String? city, 
      String? country, 
      String? deviceToken, 
      String? agreecheck, 
      String? otp, 
      String? wallet, 
      dynamic oauthProvider, 
      dynamic oauthUid, 
      dynamic lastLogin, 
      String? refferalCode, 
      String? friendCode, 
      String? refferalDate,}){
    _id = id;
    _userId = userId;
    _userType = userType;
    _amount = amount;
    _transactionId = transactionId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _refferalStatus = refferalStatus;
    _level = level;
    _refferalId = refferalId;
    _status = status;
    _username = username;
    _email = email;
    _countrycode = countrycode;
    _mobile = mobile;
    _password = password;
    _profilePic = profilePic;
    _facebookId = facebookId;
    _type = type;
    _isGold = isGold;
    _address = address;
    _city = city;
    _country = country;
    _deviceToken = deviceToken;
    _agreecheck = agreecheck;
    _otp = otp;
    _wallet = wallet;
    _oauthProvider = oauthProvider;
    _oauthUid = oauthUid;
    _lastLogin = lastLogin;
    _refferalCode = refferalCode;
    _friendCode = friendCode;
    _refferalDate = refferalDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _amount = json['amount'];
    _transactionId = json['transaction_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _refferalStatus = json['refferal_status'];
    _level = json['level'];
    _refferalId = json['refferal_id'];
    _status = json['status'];
    _username = json['username'];
    _email = json['email'];
    _countrycode = json['countrycode'];
    _mobile = json['mobile'];
    _password = json['password'];
    _profilePic = json['profile_pic'];
    _facebookId = json['facebook_id'];
    _type = json['type'];
    _isGold = json['isGold'];
    _address = json['address'];
    _city = json['city'];
    _country = json['country'];
    _deviceToken = json['device_token'];
    _agreecheck = json['agreecheck'];
    _otp = json['otp'];
    _wallet = json['wallet'];
    _oauthProvider = json['oauth_provider'];
    _oauthUid = json['oauth_uid'];
    _lastLogin = json['last_login'];
    _refferalCode = json['refferal_code'];
    _friendCode = json['friend_code'];
    _refferalDate = json['refferal_date'];
  }
  String? _id;
  String? _userId;
  String? _userType;
  String? _amount;
  String? _transactionId;
  String? _createdAt;
  String? _updatedAt;
  String? _refferalStatus;
  String? _level;
  String? _refferalId;
  String? _status;
  String? _username;
  String? _email;
  String? _countrycode;
  String? _mobile;
  String? _password;
  String? _profilePic;
  String? _facebookId;
  String? _type;
  String? _isGold;
  String? _address;
  String? _city;
  String? _country;
  String? _deviceToken;
  String? _agreecheck;
  String? _otp;
  String? _wallet;
  dynamic _oauthProvider;
  dynamic _oauthUid;
  dynamic _lastLogin;
  String? _refferalCode;
  String? _friendCode;
  String? _refferalDate;
Data copyWith({  String? id,
  String? userId,
  String? userType,
  String? amount,
  String? transactionId,
  String? createdAt,
  String? updatedAt,
  String? refferalStatus,
  String? level,
  String? refferalId,
  String? status,
  String? username,
  String? email,
  String? countrycode,
  String? mobile,
  String? password,
  String? profilePic,
  String? facebookId,
  String? type,
  String? isGold,
  String? address,
  String? city,
  String? country,
  String? deviceToken,
  String? agreecheck,
  String? otp,
  String? wallet,
  dynamic oauthProvider,
  dynamic oauthUid,
  dynamic lastLogin,
  String? refferalCode,
  String? friendCode,
  String? refferalDate,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  userType: userType ?? _userType,
  amount: amount ?? _amount,
  transactionId: transactionId ?? _transactionId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  refferalStatus: refferalStatus ?? _refferalStatus,
  level: level ?? _level,
  refferalId: refferalId ?? _refferalId,
  status: status ?? _status,
  username: username ?? _username,
  email: email ?? _email,
  countrycode: countrycode ?? _countrycode,
  mobile: mobile ?? _mobile,
  password: password ?? _password,
  profilePic: profilePic ?? _profilePic,
  facebookId: facebookId ?? _facebookId,
  type: type ?? _type,
  isGold: isGold ?? _isGold,
  address: address ?? _address,
  city: city ?? _city,
  country: country ?? _country,
  deviceToken: deviceToken ?? _deviceToken,
  agreecheck: agreecheck ?? _agreecheck,
  otp: otp ?? _otp,
  wallet: wallet ?? _wallet,
  oauthProvider: oauthProvider ?? _oauthProvider,
  oauthUid: oauthUid ?? _oauthUid,
  lastLogin: lastLogin ?? _lastLogin,
  refferalCode: refferalCode ?? _refferalCode,
  friendCode: friendCode ?? _friendCode,
  refferalDate: refferalDate ?? _refferalDate,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get userType => _userType;
  String? get amount => _amount;
  String? get transactionId => _transactionId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get refferalStatus => _refferalStatus;
  String? get level => _level;
  String? get refferalId => _refferalId;
  String? get status => _status;
  String? get username => _username;
  String? get email => _email;
  String? get countrycode => _countrycode;
  String? get mobile => _mobile;
  String? get password => _password;
  String? get profilePic => _profilePic;
  String? get facebookId => _facebookId;
  String? get type => _type;
  String? get isGold => _isGold;
  String? get address => _address;
  String? get city => _city;
  String? get country => _country;
  String? get deviceToken => _deviceToken;
  String? get agreecheck => _agreecheck;
  String? get otp => _otp;
  String? get wallet => _wallet;
  dynamic get oauthProvider => _oauthProvider;
  dynamic get oauthUid => _oauthUid;
  dynamic get lastLogin => _lastLogin;
  String? get refferalCode => _refferalCode;
  String? get friendCode => _friendCode;
  String? get refferalDate => _refferalDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['amount'] = _amount;
    map['transaction_id'] = _transactionId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['refferal_status'] = _refferalStatus;
    map['level'] = _level;
    map['refferal_id'] = _refferalId;
    map['status'] = _status;
    map['username'] = _username;
    map['email'] = _email;
    map['countrycode'] = _countrycode;
    map['mobile'] = _mobile;
    map['password'] = _password;
    map['profile_pic'] = _profilePic;
    map['facebook_id'] = _facebookId;
    map['type'] = _type;
    map['isGold'] = _isGold;
    map['address'] = _address;
    map['city'] = _city;
    map['country'] = _country;
    map['device_token'] = _deviceToken;
    map['agreecheck'] = _agreecheck;
    map['otp'] = _otp;
    map['wallet'] = _wallet;
    map['oauth_provider'] = _oauthProvider;
    map['oauth_uid'] = _oauthUid;
    map['last_login'] = _lastLogin;
    map['refferal_code'] = _refferalCode;
    map['friend_code'] = _friendCode;
    map['refferal_date'] = _refferalDate;
    return map;
  }

}