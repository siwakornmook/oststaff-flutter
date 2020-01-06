import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/models/leavetype_static.dart';
import 'package:starter/models/view.dart';
import 'package:starter/pages/attachment.dart';
import 'package:starter/pages/create_advance.dart';
import 'package:intl/intl.dart';
import 'package:starter/pages/edit_attachment.dart';
import 'package:starter/pages/leavetype.dart';
import 'package:starter/services/leave_service.dart';
import 'package:starter/services/notification_service.dart';

class EditCreatePage extends StatefulWidget {
  final String requestId;

  EditCreatePage(this.requestId);

  @override
  _EditCreatePageState createState() => _EditCreatePageState();
}

class _EditCreatePageState extends State<EditCreatePage> {
  View create = new View();
  final _controllerDescription = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _dateStart;
  var _dateEnd;
  bool _allDay = false;
  bool _onLeft = false; ////สี่เหลี่ยมซ้าย
  bool _onRight = false; ////สี่เหลี่ยมขวา
  bool _hfMorningDay = false;
  bool _hfAfterDay = false;
  var _timeStart;
  var _timeEnd;
  String keyId;
  String value;
  List<Object> list;
  List<String> imageList;
  int count = 0;
  List files = [];
  FileAttach fileAttach = new FileAttach();
  bool isLoading = false;
  bool load = true;
  var initload = true;
  List<FileAttach> oldAttach =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('create.editTitle')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAdvancePage()),
                );
                if (result != null) {
                  _dateStart = result['dateStart'];
                  _dateEnd = result['dateEnd'];
                  _timeStart = DateFormat("H:mm").format(_dateStart);
                  _timeEnd = DateFormat("H:mm").format(_dateEnd);
                  _allDay = false;
                }
//
              })
        ],
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
          : FutureBuilder(
              future: load == true
                  ? NotificationService().getView(requestId: widget.requestId)
                  : null,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {

                    View view = snapshot.data;
                    if(initload == true){
                      print('initLoad');
                      initload = false;
                      _dateStart = view.dateTimeStart;
                      _dateEnd =  view.dateTimeEnd ;
                      create.leaveTypeId = view.leaveTypeId;
                      _controllerDescription.text = view.description;

                    }


                    return Container(
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
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _buildBoxStart(),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        _buildBoxEnd(item: view)
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    _buildTimeButton(),
                                    _buildDescription(item: view),
                                    _buildType(item: view),
                                    _buildApprove(item: view),
                                    _buildAttachment(item: view),
                                    _buildEditButton(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                );
              },
            ),
    );
  }

  _buildBoxStart() {
    print('Widget $_dateStart');
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
                  DateFormat("EEE, d MMM").format(_dateStart),
                  style: TextStyle(
                      color: _onLeft == false ? Colors.black : Colors.white,
                      fontSize: 12),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  DateFormat("H:mm ").format(_dateStart),
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

  _buildBoxEnd({View item}) {
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
                  DateFormat("H:mm ").format(_dateEnd),
//                  _timeEnd,
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

  _buildTimeButton() {
    return Align(
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
                Text(translate('create.allDay'),style: TextStyle(fontSize: 12)),
                Container(),
              ],
            ),
            onPressed: () {
              setState(() {
                load = false;
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
                  _dateEnd = DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, 23, 59);
                }

              });
            },
          ),
          FlatButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                side: BorderSide(
                    color:
                        _hfMorningDay ? Colors.transparent : Colors.grey[300])),
            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
            textColor: _hfMorningDay ? Colors.white : Colors.grey[300],
            color: _hfMorningDay ? Color(0xFFfa593f) : Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Column(
              children: <Widget>[
                Text(translate('create.HalfDay'),style: TextStyle(fontSize: 12)),
                Text(
                  translate('create.morning'),
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            onPressed: () {
              setState(() {
                load = false;
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
                  _dateEnd = DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, 12, 00);
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
                Text(translate('create.HalfDay') ,style: TextStyle(fontSize: 12)),
                Text(
                  translate('create.afternoon'),
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            onPressed: () {
              setState(() {
                load = false;
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
                  _dateEnd = DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, 23, 59);
                }

              });
            },
          )
        ],
      ),
    );
  }

  _buildDescription({View item}) {

    return Container(
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
              load = false;
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _controllerDescription.clear());
            },
            icon: Icon(Icons.clear),
            color: Colors.grey,
            iconSize: 20,
          ),
        ),
        validator: _validateDescription,
        onSaved: (String value) {
          initload = false;
          load = false;
          create.description = value;
          _controllerDescription.text =value;
        },
      ),
    );
  }

  String _validateDescription(String value) {
    if (value.isEmpty) {
      return translate('create.descriptionError');
    }
    return null;
  }

  _buildType({View item}) {
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
                  if (snapshot.data != null) {
                    LeaveTypeStatic.typeList = snapshot.data;
                    keyId = item.leaveTypeId;
                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            value == null ? item.leaveTypeName : value,
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 14,
                            ),
                            onPressed: () async {
                              keyId = item.leaveTypeId;

                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LeaveTypePage(keyId)),
                              );

                              if (result != null) {
                                keyId = result['key'];
                                value = result['value'];
                                create.leaveTypeId = keyId;
                                load = false;
                                print('REV $keyId');
//                                setState(() {});
                              }

                            },
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(translate('create.networkFail')),
                    );
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

  _buildApprove({View item}) {
    create.approvePersonalId = item.approvePersonalId;
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
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              item.approveName,
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  _buildAttachment({View item}) {
//    if (item.fileAttach.length > 0) {
//      count = item.fileAttach.length;
//    }

  if(imageList != null && item.fileAttach != null){
    print('if');
    count = item.fileAttach.length + imageList.length;
  }
  else {
    print('else');
      count = item.fileAttach.length;
    }

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

                    var result;

                    print('onpress imageList $list');
                      if(list != null) {
                        result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAttachmentPage(

                                   item.fileAttach, list)),
                        );
                      }else{
                         result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAttachmentPage(

                                  item.fileAttach, null)),
                        );
                      }


                    if (result != null) {
                      list = result['imageList'];
                      imageList = result['imageStorage'];
                      oldAttach = result['fileAttach'];
                      count = list.length + oldAttach.length;
                      print('REC imageList $list');
                      setState(() {});
                    }
                    load = false;

   },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildEditButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: RaisedButton(
          padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Color(0xFFfa593f),
          onPressed: () {
            _submit();
          },
          child: Text(
            translate('create.edit'),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {

    create.id = widget.requestId;
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

      await LeaveService().putCreate(create);

      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    }
  }
}
