import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

/// [ProfileCubit]
///
/// Handles user profile operations:
/// - Fetching profile remotely or loading cached data when offline
/// - Updating/deleting hobbies, DOB, location, academic qualifications
/// - Handling followers/following
/// - Following/unfollowing users
///
/// Emits:
/// - [_Loading] during network operations
/// - [_Loaded] when remote fetch/update succeeds
/// - [_Offline] when no internet but cached data exists
/// - [_Error] when operation fails
class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(const _Initial());

  /// ---------------------------
  /// Core fetch method
  /// ---------------------------
  Future<void> getUserProfile() async {
    emit(const _Loading());

    try {
      final result = await _profileRepository.getUserProfile();

      result.fold(
        (failure) {
          if (failure.message?.contains(AppConstant.noInternetConn) == true) {
            final localUser = LocalStorageService().getUserLocalDetails();

            if (localUser != null) {
              emit(_Offline(user: localUser));
              return;
            }
          }
          emit(_Error(failure.message));
        },
        (userProfile) {
          final localUser = LocalUserDetailsModel.fromUserAcademics(
            userProfile.user,
          );
          emit(_Loaded(userDetails: localUser));
        },
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// ---------------------------
  /// Update Methods
  /// ---------------------------
  Future<void> updateHobbies(List<String> hobbies) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.updateHobbies(hobbies);
      result.fold((failure) => emit(_Error(failure.message)), (_) async {
        await getUserProfile();
        _emitSuccessMessage("Hobbies updated successfully.");
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> updateDob(DateTime dob) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.updateDob(dob);
      result.fold((failure) => emit(_Error(failure.message)), (_) async {
        await getUserProfile();
        _emitSuccessMessage("Date of birth updated successfully.");
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> updateLocation() async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.updateLocation();
      result.fold((failure) => emit(_Error(failure.message)), (_) async {
        await getUserProfile();
        _emitSuccessMessage("Location updated successfully.");
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> updateAcademicQualification(AcademicData request) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.updateAcademicQualification(
        request,
      );
      result.fold((failure) => emit(_Error(failure.message)), (_) async {
        await getUserProfile();
        _emitSuccessMessage("Academic qualification updated successfully.");
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// ---------------------------
  /// Delete Methods
  /// ---------------------------
  Future<void> deleteHobby() async {
    emit(const _Loading());
    try {
      await _profileRepository.deleteHobby();
      await getUserProfile();
      _emitSuccessMessage("Hobby deleted successfully.");
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> deleteAcademicQualification() async {
    emit(const _Loading());
    try {
      await _profileRepository.deleteAcademicQualification();
      await getUserProfile();
      _emitSuccessMessage("Academic qualification deleted successfully.");
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// ---------------------------
  /// Followers / Following
  /// ---------------------------
  Future<void> getFollowers() async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.getFollowers();
      result.fold(
        (failure) => emit(_Error(failure.message)),
        (_) => _emitSuccessMessage("Followers loaded successfully."),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> getFollowing() async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.getFollowing();
      result.fold(
        (failure) => emit(_Error(failure.message)),
        (_) => _emitSuccessMessage("Following list loaded successfully."),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// ---------------------------
  /// Follow / Unfollow User
  /// ---------------------------
  Future<void> followUser(String userId) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.followUser(userId);
      result.fold((failure) => emit(_Error(failure.message)), (_) async {
        await _refreshUserProfileWithMessage("User followed successfully.");
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> unFollowUser(String userId) async {
    emit(const _Loading());
    try {
      final result = await _profileRepository.unFollowUser(userId);
      result.fold((failure) => emit(_Error(failure.message)), (_) async {
        await _refreshUserProfileWithMessage("User unfollowed successfully.");
      });
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// ---------------------------
  /// Helper / Utility Methods
  /// ---------------------------
  /// Emits a [_Loaded] state with current userDetails and successMessage
  void _emitSuccessMessage(String message) {
    final currentState = state;

    if (currentState is _Loaded) {
      emit(currentState.copyWith(successMessage: message));
    } else if (currentState is _Offline) {
      emit(_Loaded(userDetails: currentState.user, successMessage: message));
    } else {
      final localUser = LocalStorageService().getUserLocalDetails();

      if (localUser != null) {
        emit(_Loaded(userDetails: localUser, successMessage: message));
      } else {
        emit(_Error("No user data available"));
      }
    }
  }

  /// Fetches profile and emits [_Loaded] with successMessage
  Future<void> _refreshUserProfileWithMessage(String message) async {
    await getUserProfile();
    _emitSuccessMessage(message);
  }

  /// Returns true if the user has registered (DOB is not empty)
  bool hasRegistered() {
    if (state is _Loaded) {
      final user = (state as _Loaded).userDetails;
      return user.dateOfBirth != null && user.dateOfBirth!.isNotEmpty;
    }
    return false;
  }
}
