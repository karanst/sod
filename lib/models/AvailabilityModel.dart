/// status : true
/// message : "Availability time"
/// data : [{"id":"151","v_id":"34","from_time":"13:01","to_time":"17:01","day":"Monday","is_set":"1"},{"id":"152","v_id":"34","from_time":"13:01","to_time":"17:01","day":"Tuesday","is_set":"1"},{"id":"153","v_id":"34","from_time":"13:01","to_time":"17:01","day":"Wednesday","is_set":"1"},{"id":"154","v_id":"34","from_time":"13:01","to_time":"17:01","day":"Thursday","is_set":"1"},{"id":"155","v_id":"34","from_time":"13:01","to_time":"17:01","day":"Friday","is_set":"1"},{"id":"156","v_id":"34","from_time":"13:01","to_time":"17:01","day":"Saturday","is_set":"1"},{"id":"157","v_id":"34","from_time":"13:01","to_time":"17:01","day":"Sunday","is_set":"1"}]

class AvailabilityModel {
  AvailabilityModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AvailabilityModel.fromJson(dynamic json) {
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
AvailabilityModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => AvailabilityModel(  status: status ?? _status,
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

/// id : "151"
/// v_id : "34"
/// from_time : "13:01"
/// to_time : "17:01"
/// day : "Monday"
/// is_set : "1"

class Data {
  Data({
      String? id, 
      String? vId, 
      String? fromTime, 
      String? toTime, 
      String? day, 
      String? isSet,}){
    _id = id;
    _vId = vId;
    _fromTime = fromTime;
    _toTime = toTime;
    _day = day;
    _isSet = isSet;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _vId = json['v_id'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _day = json['day'];
    _isSet = json['is_set'];
  }
  String? _id;
  String? _vId;
  String? _fromTime;
  String? _toTime;
  String? _day;
  String? _isSet;
Data copyWith({  String? id,
  String? vId,
  String? fromTime,
  String? toTime,
  String? day,
  String? isSet,
}) => Data(  id: id ?? _id,
  vId: vId ?? _vId,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  day: day ?? _day,
  isSet: isSet ?? _isSet,
);
  String? get id => _id;
  String? get vId => _vId;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get day => _day;
  String? get isSet => _isSet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['v_id'] = _vId;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['day'] = _day;
    map['is_set'] = _isSet;
    return map;
  }

}