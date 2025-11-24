// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core.dart' as _i446;
import '../network/dio_client.dart' as _i45;
import '../services/local_storage_service.dart' as _i473;
import '../services/location_service.dart' as _i65;
import '../services/secure_storage_service.dart' as _i493;
import '../../features/auth/auth.dart' as _i815;
import '../../features/auth/data/data_sources/auth_local_data_source.dart' as _i1029;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart' as _i145;
import '../../features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import '../../features/dashboard/dashboard.dart' as _i384;
import '../../features/dashboard/data/data.dart' as _i199;
import '../../features/dashboard/data/data_sources/post/post_remote_data_source.dart'
    as _i242;
import '../../features/dashboard/data/data_sources/profile/profile_local_data_source.dart'
    as _i928;
import '../../features/dashboard/data/data_sources/profile/profile_remote_data_source.dart'
    as _i66;
import '../../features/dashboard/data/repository/post_repository_impl.dart' as _i1049;
import '../../features/dashboard/data/repository/profile_repository_impl.dart'
    as _i233;
import '../../features/dashboard/domain/domain.dart' as _i494;
import '../../features/dashboard/presentation/cubit/bottom_bar_cubit.dart' as _i313;
import '../../features/dashboard/presentation/cubit/post_cubit.dart' as _i140;
import '../../features/dashboard/presentation/cubit/profile_cubit.dart' as _i747;
import '../../features/onboarding/cubit/onboarding_cubit.dart' as _i399;
import '../../features/splash/cubit/splash_cubit.dart' as _i383;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i313.BottomBarCubit>(() => _i313.BottomBarCubit());
    gh.factory<_i399.OnboardingCubit>(() => _i399.OnboardingCubit());
    gh.factory<_i383.SplashCubit>(() => _i383.SplashCubit());
    gh.lazySingleton<_i45.DioClient>(() => _i45.DioClient());
    gh.lazySingleton<_i473.LocalStorageService>(
      () => _i473.LocalStorageService(),
    );
    gh.lazySingleton<_i65.LocationService>(() => _i65.LocationService());
    gh.lazySingleton<_i493.SecureStorageService>(
      () => _i493.SecureStorageService(),
    );
    gh.lazySingleton<_i1029.AuthLocalDataSource>(
      () => _i1029.AuthLocalDataSourceImpl(
        gh<_i446.SecureStorageService>(),
        gh<_i446.LocalStorageService>(),
      ),
    );
    gh.lazySingleton<_i928.ProfileLocalDataSource>(
      () => _i928.ProfileLocalDataSourceImpl(
        gh<_i446.LocationService>(),
        gh<_i446.LocalStorageService>(),
      ),
    );
    gh.lazySingleton<_i66.ProfileRemoteDataSource>(
      () => _i66.ProfileRemoteDataSourceImpl(gh<_i446.DioClient>()),
    );
    gh.lazySingleton<_i145.AuthRemoteDataSource>(
      () => _i145.AuthRemoteDataSourceImpl(gh<_i446.DioClient>()),
    );
    gh.lazySingleton<_i494.ProfileRepository>(
      () => _i233.ProfileRepositoryImpl(
        gh<_i199.ProfileLocalDataSource>(),
        gh<_i199.ProfileRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i242.PostRemoteDataSource>(
      () => _i242.PostRemoteDataSourceImpl(gh<_i446.DioClient>()),
    );
    gh.factory<_i747.ProfileCubit>(
      () => _i747.ProfileCubit(gh<_i384.ProfileRepository>()),
    );
    gh.lazySingleton<_i815.AuthRepository>(
      () => _i111.AuthRepositoryImpl(
        gh<_i815.AuthRemoteDataSource>(),
        gh<_i815.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i384.PostRepository>(
      () => _i1049.PostRepositoryImpl(gh<_i384.PostRemoteDataSource>()),
    );
    gh.factory<_i140.PostCubit>(
      () => _i140.PostCubit(gh<_i384.PostRepository>()),
    );
    gh.factory<_i363.AuthBloc>(
      () => _i363.AuthBloc(gh<_i815.AuthRepository>()),
    );
    return this;
  }
}
