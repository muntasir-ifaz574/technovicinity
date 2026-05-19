import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/authentication_repository.dart';

class SetStartScreenStatusUseCase implements UseCase<void, bool> {
  final AuthRepository repository;

  SetStartScreenStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(bool active) async {
    return await repository.setStartScreenStatus(active);
  }
}
