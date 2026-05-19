import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/authentication_repository.dart';

enum SplashRedirect { signIn, start, home }

class CheckSplashRedirectUseCase implements UseCase<SplashRedirect, NoParams> {
  final AuthRepository authRepository;

  CheckSplashRedirectUseCase({required this.authRepository});

  @override
  Future<Either<Failure, SplashRedirect>> call(NoParams params) async {
    final loginResult = await authRepository.isLoggedIn();
    
    return await loginResult.fold(
      (failure) => Left(failure),
      (isLoggedIn) async {
        if (!isLoggedIn) {
          return const Right(SplashRedirect.signIn);
        }
        
        final startStatusResult = await authRepository.getStartScreenStatus();
        return startStatusResult.fold(
          (failure) => Left(failure),
          (inStartScreen) {
            if (inStartScreen) {
              return const Right(SplashRedirect.start);
            } else {
              return const Right(SplashRedirect.home);
            }
          },
        );
      },
    );
  }
}
