import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

import 'package:starter/models/summary.dart';
import 'package:starter/services/report_service.dart';
import 'package:starter/widgets/ui_elements/drawer.dart';
import 'package:starter/widgets/utils/chart.dart';

class LeaveReport extends StatefulWidget {
  @override
  _LeaveReportState createState() => _LeaveReportState();
}

class _LeaveReportState extends State<LeaveReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text(translate('leaveReport.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.alarm, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/history");
            },
          )
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              FutureBuilder(
                  future: ReportService().getGraphList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return BarChart(snapshot.data);
                      } else {
                        return Center(
                          child: Text(translate('leaveReport.networkFail')),
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
              _buildHeaderReport(context),
              _buildReport(context),
            ],
          ),
        ),
      ),
    );
  }
}

//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:starter/models/graph.dart';
//import 'package:starter/models/summary.dart';
//import 'package:starter/services/report_service.dart';
//import '../widgets/ui_elements/drawer.dart';
//
//class LeaveReport extends StatelessWidget {
//  final List<charts.Series> seriesList;
//  final bool animate;
//
//  LeaveReport(this.seriesList, {this.animate});
//
//  factory LeaveReport.withSampleData() {
//    return new LeaveReport(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final double deviceWidth = MediaQuery.of(context).size.width;
//    final double deviceheight = MediaQuery.of(context).size.height;
//    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
//    return Scaffold(
//      drawer: DrawerMenu(),
//      body: Stack(
//        fit: StackFit.expand,
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                  begin: Alignment.topCenter,
//                  end: Alignment.bottomCenter,
//                  colors: [
//                    const Color(0xFFfa593f),
//                    const Color(0xFFfb9060),
//                  ]),
//            ),
//            height: deviceheight,
//            width: targetWidth,
//          ),
//          AppBar(
//            title: Text("Leave Report"),
//            backgroundColor: Colors.transparent,
//            elevation: 0.0,
//            actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.alarm, color: Colors.white),
//                onPressed: () {
//                  Navigator.pushNamed(context, "/history");
//                },
//              )
//            ],
//          ),
//          Container(
//            height: deviceheight,
//            alignment: Alignment.center,
//            margin: EdgeInsets.only(top: 150),
//            decoration: BoxDecoration(
//              color: Colors.white,
//              borderRadius: BorderRadius.only(
//                  topLeft: Radius.circular(16.0),
//                  topRight: Radius.circular(16.0)),
//            ),
//          ),
//          Container(
//            height: deviceheight,
//            width: deviceWidth,
//            alignment: Alignment.center,
//            margin: EdgeInsets.only(top: 150),
//            decoration: BoxDecoration(
//              color: Colors.white,
//              borderRadius: BorderRadius.only(
//                  topLeft: Radius.circular(16.0),
//                  topRight: Radius.circular(16.0)),
//            ),
//          ),
//          Column(
//            mainAxisAlignment: MainAxisAlignment.end,
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              SizedBox(height: MediaQuery.of(context).size.height / 5),
//              Container(
//                margin: EdgeInsets.only(left: 30, right: 30),
//                child: SizedBox(
//                  width: deviceWidth,
//                  height: 300,
//                  child: charts.BarChart(
//                    seriesList,
//                    animate: true,
//                    behaviors: [
//                      // Add the sliding viewport behavior to have the viewport center on the
//                      // domain that is currently selected.
//                      new charts.SlidingViewport(),
//                      // A pan and zoom behavior helps demonstrate the sliding viewport
//                      // behavior by allowing the data visible in the viewport to be adjusted
//                      // dynamically.
//                      new charts.PanAndZoomBehavior(),
//                    ],
//                    domainAxis: new charts.OrdinalAxisSpec(
//                        viewport: new charts.OrdinalViewport('', 4)),
//                  ),
//                ),
//              ),
//              _buildHeaderReport(context),
//              _buildReport(context),
//            ],
//          )
//        ],
//      ),
//    );
//  }
//
Widget _buildHeaderReport(context) => Container(
      alignment: FractionalOffset.bottomCenter,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 10),
      margin: EdgeInsets.only(left: 10, right: 10, top: 40),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                translate('leaveReport.typeofLeave'),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                translate('leaveReport.summary'),
                softWrap: true,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                translate('leaveReport.amount'),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                translate('leaveReport.remain'),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ),
          )
        ],
      ),
    );

Widget _buildReport(context) {
  return Expanded(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: FutureBuilder(
              future: ReportService().getSummaryList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        SummaryList summary = snapshot.data[index];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(bottom: 10),
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.blueGrey[50],
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.75, color: Color(0xFFcfcfcf)),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      summary.title,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    summary.cumulative,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    summary.amount,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    summary.remain,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text(translate('leaveReport.networkFail')));
                  }
                }
                return Center(child: CircularProgressIndicator());
              })));
}
//
//  /// Create one series with sample hard coded data.
//  static List<charts.Series<LeaveData, String>> _createSampleData() {
//
//
//    final data = [
//      new LeaveData('ลาป่วย', 10),
//      new LeaveData('ลากิจ', 25),
//      new LeaveData('ลาพักผ่อน', 100),
//      new LeaveData('ลาคลอด', 75),
//      new LeaveData('ลาสมรส', 75),
//      new LeaveData('ลาพักผ่อน', 30),
//      new LeaveData('ลาคลอด', 75),
//      new LeaveData('ลาสมรส', 75),
//      new LeaveData('ลาพักผ่อน', 30),
//      new LeaveData('ลาคลอด', 75),
//      new LeaveData('ลาสมรส', 75),
//      new LeaveData('ลาออก', 30),
//    ];
//
//    return [
//      new charts.Series<LeaveData, String>(
//        id: 'Sales',
//        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
//        domainFn: (LeaveData data, _) => data.title,
//        measureFn: (LeaveData data, _) => data.value,
//        data: data,
//      )
//    ];
//  }
//}
//
///// Sample ordinal data type.
//class LeaveData {
//  final String title;
//  final int value;
//
//  LeaveData(this.title, this.value);
//}
//
//
