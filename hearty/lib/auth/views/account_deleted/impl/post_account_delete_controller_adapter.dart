import 'package:auto_route/auto_route.dart';
import 'package:logger/logger.dart';

import '../../../../core/routes/constants.dart';
import '../post_account_delete_controller.dart';

/// Defines an implementation of [PostAccountDeleteController] that uses
/// [StackRouter] to manage page navigation.
class PostAccountDeleteControllerAdapter extends PostAccountDeleteController {
  PostAccountDeleteControllerAdapter({
    required this.router,
  });

  /// Manages page navigation.
  final StackRouter router;

  final _logger = Logger();

  @override
  void onDoneTap() {
    router.popUntilRoot();
    router.replaceNamed(landingPath).then(
          (_) {},
          onError: (error) => _logger.e('Failed to replace the route.', error),
        );
  }
}
