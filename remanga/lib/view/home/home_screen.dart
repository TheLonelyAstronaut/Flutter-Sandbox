import 'package:flutter/material.dart';
import 'package:remanga/bloc/title_list_bloc/title_list_bloc.dart';
import 'package:remanga/di/dependency_injection_root.dart';
import 'package:remanga/view/navigation/global_navigator/page_manager/global_route_page_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //DI xDDDDDDDDD
    return HomeScreenState(
        instance.get<GlobalRoutePageManager>(), instance.get<TitleListBloc>());
  }
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalRoutePageManager globalPageManager;
  final TitleListBloc titleListBloc;

  HomeScreenState(this.globalPageManager, this.titleListBloc);

  @override
  void initState() {
    super.initState();

    titleListBloc.states.titles.listen((event) {
      print(event);
    });

    titleListBloc.states.isLoading.listen((event) {
      print(event);
    });
  }

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
                child: Text('Open title')),
            TextButton(
                onPressed: titleListBloc.events.getTopThirty,
                child: Text('Get top 30'))
          ],
        ),
      ),
    );
  }
}
