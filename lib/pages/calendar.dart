import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:starter/models/calendar.dart';
import 'package:starter/pages/eventdetail.dart';
import 'package:starter/pages/type.dart';
import 'package:starter/services/calendar_service.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';
import '../widgets/ui_elements/drawer.dart';

// Example holidays
//final Map<DateTime, List> _holidays = {
//   DateTime(2019, 12, 2): ['New Year\'s Day'],
//   DateTime(2019, 1, 8): ['Epiphany'],
//  DateTime(2019, 2, 14): ['Valentine\'s Day'],
//  DateTime(2019, 4, 21): ['Easter Sunday'],
//  DateTime(2019, 4, 22): ['Easter Monday'],
//};

final Map<DateTime, List> testList = {};

void main() {
  initializeDateFormatting().then((_) => runApp(CalendarPage()));
}

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarPageState();
  }
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  Map<DateTime, List> _events = {};
  Map<DateTime, List> _holidays = {};

  List _selectedEvents;

  String _dateSelected;
  bool isSelected = false;
  AnimationController _animationController;
  Animation _animation;
  CalendarController _calendarController;
  var date = DateTime.now();
  bool switchWork = true;
  bool switchLeave  = true;
  bool switchHoliday  = true;

  List<Calendar> responseList = [];

  // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    var format = new DateFormat("EEEE, d MMMM").format(_selectedDay);
    print('Format' + '$format');
    _dateSelected = format.toString();

    // DateTime dateTime = dateFormat.parse("2019-09-19 8:40:23");

//    _events = {
//      //_selectedDay.subtract(Duration(days: 1)): ['Event A0', 'Event B0', 'Event C0'],
//      // _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
//      // _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
//      // _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
//      // _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
//      // _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
//      // _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
//      // _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
//      // DateTime(2019, 1, 1): ['New1 Year\'s Day'],
//      // DateTime(2019, 1, 8): ['New8 Year\'s Day']
//      DateTime(2019,9,1): [
//        {
//          'title': 'Event A1',
//          'location': 'London',
//          'start': '09.00',
//          'end': '12.00',
//          'type': 'holiday'
//        },
//        {
//          'title': 'Event A2',
//          'location': 'New York',
//          'start': '09.00',
//          'end': '12.00',
//          'type': 'leave'
//        },
//      ]
//
//      // _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
//      // _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
//      // _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
//      // _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
//      // _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
//      // _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
//    };

    _selectedEvents = _events[_selectedDay] ?? [];

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    // print('CALLBACK: _onDaySelected' + '$day');
    var format = new DateFormat("EEEE, d MMMM").format(day);
    // print('Format' + '$format');
    _dateSelected = format.toString();
    _selectedEvents = events;
    print(_dateSelected);
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime firstDateofMonth, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
    date = firstDateofMonth;
    setState(() {});

    print(date);
    print(last);
  }

  _buildTableCalendarWithBuilders() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: FutureBuilder(
          future: CalendarService()
              .getCalendar(date: DateFormat("yyyy-MM-dd").format(date),workday: switchWork,leave: switchLeave,holiday: switchHoliday),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                _events.clear();
                _holidays.clear();
                responseList = snapshot.data;
                responseList.forEach((response) {
                  var date = response.date;
                  List _list = [];

//                  print(DateFormat("yyyy,MM,dd").format(DateTime.parse(date)));
                  response.schedule.forEach((value) {
                    if (value.type == 'holiday') {
                      _holidays[DateTime.parse(date)] = [
                        {
                          "title": value.title,
                          "type": value.type,
                          "scheduleid": value.scheduleid,
                          "dateStart": value.dateStart,
                          "dateEnd": value.dateEnd,
                          "status": value.status
                        }
                      ];
                    }
                    _list.add({
                      "title": value.title,
                      "type": value.type,
                      "scheduleid": value.scheduleid,
                      "dateStart": value.dateStart,
                      "dateEnd": value.dateEnd,
                      "status": value.status
                    });
                    _events[DateTime.parse(date)] = _list;
                  });
                });

                return TableCalendar(
                  locale: 'en_US',
                  calendarController: _calendarController,
                  events: _events,
                  holidays: _holidays,
                  initialCalendarFormat: CalendarFormat.month,
                  formatAnimation: FormatAnimation.slide,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  availableGestures: AvailableGestures.all,
                  availableCalendarFormats: const {
                    CalendarFormat.month: '',
                    CalendarFormat.week: '',
                  },
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendStyle:
                        TextStyle().copyWith(color: Color(0xFFb5b5b5)),
                    holidayStyle:
                        TextStyle().copyWith(color: Color(0xFFc42329)),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle:
                        TextStyle().copyWith(color: Color(0xFFb5b5b5)),
                  ),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                  ),
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, _) {
                      return FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0)
                            .animate(_animationController),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFed892e),
                            shape: BoxShape.circle,
                          ),
                          margin: const EdgeInsets.all(4.0),
                          // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: TextStyle().copyWith(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                    todayDayBuilder: (context, date, _) {
                      return Container(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle().copyWith(
                                fontSize: 16.0,
                                color: Color(0xFFed892e),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    markersBuilder: (context, date, events, holidays) {
                      final children = <Widget>[];

                      if (events.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: _buildEventsMarker(date, events),
                          ),
                        );
                      }

                      if (holidays.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: -2,
                            top: -2,
                            child: _buildHolidaysMarker(),
                          ),
                        );
                      }

                      return children;
                    },
                  ),
                  onDaySelected: (date, events) {
                    _onDaySelected(date, events);
                    _animationController.forward(from: 0.0);
                  },
                  onVisibleDaysChanged: _onVisibleDaysChanged,
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
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              ),
            );
          }),
    );
  }

