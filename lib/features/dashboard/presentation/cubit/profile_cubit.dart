import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';
import 'package:social_media_app/features/dashboard/data/models/profile/create_academic_request.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(const ProfileState.initial());

  Future<void> getUserProfile() async {
    emit(const _Loading());

    try {
      final result = await _profileRepository.getUserProfile();

      result.fold(
        (failure) {
          emit(_Error(failure.message));
        },
        (userProfile) {
          final localUser = LocalUserDetailsModel.fromUser(userProfile.user);
          emit(_Loaded(userDetails: localUser));
        },
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> updateHobbies(List<String> hobbies) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.updateHobbies(hobbies);
      result.fold((failure) => emit(_Error(failure.message)), (_) async {
        await getUserProfile();
        emit(_Loaded(successMessage: "Hobbies updated successfully."));
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> deleteHobby() async {
    emit(const _Loading());
    try {
      await _profileRepository.deleteHobby();
      await getUserProfile();
      emit(_Loaded(successMessage: "Hobby deleted successfully."));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> updateDob(DateTime dob) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.updateDob(dob);
      result.fold(
        (failure) {
          emit(_Error(failure.message));
        },
        (_) async {
          await getUserProfile();
          emit(_Loaded(successMessage: "Date of birth updated successfully."));
        },
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> updateLocation() async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.updateLocation();
      result.fold(
        (failure) {
          emit(_Error(failure.message));
        },
        (_) async {
          await getUserProfile();
          emit(_Loaded(successMessage: "Location updated successfully."));
        },
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> updateAcademicQualification(
    CreateAcademicRequest request,
  ) async {
    emit(const _Loading());

    try {
      final result = await _profileRepository.updateAcademicQualification(
        request,
      );

      result.fold((failure) => emit(_Error(failure.message)), (response) async {
        await getUserProfile();
        emit(
          _Loaded(
            successMessage: "Academic qualification updated successfully.",
          ),
        );
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> deleteAcademicQualification() async {
    emit(const _Loading());

    try {
      await _profileRepository.deleteAcademicQualification();
      await getUserProfile();
      emit(
        _Loaded(successMessage: "Academic qualification deleted successfully."),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> getFollowers() async {
    emit(const _Loading());

    try {
      final result = await _profileRepository.getFollowers();

      result.fold((failure) => emit(_Error(failure.message)), (followersData) {
        emit(
          ProfileState.loaded(
            userDetails: null,
            successMessage: "Followers loaded successfully.",
          ),
        );
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> getFollowing() async {
    emit(const _Loading());

    try {
      final result = await _profileRepository.getFollowing();

      result.fold((failure) => emit(_Error(failure.message)), (followingData) {
        emit(
          ProfileState.loaded(
            userDetails: null,
            successMessage: "Following list loaded successfully.",
          ),
        );
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> followUser(String userId) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.followUser(userId);
      result.fold(
        (failure) {
          emit(_Error(failure.message));
        },
        (success) async {
          final userProfileResult = await _profileRepository.getUserProfile();

          userProfileResult.fold((failure) => emit(_Error(failure.message)), (
            userProfile,
          ) {
            final localUser = LocalUserDetailsModel.fromUser(userProfile.user);

            emit(
              ProfileState.loaded(
                userDetails: localUser,
                successMessage: "User followed successfully.",
              ),
            );
          });
        },
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> unFollowUser(String userId) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.unFollowUser(userId);

      result.fold((failure) => emit(_Error(failure.message)), (success) async {
        final userProfileResult = await _profileRepository.getUserProfile();

        userProfileResult.fold((failure) => emit(_Error(failure.message)), (
          userProfile,
        ) {
          final localUser = LocalUserDetailsModel.fromUser(userProfile.user);

          emit(
            ProfileState.loaded(
              userDetails: localUser,
              successMessage: "User unfollowed successfully.",
            ),
          );
        });
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  bool hasRegister() {
    if (state is _Loaded) {
      final user = (state as _Loaded).userDetails;

      if (user == null) return false;
      final isDobFilled = user.dateOfBirth != null;

      return isDobFilled;
    }

    return false;
  }
}
