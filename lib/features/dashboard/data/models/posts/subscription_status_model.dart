// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_status_model.freezed.dart';
part 'subscription_status_model.g.dart';

@freezed
abstract class SubscriptionStatusModel with _$SubscriptionStatusModel {
  const factory SubscriptionStatusModel({
    @JsonKey(name: 'status', fromJson: _statusFromJson, toJson: _statusToJson)
    required bool isActive,
    required DateTime startDate,
    required DateTime endDate,
  }) = _SubscriptionStatusModel;

  factory SubscriptionStatusModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionStatusModelFromJson(json);
}

/// Convert "active"/other to boolean
bool _statusFromJson(String status) => status.toLowerCase() == 'active';

String _statusToJson(bool isActive) => isActive ? 'active' : 'inactive';
