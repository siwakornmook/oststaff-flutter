import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class GenderPage extends StatefulWidget {
  final genderId;

  GenderPage({this.genderId});

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  int _currentIndex = 0;
  var genderName;
  var id;

  List _genderList = [
    {
      "genderId": "1",
      "genderName": "ชาย",
    },
    {
      "genderId": "2",
      "genderName": "หญิง",
    }
  ];

  @override
  void initState() {
    _genderList.asMap().forEach((index, data) {
      if (data["genderId"] == widget.genderId) {
        _currentIndex = index;
        genderName = data["genderId"];
        id = data["genderName"];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('gender.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(context, {'genderId': id, 'genderName': genderName});
          },
        ),
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
                buildListTile(),
              ],
            )),
      ),
    );
  }

  buildListTile() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 500.0,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: _genderList.length,
          itemBuilder: (BuildContext context, int ind) {
            return GestureDetector(
              child: ListTile(
                title: Text(_genderList[ind]["genderName"]),
                trailing: IconButton(
                  icon: Icon(Icons.check,
                      color: _currentIndex == ind
                          ? Colors.deepOrange
                          : Colors.transparent),
                  onPressed: () {},
                ),
              ),
              onTap: () {
                _currentIndex = ind;
                id = _genderList[_currentIndex]["genderId"];
                genderName = _genderList[_currentIndex]["genderName"];
                setState(() => {});
              },
            );
          },
        ),
      ),
    );
  }
}
