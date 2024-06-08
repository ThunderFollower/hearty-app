import 'package:auto_route/auto_route.dart';

import '../../../core/core.dart';
import '../../auth.dart';

/// An implementation of [AsyncCommand] that signs out the current user
/// and navigates to the initial path.
class SignOutInteractor implements AsyncCommand<bool> {
  /// Creates a new instance of [SignOutInteractor].
  ///
  /// [router] is the navigation router used for navigation.
  /// [service] is the [AuthProfileService] used for signing out the user.
  /// [path] is the path to navigate to after sign out.
  const SignOutInteractor(
    this.router,
    this.service, {
    required this.path,
  });

  /// Navigation router.
  final StackRouter router;

  /// The [AuthProfileService] used for signing out the user.
  final AuthProfileService service;

  /// The path to navigate to after sign out.
  final String path;

  @override
  Future<bool> execute() async {
    if (router.currentPath != path) {
      await service.signOut();

      router.popUntilRoot();
      router.replaceNamed(path);
      return true;
    }
    return false;
  }
}
