import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/user_entity.dart';
import '../repository/user_repository.dart';

class GetUsersUseCase implements UseCase<List<UserEntity>, NoParams> {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await repository.getUsers();
  }
}
