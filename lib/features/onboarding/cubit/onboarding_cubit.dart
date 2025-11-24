import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:social_media_app/core/core.dart';

@injectable
class OnboardingCubit extends HydratedCubit<bool> {
  OnboardingCubit() : super(false);

  void completeOnboarding() => emit(true);

  @override
  Map<String, dynamic>? toJson(bool state) => {AppConstant.completed: state};

  @override
  bool? fromJson(Map<String, dynamic> json) =>
      json[AppConstant.completed] as bool?;
}
