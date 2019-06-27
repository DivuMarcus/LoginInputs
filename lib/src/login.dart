import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class MyApp extends StatelessWidget {
  final barColor = const Color(0xFF9E2B25);
  final bgColor = const Color(0xFFFFF8F0);
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: MyLoginPage(),
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: barColor,
        ),
      ),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  createState() {
    return LoginPage();
  }
}

class _LoginData {
  String email = '';
  String password = '';
}

class LoginPage extends State<MyLoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  // Add validate email function.
  String _validateEmail(String value) {
    if (EmailValidator.validate(value) == true) {
      return null;
    } else {
      return 'The E-mail Address must be a valid email address.';
    }
  }

  // Add validate password function.
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: this._formKey,
      child: new ListView(
        padding: EdgeInsets.fromLTRB(
            20, (screenSize.height / 2) - 135, 20, (screenSize.height / 2)),
        children: <Widget>[
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: 'Email Address', hintText: 'you@example.com'),
              validator: this._validateEmail,
              onSaved: (String value) {
                this._data.email = value;
              }),
          new TextFormField(
              obscureText: true, // Use secure text for passwords.
              decoration: new InputDecoration(
                  hintText: 'Password', labelText: 'Enter your password'),
              validator: this._validatePassword,
              onSaved: (String value) {
                this._data.password = value;
              }),
          new Container(
            width: screenSize.width,
            child: new RaisedButton(
              child: new Text(
                'Login',
                style: new TextStyle(color: Colors.white),
              ),
              onPressed: this.submit,
              color: Colors.blue,
            ),
            margin: new EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }
}
