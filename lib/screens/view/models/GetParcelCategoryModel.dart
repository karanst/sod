/// status : true
/// message : "Get Parcel Category Successfully"
/// data : [{"id":"2","parent_id":"2","name":"Gift"},{"id":"3","parent_id":"2","name":"Document"}]

class GetParcelCategoryModel {
  GetParcelCategoryModel({
      bool? status, 
      String? message, 
      List<Data2>? data,}){
    _status = status;
    _message = message;
    _data = data;
}
  GetParcelCategoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data2.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data2>? _data;
GetParcelCategoryModel copyWith({  bool? status,
  String? message,
  List<Data2>? data,
}) => GetParcelCategoryModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data2>? get data => _data;

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

/// id : "2"
/// parent_id : "2"
/// name : "Gift"

class Data2 {
  Data2({
      String? id, 
      String? parentId, 
      String? name,}){
    _id = id;
    _parentId = parentId;
    _name = name;
}

  Data2.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
  }
  String? _id;
  String? _parentId;
  String? _name;
Data2 copyWith({  String? id,
  String? parentId,
  String? name,
}) => Data2(  id: id ?? _id,
  parentId: parentId ?? _parentId,
  name: name ?? _name,
);
  String? get id => _id;
  String? get parentId => _parentId;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['name'] = _name;
    return map;
  }

}