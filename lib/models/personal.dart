import './email.dart';
import './phone.dart';

class Personal {
  String updateDatetime;
  String prefix;
  String firstName;
  String lastName;
  String email;
  String phone;
  String dateOfBirth;
  String genderId;
  String genderName;
  String image;
  String personalId;
  String language;
  String languageName;
  String position;
  String middleName;
  String idCardNumber;
  String passportNumber;
  String maritalStatus;
  String nationality;
  String religion;
  String occupation;
  String facebook;
  String twister;
  String google;
  List<Emails> emails;
  List<Phones> phones;

  Personal(
      {this.updateDatetime,
      this.prefix,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.genderId,
      this.genderName,
      this.image,
      this.personalId,
      this.language,
      this.languageName,
      this.position,
      this.middleName,
      this.idCardNumber,
      this.passportNumber,
      this.maritalStatus,
      this.nationality,
      this.religion,
      this.occupation,
      this.facebook,
      this.twister,
      this.google,
      this.emails,
      this.phones});

  Personal.fromJson(Map<String, dynamic> json) {
    updateDatetime = json['updateDatetime'];
    prefix = json['prefix'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'] != null ? json['phone'] : '';
    dateOfBirth = json['dateOfBirth'] != null ? json['dateOfBirth'] : '';
    genderId = json['genderId'] != null ? json['genderId'] : '';
    genderName = json['genderName'] != null ? json['genderName'] : '';
    image = json['image'] != null ? json['image'] : '';
    personalId = json['personalId'] != null ? json['personalId'] : '';
    language = json['language']!= null ? json['language'] : '';
    languageName = json['languageName']!= null ? json['languageName'] : '';
    position = json['position']!= null ? json['position'] : '';
    middleName = json['middleName']!= null ? json['middleName'] : '';
    idCardNumber = json['idCardNumber']!= null ? json['idCardNumber'] : '';
    passportNumber = json['passportNumber']!= null ? json['passportNumber'] : '';
    maritalStatus = json['maritalStatus']!= null ? json['maritalStatus'] : '';
    nationality = json['nationality']!= null ? json['nationality'] : '';
    religion = json['religion']!= null ? json['religion'] : '';
    occupation = json['occupation']!= null ? json['occupation'] : '';
    facebook = json['facebook']!= null ? json['facebook'] : '';
    twister = json['twister']!= null ? json['twister'] : '';
    google = json['google']!= null ? json['google'] : '';
    if (json['emails'] != null) {
      emails = new List<Emails>();
      json['emails'].forEach((v) {
        emails.add(new Emails.fromJson(v));
      });
    }
    if (json['phones'] != null) {
      phones = new List<Phones>();
      json['phones'].forEach((v) {
        phones.add(new Phones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updateDatetime'] = this.updateDatetime;
    data['prefix'] = this.prefix;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dateOfBirth'] = this.dateOfBirth;
    data['genderId'] = this.genderId;
    data['genderName'] = this.genderName;
    data['image'] = this.image;
    data['personalId'] = this.personalId;
    data['language'] = this.language;
    data['languageName'] = this.languageName;
    data['position'] = this.position;
    data['middleName'] = this.middleName;
    data['idCardNumber'] = this.idCardNumber;
    data['passportNumber'] = this.passportNumber;
    data['maritalStatus'] = this.maritalStatus;
    data['nationality'] = this.nationality;
    data['religion'] = this.religion;
    data['occupation'] = this.occupation;
    data['facebook'] = this.facebook;
    data['twister'] = this.twister;
    data['google'] = this.google;
    if (this.emails != null) {
      data['emails'] = this.emails.map((v) => v.toJson()).toList();
    }
    if (this.phones != null) {
      data['phones'] = this.phones.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
