import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';
import 'auth_profile_service_provider.dart';

final usersDatabaseKeyOverride = usersDatabaseKeyProvider.overrideWith(
  (ref) => ref
      .watch(authProfileServiceProvider)
      .observeProfileChanges()
      .map((event) => event?.id)
      .distinct()
      .whereNotNull(),
);
