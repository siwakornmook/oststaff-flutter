import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:starter/models/history_summary.dart';
import 'package:starter/services/report_service.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _onLeft = false; ////สี่เหลี่ยมซ้าย
  bool _onRight = false; ////สี่เหลี่ยมขวา
  DateTime _dateTime = DateTime.now();

//  var _dateStart = new DateFormat("EEE, d MMM").format(DateTime.now());
//  var _dateEnd = new DateFormat("EEE, d MMM")
//      .format(DateTime.now().add(Duration(days: 30)));
  var _dateStart = DateTime.now();
  var _dateEnd = DateTime.now().add(Duration(days: 30));

  List _list = [
    {
      "dateStart": "2019-10-09 00:00:00.000",
      "dateEnd": "2019-11-09 00:00:00.000",
      "title": "ลาพักผ่อน",
      "statusText": "อนุมัติ"
    },
    {
      "dateStart": "2019-11-03 00:00:00.000",
      "dateEnd": "2019-11-03 00:00:00.000",
      "title": "ลาป่วย",
      "statusText": "อนุมัติ"
    },
    {
      "dateStart": "2019-08-13 00:00:00.000",
      "dateEnd": "2019-08-13 00:00:00.000",
      "title": "ลากิจ",
      "statusText": "อนุมัติ"
    },
    {
      "dateStart": "2019-08-13 00:00:00.000",
      "dateEnd": "2019-08-13 00:00:00.000",
      "title": "ลากิจ",
      "statusText": "อนุมัติ"
    },
    {
      "dateStart": "2019-08-13 00:00:00.000",
      "dateEnd": "2019-08-13 00:00:00.000",
      "title": "ลากิจ",
      "statusText": "อนุมัติ"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('history.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
      ),
      body: Container(
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
        child: Container(
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 15),
                    margin: EdgeInsets.only(left: 30, right: 30),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
                    )),
                    child: Text(
                        translate('history.title'),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                  _buildHistoryList(),
                ],
              ),
            ],
          ),
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
          width: 180,
          height: 100,
          margin: EdgeInsets.only(left: 20, top: 40),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.access_alarm,
                  color: !_onLeft ? Colors.grey : Colors.white,
                ),
                padding: EdgeInsets.only(left: 10),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                        translate('history.dateStart'),
                      style: TextStyle(
                          color: !_onLeft ? Colors.black : Colors.white,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 25),
                    child: Text(
                      DateFormat("EEE, d MMM").format(_dateStart),
                      style: TextStyle(
                          color: !_onLeft ? Color(0xFFfa593f) : Colors.white,
                          fontSize: 20,
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
          width: 180,
          height: 100,
          margin: EdgeInsets.only(right: 20, top: 40),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        translate('history.dateEnd'),
                        style: TextStyle(
                            color: !_onRight ? Colors.black : Colors.white,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 55),
                    child: Text(
                      DateFormat("EEE, d MMM").format(_dateEnd),
                      style: TextStyle(
                          color: !_onRight ? Color(0xFFfa593f) : Colors.white,
                          fontSize: 20,
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

  Widget _buildCalendarDate() => Padding(
        padding: EdgeInsets.only(top: 30),
        child: CupertinoDatePicker(
          initialDateTime: _onLeft == true ? _dateStart : _dateEnd,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) {
            setState(() {
              _dateTime = dateTime;
              if (_onLeft == true && _onRight == false) {
//
                _dateStart =
                    DateTime.parse(DateFormat("yyyy-MM-dd").format(dateTime));
              } else if (_onLeft == false && _onRight == true) {
//
                _dateEnd =
                    DateTime.parse(DateFormat("yyyy-MM-dd").format(dateTime));
              }
            });
          },
        ),
      );

  Widget _buildHistoryList() {
    return Container(
        margin: EdgeInsets.only(left: 30, right: 30),

        // height: 380,
        height: MediaQuery.of(context).size.height / 3,
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: FutureBuilder(
                future: ReportService().getHistorySummary(start: DateFormat("yyyy-MM-dd").format(_dateStart),end: DateFormat("yyyy-MM-dd").format(_dateEnd)),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            HistorySummary history = snapshot.data[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 0.75, color: Color(0xFFcfcfcf)),
                                ),
                              ),
                              child: Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Icon(
                                          Icons.radio_button_checked,
                                          color: Colors.deepOrange,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: identical(history.dateStart,
                                              history.dateEnd)
                                          ? Text(
                                              DateFormat("EEE, d MMM").format(
                                                  DateTime.parse(
                                                      history.dateStart)),
                                              style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          : Text(
                                              DateFormat("EEE, d MMM").format(
                                                      DateTime.parse(
                                                          history.dateStart)) +
                                                  ' - ' +
                                                  DateFormat("EEE, d MMM")
                                                      .format(
                                                    DateTime.parse(
                                                        history.dateEnd),
                                                  ),
                                              style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 25),
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        history.title,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 25),
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        translate('history.status') + '${history.statusText}',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                            );
                          });
                    } else {
                      Center(
                        child: Text(translate('history.networkFail')),
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
                })));
  }
}
