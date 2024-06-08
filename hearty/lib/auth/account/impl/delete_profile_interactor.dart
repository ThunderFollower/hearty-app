import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/core.dart';
import '../../../legal_document/legal_document/legal_document_service.dart';
import '../auth_profile_service.dart';
import '../constants.dart';

/// An implementation of [AsyncCommand] that deletes the user's profile from
/// the server and navigates to the specified path.
class DeleteProfileInteractor implements AsyncCommand {
  /// Creates a new instance of [DeleteProfileInteractor].
  const DeleteProfileInteractor(
    this._service,
    this._documentService,
    this._asyncPreferences,
    this._emailController,
    this._storages,
  );

  /// The [AuthProfileService] used for signing out the user.
  final AuthProfileService _service;

  /// A future that returns the [SharedPreferences] instance for this app.
  final Future<SharedPreferences> _asyncPreferences;

  /// A [StateController] to store the email of the authenticated profile.
  final StateController<String> _emailController;

  /// A list of storage instances that can be used to persist user data.
  /// Implementations of the [ObjectStorage] interface allow for data to be
  /// stored and retrieved in a platform-agnostic way, regardless of the
  /// underlying storage mechanism.
  final Iterable<ObjectStorage> _storages;

  final LegalDocumentService _documentService;

  @override
  Future<void> execute() async {
    await _service.deleteProfile();
    await _clearProfileData();
    await _resetFirstTimeAuthFlag();
    await _documentService.clearSignatures();
    _emailController.state = '';
  }

  Future<void> _clearProfileData() async {
    final futures = _storages.map((event) => event.clear());
    await Future.wait(futures);
  }

  Future<void> _resetFirstTimeAuthFlag() async {
    if (await _service.isNotEmpty) return;

    final preferences = await _asyncPreferences;
    // Saves that the first time login flag.
    await preferences.setBool(firstTimeAuthKey, true);
  }
}
