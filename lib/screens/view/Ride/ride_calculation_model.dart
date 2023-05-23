/// status : true
/// message : "Ride Price"
/// sub_total : "33.90"
/// gst : "6.10"
/// gst_type : "include"
/// gst_charge : "18"
/// finalTotal : "40.00"

class RideCalculationModel {
  RideCalculationModel({
      bool? status, 
      String? message, 
      String? subTotal, 
      String? gst, 
      String? gstType, 
      String? gstCharge, 
      String? finalTotal,}){
    _status = status;
    _message = message;
    _subTotal = subTotal;
    _gst = gst;
    _gstType = gstType;
    _gstCharge = gstCharge;
    _finalTotal = finalTotal;
}

  RideCalculationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _subTotal = json['sub_total'];
    _gst = json['gst'];
    _gstType = json['gst_type'];
    _gstCharge = json['gst_charge'];
    _finalTotal = json['finalTotal'];
  }
  bool? _status;
  String? _message;
  String? _subTotal;
  String? _gst;
  String? _gstType;
  String? _gstCharge;
  String? _finalTotal;
RideCalculationModel copyWith({  bool? status,
  String? message,
  String? subTotal,
  String? gst,
  String? gstType,
  String? gstCharge,
  String? finalTotal,
}) => RideCalculationModel(  status: status ?? _status,
  message: message ?? _message,
  subTotal: subTotal ?? _subTotal,
  gst: gst ?? _gst,
  gstType: gstType ?? _gstType,
  gstCharge: gstCharge ?? _gstCharge,
  finalTotal: finalTotal ?? _finalTotal,
);
  bool? get status => _status;
  String? get message => _message;
  String? get subTotal => _subTotal;
  String? get gst => _gst;
  String? get gstType => _gstType;
  String? get gstCharge => _gstCharge;
  String? get finalTotal => _finalTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['sub_total'] = _subTotal;
    map['gst'] = _gst;
    map['gst_type'] = _gstType;
    map['gst_charge'] = _gstCharge;
    map['finalTotal'] = _finalTotal;
    return map;
  }

}