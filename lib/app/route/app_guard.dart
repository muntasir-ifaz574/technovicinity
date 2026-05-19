import 'package:auto_route/auto_route.dart';
import 'package:technovicinity/app/route/app_route.gr.dart';
import 'package:get_it/get_it.dart';
import '../feature/authentication/domain/repository/authentication_repository.dart';

class AppGuard extends AutoRouteGuard {

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (resolver.routeName == SplashRoute.name) {
      resolver.next();
      return;
    }

    final authRepository = GetIt.I<AuthRepository>();
    final isLoggedInResult = await authRepository.isLoggedIn();
    final isLoggedIn = isLoggedInResult.fold((_) => false, (status) => status);

    if (!isLoggedIn) {
      router.replace(const SignInRoute());
      return;
    }

    resolver.next();
  }
}
