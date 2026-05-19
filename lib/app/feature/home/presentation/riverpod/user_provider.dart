import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../di.dart';
import '../../../../core/use_case/use_case.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/use_case/get_users_use_case.dart';

part 'user_provider.g.dart';

@riverpod
class UserList extends _$UserList {
  @override
  Future<List<UserEntity>> build() async {
    final getUsers = sl<GetUsersUseCase>();
    final result = await getUsers(NoParams());
    
    return result.fold(
      (failure) => throw failure,
      (users) => users,
    );
  }
}
