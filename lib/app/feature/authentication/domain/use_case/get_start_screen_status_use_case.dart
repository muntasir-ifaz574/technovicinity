import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/authentication_repository.dart';

class GetStartScreenStatusUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  GetStartScreenStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.getStartScreenStatus();
  }
}
