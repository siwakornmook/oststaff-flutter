import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/services/auth_service.dart';
import 'package:starter/services/profile_service.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter,
                      //  end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFfa593f),
                        const Color(0xFFfb9060),
                      ]),
                ),
                height: MediaQuery.of(context).size.height),
            FutureBuilder(
                future: ProfileService().fetchProfile(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(top: 80, left: 30),
                              child: ClipOval(
                                child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: snapshot.data.image != null &&
                                            snapshot.data.image != ''
                                        ? Image.network(
                                            snapshot.data.image,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset(
                                            'assets/images/default-profile.png',
                                            fit: BoxFit.cover,
                                          )),
                              ),

                              padding: const EdgeInsets.all(4.0), // borde width
                              decoration: new BoxDecoration(
                                  color: Colors.deepOrange, // border color
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepOrange[400],
                                      blurRadius: 20.0,
                                      // has the effect of softening the shadow
                                      spreadRadius: 1.0,
                                      // has the effect of extending the shadow
                                      offset: Offset(
                                        0.0, // horizontal, move right 10
                                        0.0,
                                      ),
                                    ),
                                  ]),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              '${snapshot.data.firstName}  ${snapshot.data.lastName}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              '${snapshot.data.position}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 20),
                            leading: Icon(
                              Icons.access_alarm,
                              color: Colors.white,
                            ),
                            title: Text(
                              translate('drawer.timestamp'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/dashboard');
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 20),
                            leading: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            title: Text(
                              translate('drawer.calendar'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/calendar');
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 20),
                            leading: Icon(
                              Icons.description,
                              color: Colors.white,
                            ),
                            title: Text(
                              translate('drawer.timeSheets'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/timesheet');
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 20),
                            leading: Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                            ),
                            title: Text(
                              translate('drawer.notification'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/notification');
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 20),
                            leading: Icon(
                              Icons.insert_chart,
                              color: Colors.white,
                            ),
                            title: Text(
                              translate('drawer.leaveReport'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "/leavereport");
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 20),
                            leading: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            title: Text(
                              translate('drawer.logout'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onTap: () async {
                              await AuthService().logout();

                              Navigator.pushReplacementNamed(
                                  context, "/authen");
                            },
                          )
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
          ],
        ),
      ),
    );
  }
}
