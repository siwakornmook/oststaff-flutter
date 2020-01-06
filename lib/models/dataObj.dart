class DataObj {
  String language;

  DataObj({this.language});

  DataObj.fromJson(Map<String, dynamic> json) {
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    return data;
  }
}