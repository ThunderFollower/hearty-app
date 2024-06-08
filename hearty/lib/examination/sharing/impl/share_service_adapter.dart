import 'dart:async';

import 'package:logger/logger.dart';

import '../entities/share.dart';
import '../ports/share_repository.dart';
import '../share_service.dart';

/// Implements the [ShareService] using the [ShareRepository].
class ShareServiceAdapter extends ShareService {
  /// Create a new [ShareServiceAdapter] with the [repository].
  ShareServiceAdapter(this.repository);

  /// A repository for access to the [Share] domain models.
  final ShareRepository repository;

  final _pendingStream = StreamController<String>.broadcast();
  final Set<String> _pending = {};
  final Logger _logger = Logger();

  void dispose() {
    _pendingStream.close();
  }

  @override
  Stream<Share> startSharing({required String examinationId}) =>
      repository.create(examinationId: examinationId);

  @override
  void add(String id) {
    _pending.add(id);
    _pendingStream.sink.add(id);
  }

  @override
  Stream<String> selectPending() async* {
    final initialList = List<String>.from(_pending);
    yield* Stream.fromIterable(initialList);
    yield* _pendingStream.stream;
  }

  @override
  Stream<String> acquire(String id) async* {
    if (_pending.remove(id)) {
      try {
        await for (final event in repository.acquire(id)) {
          yield event;
        }
      } catch (error) {
        _logger.e(error);
        rethrow;
      }
    }
  }
}
