import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:starter/models/graph.dart';


class BarChart extends StatefulWidget {
  final List<GraphList> data;

  BarChart(this.data);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<GraphList, String>> series = [
      charts.Series(
        id: "Subscribers",
        data: widget.data,
        domainFn: (GraphList series, _) => series.title,
        measureFn: (GraphList series, _) => series.value,
      )
    ];

    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: charts.BarChart(
          series,
          animate: true,
          behaviors: [


            new charts.PanAndZoomBehavior(),
          ],
          domainAxis: new charts.OrdinalAxisSpec(
              viewport: new charts.OrdinalViewport('', 3)),
        ),
      ),
    );
  }
}
