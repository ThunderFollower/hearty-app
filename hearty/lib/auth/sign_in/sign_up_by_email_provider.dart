import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../account/index.dart';
import 'auth_by_email_use_case.dart';
import 'impl/sign_up_by_email_interactor.dart';

// Define a provider called `signUpByEmailProvider` that creates instances of
// `SignUpEmailInteractor`. This provider is set to auto-dispose when no longer
// needed.
final signUpByEmailProvider = Provider.autoDispose<AuthByEmailUseCase>(
  (ref) => SignUpByEmailInteractor(ref.watch(authProfileServiceProvider)),
);
