import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/models/view.dart';
import 'package:starter/pages/view_attachment.dart';
import 'package:starter/services/notification_service.dart';
import 'package:intl/intl.dart';

class ViewPage extends StatefulWidget {
  final String requestId;

  ViewPage(this.requestId);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {


    final double deviceheight = MediaQuery.of(context).size.height;



    return Scaffold(
      appBar: AppBar(
        title: Text(translate('event.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
      ),
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
      ):Container(
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
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,

            alignment: Alignment.center,
            margin: EdgeInsets.only(top: deviceheight * 0.1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
            child: FutureBuilder(
                future: NotificationService().getView(requestId: widget.requestId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      View view = snapshot.data;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30, right: 30,top: 10),
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.75, color: Color(0xFFcfcfcf)),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
//                                  child: CircleAvatar(
//                                    backgroundImage:
//                                        NetworkImage(snapshot.data.requestImg),
//                                    radius: 30.0,
//                                  ),
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    child: ClipOval(

                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: snapshot.data.requestImg != null && snapshot.data.requestImg != ''
                                              ? Image.network(
                                            snapshot.data.requestImg,
                                            fit: BoxFit.cover,
                                          )
                                              : Image.asset('assets/images/default-profile.png',fit: BoxFit.cover,)
                                      ),
                                    ),
                                  ),

                                  padding: const EdgeInsets.all(4.0),
                                  // borde width
                                  decoration: new BoxDecoration(
                                    color: Colors.grey[300], // border color
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        snapshot.data.requestName,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[700]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data.subtitle,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                top: 15, bottom: 10, left: 30, right: 30),
                            child: Text(
                              snapshot.data.title,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700],fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _buildBoxStart(view.dateTimeStart),
                              SizedBox(
                                width: 1,
                              ),
                              _buildBoxEnd(view.dateTimeEnd),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _buildDescription(view.description),
                          _buildType(view.leaveTypeName),
                          _buildApprove(view.approveName),
                          _buildAttachment(view: view,context: context),
                          _buildStatus(view.statusconfirm),
                          SizedBox(
                            height: 20,
                          ),
                          _buildRejectButton(view,context),
                          SizedBox(
                            height: 10,
                          ),
                          _buildApproveButton(view,context),
                        ],
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
          ),
        ),
      ),
    );
  }

  Widget _buildBoxStart(dateTimeStart) => GestureDetector(
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
          height: 80,
          margin: EdgeInsets.only(left: 10),
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
                    padding: EdgeInsets.only(top: 20, left: 15),
                    child: Text(
                      DateFormat("EEE, d MMM").format(dateTimeStart),
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 5),
                    child: Text(
                      DateFormat("H:mm ").format(dateTimeStart),
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

  Widget _buildBoxEnd(dateTimeEnd) => GestureDetector(
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
          height: 80,
//          margin: EdgeInsets.only(right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 25),
                    child: Center(
                      child: Text(
                        DateFormat("EEE, d MMM").format(dateTimeEnd),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 25),
                    child: Text(
                      DateFormat("H:mm ").format(dateTimeEnd),
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

  Widget _buildDescription(description) => Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.75, color: Color(0xFFcfcfcf)),
          ),
        ),
        child: Text(
          description,
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
      );

  Widget _buildType(leaveTypeName) => Container(
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
                    leaveTypeName,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildApprove(approveName) => Container(
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
                approveName,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );

  Widget _buildAttachment({View view,context}) => Container(
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
                      view.fileAttach.length.toString(),
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
              onTap: (){
                if(view.fileAttach.length > 0){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAttachmentPage(view.fileAttach)),
                  );
                }

              },
            ),
          ],
        ),
      );

  Widget _buildStatus(status) => Container(
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
                    color: status == '1'
                        ? Colors.deepOrange
                        : status == '2'
                            ? Colors.green
                            : status == '3' ? Colors.red : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: status == '1'
                  ? Text(translate('event.waitApproveField'))
                  : status == '2'
                      ? Text(translate('event.approvedField'))
                      : status == '3' ? Text(translate('event.rejectField')) : Text(translate('event.voidField')),
            )
          ],
        ),
      );

  _buildRejectButton(data,context) => Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 50,
          width: 180,
          child: RaisedButton(
            // padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
            color: Colors.red,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            onPressed: ()  {
             showDialogCancel(data,context);
            },
            child: Text(
              translate('event.rejectField'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

   _buildApproveButton(data,context) => Align(
     alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 50,
          width: 180,
          child: RaisedButton(
            // padding: EdgeInsets.fromLTRB(60, 0, 60, 15),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            // color: Color(0xFFfa593f),
            color: Colors.green,
            onPressed: ()  {
              showDialogConfirm(data,context);
            },
            child: Text(
              translate('event.approvedField'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );

  void showDialogConfirm(data,context) {
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
              child: Text(translate('event.confirm')),
              onPressed: ()  async {
                isLoading = true;


                await NotificationService().dialogNotofication(requestId: widget.requestId,status: 2);
                Navigator.of(dialogContext).pop();
                Navigator.pop(context);
              // Dismiss alert dialog
              },
            ),
            FlatButton(
              child: Text(translate('event.cancel')),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogCancel(data,context) {
    showDialog<void>(
      context:  context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
//          title: Text('title'),
          content: Text(data.dialogue),
          actions: <Widget>[
            FlatButton(
              child: Text(translate('event.confirm')),
              onPressed: ()  async {
                isLoading = true;

                await NotificationService().dialogNotofication(requestId: widget.requestId,status: 3);
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                Navigator.pop(context);


              },
            ),
            FlatButton(
              child: Text(translate('event.cancel')),
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
