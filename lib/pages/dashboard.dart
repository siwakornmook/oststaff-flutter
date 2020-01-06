import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:starter/models/dashboard.dart';
import 'package:starter/models/scantime.dart';
import 'package:starter/services/dashboard_service.dart';
import '../widgets/ui_elements/drawer.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
//    DashboardService.getScan();
//
//    super.initState();
  }

  Widget _buildTimestamp() {
    return FutureBuilder(
        future: DashboardService().getScan(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              var lengthData = snapshot.data.length;

              if (lengthData > 0) {
                return Container(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 60),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Scan scan = snapshot.data[index];

                          return ListTile(
                            dense: true,
                            leading: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Icon(
                                Icons.radio_button_checked,
                                color: Color(0xFFed892e),
                                size: 15,
                              ),
                            ),
                            title: Text(
                              '${scan.time}',
                              textAlign: TextAlign.left,
                              style: TextStyle().copyWith(
                                  fontSize: 15, color: Color(0xFF535353)),
                            ),
                          );
                        }));
              }
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              ),
            );
          }

          return Container(
              padding: EdgeInsets.only(top: 100),
              alignment: Alignment.topCenter,
              child: Text(
                translate('dashboard.notFound'),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Add AppBar here only
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
        title: Center(
          child: Text(translate('dashboard.title')),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            iconSize: 30,
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create');
            },
          )
        ],
      ),
      drawer: DrawerMenu(),
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
          child: FutureBuilder(
              future: DashboardService().fetchDashboard(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    Dashboard dashboard = snapshot.data;

                    return Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Padding(
                                padding: EdgeInsets.only(left: 70),
                                child: Text(
                                  translate('dashboard.in'),
                                  style: TextStyle().copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              snapshot.data.late == true
                                  ? new Padding(
                                      padding: EdgeInsets.only(right: 70),
                                      child: Text(
                                        translate('dashboard.late'),
                                        style: TextStyle().copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    )
                                  : Padding(padding: EdgeInsets.only(right: 1)),
                            ],
                          ),
                        ),
//
                        buildTimeStart(timeIn: dashboard.dateStart),
                        SizedBox(height: 20),
                        Container(
//                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Padding(
                                padding: EdgeInsets.only(left: 70),
                                child: Text(
                                  translate('dashboard.out'),
                                  style: TextStyle().copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildTimeEnd(timeOut: dashboard.dateEnd),

                        SizedBox(height: 40),

                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF494949),
                                  blurRadius: 20.0,
                                  // has the effect of softening the shadow
                                  spreadRadius: 5.0,
                                  // has the effect of extending the shadow
                                  offset: Offset(
                                    10.0, // horizontal, move right 10
                                    10.0, // vertical, move down 10
                                  ),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(36),
                                topRight: Radius.circular(36),
                              ),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 30, left: 40),
                                  child: Text(
                                    translate('dashboard.scanTime'),
                                    style: TextStyle().copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF494949)),
                                  ),
                                ),
                                _buildTimestamp(),
//                                Align(
//                                    alignment: Alignment.center,
//                                    child: Divider(
//                                      indent: 27.0,
//                                      endIndent: 27.0,
//                                      color: Color(0xFFEAEAEA),
//                                      thickness: 0.75,
//                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 50, bottom: 30),
                                  alignment: Alignment.bottomCenter,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/timesheet');
                                    },
                                    child:  Text(translate('dashboard.more'),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                          decoration: TextDecoration.underline,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
//
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(translate('dashboard.notFound')),
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
              })),
    );
  }

  buildTimeStart({timeIn}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 28, right: 28),
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        timeIn != null
            ? DateFormat("H:mm ").format(DateTime.parse(timeIn))
            : '-',
        textAlign: TextAlign.center,
        style: TextStyle().copyWith(color: Colors.white, fontSize: 80),
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.2, color: Colors.white),
        ),
      ),
    );
  }

  buildTimeEnd({timeOut}) {
    return Container(
      width: MediaQuery.of(context).size.width,
//          margin: EdgeInsets.only(top: 375),
      child: Text(
//        "16.00"
        timeOut != null
            ? DateFormat("H:mm ").format(DateTime.parse(timeOut))
            : '-',

        textAlign: TextAlign.center,
        style: TextStyle().copyWith(color: Colors.white, fontSize: 80),
      ),
    );
  }
}
