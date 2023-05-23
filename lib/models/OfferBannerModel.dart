/// status : 1
/// msg : "Banners Found"
/// Banners : [{"id":"7","url":"https://sodindia.com/website/service_provider","image":"64342706eb0a3.png"}]
/// title : "Offer Banner"

class OfferBannerModel {
  OfferBannerModel({
      num? status, 
      String? msg, 
      List<Banners>? banners, 
      String? title,}){
    _status = status;
    _msg = msg;
    _banners = banners;
    _title = title;
}

  OfferBannerModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['Banners'] != null) {
      _banners = [];
      json['Banners'].forEach((v) {
        _banners?.add(Banners.fromJson(v));
      });
    }
    _title = json['title'];
  }
  num? _status;
  String? _msg;
  List<Banners>? _banners;
  String? _title;
OfferBannerModel copyWith({  num? status,
  String? msg,
  List<Banners>? banners,
  String? title,
}) => OfferBannerModel(  status: status ?? _status,
  msg: msg ?? _msg,
  banners: banners ?? _banners,
  title: title ?? _title,
);
  num? get status => _status;
  String? get msg => _msg;
  List<Banners>? get banners => _banners;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_banners != null) {
      map['Banners'] = _banners?.map((v) => v.toJson()).toList();
    }
    map['title'] = _title;
    return map;
  }

}

/// id : "7"
/// url : "https://sodindia.com/website/service_provider"
/// image : "64342706eb0a3.png"

class Banners {
  Banners({
      String? id, 
      String? url, 
      String? image,}){
    _id = id;
    _url = url;
    _image = image;
}

  Banners.fromJson(dynamic json) {
    _id = json['id'];
    _url = json['url'];
    _image = json['image'];
  }
  String? _id;
  String? _url;
  String? _image;
Banners copyWith({  String? id,
  String? url,
  String? image,
}) => Banners(  id: id ?? _id,
  url: url ?? _url,
  image: image ?? _image,
);
  String? get id => _id;
  String? get url => _url;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['url'] = _url;
    map['image'] = _image;
    return map;
  }

}