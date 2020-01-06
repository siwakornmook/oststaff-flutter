import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/services/auth_service.dart';

import 'package:validators/validators.dart';

class AuthenPage extends StatefulWidget {
  final Function authencation;

  AuthenPage({this.authencation});

  @override
  _AuthenPageState createState() => _AuthenPageState();
}

class _AuthenPageState extends State<AuthenPage> {
  final Map<String, dynamic> _formData = {'email': null, 'password': null};
  final _formKey = GlobalKey<FormState>();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Image.asset(
              "assets/background/banner.png",
              fit: BoxFit.cover,
            ),

            // _buildForm(context)
            _buildForm(context),

          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 300),
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 20),
                  child: Text(
                    translate('authen.title'),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                _buildEmailInput(),
                SizedBox(
                  height: 20,
                ),
                _buildPasswordInput(),
                /**/
                _buildSubmitButton(context),
                _buildForgotButton(context)
              ],
            ),
          ),
        ),
      );

  Widget _buildEmailInput() => TextFormField(
        decoration: InputDecoration(
          labelText: translate('authen.email'),
          labelStyle: TextStyle(color: Colors.grey[300]),
          icon: Icon(
            Icons.email,
            color: Colors.grey[300],
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: _validateEmail,
        onSaved: (String value) {
          _formData["email"] = value;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
      );

  Widget _buildPasswordInput() => TextFormField(
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          labelText: translate('authen.password'),
          labelStyle: TextStyle(color: Colors.grey[300]),
          icon: Icon(
            Icons.vpn_key,
            color: Colors.grey[300],
          ),
        ),
        obscureText: true,
        validator: _validatePassword,
        onSaved: (String value) {
          _formData["password"] = value;
        },
        onFieldSubmitted: (String value) {},
      );

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 30, left: 80, right: 80),
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: Text(
            translate('authen.login'),
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.deepOrangeAccent,
          onPressed: () => _submit(),
        ));
  }

  Widget _buildForgotButton(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,

      // padding: EdgeInsets.only(left: 80, right: 80),

//          alignment: Alignment.center,
      child: FlatButton(
        child: Text(
          translate('authen.forgot'),
          style: TextStyle(color: Colors.grey[400], fontSize: 17),
        ),
        onPressed: () {},
      ));

  void _submit() async {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      bool successInformation = await (AuthService().authencation(
          user: _formData['email'], password: _formData['password']));
      if (successInformation) {
//        ProfileService().fetchProfile();
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        print('success false');
        _showAlertDialog();
      }
    }
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(translate('authen.incorrect'),style: TextStyle(fontSize: 16),),
            content: Text(translate('authen.tryAgain'),style: TextStyle(fontSize: 14)),
            actions: <Widget>[
              FlatButton(
                child: Text(translate('authen.ok')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return translate('authen.emailEmpty');
    }
    if (!isEmail(value)) {
      return translate('authen.valid');
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return translate('authen.passwordEmpty');
    }
    return null;
  }
}
