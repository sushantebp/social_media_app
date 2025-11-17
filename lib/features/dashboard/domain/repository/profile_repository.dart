import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/data/data.dart';

abstract class ProfileRepository {
  // user management
  Future<Result<UserAcademicsProfileResponseModel>> getUserProfile();

  Future<Result<HobbiesUpdateResponseModel>> updateHobbies(
    List<String> hobbies,
  );
  Future<void> deleteHobby();

  Future<Result<AcademicResponseModel>> updateAcademicQualification(
    AcademicData request,
  );
  Future<void> deleteAcademicQualification();

  Future<Result<UpdateDobResponse>> updateDob(DateTime dob);
  Future<Result<UserLocationModel>> updateLocation();
  // update location

  // related to follower and following stuff
  Future<Result<GetFollowersResponseModel>> getFollowers();
  Future<Result<GetFollowersResponseModel>> getFollowing();
  Future<Result<SuccessResponse>> followUser(String followUserId);
  Future<Result<SuccessResponse>> unFollowUser(String unfollowUserId);
}
