import 'dart:convert';
import 'dart:io';

import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/pages/gender.dart';
import 'package:starter/pages/language.dart';
import 'package:starter/services/profile_service.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/personal.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  Personal personal = new Personal();

  final _formKey = GlobalKey<FormState>();

  File _imageFile;
  String _genderId = '1';
  String _language = 'en';
  List<int> _imageBytes;
  String _imageBase64;
  bool load = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('profile.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
      ),
      body: isLoading == true
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFfa593f),
                      const Color(0xFFfb9060),
                    ]),
              ),
              height: deviceheight,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFfa593f),
                          const Color(0xFFfb9060),
                        ]),
                  ),
                  height: deviceheight,
                  width: double.infinity,
                  child: FutureBuilder(
                      future:
                          load == true ? ProfileService().fetchProfile() : null,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            personal = snapshot.data;
                            return Stack(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  margin: EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  padding: EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 3.0, color: Color(0xFFcfcfcf)),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      _buildImageProfile(item: personal),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _buildTitleFullname(item: personal),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _buildTitlePosition(item: personal),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: deviceheight,
                                  alignment: Alignment.center,
                                  margin:
                                      EdgeInsets.only(top: deviceheight * 0.28),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                    ),
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          width: deviceWidth,
                                          margin: EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              bottom: 10,
                                              top: 20),
                                          padding: EdgeInsets.only(bottom: 20),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 0.75,
                                                  color: Color(0xFFcfcfcf)),
                                            ),
                                          ),
                                          child: Text(
                                            translate('profile.title'),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        _buildFirstname(item: personal),
                                        _buildSurname(item: personal),
                                        _buildEmail(item: personal),
                                        _buildGender(item: personal),
                                        _buildLanguage(item: personal),
                                        _buildSaveButton(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.deepOrange),
                              ),
                            );
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.deepOrange),
                          ),
                        );
                      })),
            ),
    );
  }

  Widget _buildImageProfile({Personal item}) {
    return GestureDetector(
      child: Container(
        child: CircleAvatar(
//          backgroundColor: Colors.black,
          radius: 40.0,
          child: ClipOval(
            child: SizedBox(
                width: 150,
                height: 100,
                child: item.image != '' && _imageFile == null
                    ? Image.network(
                        item.image,
                        fit: BoxFit.fill,
                      )
                    : _imageFile != null
                        ? Image.file(
                            _imageFile,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/images/default-profile.png',
                            fit: BoxFit.cover,
                          )),
          ),
        ),

        padding: const EdgeInsets.all(4.0), // borde width
        decoration: new BoxDecoration(
            color: Colors.deepOrange, // border color
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange[400],
                blurRadius: 20.0,
                // has the effect of softening the shadow
                spreadRadius: 1.0,
                // has the effect of extending the shadow
                offset: Offset(
                  0.0, // horizontal, move right 10
                  0.0,
                ),
              ),
            ]),
      ),
      onTap: () {
        containerForSheet<String>(
          context: context,
          child: _cupertinoActionSheet(),
        );
      },
    );
  }

  Widget _buildTitleFullname({Personal item}) {
    return Text(
      '${item.firstName}  ${item.lastName}',
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTitlePosition({Personal item}) {
    return Text(
      item.position != '' ? item.position : 'Employee',
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  Widget _buildFirstname({Personal item}) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.account_circle,
              color: Colors.deepOrange,
              size: 30,
            ),
          ),
          Text(
            translate('profile.firstName'),
            style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                child: TextFormField(
                  textAlign: TextAlign.right,
                  initialValue: item.firstName,
//                  controller: TextEditingController(text: item.firstName),
                  maxLines: 1,
                  validator: _validateEmpty,

                  onSaved: (String value) {
                    item.firstName = value;
                    load = false;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurname({Personal item}) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.account_circle,
              color: Colors.deepOrange,
              size: 30,
            ),
          ),
          Text(
            translate('profile.lastName'),
            style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                child: TextFormField(
                  maxLines: 1,
                  textAlign: TextAlign.right,
                  initialValue: item.lastName,
//                  controller: TextEditingController(text: item.lastName),
                  validator: _validateEmpty,
                  onSaved: (String value) {
                    load = false;
                    item.lastName = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmail({Personal item}) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.email,
              color: Colors.deepOrange,
              size: 30,
            ),
          ),
          Text(
            translate('profile.email'),
            style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                // padding: EdgeInsets.only(left: deviceWidth / 4),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  controller: TextEditingController(text: item.email),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  readOnly: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGender({Personal item}) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10, top: 10),
            child: Icon(
              Icons.wc,
              color: Colors.deepOrange,
              size: 30,
            ),
          ),
          Text(
            translate('profile.gender'),
            style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Container(
                  child: Text(personal.genderName),
//                child: DropdownButton<String>(
//                  items: [
//                    DropdownMenuItem<String>(
//                      value: "1",
//                      child: Text(
//                        "Male",
//                      ),
//                    ),
//                    DropdownMenuItem<String>(
//                      value: "2",
//                      child: Text(
//                        "Female",
//                      ),
//                    ),
//                  ],
//                  value: item.genderId,
//                  icon: Icon(Icons.keyboard_arrow_down),
//                  iconSize: 24,
//                  elevation: 16,
//                  style: TextStyle(color: Colors.black),
//                  underline: Container(
//                    height: 2,
//                    color: Colors.transparent,
//                  ),
//                  onChanged: (String newValue) {
//                    setState(() {
//                      item.genderId = newValue;
//                    });
//                  },
//                ),
                ),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GenderPage(
                              genderId: personal.genderId,
                            )),
                  );

                  if (result != null) {
                    personal.genderId = result['genderId'];
                    personal.genderName = result['genderName'];
                    load = false;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguage({Personal item}) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      padding: EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10, top: 10),
            child: Icon(
              Icons.language,
              color: Colors.deepOrange,
              size: 30,
            ),
          ),
          Text(
            translate('profile.language'),
            style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
                fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Container(
                  child: Text(personal.languageName),
                ),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LanguagePage(
                              language: personal.language,
                            )),
                  );

                  if (result != null) {
                    personal.language = result['language'];

                    personal.languageName = result['languageName'];
                    load = false;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      margin: EdgeInsets.only(top: 50, bottom: 20),
      child: SizedBox(
        height: 50,
        width: 180,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          // color: Color(0xFFfa593f),
          color: Color(0xFFfa593f),
          onPressed: () => _submitForm(),

          child: Text(
            'save'.toUpperCase(),
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _cupertinoActionSheet() => CupertinoActionSheet(
      title: const Text('Upload Profile'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text('Camera'),
          onPressed: () {
            _openCamera();
            // Navigator.pop(context, '🙋 Yes');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Gallery'),
          onPressed: () {
            _openGallery();
            // Navigator.pop(context, '🙋 No');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ));

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
        context: context, builder: (BuildContext context) => child);
    // ).then<void>((T value) {
    //   Scaffold.of(context).showSnackBar(new SnackBar(
    //     content: new Text('You clicked $value'),
    //     duration: Duration(milliseconds: 800),
    //   ));
  }

  _openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = picture;
    });
    _imageBytes = _imageFile.readAsBytesSync();
    _imageBase64 = base64Encode(_imageBytes);

    personal.image = _imageBase64;
    Navigator.pop(context);
    print('camera');
  }

  Future _openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = picture;
    });
    _imageBytes = _imageFile.readAsBytesSync();
    _imageBase64 = base64Encode(_imageBytes);
    print(_imageBase64);

    personal.image = "data:image/jpeg;base64," '$_imageBase64';
    Navigator.pop(context);
    print('gallery');
  }

  String _validateEmpty(String value) {
    if (value.isEmpty) {
      return "invalid data or this empty";
    }
    return null;
  }

  void _submitForm() async {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();

      isLoading = true;
      setState(() {});

//      await ProfileService()
//          .updatePersonal(personal)
//          .then((_) => Navigator.pushReplacementNamed(context, '/dashboard'));
      personal.image = "data:image/jpeg;base64," '$_imageBase64';
      await ProfileService().updatePersonal(personal).then((_) {
        changeLocale(context, personal.language);
        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    }
  }
}
