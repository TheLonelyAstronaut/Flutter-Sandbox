import 'package:flutter/material.dart';
import 'package:remanga/utils/types.dart';

class ReaderScreen extends StatelessWidget {
  final NoPararmsCallback goBack;

  ReaderScreen(this.goBack);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Reader',
            ),
            TextButton(onPressed: goBack, child: Text('Go back'))
          ],
        ),
      ),
    );
  }
}
