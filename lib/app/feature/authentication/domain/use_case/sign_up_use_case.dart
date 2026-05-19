import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/sign_up_entity.dart';
import '../repository/authentication_repository.dart';

class SignUpUseCase implements UseCase<SignUpEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<Either<Failure, SignUpEntity>> call(params) async {
    return await repository.signUp(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
      phoneNumber: params.phoneNumber,
    );
  }
}

class SignUpParams {
  final String email;
  final String fullName;
  final String password;
  final String phoneNumber;

  SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
  });
}
