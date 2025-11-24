import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

abstract class ProfileLocalDataSource {
  Future<Position> getPosition();
  // save user profile data locally including everything
  // like hobbies,their location,academic qualicition,follwoing and folowers as well
  Future<void> saveUserProfileDetails(LocalUserDetailsModel userDetails);

  LocalUserDetailsModel? getUserDetails();
}

@LazySingleton(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  final LocationService _locationService;
  final LocalStorageService _localStorageService;
  ProfileLocalDataSourceImpl(this._locationService, this._localStorageService);

  @override
  Future<Position> getPosition() async =>
      await _locationService.determinePosition();

  @override
  Future<void> saveUserProfileDetails(
    LocalUserDetailsModel userDetails,
  ) async => await _localStorageService.saveUserLocalDetails(userDetails);

  @override
  LocalUserDetailsModel? getUserDetails() =>
      _localStorageService.getUserLocalDetails();
}
