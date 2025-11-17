import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/data/data.dart';
import 'package:social_media_app/features/dashboard/data/models/profile/create_academic_request.dart';

abstract class ProfileRemoteDataSource {
  Future<GetUserProfileResponseModel> getUserProfile();
  Future<HobbiesResponseModel> updateHobbies(List<String> hobbies);
  Future<void> deleteHobby();

  Future<AcademicResponseModel> updateAcademicQualification(
    CreateAcademicRequest request,
  );
  Future<void> deleteAcademicQualification();

  Future<UpdateDobResponse> updateDob(DateTime dob);

  Future<UserLocationModel> updateLocation();

  Future<GetFollowersResponseModel> getFollowers();
  Future<GetFollowersResponseModel> getFollowing();
  Future<SuccessResponse> followUser(String followUserId);
  Future<SuccessResponse> unFollowUser(String unfollowUserId);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final DioClient _dioClient;
  ProfileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<GetUserProfileResponseModel> getUserProfile() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoint.getUserProfile);
      if (response.statusCode == 200) {
        return GetUserProfileResponseModel.fromJson(response.data);
      } else {
        throw DioAppException.fromDioError(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: "Unexpected server response",
          ),
        );
      }
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<HobbiesResponseModel> updateHobbies(List<String> hobbies) async {
    try {
      final response = await _dioClient.dio.put(
        ApiEndpoint.updateHobbie,
        data: jsonEncode({'hobbies': hobbies}),
      );
      if (response.statusCode == 200) {
        return HobbiesResponseModel.fromJson(response.data);
      }
      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Unexpected server response",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<void> deleteHobby() async {
    try {
      final response = await _dioClient.dio.delete(ApiEndpoint.updateHobbie);
      if (response.statusCode != 200) {
        throw DioAppException.fromDioError(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: "Failed to delete hobby",
          ),
        );
      }
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<AcademicResponseModel> updateAcademicQualification(
    CreateAcademicRequest request,
  ) async {
    try {
      final response = await _dioClient.dio.put(
        ApiEndpoint.updateAcademicQ,
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return AcademicResponseModel.fromJson(response.data);
      }
      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Failed to update academic qualification",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<void> deleteAcademicQualification() async {
    try {
      final response = await _dioClient.dio.delete(ApiEndpoint.updateAcademicQ);
      if (response.statusCode != 200) {
        throw DioAppException.fromDioError(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: "Failed to delete academic qualification",
          ),
        );
      }
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<UpdateDobResponse> updateDob(DateTime dob) async {
    try {
      final response = await _dioClient.dio.put(
        ApiEndpoint.updateDOB,
        data: {'dob': dob.toIso8601String()},
      );
      if (response.statusCode == 200) {
        return UpdateDobResponse.fromJson(response.data);
      }
      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Failed to update DOB",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<GetFollowersResponseModel> getFollowers() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoint.getFollower);
      if (response.statusCode == 200) {
        return GetFollowersResponseModel.fromJson(response.data);
      }
      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Failed to get followers",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<GetFollowersResponseModel> getFollowing() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoint.getFollwing);
      if (response.statusCode == 200) {
        return GetFollowersResponseModel.fromJson(response.data);
      }
      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Failed to get following",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<SuccessResponse> followUser(String followUserId) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoint.followUser,
        data: {"followUserId": followUserId},
      );
      if (response.statusCode == 200) {
        return SuccessResponse.fromJson(response.data);
      }
      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Failed to follow user",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<SuccessResponse> unFollowUser(String unfollowUserId) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoint.followUser,
        data: {"unfollowUserId": unfollowUserId},
      );

      if (response.statusCode == 200) {
        return SuccessResponse.fromJson(response.data);
      }

      throw DioAppException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Failed to unfollow users",
        ),
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }

  @override
  Future<UserLocationModel> updateLocation() async {
    try {
      // Get current position
      final position = await LocationService().determinePosition();

      final request = LocationRequestWrapper(
        data: LocationRequestData(
          location: UserLocationModel(
            lat: position.latitude,
            lng: position.longitude,
          ),
        ),
      );

      // Send POST request
      final response = await _dioClient.dio.post(
        ApiEndpoint.updateLocation,
        data: request.toJson(),
      );

      // Parse response
      if (response.statusCode == 200 && response.data != null) {
        // parse a/q to response
        final locationJson = response.data['data']['location'];
        return UserLocationModel.fromJson(locationJson);
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: "Failed to update location",
      );
    } on DioException catch (e) {
      throw DioAppException.fromDioError(e);
    } catch (e) {
      throw UnknownException("$e");
    }
  }
}
