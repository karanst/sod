/// status : 1
/// msg : "Banners Found"
/// Banners : [{"id":"4","image":"https://sodindia.com/uploads/6450eb91f3d14.jpg"}]

class MarqueeBannerModel {
  MarqueeBannerModel({
      num? status, 
      String? msg, 
      List<Banners>? banners,}){
    _status = status;
    _msg = msg;
    _banners = banners;
}

  MarqueeBannerModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['Banners'] != null) {
      _banners = [];
      json['Banners'].forEach((v) {
        _banners?.add(Banners.fromJson(v));
      });
    }
  }
  num? _status;
  String? _msg;
  List<Banners>? _banners;
MarqueeBannerModel copyWith({  num? status,
  String? msg,
  List<Banners>? banners,
}) => MarqueeBannerModel(  status: status ?? _status,
  msg: msg ?? _msg,
  banners: banners ?? _banners,
);
  num? get status => _status;
  String? get msg => _msg;
  List<Banners>? get banners => _banners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_banners != null) {
      map['Banners'] = _banners?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "4"
/// image : "https://sodindia.com/uploads/6450eb91f3d14.jpg"

class Banners {
  Banners({
      String? id, 
      String? image,}){
    _id = id;
    _image = image;
}

  Banners.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
  }
  String? _id;
  String? _image;
Banners copyWith({  String? id,
  String? image,
}) => Banners(  id: id ?? _id,
  image: image ?? _image,
);
  String? get id => _id;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    return map;
  }

}