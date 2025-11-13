import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/features/onboarding/onboarding.dart';
import 'package:social_media_app/features/splash/cubit/splash_cubit.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await LocalStorageService().init();
  final storage = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(storage.path),
  );
  // Bloc.observer = AppBlocObserver();
  initDependencies();
  runApp(const SocialMediaApp());
}

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()),
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => AuthBloc(sl<AuthRepository>())),
        BlocProvider(create: (_) => BottomBarCubit()),
      ],
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.instance.config(),
      ),
    );
  }
}
