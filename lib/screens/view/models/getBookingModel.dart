class GetBookingModel {
  int? status;
  String? msg;
  List<Booking>? booking;

  GetBookingModel({this.status, this.msg, this.booking});

  GetBookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['booking'] != null) {
      // ignore: deprecated_member_use
      booking = <Booking>[];
      json['booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.booking != null) {
      data['booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  String? id;
  String? date;
  String? total;
  String? slot;
  String? otp;
  String? userId;
  String? resId;
  String? status;
  String? amount;
  String? isPaid;
  String? txnId;
  String? pDate;
  Service? service;
  String? address;

  Booking(
      {this.id,
      this.date,
      this.slot,
      this.otp,
      this.userId,
      this.isPaid,
      this.resId,
        this.total,
      this.status,
      this.amount,
      this.txnId,
      this.pDate,
      this.service,
      this.address});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    slot = json['slot'];
    total = json['total'];
    isPaid = json['is_paid'];
    userId = json['user_id'];
    otp = json['otp'];
    resId = json['res_id'];
    status = json['status'];
    amount = json['amount'];
    txnId = json['txn_id'];
    pDate = json['p_date'];
    address = json['address'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['otp'] = this.otp;
    data['total'] = this.total;
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['is_paid'] = this.isPaid;
    data['user_id'] = this.userId;
    data['res_id'] = this.resId;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['txn_id'] = this.txnId;
    data['p_date'] = this.pDate;
    data['address'] = this.address;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  String? resId;
  String? catId;
  String? vendorId;
  String? vendorName;
  String? vendorImage;
  String? scatId;
  String? resName;
  String? resNameU;
  String? resDesc;
  String? resDescU;
  String? resWebsite;
  ResImage? resImage;
  String? logo;
  String? resPhone;
  String? resAddress;
  String? resIsOpen;
  String? resStatus;
  String? resCreateDate;
  String? resRatings;
  String? status;
  String? resVideo;
  String? resUrl;
  String? mfo;
  String? lat;
  String? lon;
  String? vid;
  String? structure;
  String? cName;
  int? reviewCount;
  int? viewCount;
  List<String>? allImage;

  Service(
      {this.resId,
      this.catId,
      this.scatId,
      this.resName,
      this.resNameU,
      this.vendorId,
      this.vendorName,
      this.vendorImage,
      this.resDesc,
      this.resDescU,
      this.resWebsite,
      this.resImage,
      this.logo,
      this.resPhone,
      this.resAddress,
      this.resIsOpen,
      this.resStatus,
      this.resCreateDate,
      this.resRatings,
      this.status,
      this.resVideo,
      this.resUrl,
      this.mfo,
      this.lat,
      this.lon,
      this.vid,
      this.structure,
      this.cName,
      this.reviewCount,
      this.viewCount,
      this.allImage});

  Service.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    catId = json['cat_id'];
    vendorId = json['provider_id'];
    vendorName = json['provider_name'];
    vendorImage = json['provider_image'];
    scatId = json['scat_id'];
    resName = json['res_name'];
    resNameU = json['res_name_u'];
    resDesc = json['res_desc'];
    resDescU = json['res_desc_u'];
    resWebsite = json['res_website'];
    resImage = json['res_image'] != null
        ? new ResImage.fromJson(json['res_image'])
        : null;
    logo = json['logo'];
    resPhone = json['res_phone'];
    resAddress = json['res_address'];
    resIsOpen = json['res_isOpen'];
    resStatus = json['res_status'];
    resCreateDate = json['res_create_date'];
    resRatings = json['res_ratings'];
    status = json['status'];
    resVideo = json['res_video'];
    resUrl = json['res_url'];
    mfo = json['mfo'];
    lat = json['lat'];
    lon = json['lon'];
    vid = json['vid'];
    structure = json['structure'];
    cName = json['c_name'];
    reviewCount = json['review_count'];
    viewCount = json['view_count'];
    allImage = json['all_image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_id'] = this.resId;
    data['cat_id'] = this.catId;
    data['scat_id'] = this.scatId;
    data['provider_image'] = this.vendorImage;
    data['provider_name'] = this.vendorName;
    data['provider_id'] = this.vendorId;
    data['res_name'] = this.resName;
    data['res_name_u'] = this.resNameU;
    data['res_desc'] = this.resDesc;
    data['res_desc_u'] = this.resDescU;
    data['res_website'] = this.resWebsite;
    if (this.resImage != null) {
      data['res_image'] = this.resImage!.toJson();
    }
    data['logo'] = this.logo;
    data['res_phone'] = this.resPhone;
    data['res_address'] = this.resAddress;
    data['res_isOpen'] = this.resIsOpen;
    data['res_status'] = this.resStatus;
    data['res_create_date'] = this.resCreateDate;
    data['res_ratings'] = this.resRatings;
    data['status'] = this.status;
    data['res_video'] = this.resVideo;
    data['res_url'] = this.resUrl;
    data['mfo'] = this.mfo;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['vid'] = this.vid;
    data['structure'] = this.structure;
    data['c_name'] = this.cName;
    data['review_count'] = this.reviewCount;
    data['view_count'] = this.viewCount;
    data['all_image'] = this.allImage;
    return data;
  }
}

class ResImage {
  String? resImag0;
  String? resImag1;
  String? resImag2;

  ResImage({this.resImag0, this.resImag1, this.resImag2});

  ResImage.fromJson(Map<String, dynamic> json) {
    resImag0 = json['res_imag0'];
    resImag1 = json['res_imag1'];
    resImag2 = json['res_imag2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_imag0'] = this.resImag0;
    data['res_imag1'] = this.resImag1;
    data['res_imag2'] = this.resImag2;
    return data;
  }
}
