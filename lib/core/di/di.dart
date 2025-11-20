import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/core/di/bloc/register_bloc.dart';
import 'package:social_media_app/core/di/repositories/register_repositories.dart';

final sl = GetIt.instance;

void initDependencies() {
  registerServices();
  registerBloc(sl);
  registerRepositories(sl);
}

void registerServices() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<SecureStorageService>(SecureStorageService());
  sl.registerSingleton<LocalStorageService>(LocalStorageService());
  sl.registerSingleton<LocationService>(LocationService());
}
