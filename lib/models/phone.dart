class Phones {
  String telephoneId;
  String telephoneType;
  String telephone;

  Phones({this.telephoneId, this.telephoneType, this.telephone});

  Phones.fromJson(Map<String, dynamic> json) {
    telephoneId = json['telephoneId'];
    telephoneType = json['telephoneType'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['telephoneId'] = this.telephoneId;
    data['telephoneType'] = this.telephoneType;
    data['telephone'] = this.telephone;
    return data;
  }
}