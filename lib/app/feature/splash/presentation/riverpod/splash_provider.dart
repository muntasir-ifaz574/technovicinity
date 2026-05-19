import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_provider.g.dart';

@riverpod
class Splash extends _$Splash {
  @override
  bool build() {
    _startSplashTimer();
    return true; // splash is active
  }

  void _startSplashTimer() {
    Timer(const Duration(seconds: 3), () {
      state = false; // splash finished
    });
  }
}
