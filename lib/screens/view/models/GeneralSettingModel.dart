/// status : 1
/// msg : "Setting Found"
/// setting : {"id":"1","n_server_key":"AAAA0I6gvao:APA91bENmsxDZy6OLKvZ-lC66o2lXgNBJugEwgRs8h7YG1D-7Y0IsB5dLrhE5Q8jsbFyILKsp0v4IPKZ6D2ybIqTxesVkiVfsXgXQ8F0bh3nCvFgb1rzzMblqUddvOP78bIfc-68JJ2X","s_secret_key":"sk_test_Vcv04sLCi00ljN3C8GqrpDmw00SJk0bP62","s_public_key":"pk_test_asd3w4refds4werfweasfdfwwrwdfs4343","r_secret_key":"fnwpQ69iqzV5Aq0GUiG5sC71","r_public_key":"rzp_test_dv9hJ9iSfC2Far","twitter_url":"https://twitter.com/Serviceondeman3/status/1608113486734979073?t=YTclNRPgd5xN2wzd3sedtw&s=19","likend_in_url":"https://www.linkedin.com/posts/surendra-khatana-25739425a_housecleaning-cleaning-cleaningservice-activity-7013879001656012801-K2M-?utm_source=share&utm_medium=member_android","instaram_url":"https://www.instagram.com/p/CmtzDpMhgrv/?igshid=YmMyMTA2M2Y=","facebook_url":"https://www.facebook.com/100088498003949/posts/120213467605253/?mibextid=cr9u03","address":"MI road Jaipur 302002 Rajasthan India","email":"hello@sodindia.com","contact_no":"9001887487","per_km_charge":"","gst_charge":"5","ride_gst_charge":"18","parcel_gst_charge":"18","radius":"10000","advanced_amount":"","youtube_url":"https://youtube.com/@serviceondemandd","app_store_url":"https://www.apple.com/in/app-store/","play_store_url":"https://play.google.com/store/games?hl=en&gl=US","handy_man_status":"1","event_status":"0","event":"18","handy":"18","parcel_delivery_status":"1","mehndi_gst_charge":"18","two_wheeler":"18","three_wheeler":"18","four_wheeler":"18","food_driver_gst":"50","handy_fixed_amount":"100","aap_orderfood_cat_image":"6442d4dc63862.png","aap_bookride_cat_image":"6442d4dc639c6.png","aap_sendpackage_cat_image":"aap_sendpackage_cat_image.png","aap_handyman_cat_image":"aap_handyman_cat_image.png","aap_mehndi_cat_image":"aap_mehndi_cat_image.png","web_orderfood_cat_image":"64423d525aa13.png","web_bookride_cat_image":"644273d1b5ec3.png","web_sendpackage_cat_image":"64423f112e6a3.png","web_handyman_cat_image":"6442813aa3931.png","web_mehndi_cat_image":"64427b90d2054.png","aap_back_banner_image":"6456710cd9747.png","web_show_ride_image":"64439ccb6aca7.png","web_show_sendpackage_image":"6441501118629.png","aap_profile_back_image":"6454ba96c6e11.png"}

