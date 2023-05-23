/// status : 1
/// msg : "Banners Found"
/// Banners : ["https://sodindia.com/uploads/6433d99d0d390.png","https://sodindia.com/uploads/63cbebcf2a378.jpeg","https://sodindia.com/uploads/63cbebb606f77.jpeg","https://sodindia.com/uploads/63cbaf3250bdb.jpeg","https://sodindia.com/uploads/63cbaf27051e6.jpeg"]

class BannerModal {
  BannerModal({
      num? status, 
      String? msg, 
      List<String>? banners,}){
    _status = status;
    _msg = msg;
    _banners = banners;
}

  BannerModal.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _banners = json['Banners'] != null ? json['Banners'].cast<String>() : [];
  }
  num? _status;
  String? _msg;
  List<String>? _banners;
BannerModal copyWith({  num? status,
  String? msg,
  List<String>? banners,
}) => BannerModal(  status: status ?? _status,
  msg: msg ?? _msg,
  banners: banners ?? _banners,
);
  num? get status => _status;
  String? get msg => _msg;
  List<String>? get banners => _banners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    map['Banners'] = _banners;
    return map;
  }

}