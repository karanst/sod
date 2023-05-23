class Data {
  Data({
      this.id, 
      this.name, 
      this.image, 
      this.description, 
      this.countryId, 
      this.stateId, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? name;
  String? image;
  String? description;
  String? countryId;
  String? stateId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['description'] = description;
    map['country_id'] = countryId;
    map['state_id'] = stateId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}