import 'package:get_it/get_it.dart';

import 'package:social_media_app/features/auth/auth.dart';

void registerBloc(GetIt sl) {
  // Auth BLoC
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<AuthRepository>()));
}
