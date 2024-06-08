import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../core/core.dart';
import 'entities/auth_token.dart';

final tokenService = Provider.autoDispose<TokenService>((ref) {
  final tokenService = TokenService(ref);
  ref.onDispose(tokenService.dispose);
  return tokenService;
});

typedef Json = Map<String, dynamic>;

class TokenService {
  static const String _secureStorageKey = 'tokens';

  late final ObjectStorage _storageService;

  /// The [Logger] to use for logging.
  final Logger logger = Logger();

  final _tokenStream = StreamController<AuthToken?>.broadcast();

  TokenService(Ref ref) {
    _storageService = ref.read(personalSecureStorageService);
  }

  void dispose() {
    _tokenStream.close();
  }

  Future<void> clear() async {
    if (await _storageService.contains(_secureStorageKey)) {
      await _storageService.remove(_secureStorageKey);
    }
    _tokenStream.sink.add(null);
  }

  Future<AuthToken?> get() async {
    try {
      if (await hasTokens()) {
        final json = await _storageService.get<Json>(_secureStorageKey);
        return AuthToken.fromJson(json);
      }
    } on Exception catch (e, stackTrace) {
      logger.e('Failed to get token', e, stackTrace);
    }
    return null;
  }

  Future<void> update(AuthToken tokens) async {
    await _storageService.put(_secureStorageKey, tokens);
    _tokenStream.sink.add(tokens);
  }

  Future<bool> hasTokens() async {
    return _storageService.contains(_secureStorageKey);
  }

  /// Listen to the access token.
  Stream<AuthToken?> selectToken() async* {
    if (await hasTokens()) {
      yield await get();
    } else {
      yield null;
    }
    yield* _tokenStream.stream;
  }
}
