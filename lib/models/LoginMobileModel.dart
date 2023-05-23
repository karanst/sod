/// status : true
/// message : "OTP send success 9621"
/// otp : 9621

class LoginMobileModel {
  LoginMobileModel({
      bool? status, 
      String? message, 
      num? otp,}){
    _status = status;
    _message = message;
    _otp = otp;
}

  LoginMobileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _otp = json['otp'];
  }
  bool? _status;
  String? _message;
  num? _otp;
LoginMobileModel copyWith({  bool? status,
  String? message,
  num? otp,
}) => LoginMobileModel(  status: status ?? _status,
  message: message ?? _message,
  otp: otp ?? _otp,
);
  bool? get status => _status;
  String? get message => _message;
  num? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['otp'] = _otp;
    return map;
  }

}