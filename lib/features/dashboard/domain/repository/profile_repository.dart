import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/data/data.dart';
import 'package:social_media_app/features/dashboard/data/models/profile/create_academic_request.dart';

abstract class ProfileRepository {
  // user management
  Future<Result<GetUserProfileResponseModel>> getUserProfile();

  Future<Result<HobbiesResponseModel>> updateHobbies(List<String> hobbies);
  Future<void> deleteHobby();

  Future<Result<AcademicResponseModel>> updateAcademicQualification(
    CreateAcademicRequest request,
  );
  Future<void> deleteAcademicQualification();

  Future<Result<UpdateDobResponse>> updateDob(DateTime dob);
  Future<Result<LocationResponseModel>> updateLocation(
    LocationRequestModel request,
  );

  // related to follower and following stuff
  Future<Result<GetFollowersResponseModel>> getFollowers();
  Future<Result<GetFollowersResponseModel>> getFollowing();
  Future<Result<SuccessResponse>> followUser(String followUserId);
  Future<Result<SuccessResponse>> unFollowUser(String unfollowUserId);
}
