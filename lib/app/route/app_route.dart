import 'package:auto_route/auto_route.dart';

import 'app_guard.dart';
import 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(
      page: StartRoute.page,
      guards: [AppGuard()],
    ),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(
      page: HomeRoute.page,
      guards: [AppGuard()],
    ),
    AutoRoute(
      page: DetailsRoute.page,
      guards: [AppGuard()],
    ),
  ];
}
