class DistrictMasterEntity {
  int? id;
  String? nameTh;
  String? nameEn;
  int? provinceId;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  DistrictMasterEntity(
      {this.id,
      this.nameTh,
      this.nameEn,
      this.provinceId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  DistrictMasterEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    provinceId = json['province_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name_th'] = nameTh;
    data['name_en'] = nameEn;
    data['province_id'] = provinceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
