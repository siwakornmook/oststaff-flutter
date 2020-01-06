import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:starter/models/leavetype_static.dart';
import 'package:starter/models/view.dart';
import 'package:starter/pages/attachment.dart';
import 'package:starter/pages/create_advance.dart';

import 'package:starter/pages/leavetype.dart';
import 'package:starter/services/leave_service.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreatePage extends StatefulWidget {
  final dateStart;
  final dateEnd;

  CreatePage(this.dateStart, this.dateEnd);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _controllerTitle = new TextEditingController();
  final _controllerDescription = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); /////snackbar
  View create = new View();
  List files = [];
  FileAttach fileAttach = new FileAttach();

  String keyId;
  String value;
  List<Object> list;
  List<String> imageList;
  int count = 0;
  bool _onLeft = false; ////สี่เหลี่ยมซ้าย
  bool _onRight = false; ////สี่เหลี่ยมขวา
  bool _allDay = true;
  bool _hfMorningDay = false;
  bool _hfAfterDay = false;
  bool _onTab = false;
  bool hidebutton = false;

  var tomorrowNoon;
  var startMidNight;
  var endMidNight;
  bool isLoading = false;
  bool _switchAllDay;

//  var _dateStart = new DateFormat("EEE, d MMM").format(DateTime.now());
////  var _dateEnd = new DateFormat("EEE, d MMM")
////      .format(DateTime.now().add(Duration(days: 1)));

  var _dateStart = DateTime.now();
  var _dateEnd = DateTime.now();

  var _timeStart = DateFormat("H:mm").format(DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 00));

  var _timeEnd = DateFormat("H:mm ").format(DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59));

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (_allDay == true) {
      _dateStart = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 00);

      _dateEnd = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 23, 59);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('create.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                final resultAdvance = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAdvancePage()),
                );
                if (resultAdvance != null) {
                  _dateStart = resultAdvance['dateStart'];
                  _dateEnd = resultAdvance['dateEnd'];
                  _timeStart = DateFormat("H:mm").format(_dateStart);
                  _timeEnd = DateFormat("H:mm").format(_dateEnd);
                  _allDay = false;
                  _hfMorningDay = false;
                  _hfAfterDay = false;
//                  setState(() {
//
//                  });

                }
//
              })
        ],
      ),
      key: _scaffoldKey,
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
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFfa593f),
                      const Color(0xFFfb9060),
                    ]),
              ),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(height: 10),
