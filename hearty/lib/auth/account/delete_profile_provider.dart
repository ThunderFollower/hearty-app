import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../../legal_document/legal_document/config/legal_document_service_provider.dart';
import '../auth.dart';
import 'impl/delete_profile_interactor.dart';

/// A [Provider] that creates a [AsyncCommand] to delete the user's profile from
/// the server.
final deleteProfileProvider = Provider.autoDispose<AsyncCommand>(
  (ref) => DeleteProfileInteractor(
    ref.watch(authProfileServiceProvider),
    ref.watch(legalDocumentServiceProvider),
    ref.read(sharedPreferencesProvider.future),
    ref.read(emailProvider.notifier),
    [
      ref.watch(personalStorageService),
      ref.watch(personalSecureStorageService),
    ],
  ),
);
