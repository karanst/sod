/// status : true
/// message : "Parcel Price"
/// sub_total : "150.00"
/// gst : "27.00"
/// finalTotal : "177.00"

class ParcelPriceModel {
  ParcelPriceModel({
      bool? status, 
      String? message, 
      String? subTotal, 
      String? gst, 
      String? finalTotal,}){
    _status = status;
    _message = message;
    _subTotal = subTotal;
    _gst = gst;
    _finalTotal = finalTotal;
}

  ParcelPriceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _subTotal = json['sub_total'];
    _gst = json['gst'];
    _finalTotal = json['finalTotal'];
  }
  bool? _status;
  String? _message;
  String? _subTotal;
  String? _gst;
  String? _finalTotal;
ParcelPriceModel copyWith({  bool? status,
  String? message,
  String? subTotal,
  String? gst,
  String? finalTotal,
}) => ParcelPriceModel(  status: status ?? _status,
  message: message ?? _message,
  subTotal: subTotal ?? _subTotal,
  gst: gst ?? _gst,
  finalTotal: finalTotal ?? _finalTotal,
);
  bool? get status => _status;
  String? get message => _message;
  String? get subTotal => _subTotal;
  String? get gst => _gst;
  String? get finalTotal => _finalTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['sub_total'] = _subTotal;
    map['gst'] = _gst;
    map['finalTotal'] = _finalTotal;
    return map;
  }

}