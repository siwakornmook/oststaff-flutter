import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:starter/models/remark.dart';
import 'package:starter/models/timesheet.dart';
import 'package:starter/services/timesheet_service.dart';

import '../widgets/ui_elements/drawer.dart';

class TimesheetPage extends StatefulWidget {
  @override
  _TimesheetPageState createState() => _TimesheetPageState();
}

class _TimesheetPageState extends State<TimesheetPage> {
  TextEditingController _remarkController = TextEditingController();
  var _keyRefresh = GlobalKey<RefreshIndicatorState>();
  bool _onLeft = false; ////สี่เหลี่ยมซ้าย
  bool _onRight = false; ////สี่เหลี่ยมขวา
  DateTime _dateTime = DateTime.now();
  bool isLoading = false;

//  var _dateStart = new DateFormat("EEE, d MMM").format(DateTime.now());
////  var _dateEnd = new DateFormat("EEE, d MMM")
////      .format(DateTime.now().add(Duration(days: 7)));

//  var _dateStartLabel = new DateFormat("EEE, d MMM").format(DateTime.now());
//  var _dateEndLabel = new DateFormat("EEE, d MMM")
//      .format(DateTime.now().add(Duration(days: 7)));

  var _dateStartLabel = new DateFormat("EEE, d MMM")
      .format(DateTime.now().subtract(Duration(days: 7)));
  var _dateEndLabel = new DateFormat("EEE, d MMM").format(DateTime.now());

  var _dateStart = new DateFormat("yyyy-MM-dd")
      .format(DateTime.now().subtract(Duration(days: 7)));
  var _dateEnd = new DateFormat("yyyy-MM-dd").format(DateTime.now());

//  var _dateStart = new DateFormat("yyyy-MM-dd").format(DateTime.now());
//  var _dateEnd = new DateFormat("yyyy-MM-dd")
//      .format(DateTime.now().add(Duration(days: 7)));

