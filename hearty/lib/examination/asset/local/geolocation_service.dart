import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/common/permission_service.dart';

final geolocationService = Provider.autoDispose<GeolocationService>(
  (ref) => GeolocationService(
    ref.watch(permissionService(Permission.locationWhenInUse)),
  ),
);

class GeolocationService {
  GeolocationService(this._permissionService);

  final PermissionService _permissionService;

  Future<Position?> getLocation() async {
    Position? position;
    try {
      position = await _permissionService.isGranted()
          ? await Geolocator.getCurrentPosition()
          : null;
    } catch (e) {
      // this can happen when the app lost focus on the final stage of recording
      // to prevent the lose of the recording, we just ignore the error
      log("Couldn't get geo-location", error: e);
    }
    return position;
  }
}
