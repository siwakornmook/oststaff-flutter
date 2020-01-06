import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/models/view.dart';
import 'package:starter/pages/edit_create.dart';
import 'package:starter/pages/view_attachment.dart';
import 'package:starter/services/leave_service.dart';
import 'package:starter/services/notification_service.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatelessWidget {
  final scheduleId;

  EventDetail({this.scheduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('event.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
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
            alignment: Alignment.center,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
            child: FutureBuilder(
                future: NotificationService().getView(requestId: scheduleId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      View view = snapshot.data;
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTitleText(item: view),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _buildBoxStart(item: view),
                              SizedBox(
                                width: 1,
                              ),
                              _buildBoxEnd(item: view)
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          _buildDescription(item: view),
                          _buildType(item: view),
                          _buildApprove(item: view),
                          _buildAttachment(item: view, context: context),
                          _buildStatus(item: view),
                          SizedBox(
                            height: 15,
                          ),
                          view.statusconfirm != '3'
                              ? _buildEditButton(item: view, context: context)
                              : Container(),
                          SizedBox(
                            height: 5,
                          ),
                          _buildCancelButton(context),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.deepOrange),
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
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText({View item}) => Container(
        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Text(
          item.title,
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
      );

  Widget _buildBoxStart({View item}) => GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            color: Colors.white70,
            border: Border.all(color: Colors.grey[100]),
          ),
          width: 160,
          height: 100,
          margin: EdgeInsets.only(top: 40),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Icon(Icons.access_alarm, color: Colors.grey),
                padding: EdgeInsets.only(left: 10),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      DateFormat("EEE, d MMM").format(item.dateTimeStart),
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      DateFormat("H:mm ").format(
                        item.dateTimeStart,
                      ),
                      style: TextStyle(
                          color: Color(0xFFfa593f),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );

  Widget _buildBoxEnd({View item}) => GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Colors.white70,
            border: Border.all(color: Colors.grey[100]),
          ),
          width: 160,
          height: 100,
          margin: EdgeInsets.only( top: 40),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 60),
                    child: Center(
                      child: Text(
                        DateFormat("EEE, d MMM").format(item.dateTimeEnd),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 60),
                    child: Text(
                      DateFormat("H:mm ").format(
                        item.dateTimeEnd,
                      ),
                      style: TextStyle(
                          color: Color(0xFFfa593f),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget _buildDescription({View item}) => Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 30, right: 30),
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
          ),
        ),
        child: Text(
          item.description,
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
      );

  Widget _buildType({View item}) => Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        padding: EdgeInsets.only(bottom: 13, top: 13),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                translate('event.typeField'),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.leaveTypeName,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildApprove({View item}) => Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        padding: EdgeInsets.only(bottom: 13, top: 13),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                translate('event.approveField'),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                item.approveName,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );

  Widget _buildAttachment({View item, context}) => Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        padding: EdgeInsets.only(bottom: 13, top: 13),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                translate('event.attachmentField'),
                style: TextStyle(fontSize: 16),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.attach_file,
                      color: Colors.grey,
                      size: 20,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      item.fileAttach.length.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
              onTap: () {
                if(item.fileAttach.length > 0){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewAttachmentPage(item.fileAttach)),
                  );
                }

              },
            ),
          ],
        ),
      );

  Widget _buildStatus({View item}) => Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        padding: EdgeInsets.only(bottom: 13, top: 13),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                translate('event.statusField'),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.centerRight,
                child: Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  height: 10,
                  width: 10,
                  decoration: new BoxDecoration(
                    color: item.statusconfirm == '1'
                        ? Colors.deepOrange
                        : item.statusconfirm == '2'
                            ? Colors.green
                            : item.statusconfirm == '3'
                                ? Colors.red
                                : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: item.statusconfirm == '1'
                  ? Text(translate('event.waitApproveField'))
                  : item.statusconfirm == '2'
                      ? Text(translate('event.approvedField'))
                      : item.statusconfirm == '3'
                          ? Text(translate('event.rejectField'))
                          : Text(translate('event.voidField')),
            )
          ],
        ),
      );

  Widget _buildEditButton({View item, context}) => Align(
        alignment: FractionalOffset.bottomCenter,
        child: SizedBox(
          height: 50,
          width: 180,
          child: OutlineButton(
            // padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
            borderSide: BorderSide(
              color: Color(0xFFfa593f),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditCreatePage(item.id)),
              );
            },
            child: Text(
              translate('event.edit'),
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFfa593f),
              ),
            ),
          ),
        ),
      );

  Widget _buildCancelButton(context) => Align(
        alignment: FractionalOffset.bottomCenter,
        child: SizedBox(
          height: 50,
          width: 180,
          child: RaisedButton(
            // padding: EdgeInsets.fromLTRB(60, 0, 60, 15),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Color(0xFFfa593f),
            onPressed: () async {
              await LeaveService().deleteLeave(scheduleId);
              Navigator.pop(context);
            },
            child: Text(
              translate('event.cancel'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
