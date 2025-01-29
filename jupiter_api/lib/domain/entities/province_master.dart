class ProvinceMasterEntity {
  int? id;
  String? nameTh;
  String? nameEn;
  int? geographyId;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  ProvinceMasterEntity(
      {this.id,
      this.nameTh,
      this.nameEn,
      this.geographyId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ProvinceMasterEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    geographyId = json['geography_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name_th'] = nameTh;
    data['name_en'] = nameEn;
    data['geography_id'] = geographyId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
