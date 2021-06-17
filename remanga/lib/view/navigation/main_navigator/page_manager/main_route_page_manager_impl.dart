import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:remanga/di/dependency_injection_root.dart';
import 'package:remanga/view/home/home_screen.dart';
import 'package:remanga/view/navigation/global_navigation_configuration.dart';
import 'package:remanga/view/navigation/global_navigator/page_manager/global_route_page_manager.dart';
import 'package:remanga/view/settings/settings_screen.dart';
import 'package:remanga/view/user/user_screen.dart';

import 'main_route_page_manager.dart';

@LazySingleton(as: MainRoutePageManager)
class MainRoutePageManagerImpl extends ChangeNotifier
    implements MainRoutePageManager {
  static MainRoutePageManager of(BuildContext context) {
    return Provider.of<MainRoutePageManager>(context, listen: false);
  }

  final List<Page> _pages = [
    MaterialPage(child: HomeScreen(), key: ValueKey('Home'), name: '/')
  ];

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  List<Page> get pages => List.unmodifiable(_pages);
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  GlobalNavigationConfiguration get currentConfiguration {
    return parseRoute(Uri.parse(_pages.last.name!));
  }

  @override
  void didPop(Page page) {
    _pages.remove(page);
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(
      GlobalNavigationConfiguration configuration) async {
    if (configuration.isSettings) {
      if (_pages.any((element) => element.key == ValueKey('Settings'))) {
        return;
      }

      _pages.add(MaterialPage(
          child: SettingsScreen(),
          key: ValueKey('Settings'),
          name: '/settings'));
    }

    if (configuration.isUser) {
      if (_pages.any((element) => element.key == ValueKey('User'))) {
        return;
      }

      _pages.add(MaterialPage(
          child: UserScreen(), key: ValueKey('User'), name: '/user'));
    }

    if (configuration.isHome) {
      _pages.removeWhere((element) => element.key != ValueKey('Home'));
    }

    notifyListeners();
  }

  void openSettings() {
    setNewRoutePath(GlobalNavigationConfiguration.settings());
  }

  void openUser() {
    setNewRoutePath(GlobalNavigationConfiguration.user());
  }

  void openHome() {
    setNewRoutePath(GlobalNavigationConfiguration.home());
  }

  void openTitleDescription() {
    setNewRoutePath(GlobalNavigationConfiguration.titleDescription());
  }
}
