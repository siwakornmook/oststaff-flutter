import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:starter/pages/authen.dart';
import 'package:starter/pages/create.dart';
import 'package:starter/pages/create_advance.dart';
import 'package:starter/pages/dashboard.dart';
import 'package:starter/pages/event.dart';
import 'package:starter/pages/eventdetail.dart';
import 'package:starter/pages/gender.dart';
import 'package:starter/pages/leavereport.dart';
import 'package:starter/pages/leavetype.dart';
import 'package:starter/pages/history.dart';
import 'package:starter/pages/notification.dart';
import 'package:starter/pages/profile.dart';
import 'package:starter/pages/timesheet.dart';
import 'package:starter/pages/type.dart';
import 'package:starter/pages/view.dart';
import 'package:starter/services/auth_service.dart';

import './pages/calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'th',
      supportedLocales: ['th','en']);

  runApp(LocalizedApp(delegate, MyApp()));

}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print('building main page');
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "OST Staff",
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        home: FutureBuilder(
            future: AuthService().isLogin(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.data == false) {
                return AuthenPage();
              }

              return DashboardPage();
            }),
        routes: {

          '/authen': (BuildContext context) => AuthenPage(),
          '/calendar': (BuildContext context) => CalendarPage(),
          '/dashboard': (BuildContext context) => DashboardPage(),
          '/create': (BuildContext context) => CreatePage(null, null),
          '/type': (BuildContext context) => TypePage(),
          '/leavetype': (BuildContext context) => LeaveTypePage(null),
          '/event': (BuildContext context) => EventPage(),
          '/eventdetail': (BuildContext context) => EventDetail(),
          '/history': (BuildContext context) => HistoryPage(),
          '/timesheet': (BuildContext context) => TimesheetPage(),
          '/notification': (BuildContext context) => NotificationPage(),
          '/view': (BuildContext context) => ViewPage(null),
          '/profile': (BuildContext context) => PersonalPage(),
//           '/leavereport':(BuildContext context) => LeaveReport.withSampleData(),
          '/leavereport': (BuildContext context) => LeaveReport(),
          '/createadv': (BuildContext context) => CreateAdvancePage(),
          '/gender': (BuildContext context) =>
              GenderPage(
                genderId: null,
              ),
        },
      ),
    );
  }
}
