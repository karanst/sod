/// status : true
/// message : "Food Price"
/// deliver_charge : "66.36"
/// gst : "11.94"
/// gst_type : "include"
/// gst_charge : "18"
/// vendor_gst : "3.6"
/// vendor_delivery_charge : "20"
/// subtotal_gst_charge : "55"
/// subtotal_gst_percentage : "5"
/// total : "1233.30"

class DeliveryChargeDistanceModel {
  DeliveryChargeDistanceModel({
      bool? status, 
      String? message, 
      String? deliverCharge, 
      String? gst, 
      String? gstType, 
      String? gstCharge, 
      String? vendorGst, 
      String? vendorDeliveryCharge, 
      String? subtotalGstCharge, 
      String? subtotalGstPercentage, 
      String? total,}){
    _status = status;
    _message = message;
    _deliverCharge = deliverCharge;
    _gst = gst;
    _gstType = gstType;
    _gstCharge = gstCharge;
    _vendorGst = vendorGst;
    _vendorDeliveryCharge = vendorDeliveryCharge;
    _subtotalGstCharge = subtotalGstCharge;
    _subtotalGstPercentage = subtotalGstPercentage;
    _total = total;
}

  DeliveryChargeDistanceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _deliverCharge = json['deliver_charge'];
    _gst = json['gst'];
    _gstType = json['gst_type'];
    _gstCharge = json['gst_charge'];
    _vendorGst = json['vendor_gst'];
    _vendorDeliveryCharge = json['vendor_delivery_charge'];
    _subtotalGstCharge = json['subtotal_gst_charge'];
    _subtotalGstPercentage = json['subtotal_gst_percentage'];
    _total = json['total'];
  }
  bool? _status;
  String? _message;
  String? _deliverCharge;
  String? _gst;
  String? _gstType;
  String? _gstCharge;
  String? _vendorGst;
  String? _vendorDeliveryCharge;
  String? _subtotalGstCharge;
  String? _subtotalGstPercentage;
  String? _total;
DeliveryChargeDistanceModel copyWith({  bool? status,
  String? message,
  String? deliverCharge,
  String? gst,
  String? gstType,
  String? gstCharge,
  String? vendorGst,
  String? vendorDeliveryCharge,
  String? subtotalGstCharge,
  String? subtotalGstPercentage,
  String? total,
}) => DeliveryChargeDistanceModel(  status: status ?? _status,
  message: message ?? _message,
  deliverCharge: deliverCharge ?? _deliverCharge,
  gst: gst ?? _gst,
  gstType: gstType ?? _gstType,
  gstCharge: gstCharge ?? _gstCharge,
  vendorGst: vendorGst ?? _vendorGst,
  vendorDeliveryCharge: vendorDeliveryCharge ?? _vendorDeliveryCharge,
  subtotalGstCharge: subtotalGstCharge ?? _subtotalGstCharge,
  subtotalGstPercentage: subtotalGstPercentage ?? _subtotalGstPercentage,
  total: total ?? _total,
);
  bool? get status => _status;
  String? get message => _message;
  String? get deliverCharge => _deliverCharge;
  String? get gst => _gst;
  String? get gstType => _gstType;
  String? get gstCharge => _gstCharge;
  String? get vendorGst => _vendorGst;
  String? get vendorDeliveryCharge => _vendorDeliveryCharge;
  String? get subtotalGstCharge => _subtotalGstCharge;
  String? get subtotalGstPercentage => _subtotalGstPercentage;
  String? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['deliver_charge'] = _deliverCharge;
    map['gst'] = _gst;
    map['gst_type'] = _gstType;
    map['gst_charge'] = _gstCharge;
    map['vendor_gst'] = _vendorGst;
    map['vendor_delivery_charge'] = _vendorDeliveryCharge;
    map['subtotal_gst_charge'] = _subtotalGstCharge;
    map['subtotal_gst_percentage'] = _subtotalGstPercentage;
    map['total'] = _total;
    return map;
  }

}