//
//

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Color(0xFF26b7ea),
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.bookmark,
      size: 20.0,
      color: Color(0xFFfff568),
    );
  }

  Widget _buildEventList() {
    _animationController.forward();
    return FadeTransition(
      opacity: _animation,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 30),
          itemCount: _selectedEvents.length,
          itemBuilder: (BuildContext context, int index) {
            var status = _selectedEvents[index]["status"];

            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: new Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.radio_button_checked,
                      color: status == '1'
                          ? Colors.grey
                          : status == '2' ? Colors.green : Colors.red,
                      size: 20,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  dense: true,
                  title: Text('${_selectedEvents[index]['title']}'),
                  subtitle: Text(
                      '${DateFormat("H:mm ").format(_selectedEvents[index]['dateStart'])} - ${DateFormat("H:mm ").format(_selectedEvents[index]['dateEnd'])}'),
                  onTap: () {
//                  print('${_selectedEvents[index]} tapped!');
                    if (_selectedEvents[index]['type'].toString() !=
                        'holiday') {
                      print(_selectedEvents[index]['scheduleid']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetail(
                                  scheduleId: _selectedEvents[index]
                                      ['scheduleid'],
                                )),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    var parsedDate = DateTime.parse('1974-03-20 00:00:00.000');
//    print(parsedDate);
    return Scaffold(
      drawer: DrawerMenu(),
      body: Stack(
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
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Card(
            elevation: 0.2,
            borderOnForeground: true,
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 100.0),
            child: _buildTableCalendarWithBuilders(),
          ),
          Positioned(
            child: _selectedEvents.length > 0
                ? Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 500),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        // bottom: BorderSide(width: 0.75, color: Color(0xFFd5d5d5)),
                        bottom:
                            BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        _dateSelected,
                        textAlign: TextAlign.left,
                        style: TextStyle().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFed892e)),
                      ),
                    ),
                  )
                : Container(),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 500),
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(bottom: 25, top: 10),
              decoration: const BoxDecoration(
                border: Border(
                  // bottom: BorderSide(width: 0.75, color: Color(0xFFd5d5d5)),
                  bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
                ),
              ),

              child: _buildEventList(),
            ),
          ),
          Positioned(
              child: Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 500),
          )),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              // Add AppBar here only

              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Center(
                child: Text(translate('calendar.title')),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.more_horiz),
                    tooltip: translate('calendar.tooltip'),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TypePage(
                                  switchWork: switchWork,
                                  switchLeave: switchLeave,
                                  switchHoliday: switchHoliday,
                                )),
                      );
                      if (result != null) {
                        switchWork = result['switchWork'];
                        switchLeave = result['switchLeave'];
                        switchHoliday = result['switchHoliday'];
                      }
                      setState(() {

                      });
                    })
              ],
            ),
          ),
        ],
      ),

      // drawer: _buildSideDrawer(context),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(185.0), // here the desired height
      //   child: GradientAppBar(
      //     title: Text('Dashboard'),
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [
      //           const Color(0xFFfa593f),
      //           const Color(0xFFfb9060),
      //         ]),
      //   ),
      // ),
      // body: Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: <Widget>[
      //     // Switch out 2 lines below to play with TableCalendar's settings
      //     //-----------------------

      //     _buildTableCalendarWithBuilders(),
      //     // const SizedBox(height: 8.0),
      //     // _buildButtons(),
      //     const SizedBox(height: 8.0),
      //     Expanded(child: _buildEventList()),
      //   ],
      // ),
    );
  }
}
