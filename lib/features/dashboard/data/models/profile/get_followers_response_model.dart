import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_followers_response_model.freezed.dart';
part 'get_followers_response_model.g.dart';

/// Response model for getting followers
@freezed
abstract class GetFollowersResponseModel with _$GetFollowersResponseModel {
  const factory GetFollowersResponseModel({
    required String status,
    required GetFollowersDataModel data,
  }) = _GetFollowersResponseModel;

  factory GetFollowersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetFollowersResponseModelFromJson(json);
}

/// Data field containing list of followers
@freezed
abstract class GetFollowersDataModel with _$GetFollowersDataModel {
  const factory GetFollowersDataModel({
    required List<GetFollowerModel> followers,
  }) = _GetFollowersDataModel;

  factory GetFollowersDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetFollowersDataModelFromJson(json);
}

/// Individual follower
@freezed
abstract class GetFollowerModel with _$GetFollowerModel {
  const factory GetFollowerModel({
    required String id,
    required String name,
    required String email,
  }) = _GetFollowerModel;

  factory GetFollowerModel.fromJson(Map<String, dynamic> json) =>
      _$GetFollowerModelFromJson(json);
}
