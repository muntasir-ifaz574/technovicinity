import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../di.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../domain/use_case/sign_up_use_case.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/logout_use_case.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  Future<Either<Failure, dynamic>> build() async {
    return const Right(null);
  }

  /// 🔹 Login Request
  Future<void> loginReq({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final login = sl<LoginUseCase>();
    final result = await login(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    if (ref.mounted) {
      state = AsyncData(result);
    }
  }

  /// 🔹 Sign Up Request
  Future<void> signUpReq({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    state = const AsyncLoading();

    final signUp = sl<SignUpUseCase>();
    final result = await signUp(
      SignUpParams(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
      ),
    );

    if (ref.mounted) {
      state = AsyncData(result);
    }
  }

  /// 🔹 Logout Request
  Future<void> logoutReq() async {
    state = const AsyncLoading();

    final logout = sl<LogoutUseCase>();
    final result = await logout(NoParams());

    if (ref.mounted) {
      state = AsyncData(result);
    }
  }
}
