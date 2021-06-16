import 'package:flutter/material.dart';
import 'package:remanga/view/navigation/global_navigator/global_navigator.dart';

void main() {
  runApp(ReManga());
}

class ReManga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalNavigator();
  }
}