//                      _buildTitleField(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                _buildBoxStart(),
                                SizedBox(
                                  width: 1,
                                ),
                                _buildBoxEnd()
                              ],
                            ),
                            SizedBox(height: 20),
                            _buildTimeButton(),
                            _buildDescription(),
                            _buildType(),
                            _buildApprove(),
                            _buildAttachment(),
                            _buildCreateButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTitleField() => Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: TextFormField(
          controller: _controllerTitle,
          decoration: InputDecoration(
            labelText: translate('create.titleField'),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _controllerTitle.clear()); // clear textfield
              },
              icon: Icon(Icons.clear),
              color: Colors.grey,
              iconSize: 20,
            ),
          ),
          validator: _validateTitle,
          onSaved: (String value) {
            create.title = value;
          },
        ),
      );

  Widget _buildBoxStart() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        color: _onLeft == false ? Colors.white70 : Color(0xFFfa593f),
        border: Border.all(color: Colors.grey[100]),
      ),
      width: 170,
      height: 100,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Icon(
              Icons.access_alarm,
              color: _onLeft == false ? Colors.grey : Colors.white,
            ),
            padding: EdgeInsets.only(left: 5),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Text(
//                      "$_dateStart",
                  DateFormat("EEE, d MMM").format(_dateStart),
                  style: TextStyle(
                      color: _onLeft == false ? Colors.black : Colors.white,
                      fontSize: 12),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  _timeStart,
//                  DateFormat("H:mm ").format(_dateStart),
//                      "$_timeStart",
                  style: TextStyle(
                      color:
                          _onLeft == false ? Color(0xFFfa593f) : Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBoxEnd() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: _onRight == false ? Colors.white70 : Color(0xFFfa593f),
        border: Border.all(color: Colors.grey[100]),
      ),
      width: 170,
      height: 100,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, left: 25),
                child: Center(
                  child: Text(
                    DateFormat("EEE, d MMM").format(_dateEnd),
//                        "$_dateEnd",
                    style: TextStyle(
                        color: _onRight == false ? Colors.black : Colors.white,
                        fontSize: 12),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 25),
                child: Text(
//                      "$_timeEnd",
//                  DateFormat("H:mm ").format(_dateEnd),
                  _timeEnd,
                  style: TextStyle(
                      color:
                          _onRight == false ? Color(0xFFfa593f) : Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFullDatePicker() => Padding(
        padding: EdgeInsets.only(top: 30, bottom: 15),
        child: CupertinoDatePicker(
          initialDateTime: _dateTime,
          mode: _onTab
              ? CupertinoDatePickerMode.dateAndTime
              : CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            setState(() {
              _dateTime = dateTime;
              if (_onLeft == true && _onRight == false) {
//                _dateStart =  DateFormat("EEE, d MMM").format(dateTime)
                _timeStart = new DateFormat("H:mm ").format(dateTime);
              } else if (_onLeft == false && _onRight == true) {
//                _dateEnd = new DateFormat("EEE, d MMM").format(dateTime);
                _timeEnd = new DateFormat("H:mm ").format(dateTime);
              }
            });
          },
        ),
      );

  Widget _buildTimeButton() => Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  side: BorderSide(
                      color: _allDay ? Colors.transparent : Colors.grey[300])),
              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
              textColor: _allDay ? Colors.white : Colors.grey[300],
              color: _allDay ? Color(0xFFfa593f) : Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Text(translate('create.allDay'),
                      style: TextStyle(fontSize: 12)),
                  Container(),
                ],
              ),
              onPressed: () {
                setState(() {
                  _allDay = !_allDay;
                  _hfMorningDay = false;
                  _hfAfterDay = false;

                  if (_allDay) {
                    _timeStart = DateFormat("H:mm").format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        0,
                        00));
                    _dateStart = DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day, 0, 00);

                    _timeEnd = DateFormat("H:mm ").format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        23,
                        59));
                    _dateEnd = DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day, 23, 59);
                  }
                });
              },
            ),
            FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  side: BorderSide(
                      color: _hfMorningDay
                          ? Colors.transparent
                          : Colors.grey[300])),
              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
              textColor: _hfMorningDay ? Colors.white : Colors.grey[300],
              color: _hfMorningDay ? Color(0xFFfa593f) : Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Text(translate('create.HalfDay'),
                      style: TextStyle(fontSize: 12)),
                  Text(
                    translate('create.morning'),
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              onPressed: () {
                setState(() {
                  _hfMorningDay = !_hfMorningDay;

                  _allDay = false;
                  _hfAfterDay = false;

                  if (_hfMorningDay) {
                    _timeStart = DateFormat("H:mm").format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        0,
                        00));
                    _dateStart = DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day, 0, 00);
//
                    _timeEnd = DateFormat("H:mm ").format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        12,
                        00));
                    _dateEnd = DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day, 12, 00);
                  }
