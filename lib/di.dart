import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/core/data/data.dart';
import 'app/feature/authentication/data/data.dart';
import 'app/feature/authentication/domain/domain.dart';
import 'app/feature/authentication/presentation/presentation.dart';
import 'app/feature/home/data/data_source/user_local_data_source.dart';
import 'app/feature/home/data/repository/user_repository_impl.dart';
import 'app/feature/home/domain/repository/user_repository.dart';
import 'app/feature/home/domain/use_case/get_users_use_case.dart';

final sl = GetIt.instance;

Future dI() async {
  // Local Data Storage/ Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Core
  //-- Local Data
  sl.registerLazySingleton<LocalData>(() => LocalData(sl()));
  //-- Network API Service
  final apiService = NetworkApiServices(sl());
  sl.registerLazySingleton(() => apiService);

  // Data sources
  //-- Remote
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: sl()),
  );
  //-- Local
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      localData: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(repository: sl()));
  sl.registerLazySingleton<CheckSplashRedirectUseCase>(() => CheckSplashRedirectUseCase(authRepository: sl()));
  sl.registerLazySingleton<GetStartScreenStatusUseCase>(() => GetStartScreenStatusUseCase(repository: sl()));
  sl.registerLazySingleton<SetStartScreenStatusUseCase>(() => SetStartScreenStatusUseCase(repository: sl()));
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(repository: sl()));

  // Riverpod Notifier
  sl.registerFactory(() => Auth());
}
