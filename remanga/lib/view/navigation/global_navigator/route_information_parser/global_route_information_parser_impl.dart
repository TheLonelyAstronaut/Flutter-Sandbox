import 'package:flutter/material.dart';

import '../../global_navigation_configuration.dart';
import 'global_route_information_parser.dart';

class GlobalRouteInformationParserImpl
    extends RouteInformationParser<GlobalNavigationConfiguration>
    implements GlobalRouteInformationParser {
  @override
  Future<GlobalNavigationConfiguration> parseRouteInformation(
          RouteInformation routeInformation) async =>
      parseRoute(Uri.parse(routeInformation.location ?? ''));

  @override
  RouteInformation restoreRouteInformation(
      GlobalNavigationConfiguration configuration) {
    if (configuration.isMain) {
      return RouteInformation(location: '/');
    }

    if (configuration.isSettings) {
      return RouteInformation(location: '/settings');
    }

    if (configuration.isUser) {
      return RouteInformation(location: '/user');
    }

    if (configuration.isLogin) {
      return RouteInformation(location: '/login');
    }

    return RouteInformation(location: '/404');
  }
}
