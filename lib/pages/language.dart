import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LanguagePage extends StatefulWidget {
  final language;

  LanguagePage({this.language});
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<LanguagePage> {
  int _currentIndex = 0;
  var languageName;
  var id;

  List _languageList = [
    {
      "language": "en",
      "languageName": "English",
    },
    {
      "language": "th",
      "languageName": "ภาษาไทย",
    }

  ];
  @override
  void initState() {
    _languageList.asMap().forEach((index, data) {
      if (data["language"] == widget.language) {
        _currentIndex = index;
        languageName = data["languageName"];
        id = data["language"];
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('language.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(context, {'language': id, 'languageName': languageName});
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
          itemCount: _languageList.length,
          itemBuilder: (BuildContext context, int ind) {
            return GestureDetector(
              child: ListTile(
                title: Text(_languageList[ind]["languageName"]),
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
                id = _languageList[_currentIndex]["language"];
                languageName = _languageList[_currentIndex]["languageName"];
                setState(() => {});
              },
            );
          },
        ),
      ),
    );
  }
}


