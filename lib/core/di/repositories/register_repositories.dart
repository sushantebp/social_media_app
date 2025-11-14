import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

void registerRepositories(GetIt sl) {
  // Auth Local Data Source
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sl<SecureStorageService>(),
      sl<LocalStorageService>(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<AuthLocalDataSource>(),
    ),
  );

  // profile local data source
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(
      sl<LocationService>(),
      sl<LocalStorageService>(),
    ),
  );

  // profile remote data source

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Profile Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      sl<ProfileLocalDataSource>(),
      sl<ProfileRemoteDataSource>(),
    ),
  );
}
