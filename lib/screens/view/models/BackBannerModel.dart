/// status : 1
/// msg : "Banner Back Image"
/// data : {"banner":"https://sodindia.com/uploads/category_images/643ff04b7f03c.png"}

class BackBannerModel {
  BackBannerModel({
      num? status, 
      String? msg, 
      Data? data,}){
    _status = status;
    _msg = msg;
    _data = data;
}

  BackBannerModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _msg;
  Data? _data;
BackBannerModel copyWith({  num? status,
  String? msg,
  Data? data,
}) => BackBannerModel(  status: status ?? _status,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get status => _status;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// banner : "https://sodindia.com/uploads/category_images/643ff04b7f03c.png"

class Data {
  Data({
      String? banner,}){
    _banner = banner;
}

  Data.fromJson(dynamic json) {
    _banner = json['banner'];
  }
  String? _banner;
Data copyWith({  String? banner,
}) => Data(  banner: banner ?? _banner,
);
  String? get banner => _banner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['banner'] = _banner;
    return map;
  }

}