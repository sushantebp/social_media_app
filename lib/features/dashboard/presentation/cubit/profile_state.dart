part of 'profile_cubit.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;

  const factory ProfileState.loaded({
    LocalUserDetailsModel? userDetails,
    List<String>? hobbies,
    DateTime? dob,
    List<AcademicQualificationItem>? academics,
    String? successMessage,
  }) = _Loaded;

  const factory ProfileState.error(String? errorMessage) = _Error;
}
