import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/data/data.dart';
import 'package:social_media_app/features/dashboard/domain/domain.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileLocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Result<UserAcademicsProfileResponseModel>> getUserProfile() async {
    try {
      final response = await _remoteDataSource.getUserProfile();
      // Save locally
      await _localDataSource.saveUserProfileDetails(
        LocalUserDetailsModel.fromUserAcademics(response.user),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<HobbiesUpdateResponseModel>> updateHobbies(
    List<String> hobbies,
  ) async {
    try {
      final response = await _remoteDataSource.updateHobbies(hobbies);
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<void>> deleteHobby() async {
    try {
      await _remoteDataSource.deleteHobby();
      return const Right(null);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<AcademicResponseModel>> updateAcademicQualification(
    AcademicData request,
  ) async {
    try {
      final response = await _remoteDataSource.updateAcademicQualification(
        request,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<void>> deleteAcademicQualification() async {
    try {
      await _remoteDataSource.deleteAcademicQualification();
      return const Right(null);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<UpdateDobResponse>> updateDob(DateTime dob) async {
    try {
      final response = await _remoteDataSource.updateDob(dob);
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<UserLocationModel>> updateLocation() async {
    try {
      final response = await _remoteDataSource.updateLocation();
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<GetFollowersResponseModel>> getFollowers() async {
    try {
      final response = await _remoteDataSource.getFollowers();
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<GetFollowersResponseModel>> getFollowing() async {
    try {
      final response = await _remoteDataSource.getFollowing();
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<SuccessResponse>> followUser(String followUserId) async {
    try {
      final response = await _remoteDataSource.followUser(followUserId);
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }

  @override
  Future<Result<SuccessResponse>> unFollowUser(String unfollowUserId) async {
    try {
      final response = await _remoteDataSource.unFollowUser(unfollowUserId);
      return Right(response);
    } on DioException catch (e) {
      return Left(DioAppException.fromDioError(e));
    } catch (e) {
      return Left(UnknownException("$e"));
    }
  }
}