  List _list = [
    {
      "dateStart": "2019-09-10 00:00:00.000",
      "dateEnd": "2019-09-10 00:00:00.000",
      "titleStart": "เข้าปกติ",
      "titleEnd": "ออกปกติ",
      "remarkStatus": true,
      "remarkNote": "Test Data",
      "state": true,
      "title": "วันหยุด ประจำสัปดาห์"
    },
    {
      "dateStart": "2019-09-11 08:58:00.000",
      "dateEnd": "2019-09-11 18:10:00.000",
      "titleStart": "เข้าปกติ",
      "titleEnd": "ออกปกติ",
      "remarkStatus": false,
      "remarkNote": "Test Data",
      "state": false
    },
    {
      "dateStart": "2019-09-12 09:04:00.000",
      "dateEnd": "2019-09-12 18:00:00.000",
      "titleStart": "เข้าสาย",
      "titleEnd": "ออกปกติ",
      "remarkStatus": true,
      "remarkNote": "Test Data",
      "state": false
    },
    {
      "dateStart": "2019-09-13 08:45:00.000",
      "dateEnd": "2019-09-13 18:10:00.000",
      "titleStart": "เข้าปกติ",
      "titleEnd": "ออกปกติ",
      "remarkStatus": true,
      "remarkNote": "Test Data",
      "state": false
    },
    {
      "dateStart": "2019-09-14 09:04:00.000",
      "dateEnd": "2019-09-14 18:00:00.000",
      "titleStart": "เข้าสาย",
      "titleEnd": "ออกปกติ",
      "remarkStatus": false,
      "remarkNote": "Test Data",
      "state": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceheight = MediaQuery.of(context).size.height;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('timeSheet.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
      ),
      drawer: DrawerMenu(),
      body: RefreshIndicator(
        key: _keyRefresh,
        onRefresh: _refreshing,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
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
              width: targetWidth,
            ),
            Container(
              height: deviceheight,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildBoxStart(),
                    SizedBox(
                      width: 1,
                    ),
                    _buildBoxEnd()
                  ],
                ),
                SizedBox(
                  height: _onLeft || _onRight ? 120 : 50,
                  child: _onLeft || _onRight
                      ? _buildCalendarDate()
                      : Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                ),
                _buildTitle(),
               _buildTimesheetList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoxStart() => GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            color: !_onLeft ? Colors.white70 : Color(0xFFfa593f),
            border: Border.all(color: Colors.grey[100]),
          ),
          width: 160,
          height: 80,
          margin: EdgeInsets.only(left: 10, top: 40),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.access_alarm,
                  color: !_onLeft ? Colors.grey : Colors.white,
                ),
                padding: EdgeInsets.only(left: 5),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      translate('timeSheet.dateStart'),
                      style: TextStyle(
                          color: !_onLeft ? Colors.black : Colors.white,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      " $_dateStartLabel",
                      style: TextStyle(
                          color: !_onLeft ? Color(0xFFfa593f) : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _onLeft = !_onLeft;
            _onRight = false;
          });
        },
      );

  Widget _buildBoxEnd() => GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: !_onRight ? Colors.white70 : Color(0xFFfa593f),
            border: Border.all(color: Colors.grey[100]),
          ),
          width: 160,
          height: 80,
          margin: EdgeInsets.only(right: 10, top: 40),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        translate('timeSheet.dateEnd'),
                        style: TextStyle(
                            color: !_onRight ? Colors.black : Colors.white,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 30),
                    child: Text(
                      "$_dateEndLabel",
                      style: TextStyle(
                          color: !_onRight ? Color(0xFFfa593f) : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _onRight = !_onRight;
            _onLeft = false;
          });
        },
      );

  _buildCalendarDate() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: CupertinoDatePicker(
        initialDateTime: _onLeft == true
            ? DateTime.parse(_dateStart)
            : DateTime.parse(_dateEnd),
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) {
          setState(() {
            _dateTime = dateTime;
            if (_onLeft == true && _onRight == false) {
              _dateStartLabel = new DateFormat("EEE, d MMM").format(dateTime);
              _dateStart = new DateFormat("yyyy-MM-dd").format(dateTime);
//              setState(() {});
              isLoading = true;
            } else if (_onLeft == false && _onRight == true) {
              _dateEndLabel = new DateFormat("EEE, d MMM").format(dateTime);
              _dateEnd = new DateFormat("yyyy-MM-dd").format(dateTime);
              isLoading = true;
//              setState(() {});
            }
          });
        },
      ),
    );
  }

  Widget _buildTitle() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 15),
        margin: EdgeInsets.only(left: 30, right: 30),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        )),
        child: Text(
          translate('timeSheet.title'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      );

  _buildTimesheetList() {


    return FutureBuilder(
        future: TimesheetService()
            .getTimesheetList(dateStart: _dateStart, dateEnd: _dateEnd),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Timesheet timesheet = snapshot.data[index];

                      return Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 0.75, color: Color(0xFFcfcfcf)),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                    child: Icon(
                                      Icons.radio_button_checked,
                                      color: Colors.deepOrange,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    DateFormat("EEE, d MMM").format(
                                        DateTime.parse(
                                            snapshot.data[index].dateStart)),
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: snapshot.data[index].id != '' ? IconButton(
                                    icon: Icon(Icons.description),
                                    iconSize: 18,
                                    color: snapshot.data[index].remarkStatus
                                        ? Colors.orangeAccent
                                        : Colors.grey[400],
                                    alignment: Alignment.centerRight,
                                    onPressed: () {
                                      print(timesheet.id);
                                      _displayDialog(context, timesheet);
                                      setState(() {});
                                    },
                                  ):Container(),
                                ),
                              ],
                            ),
                            snapshot.data[index].state
                                ? _buildHoliday(snapshot.data[index])
                                : _buildTimeStart(snapshot.data[index])
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                ),
              );
            }
          }
          return Center(
            child:
//            Container(
//              margin: EdgeInsets.only(top:30),
//                child: Text('No data of timesheet'))
                CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
            ),
          );
        });
  }

  Widget _buildTimeStart(data) => Column(
        children: <Widget>[
          Row(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  DateFormat("H:mm ").format(
                    DateTime.parse(data.dateStart),
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  '(' + data.titleStart + ')',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
            ],
          ),
          Row(
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  DateFormat("H:mm ").format(
                    DateTime.parse(data.dateEnd),
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Text(
                  '(' + data.titleEnd + ')',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildHoliday(data) => Row(
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              data.title,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ),
        ],
      );

  _displayDialog(
    BuildContext context,
    Timesheet item,
  ) async {
    _remarkController.text = item.remarkNote;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(translate('timeSheet.detail')),
            content: TextField(
              controller: _remarkController,
              decoration: InputDecoration(
                hintText: translate('timeSheet.message'),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(translate('timeSheet.cancel')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(translate('timeSheet.confirm')),
                onPressed: () async {
                  Remark remark = new Remark();
                  remark.id = item.id;
                  remark.remark = _remarkController.text;
                  await TimesheetService().postRemark(remark: remark);
                  Navigator.of(context).pop();

                },
              )
            ],
          );
        });
  }

  Future<void> _refreshing() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }
}
