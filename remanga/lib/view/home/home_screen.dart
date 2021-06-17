import 'package:flutter/material.dart';
import 'package:remanga/di/dependency_injection_root.dart';
import 'package:remanga/view/navigation/global_navigator/page_manager/global_route_page_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState(instance.get<GlobalRoutePageManager>());
  }
}

class HomeScreenState extends State<HomeScreen> {
  late final GlobalRoutePageManager globalPageManager;

  HomeScreenState(this.globalPageManager);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home',
            ),
            TextButton(
                onPressed: globalPageManager.openTitleDescription,
                child: Text('Open title'))
          ],
        ),
      ),
    );
  }
}