//
                });
              },
            ),
            FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  side: BorderSide(
                      color:
                          _hfAfterDay ? Colors.transparent : Colors.grey[300])),
              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
              textColor: _hfAfterDay ? Colors.white : Colors.grey[300],
              color: _hfAfterDay ? Color(0xFFfa593f) : Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Text(translate('create.HalfDay'),
                      style: TextStyle(fontSize: 12)),
                  Text(
                    translate('create.afternoon'),
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              onPressed: () {
                setState(() {
                  _hfAfterDay = !_hfAfterDay;
                  _allDay = false;
                  _hfMorningDay = false;

                  if (_hfAfterDay) {
                    _timeStart = DateFormat("H:mm").format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        12,
                        01));
//                    _dateEnd = DateFormat("EEE, d MMM").format(DateTime.now());
                    _timeEnd = DateFormat("H:mm ").format(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        23,
                        59));
                    _dateStart = DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day, 12, 01);
                    _dateEnd = DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day, 23, 59);
                  }
                });
              },
            )
          ],
        ),
      );

  Widget _buildDescription() => Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
          ),
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          maxLines: 2,
          controller: _controllerDescription,
          decoration: InputDecoration(
            labelText: translate('create.descriptionField'),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _controllerDescription.clear());
              },
              icon: Icon(Icons.clear),
              color: Colors.grey,
              iconSize: 20,
            ),
          ),
          validator: _validateDescription,
          onSaved: (String value) {
            create.description = value;
          },
        ),
      );

   _buildType() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              translate('create.typeField'),
              style: TextStyle(fontSize: 16),
            ),
          ),
          FutureBuilder(
              future: LeaveService().getLeaveType(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {

                  if (snapshot.data != null && snapshot.data.length > 0) {

                    if(snapshot.data.length > 0){
                      LeaveTypeStatic.typeList = snapshot.data;

                      if (keyId == null) {
                        keyId = snapshot.data[0].key;
                      }



                      create.leaveTypeId = snapshot.data[0].key;

                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),

                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                             Text(
                              value == null ? snapshot.data[0].value : value,
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 14,
                              ),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LeaveTypePage(keyId)),
                                );

                                if (result != null) {
                                  keyId = result['key'];
                                  value = result['value'];
                                }
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      );
                    }else{

                    }

                  } else {
                    hidebutton = true;


                    return Center(
                      child: Container(
                          padding: EdgeInsets.only(bottom: 13, top: 13),

                          child: Text(translate('create.typeFail'),)),
                    );

                  }
                }
                return

                  Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                );

              }),
        ],
      ),
    );
  }

  Widget _buildApprove() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      padding: EdgeInsets.only(bottom: 13, top: 13),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              translate('create.approveField'),
              style: TextStyle(fontSize: 16),
            ),
          ),
          FutureBuilder(
              future: LeaveService().getLeader(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    create.approvePersonalId = snapshot.data.leaderid;
//                    _formData['approvePersonalId'] = snapshot.data.leaderid;

                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        snapshot.data.leadername,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else {
                    return Center(child: Text(translate('create.networkFail')));
                  }
                }
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildAttachment() => Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                translate('create.attachmentField'),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    count.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.attach_file,
                      color: Colors.grey,
                      size: 25,
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AttachmentPage(list)),
                      );

                      if (result != null) {
                        list = result['imageList'];
                        imageList = result['imageStorage'];
                        count = list.length;
                      }
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildCreateButton() {
    return hidebutton == false ? Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Color(0xFFfa593f),
            onPressed: () => _submit(),
            child: Text(
              translate('create.create'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),):SizedBox();
  }

  String _validateTitle(String value) {
    if (value.isEmpty) {
      return translate('create.titleError');
    }
    return null;
  }

  String _validateDescription(String value) {
    if (value.isEmpty) {
      return translate('create.descriptionError');
    }
    return null;
  }

  Future _submit() async {
    create.leaveTypeId = keyId;

    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      create.dateTimeStart = _dateStart;

      create.dateTimeEnd = _dateEnd;

      if (imageList != null) {
        imageList.forEach((value) {
          files.add(FileAttach(id: '', url: value));
        });
      }
      var encode = json.encode(files);
      var jsonResponse = json.decode(encode);

      var filetoList = jsonResponse
          .map<FileAttach>((json) => FileAttach.fromJson(json))
          .toList();

      create.fileAttach = filetoList;

      isLoading = true;
      setState(() {});
      await LeaveService().postCreate(create);
      await showInSnackBar(translate('create.success'));
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
//    } else {
//      showInSnackBar('Error');
//    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      duration: Duration(seconds: 2),
      backgroundColor: Color(0xFFfb9060),
      behavior: SnackBarBehavior.floating,
    ));
  }

//  void getRequest(val) {
//    setState(() {
//      _key = val['key'];
//      _title = val['title'];
//    });
//  }
}
