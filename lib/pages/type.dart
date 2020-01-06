import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/services/calendar_service.dart';

class TypePage extends StatefulWidget {
   bool switchWork;
   bool switchLeave;
   bool switchHoliday;

  TypePage({this.switchWork, this.switchLeave, this.switchHoliday});

  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  final _formKey = GlobalKey<FormState>();

//  final Map<String, dynamic> _formData = {
//    'switchWork': false,
//    'switchLeave': false,
//    'switchHoliday': false
//  };

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
            height: MediaQuery.of(context).size.height,
          ),
          AppBar(
            title: Text(translate('type.title')),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 150),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _buildSwitchWork(),
                    _buildSwitchLeave(),
                    _buildSwitchHoliday(),
                  ],
                ),
              )),
          _buildDoneButton()
        ],
      ),
    );
  }

  Widget _buildSwitchWork() => Container(
        margin: EdgeInsets.only(top: 180),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SwitchListTile(
          title: Text(translate('type.work')),
          activeColor: Colors.green,
          value: widget.switchWork,
          onChanged: (value) => setState(() {
            widget.switchWork = value;
          }),
        ),
      );

  Widget _buildSwitchLeave() => Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SwitchListTile(
          title: Text(translate('type.leave')),
          activeColor: Colors.green,
          value: widget.switchLeave,
          onChanged: (value) => setState(() {
            widget.switchLeave = value;
          }),
        ),
      );

  Widget _buildSwitchHoliday() => Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SwitchListTile(
          title: Text(translate('type.holiday')),
          activeColor: Colors.green,
          value: widget.switchHoliday,
          onChanged: (value) => setState(() {
            widget.switchHoliday = value;
          }),
        ),
      );

  Widget _buildDoneButton() => Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 70),
          child: RaisedButton(
            padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Color(0xFFfa593f),
            onPressed: () => _submit(),
            child: Text(
              translate('type.done'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  Future _submit() async {
    _formKey.currentState.save();
    // await CalendarService().setTypeCalendar(workday:switchWork,leave: switchLeave,holiday: switchHoliday);
    Navigator.pop(context, {
      'switchWork': widget.switchWork,
      'switchLeave': widget.switchLeave,
      'switchHoliday':widget.switchHoliday
    });
  }
}
