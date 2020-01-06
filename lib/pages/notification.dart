import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/pages/event.dart';
import 'package:starter/pages/view.dart';
import 'package:starter/services/notification_service.dart';
import '../widgets/ui_elements/drawer.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var _keyRefresh = GlobalKey<RefreshIndicatorState>();
  List _notificationlist = [];
  List _historylist = [];
  List _list = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceheight = MediaQuery.of(context).size.height;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('notification.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
      ),
      drawer: DrawerMenu(),
      body: isLoading == true
          ? Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFfa593f),
                const Color(0xFFfb9060),
              ]),
        ),
        height: deviceheight,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor:
            new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
          ),
        ),
      ):FutureBuilder(
          future: NotificationService().getNotificationList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                _notificationlist.clear();
                _historylist.clear();
                _list = snapshot.data;
                snapshot.data.forEach((v) => v.status == '0'
                    ? _notificationlist.add(v)
                    : _historylist.add(v));

//

                return RefreshIndicator(
                  key: _keyRefresh,
                  onRefresh: _refreshing,
                  child: Stack(
                    fit: StackFit.expand,
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
                        height: deviceheight,
                        width: targetWidth,
                      ),
                      Container(
                        height: deviceheight,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: deviceheight * 0.1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0)),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          _notificationlist.length > 0
                              ? _buildRequestTitle()
                              : Padding(
                                  padding: EdgeInsets.only(top: 1),
                                ),
                          _notificationlist.length > 0
                              ? _buildNotificationList(_notificationlist)
                              : Padding(
                                  padding: EdgeInsets.only(top: 1),
                                ),
                          _historylist.length > 0
                              ? _buildEarlierTitle()
                              : Padding(
                                  padding: EdgeInsets.only(top: 1),
                                ),
                          _historylist.length > 0
                              ? _buildHistoryList(_historylist)
                              : Center(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(translate('notification.notFound'),),
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
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

  Widget _buildRequestTitle() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 15),
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        )),
        child: Text(
            translate('notification.request'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      );

  Widget _buildEarlierTitle() => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 15),
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
        )),
        child: Text(
          translate('notification.earlier'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      );

  Widget _buildNotificationList(data) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: false,
          itemCount: data.length,
//            semanticChildCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 35,
                        child: ClipOval(
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: data[index].image != null &&
                                      data[index].image != ''
                                  ? Image.network(
                                      data[index].image,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/images/default-profile.png',
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
//                      child: CircleAvatar(
//                        backgroundImage: NetworkImage(data[index].image),
//                        radius: 35.0,
//                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data[index].requestName,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          data[index].subtitle,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 28,
                              width: 100,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(2.0),
                                ),
                                color: Color(0xFFfa593f),
                                textColor: Colors.white,
                                child: Text(
                                  translate('notification.approve'),
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () {
                                  showDialogConfirm(data[index]);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 28,
                              width: 100,
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(2.0),
                                    side: BorderSide(color: Colors.grey[300])),
                                color: Colors.transparent,
                                textColor: Colors.grey,
                                child: Text(
                                  translate('notification.reject'),
                                  style: TextStyle(fontSize: 12),
                                ),
                                onPressed: () {
                                  showDialogCancel(data[index]);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewPage(data[index].requestId)));
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHistoryList(data) => Expanded(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            shrinkWrap: false,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 35,
                          child: ClipOval(
                            child: SizedBox(
                                width: 100,
                                height: 100,
                                child: data[index].image != null &&
                                        data[index].image != ''
                                    ? Image.network(
                                        data[index].image,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        'assets/images/default-profile.png',
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            data[index].requestName,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
//
//                           Icon(Icons.check_circle, color: Colors.green,size: 1,),
//
                          SizedBox(
                            width: 200,
                            child: Text(
                              data[index].subtitle,

                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
//
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                data[index].approveStatus == '1'
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: data[index].approveStatus == '1'
                                    ? Colors.green[500]
                                    : Colors.red,
                                size: 17,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                data[index].dateConfirm != null
                                    ? data[index].dateConfirm
                                    : '',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () {
//
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventPage(
                              requestId: data[index].requestId,
                            )),
                  );
//                  Navigator.pushNamed(context, "/event");
                },
              );
            },
          ),
        ),
      );

  Future<void> _refreshing() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  void showDialogConfirm(data) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
//          title: Text('title'),
          content: Text(data.dialogue),
          actions: <Widget>[
            FlatButton(
              child: Text(translate('notification.confirm')),
              onPressed: () async {
                isLoading = true;
                setState(() {});
                Navigator.of(dialogContext).pop();
                await NotificationService()
                    .dialogNotofication(requestId: data.requestId, status: 2);
                // Dismiss alert dialog
              },
            ),
            FlatButton(
              child: Text(translate('notification.cancel')),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogCancel(data) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
//          title: Text('title'),
          content: Text(data.dialogue),
          actions: <Widget>[
            FlatButton(
              child: Text(translate('notification.confirm')),
              onPressed: () async {
                isLoading = true;
                setState(() {});
                await NotificationService()
                    .dialogNotofication(requestId: data.requestId, status: 3);
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog

              },
            ),
            FlatButton(
              child: Text(translate('notification.cancel')),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
