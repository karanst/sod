/// status : 1
/// msg : "Hours Found"
/// data : [{"id":"1","hours":"1"},{"id":"2","hours":"2"},{"id":"3","hours":"10"}]

class GetHoursModel {
  GetHoursModel({
      num? status, 
      String? msg, 
      List<Data>? data,}){
    _status = status;
    _msg = msg;
    _data = data;
}

  GetHoursModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  String? _msg;
  List<Data>? _data;
GetHoursModel copyWith({  num? status,
  String? msg,
  List<Data>? data,
}) => GetHoursModel(  status: status ?? _status,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  num? get status => _status;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// hours : "1"

class Data {
  Data({
      String? id, 
      String? hours,}){
    _id = id;
    _hours = hours;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _hours = json['hours'];
  }
  String? _id;
  String? _hours;
Data copyWith({  String? id,
  String? hours,
}) => Data(  id: id ?? _id,
  hours: hours ?? _hours,
);
  String? get id => _id;
  String? get hours => _hours;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['hours'] = _hours;
    return map;
  }

}