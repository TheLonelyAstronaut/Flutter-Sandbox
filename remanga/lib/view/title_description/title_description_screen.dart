import 'package:flutter/material.dart';
import 'package:remanga/utils/types.dart';

class TitleDescriptionScreen extends StatelessWidget {
  final NoPararmsCallback goBack;
  final NoPararmsCallback toTitle;
  final NoPararmsCallback openReader;
  final NoPararmsCallback goHome;

  TitleDescriptionScreen(
      this.goBack, this.toTitle, this.openReader, this.goHome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Title Description',
            ),
            TextButton(onPressed: goBack, child: Text('Go back')),
            TextButton(
                onPressed: toTitle,
                child: Text('Open another title description')),
            TextButton(onPressed: openReader, child: Text('Open reader')),
            TextButton(onPressed: goHome, child: Text('Go home'))
          ],
        ),
      ),
    );
  }
}
