import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/data/local/local_data.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure_map.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/sign_up_entity.dart';
import '../../domain/repository/authentication_repository.dart';
import '../data_source/authentication_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.localData,
  });

  final AuthRemoteDataSource authRemoteDataSource;
  final LocalData localData;

  @override
  final TextEditingController emailController = TextEditingController();
  
  @override
  final TextEditingController passwordController = TextEditingController();

  @override
  Future<Either<Failure, SignUpEntity>> signUp({
    required String email,
    required String fullName,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final signUpReq = await authRemoteDataSource.signUp(
        email: email,
        fullName: fullName,
        password: password,
        phoneNumber: phoneNumber,
      );

      return Right(signUpReq.toEntity());
    } on AppException catch (e) {
      return Left(FailureMapper.mapExceptionToFailure(e));
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.login(email: email, password: password);
      
      // Update cache local states
      await localData.setLoginStatus(true);
      await localData.setInStartScreenStatus(false);
      
      return const Right(null);
    } on AppException catch (e) {
      return Left(FailureMapper.mapExceptionToFailure(e));
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = localData.getAccessToken();
      return Right(token.isNotEmpty);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      emailController.clear();
      passwordController.clear();
      await authRemoteDataSource.logout();
      await localData.setLoginStatus(false);
      await localData.setInStartScreenStatus(false);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final status = localData.getLoginStatus();
      return Right(status);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getStartScreenStatus() async {
    try {
      final status = localData.getInStartScreenStatus();
      return Right(status);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setStartScreenStatus(bool active) async {
    try {
      await localData.setInStartScreenStatus(active);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
