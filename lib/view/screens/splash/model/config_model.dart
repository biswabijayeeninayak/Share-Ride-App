class ConfigModel {
  String? businessName;

  ConfigModel({this.businessName});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_name'] = businessName;
    return data;
  }
}