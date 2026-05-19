// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:technovicinity/app/feature/authentication/presentation/view/sign_in_screen.dart'
    as _i3;
import 'package:technovicinity/app/feature/home/domain/entity/user_entity.dart'
    as _i8;
import 'package:technovicinity/app/feature/home/presentation/view/details_screen.dart'
    as _i1;
import 'package:technovicinity/app/feature/home/presentation/view/home_screen.dart'
    as _i2;
import 'package:technovicinity/app/feature/splash/presentation/views/splash_screen.dart'
    as _i4;
import 'package:technovicinity/app/feature/start/presentation/view/start_screen.dart'
    as _i5;

/// generated route for
/// [_i1.DetailsScreen]
class DetailsRoute extends _i6.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    _i7.Key? key,
    required _i8.UserEntity userData,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         DetailsRoute.name,
         args: DetailsRouteArgs(key: key, userData: userData),
         initialChildren: children,
       );

  static const String name = 'DetailsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailsRouteArgs>();
      return _i1.DetailsScreen(key: args.key, userData: args.userData);
    },
  );
}

class DetailsRouteArgs {
  const DetailsRouteArgs({this.key, required this.userData});

  final _i7.Key? key;

  final _i8.UserEntity userData;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, userData: $userData}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DetailsRouteArgs) return false;
    return key == other.key && userData == other.userData;
  }

  @override
  int get hashCode => key.hashCode ^ userData.hashCode;
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.SignInScreen]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute({List<_i6.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.SignInScreen();
    },
  );
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashScreen();
    },
  );
}

/// generated route for
/// [_i5.StartScreen]
class StartRoute extends _i6.PageRouteInfo<void> {
  const StartRoute({List<_i6.PageRouteInfo>? children})
    : super(StartRoute.name, initialChildren: children);

  static const String name = 'StartRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.StartScreen();
    },
  );
}
