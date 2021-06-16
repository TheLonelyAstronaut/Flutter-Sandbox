import 'package:flutter/material.dart';

import 'route_information_parser/global_route_information_parser_impl.dart';
import 'router_delegate/global_router_delegate_impl.dart';
import 'page_manager/global_route_page_manager_impl.dart';

class GlobalNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: GlobalRouteInformationParserImpl(),
      routerDelegate: GlobalRouterDelegateImpl(GlobalRoutePageManagerImpl()),
    );
  }
}
