class SubDistrictMasterEntity {
  int? id;
  int? zipCode;
  String? nameTh;
  String? nameEn;
  int? amphureId;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  SubDistrictMasterEntity(
      {this.id,
      this.nameTh,
      this.nameEn,
      this.amphureId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  SubDistrictMasterEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zipCode = json['zip_code'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    amphureId = json['amphure_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['zip_code'] = zipCode;
    data['name_th'] = nameTh;
    data['name_en'] = nameEn;
    data['amphure_id'] = amphureId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
