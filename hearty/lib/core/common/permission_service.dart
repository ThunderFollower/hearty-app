import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/utils.dart';

final permissionService =
    Provider.family.autoDispose<PermissionService, Permission>(
  (ref, permission) {
    final service = PermissionService(logger: Logger(), permission: permission);
    ref.onDispose(service.dispose);
    return service;
  },
);

class PermissionService with SubscriptionManager {
  PermissionService({
    required this.logger,
    required this.permission,
  }) {
    request.stream
        .distinct()
        .flatMap((permission) => Stream.fromFuture(_getStatus(permission)))
        .listen(response.sink.add)
        .addToList(this);
  }

  Future<PermissionStatus> _getStatus(Permission permission) async =>
      await isGranted() || await _grant(permission)
          ? PermissionStatus.granted
          : PermissionStatus.permanentlyDenied;

  @protected
  final Logger logger;
  final Permission permission;

  @protected
  final request = StreamController<Permission>.broadcast(sync: true);
  @protected
  final response = StreamController<PermissionStatus>.broadcast(sync: true);

  Stream<PermissionStatus> observeStatusChanges() => response.stream.distinct();

  void grant() => request.sink.add(permission);

  Future<bool> _grant(Permission permission) async {
    try {
      final status = await permission.request();
      return status == PermissionStatus.granted;
    } catch (error, stackTrace) {
      logger.e('Failed to request permission.', error, stackTrace);
      return false;
    }
  }

  Future<bool> isGranted() async {
    try {
      return permission.status.isGranted;
    } catch (error, stackTrace) {
      logger.e('Permission is not granted.', error, stackTrace);
      return false;
    }
  }

  Future<bool> isPermanentlyDenied() async {
    try {
      return permission.status.isPermanentlyDenied;
    } catch (error, stackTrace) {
      logger.e('Permission is permanently denied.', error, stackTrace);
      return false;
    }
  }

  void dispose() {
    cancelSubscriptions();
    response.close();
    request.close();
  }
}
