import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

class CreateAdvancePage extends StatefulWidget {


  @override
  _CreateAdvancePageState createState() => _CreateAdvancePageState();
}

class _CreateAdvancePageState extends State<CreateAdvancePage> {
  bool switchAllDay = false;
  bool onTabStart = false;
  bool onTabEnd = false;
  var dateStart = DateTime.now();

  var dateEnd = DateTime.now().add(Duration(hours: 1));

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(translate('advance.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context, {
                  'dateStart': switchAllDay == false
                      ? dateStart
                      : DateTime(dateStart.year, dateStart.month, dateStart.day,
                          0, 00),
                  'dateEnd': switchAllDay == false
                      ? dateEnd
                      : DateTime(
                          dateEnd.year, dateEnd.month, dateEnd.day, 23, 59),

                });
              })
        ],
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
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: SwitchListTile(
                          title: Text(translate('advance.allDay')),
                          activeColor: Colors.green,
                          value:  switchAllDay,
                          onChanged: (value) {

                            setState(() {
                              switchAllDay = value;
                              print('Switch $value');

                            });
                          }),
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: ListTile(
                        title: Text(translate('advance.start')),
                        trailing: GestureDetector(
                          child: Text(
                            switchAllDay == true
                                ? DateFormat("EEE, dd MMM").format(dateStart)
                                : DateFormat("EEE, d MMM H:mm")
                                    .format(dateStart),
//                            switchAllDay == false ? DateFormat("EEE, d MMM H:mm").format(dateStart) : DateFormat("EEE, dd MMM").format(dateStart),
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            onTabStart = true;
                            onTabEnd = false;

                            showDialog<void>(
                              context: context,
                              barrierDismissible: true,

                              // false = user must tap button, true = tap outside dialog
                              builder: (BuildContext dialogContext) {
                                return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: _buildFullDatePicker(dateStart)
//
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        child: ListTile(
                          title: Text(translate('advance.end')),
                          trailing: Text(
                            switchAllDay == true
                                ? DateFormat("EEE, dd MMM").format(dateEnd)
                                : DateFormat("EEE, d MMM H:mm").format(dateEnd),
//                          switchAllDay == false ? DateFormat("EEE, d MMM H:mm").format(dateEnd) : DateFormat("EEE, dd MMM").format(dateEnd),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        onTap: () {
                          onTabEnd = true;
                          onTabStart = false;
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,

                            // false = user must tap button, true = tap outside dialog
                            builder: (BuildContext dialogContext) {
                              return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: _buildFullDatePicker(dateEnd)
//
                                  );
                            },
                          );
                        },
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 20,
                      endIndent: 20,
                    ),
//                      _buildFullDatePicker()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullDatePicker(dateSelect) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: Colors.white,
      ),
      height: 300,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoDatePicker(
          initialDateTime: dateSelect,
          mode: switchAllDay == true
              ? CupertinoDatePickerMode.date
              : CupertinoDatePickerMode.dateAndTime,
          onDateTimeChanged: (dateTime) {
            setState(() {
              if (onTabStart == true && onTabEnd == false) {
                dateStart = dateTime;
              } else {
                dateEnd = dateTime;
              }
            });
          },
        ),
      ),
    );
  }
}
