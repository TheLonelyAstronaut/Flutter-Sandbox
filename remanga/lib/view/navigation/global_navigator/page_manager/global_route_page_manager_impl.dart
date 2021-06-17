import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:remanga/di/dependency_injection_root.dart';
import 'package:remanga/view/auth/login/login_screen.dart';
import 'package:remanga/view/navigation/global_navigator/router_delegate/global_router_deleagte.dart';
import 'package:remanga/view/navigation/main_navigator/page_manager/main_route_page_manager_impl.dart';
import 'package:remanga/view/navigation/main_navigator/router_delegate/main_router_delegate.dart';
import 'package:remanga/view/navigation/main_navigator/router_delegate/main_router_delegate_impl.dart';
import 'package:remanga/view/navigation/pages/slide_from_bottom_page.dart';
import 'package:remanga/view/reader/reader_screen.dart';
import 'package:remanga/view/title_description/title_description_screen.dart';

import '../../global_navigation_configuration.dart';
import '../../main_navigator/main_navigator.dart';
import 'global_route_page_manager.dart';

@LazySingleton(as: GlobalRoutePageManager)
class GlobalRoutePageManagerImpl extends ChangeNotifier
    implements GlobalRoutePageManager {
  static GlobalRoutePageManager of(BuildContext context) {
    return Provider.of<GlobalRoutePageManager>(context, listen: false);
  }

  final List<Page> _pages = [
    MaterialPage(
      child: MainNavigator(instance.get<MainRouterDelegate>()),
      key: ValueKey('Main'),
      name: '/',
    ),
  ];

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  List<Page> get pages => List.unmodifiable(_pages);
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void didPop(Page page) {
    _pages.remove(page);
    notifyListeners();
  }

  void didPopByKey(String key) {
    _pages.removeWhere((element) => element.key == ValueKey(key));
    notifyListeners();
  }

  GlobalNavigationConfiguration get currentConfiguration {
    return parseRoute(Uri.parse(_pages.last.name!));
  }

  Future<void> setNewRoutePath(
      GlobalNavigationConfiguration configuration) async {
    if (configuration.isMain) {
      _pages.removeWhere((element) => element.key != ValueKey('Main'));
    } else if (configuration.isLogin) {
      _pages.add(SlideFromBottomPage(
          child: LoginScreen(() {
            didPopByKey('Login');
          }),
          key: ValueKey('Login'),
          name: '/login'));
    } else if (configuration.isReader) {
      _pages.add(SlideFromBottomPage(
          child: ReaderScreen(() {
            didPopByKey('Reader');
          }),
          key: ValueKey('Reader'),
          name: '/reader'));
    } else if (configuration.isTitleDescription) {
      int _key = _pages.length;

      _pages.add(SlideFromBottomPage(
          child: TitleDescriptionScreen(() {
            didPopByKey('TitleDescription${_key}');
          }, openTitleDescription, openReader, openMain),
          key: ValueKey('TitleDescription${_key}'),
          name: '/titleDescription'));
    }

    notifyListeners();
  }

  void openMain() {
    setNewRoutePath(GlobalNavigationConfiguration.main());
  }

  void openUnknown() {
    setNewRoutePath(GlobalNavigationConfiguration.unknown());
  }

  void openLogin() {
    setNewRoutePath(GlobalNavigationConfiguration.login());
  }

  void openReader() {
    setNewRoutePath(GlobalNavigationConfiguration.reader());
  }

  void openTitleDescription() {
    setNewRoutePath(GlobalNavigationConfiguration.titleDescription());
  }
}
