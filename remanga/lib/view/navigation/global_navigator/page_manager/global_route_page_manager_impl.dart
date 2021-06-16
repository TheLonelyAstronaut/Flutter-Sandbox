import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remanga/view/auth/login/login_screen.dart';
import 'package:remanga/view/navigation/main_navigator/page_manager/main_route_page_manager_impl.dart';
import 'package:remanga/view/navigation/main_navigator/router_delegate/main_router_delegate_impl.dart';
import 'package:remanga/view/navigation/pages/slide_from_bottom_page.dart';

import '../../global_navigation_configuration.dart';
import '../../main_navigator/main_navigator.dart';
import 'global_route_page_manager.dart';

class GlobalRoutePageManagerImpl extends ChangeNotifier
    implements GlobalRoutePageManager {
  static GlobalRoutePageManager of(BuildContext context) {
    return Provider.of<GlobalRoutePageManager>(context, listen: false);
  }

  final List<Page> _pages = [
    MaterialPage(
      child: MainNavigator(MainRouterDelegateImpl(MainRoutePageManagerImpl())),
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
    if (!configuration.isUnknown && !configuration.isLogin) {
      _pages.removeWhere((element) => element.key != ValueKey('Main'));
    } else if (configuration.isLogin) {
      _pages.add(SlideFromBottomPage(
          child: LoginScreen(() {
            didPopByKey('Login');
          }),
          key: ValueKey('Login'),
          name: '/login'));
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
}
