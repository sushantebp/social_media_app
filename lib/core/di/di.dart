import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/di/bloc/register_bloc.dart';
import 'package:social_media_app/core/di/repositories/register_repositories.dart';

final sl = GetIt.instance;

void initDependencies() {
  registerBloc(sl);
  registerRepositories(sl);
}
