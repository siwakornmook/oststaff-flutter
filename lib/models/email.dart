class Emails {
  String email;
  String emailId;

  Emails({this.email, this.emailId});

  Emails.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailId = json['emailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['emailId'] = this.emailId;
    return data;
  }
}