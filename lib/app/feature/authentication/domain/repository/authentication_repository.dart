import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/error/failures.dart';
import '../entity/sign_up_entity.dart';

abstract class AuthRepository {
  TextEditingController get emailController;
  TextEditingController get passwordController;

  Future<Either<Failure, SignUpEntity>> signUp({
    required String email,
    required String fullName,
    required String password,
    required String phoneNumber,
  });

  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, bool>> isAuthenticated();

  Future<Either<Failure, bool>> isLoggedIn();

  Future<Either<Failure, bool>> getStartScreenStatus();

  Future<Either<Failure, void>> setStartScreenStatus(bool active);
}
