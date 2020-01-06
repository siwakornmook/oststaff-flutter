import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/models/leavetype_static.dart';


class LeaveTypePage extends StatefulWidget {
  final _key;

  LeaveTypePage(this._key);

  @override
  _LeaveTypeState createState() => _LeaveTypeState();
}

class _LeaveTypeState extends State<LeaveTypePage> {

  int _currentIndex = 0;


  @override
  void initState() {
    LeaveTypeStatic.typeList.asMap().forEach((index, value) {
      if (value.key == widget._key) {
        _currentIndex = index;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(translate('leaveType.title')),
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
            height: MediaQuery.of(context).size.height,
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
              fit: StackFit.expand,
              children: <Widget>[
                _buildListTileList(LeaveTypeStatic.typeList),
                _buildDoneButton(LeaveTypeStatic.typeList),
              ],
            )),
      ),
    );
  }

  Widget _buildListTileList(data) {

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 500.0,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int ind) {
            return ListTile(
              title: Text(data[ind].value),
              trailing: IconButton(
                icon: Icon(Icons.check,
                    color:_currentIndex == ind ?
                        Colors.deepOrange : Colors.transparent
                ),
                onPressed: () {
                  _currentIndex = ind;

                  setState(() => {});
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDoneButton(data) => Container(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Color(0xFFfa593f),
            onPressed: () {
              Navigator.pop(context, {
                'key': data[_currentIndex].key,
                'value': data[_currentIndex].value
              });
//               Navigator.pop(context,true);
            },
            child: Text(
              translate('leaveType.done'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          padding: EdgeInsets.only(bottom: 70),
        ),
      );

}
