import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/core.dart';

typedef Result<T> = Either<AppException, T>;

typedef BaseCubit<T> = Cubit<T>;

typedef BaseBloc<TEvent, TState> = Bloc<TEvent, TState>;