class GeneralSettingModel {
  GeneralSettingModel({
      num? status, 
      String? msg, 
      Setting? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  GeneralSettingModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
  }
  num? _status;
  String? _msg;
  Setting? _setting;
GeneralSettingModel copyWith({  num? status,
  String? msg,
  Setting? setting,
}) => GeneralSettingModel(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  num? get status => _status;
  String? get msg => _msg;
  Setting? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// n_server_key : "AAAA0I6gvao:APA91bENmsxDZy6OLKvZ-lC66o2lXgNBJugEwgRs8h7YG1D-7Y0IsB5dLrhE5Q8jsbFyILKsp0v4IPKZ6D2ybIqTxesVkiVfsXgXQ8F0bh3nCvFgb1rzzMblqUddvOP78bIfc-68JJ2X"
/// s_secret_key : "sk_test_Vcv04sLCi00ljN3C8GqrpDmw00SJk0bP62"
/// s_public_key : "pk_test_asd3w4refds4werfweasfdfwwrwdfs4343"
/// r_secret_key : "fnwpQ69iqzV5Aq0GUiG5sC71"
/// r_public_key : "rzp_test_dv9hJ9iSfC2Far"
/// twitter_url : "https://twitter.com/Serviceondeman3/status/1608113486734979073?t=YTclNRPgd5xN2wzd3sedtw&s=19"
/// likend_in_url : "https://www.linkedin.com/posts/surendra-khatana-25739425a_housecleaning-cleaning-cleaningservice-activity-7013879001656012801-K2M-?utm_source=share&utm_medium=member_android"
/// instaram_url : "https://www.instagram.com/p/CmtzDpMhgrv/?igshid=YmMyMTA2M2Y="
/// facebook_url : "https://www.facebook.com/100088498003949/posts/120213467605253/?mibextid=cr9u03"
/// address : "MI road Jaipur 302002 Rajasthan India"
/// email : "hello@sodindia.com"
/// contact_no : "9001887487"
/// per_km_charge : ""
/// gst_charge : "5"
/// ride_gst_charge : "18"
/// parcel_gst_charge : "18"
/// radius : "10000"
/// advanced_amount : ""
/// youtube_url : "https://youtube.com/@serviceondemandd"
/// app_store_url : "https://www.apple.com/in/app-store/"
/// play_store_url : "https://play.google.com/store/games?hl=en&gl=US"
/// handy_man_status : "1"
/// event_status : "0"
/// event : "18"
/// handy : "18"
/// parcel_delivery_status : "1"
/// mehndi_gst_charge : "18"
/// two_wheeler : "18"
/// three_wheeler : "18"
/// four_wheeler : "18"
/// food_driver_gst : "50"
/// handy_fixed_amount : "100"
/// aap_orderfood_cat_image : "6442d4dc63862.png"
/// aap_bookride_cat_image : "6442d4dc639c6.png"
/// aap_sendpackage_cat_image : "aap_sendpackage_cat_image.png"
/// aap_handyman_cat_image : "aap_handyman_cat_image.png"
/// aap_mehndi_cat_image : "aap_mehndi_cat_image.png"
/// web_orderfood_cat_image : "64423d525aa13.png"
/// web_bookride_cat_image : "644273d1b5ec3.png"
/// web_sendpackage_cat_image : "64423f112e6a3.png"
/// web_handyman_cat_image : "6442813aa3931.png"
/// web_mehndi_cat_image : "64427b90d2054.png"
/// aap_back_banner_image : "6456710cd9747.png"
/// web_show_ride_image : "64439ccb6aca7.png"
/// web_show_sendpackage_image : "6441501118629.png"
/// aap_profile_back_image : "6454ba96c6e11.png"

class Setting {
  Setting({
      String? id, 
      String? nServerKey, 
      String? sSecretKey, 
      String? sPublicKey, 
      String? rSecretKey, 
      String? rPublicKey, 
      String? twitterUrl, 
      String? likendInUrl, 
      String? instaramUrl, 
      String? facebookUrl, 
      String? address, 
      String? email, 
      String? contactNo, 
      String? perKmCharge, 
      String? gstCharge, 
      String? rideGstCharge, 
      String? parcelGstCharge, 
      String? radius, 
      String? advancedAmount, 
      String? youtubeUrl, 
      String? appStoreUrl, 
      String? playStoreUrl, 
      String? handyManStatus, 
      String? eventStatus, 
      String? event, 
      String? handy, 
      String? parcelDeliveryStatus, 
      String? mehndiGstCharge, 
      String? twoWheeler, 
      String? threeWheeler, 
      String? fourWheeler, 
      String? foodDriverGst, 
      String? handyFixedAmount, 
      String? aapOrderfoodCatImage, 
      String? aapBookrideCatImage, 
      String? aapSendpackageCatImage, 
      String? aapHandymanCatImage, 
      String? aapMehndiCatImage, 
      String? webOrderfoodCatImage, 
      String? webBookrideCatImage, 
      String? webSendpackageCatImage, 
      String? webHandymanCatImage, 
      String? webMehndiCatImage, 
      String? aapBackBannerImage, 
      String? webShowRideImage, 
      String? webShowSendpackageImage, 
      String? aapProfileBackImage,}){
    _id = id;
    _nServerKey = nServerKey;
    _sSecretKey = sSecretKey;
    _sPublicKey = sPublicKey;
    _rSecretKey = rSecretKey;
    _rPublicKey = rPublicKey;
    _twitterUrl = twitterUrl;
    _likendInUrl = likendInUrl;
    _instaramUrl = instaramUrl;
    _facebookUrl = facebookUrl;
    _address = address;
    _email = email;
    _contactNo = contactNo;
    _perKmCharge = perKmCharge;
    _gstCharge = gstCharge;
    _rideGstCharge = rideGstCharge;
    _parcelGstCharge = parcelGstCharge;
    _radius = radius;
    _advancedAmount = advancedAmount;
    _youtubeUrl = youtubeUrl;
    _appStoreUrl = appStoreUrl;
    _playStoreUrl = playStoreUrl;
    _handyManStatus = handyManStatus;
    _eventStatus = eventStatus;
    _event = event;
    _handy = handy;
    _parcelDeliveryStatus = parcelDeliveryStatus;
    _mehndiGstCharge = mehndiGstCharge;
    _twoWheeler = twoWheeler;
    _threeWheeler = threeWheeler;
    _fourWheeler = fourWheeler;
    _foodDriverGst = foodDriverGst;
    _handyFixedAmount = handyFixedAmount;
    _aapOrderfoodCatImage = aapOrderfoodCatImage;
    _aapBookrideCatImage = aapBookrideCatImage;
    _aapSendpackageCatImage = aapSendpackageCatImage;
    _aapHandymanCatImage = aapHandymanCatImage;
    _aapMehndiCatImage = aapMehndiCatImage;
    _webOrderfoodCatImage = webOrderfoodCatImage;
    _webBookrideCatImage = webBookrideCatImage;
    _webSendpackageCatImage = webSendpackageCatImage;
    _webHandymanCatImage = webHandymanCatImage;
    _webMehndiCatImage = webMehndiCatImage;
    _aapBackBannerImage = aapBackBannerImage;
    _webShowRideImage = webShowRideImage;
    _webShowSendpackageImage = webShowSendpackageImage;
    _aapProfileBackImage = aapProfileBackImage;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _nServerKey = json['n_server_key'];
    _sSecretKey = json['s_secret_key'];
    _sPublicKey = json['s_public_key'];
    _rSecretKey = json['r_secret_key'];
    _rPublicKey = json['r_public_key'];
    _twitterUrl = json['twitter_url'];
    _likendInUrl = json['likend_in_url'];
    _instaramUrl = json['instaram_url'];
    _facebookUrl = json['facebook_url'];
    _address = json['address'];
    _email = json['email'];
    _contactNo = json['contact_no'];
    _perKmCharge = json['per_km_charge'];
    _gstCharge = json['gst_charge'];
    _rideGstCharge = json['ride_gst_charge'];
    _parcelGstCharge = json['parcel_gst_charge'];
    _radius = json['radius'];
    _advancedAmount = json['advanced_amount'];
    _youtubeUrl = json['youtube_url'];
    _appStoreUrl = json['app_store_url'];
    _playStoreUrl = json['play_store_url'];
    _handyManStatus = json['handy_man_status'];
    _eventStatus = json['event_status'];
    _event = json['event'];
    _handy = json['handy'];
    _parcelDeliveryStatus = json['parcel_delivery_status'];
    _mehndiGstCharge = json['mehndi_gst_charge'];
    _twoWheeler = json['two_wheeler'];
    _threeWheeler = json['three_wheeler'];
    _fourWheeler = json['four_wheeler'];
    _foodDriverGst = json['food_driver_gst'];
    _handyFixedAmount = json['handy_fixed_amount'];
    _aapOrderfoodCatImage = json['aap_orderfood_cat_image'];
    _aapBookrideCatImage = json['aap_bookride_cat_image'];
    _aapSendpackageCatImage = json['aap_sendpackage_cat_image'];
    _aapHandymanCatImage = json['aap_handyman_cat_image'];
    _aapMehndiCatImage = json['aap_mehndi_cat_image'];
    _webOrderfoodCatImage = json['web_orderfood_cat_image'];
    _webBookrideCatImage = json['web_bookride_cat_image'];
    _webSendpackageCatImage = json['web_sendpackage_cat_image'];
    _webHandymanCatImage = json['web_handyman_cat_image'];
    _webMehndiCatImage = json['web_mehndi_cat_image'];
    _aapBackBannerImage = json['aap_back_banner_image'];
    _webShowRideImage = json['web_show_ride_image'];
    _webShowSendpackageImage = json['web_show_sendpackage_image'];
    _aapProfileBackImage = json['aap_profile_back_image'];
  }
  String? _id;
  String? _nServerKey;
  String? _sSecretKey;
  String? _sPublicKey;
  String? _rSecretKey;
  String? _rPublicKey;
  String? _twitterUrl;
  String? _likendInUrl;
  String? _instaramUrl;
  String? _facebookUrl;
  String? _address;
  String? _email;
  String? _contactNo;
  String? _perKmCharge;
  String? _gstCharge;
  String? _rideGstCharge;
  String? _parcelGstCharge;
  String? _radius;
  String? _advancedAmount;
  String? _youtubeUrl;
  String? _appStoreUrl;
  String? _playStoreUrl;
  String? _handyManStatus;
  String? _eventStatus;
  String? _event;
  String? _handy;
  String? _parcelDeliveryStatus;
  String? _mehndiGstCharge;
  String? _twoWheeler;
  String? _threeWheeler;
  String? _fourWheeler;
  String? _foodDriverGst;
  String? _handyFixedAmount;
  String? _aapOrderfoodCatImage;
  String? _aapBookrideCatImage;
  String? _aapSendpackageCatImage;
  String? _aapHandymanCatImage;
  String? _aapMehndiCatImage;
  String? _webOrderfoodCatImage;
  String? _webBookrideCatImage;
  String? _webSendpackageCatImage;
  String? _webHandymanCatImage;
  String? _webMehndiCatImage;
  String? _aapBackBannerImage;
  String? _webShowRideImage;
  String? _webShowSendpackageImage;
  String? _aapProfileBackImage;
Setting copyWith({  String? id,
  String? nServerKey,
  String? sSecretKey,
  String? sPublicKey,
  String? rSecretKey,
  String? rPublicKey,
  String? twitterUrl,
  String? likendInUrl,
  String? instaramUrl,
  String? facebookUrl,
  String? address,
  String? email,
  String? contactNo,
  String? perKmCharge,
  String? gstCharge,
  String? rideGstCharge,
  String? parcelGstCharge,
  String? radius,
  String? advancedAmount,
  String? youtubeUrl,
  String? appStoreUrl,
  String? playStoreUrl,
  String? handyManStatus,
  String? eventStatus,
  String? event,
  String? handy,
  String? parcelDeliveryStatus,
  String? mehndiGstCharge,
  String? twoWheeler,
  String? threeWheeler,
  String? fourWheeler,
  String? foodDriverGst,
  String? handyFixedAmount,
  String? aapOrderfoodCatImage,
  String? aapBookrideCatImage,
  String? aapSendpackageCatImage,
  String? aapHandymanCatImage,
  String? aapMehndiCatImage,
  String? webOrderfoodCatImage,
  String? webBookrideCatImage,
  String? webSendpackageCatImage,
  String? webHandymanCatImage,
  String? webMehndiCatImage,
  String? aapBackBannerImage,
  String? webShowRideImage,
  String? webShowSendpackageImage,
  String? aapProfileBackImage,
}) => Setting(  id: id ?? _id,
  nServerKey: nServerKey ?? _nServerKey,
  sSecretKey: sSecretKey ?? _sSecretKey,
  sPublicKey: sPublicKey ?? _sPublicKey,
  rSecretKey: rSecretKey ?? _rSecretKey,
  rPublicKey: rPublicKey ?? _rPublicKey,
  twitterUrl: twitterUrl ?? _twitterUrl,
  likendInUrl: likendInUrl ?? _likendInUrl,
  instaramUrl: instaramUrl ?? _instaramUrl,
  facebookUrl: facebookUrl ?? _facebookUrl,
  address: address ?? _address,
  email: email ?? _email,
  contactNo: contactNo ?? _contactNo,
  perKmCharge: perKmCharge ?? _perKmCharge,
  gstCharge: gstCharge ?? _gstCharge,
  rideGstCharge: rideGstCharge ?? _rideGstCharge,
  parcelGstCharge: parcelGstCharge ?? _parcelGstCharge,
  radius: radius ?? _radius,
  advancedAmount: advancedAmount ?? _advancedAmount,
  youtubeUrl: youtubeUrl ?? _youtubeUrl,
  appStoreUrl: appStoreUrl ?? _appStoreUrl,
  playStoreUrl: playStoreUrl ?? _playStoreUrl,
  handyManStatus: handyManStatus ?? _handyManStatus,
  eventStatus: eventStatus ?? _eventStatus,
  event: event ?? _event,
  handy: handy ?? _handy,
  parcelDeliveryStatus: parcelDeliveryStatus ?? _parcelDeliveryStatus,
  mehndiGstCharge: mehndiGstCharge ?? _mehndiGstCharge,
  twoWheeler: twoWheeler ?? _twoWheeler,
  threeWheeler: threeWheeler ?? _threeWheeler,
  fourWheeler: fourWheeler ?? _fourWheeler,
  foodDriverGst: foodDriverGst ?? _foodDriverGst,
  handyFixedAmount: handyFixedAmount ?? _handyFixedAmount,
  aapOrderfoodCatImage: aapOrderfoodCatImage ?? _aapOrderfoodCatImage,
  aapBookrideCatImage: aapBookrideCatImage ?? _aapBookrideCatImage,
  aapSendpackageCatImage: aapSendpackageCatImage ?? _aapSendpackageCatImage,
  aapHandymanCatImage: aapHandymanCatImage ?? _aapHandymanCatImage,
  aapMehndiCatImage: aapMehndiCatImage ?? _aapMehndiCatImage,
  webOrderfoodCatImage: webOrderfoodCatImage ?? _webOrderfoodCatImage,
  webBookrideCatImage: webBookrideCatImage ?? _webBookrideCatImage,
  webSendpackageCatImage: webSendpackageCatImage ?? _webSendpackageCatImage,
  webHandymanCatImage: webHandymanCatImage ?? _webHandymanCatImage,
  webMehndiCatImage: webMehndiCatImage ?? _webMehndiCatImage,
  aapBackBannerImage: aapBackBannerImage ?? _aapBackBannerImage,
  webShowRideImage: webShowRideImage ?? _webShowRideImage,
  webShowSendpackageImage: webShowSendpackageImage ?? _webShowSendpackageImage,
  aapProfileBackImage: aapProfileBackImage ?? _aapProfileBackImage,
);
  String? get id => _id;
  String? get nServerKey => _nServerKey;
  String? get sSecretKey => _sSecretKey;
  String? get sPublicKey => _sPublicKey;
  String? get rSecretKey => _rSecretKey;
  String? get rPublicKey => _rPublicKey;
  String? get twitterUrl => _twitterUrl;
  String? get likendInUrl => _likendInUrl;
  String? get instaramUrl => _instaramUrl;
  String? get facebookUrl => _facebookUrl;
  String? get address => _address;
  String? get email => _email;
  String? get contactNo => _contactNo;
  String? get perKmCharge => _perKmCharge;
  String? get gstCharge => _gstCharge;
  String? get rideGstCharge => _rideGstCharge;
  String? get parcelGstCharge => _parcelGstCharge;
  String? get radius => _radius;
  String? get advancedAmount => _advancedAmount;
  String? get youtubeUrl => _youtubeUrl;
  String? get appStoreUrl => _appStoreUrl;
  String? get playStoreUrl => _playStoreUrl;
  String? get handyManStatus => _handyManStatus;
  String? get eventStatus => _eventStatus;
  String? get event => _event;
  String? get handy => _handy;
  String? get parcelDeliveryStatus => _parcelDeliveryStatus;
  String? get mehndiGstCharge => _mehndiGstCharge;
  String? get twoWheeler => _twoWheeler;
  String? get threeWheeler => _threeWheeler;
  String? get fourWheeler => _fourWheeler;
  String? get foodDriverGst => _foodDriverGst;
  String? get handyFixedAmount => _handyFixedAmount;
  String? get aapOrderfoodCatImage => _aapOrderfoodCatImage;
  String? get aapBookrideCatImage => _aapBookrideCatImage;
  String? get aapSendpackageCatImage => _aapSendpackageCatImage;
  String? get aapHandymanCatImage => _aapHandymanCatImage;
  String? get aapMehndiCatImage => _aapMehndiCatImage;
  String? get webOrderfoodCatImage => _webOrderfoodCatImage;
  String? get webBookrideCatImage => _webBookrideCatImage;
  String? get webSendpackageCatImage => _webSendpackageCatImage;
  String? get webHandymanCatImage => _webHandymanCatImage;
  String? get webMehndiCatImage => _webMehndiCatImage;
  String? get aapBackBannerImage => _aapBackBannerImage;
  String? get webShowRideImage => _webShowRideImage;
  String? get webShowSendpackageImage => _webShowSendpackageImage;
  String? get aapProfileBackImage => _aapProfileBackImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['n_server_key'] = _nServerKey;
    map['s_secret_key'] = _sSecretKey;
    map['s_public_key'] = _sPublicKey;
    map['r_secret_key'] = _rSecretKey;
    map['r_public_key'] = _rPublicKey;
    map['twitter_url'] = _twitterUrl;
    map['likend_in_url'] = _likendInUrl;
    map['instaram_url'] = _instaramUrl;
    map['facebook_url'] = _facebookUrl;
    map['address'] = _address;
    map['email'] = _email;
    map['contact_no'] = _contactNo;
    map['per_km_charge'] = _perKmCharge;
    map['gst_charge'] = _gstCharge;
    map['ride_gst_charge'] = _rideGstCharge;
    map['parcel_gst_charge'] = _parcelGstCharge;
    map['radius'] = _radius;
    map['advanced_amount'] = _advancedAmount;
    map['youtube_url'] = _youtubeUrl;
    map['app_store_url'] = _appStoreUrl;
    map['play_store_url'] = _playStoreUrl;
    map['handy_man_status'] = _handyManStatus;
    map['event_status'] = _eventStatus;
    map['event'] = _event;
    map['handy'] = _handy;
    map['parcel_delivery_status'] = _parcelDeliveryStatus;
    map['mehndi_gst_charge'] = _mehndiGstCharge;
    map['two_wheeler'] = _twoWheeler;
    map['three_wheeler'] = _threeWheeler;
    map['four_wheeler'] = _fourWheeler;
    map['food_driver_gst'] = _foodDriverGst;
    map['handy_fixed_amount'] = _handyFixedAmount;
    map['aap_orderfood_cat_image'] = _aapOrderfoodCatImage;
    map['aap_bookride_cat_image'] = _aapBookrideCatImage;
    map['aap_sendpackage_cat_image'] = _aapSendpackageCatImage;
    map['aap_handyman_cat_image'] = _aapHandymanCatImage;
    map['aap_mehndi_cat_image'] = _aapMehndiCatImage;
    map['web_orderfood_cat_image'] = _webOrderfoodCatImage;
    map['web_bookride_cat_image'] = _webBookrideCatImage;
    map['web_sendpackage_cat_image'] = _webSendpackageCatImage;
    map['web_handyman_cat_image'] = _webHandymanCatImage;
    map['web_mehndi_cat_image'] = _webMehndiCatImage;
    map['aap_back_banner_image'] = _aapBackBannerImage;
    map['web_show_ride_image'] = _webShowRideImage;
    map['web_show_sendpackage_image'] = _webShowSendpackageImage;
    map['aap_profile_back_image'] = _aapProfileBackImage;
    return map;
  }

}