import 'package:flutter/material.dart';
import 'package:remanga/utils/types.dart';

class LoginScreen extends StatelessWidget {
  final NoPararmsCallback goBack;

  LoginScreen(this.goBack);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
            ),
            TextButton(onPressed: goBack, child: Text('Go back'))
          ],
        ),
      ),
    );
  }
}
