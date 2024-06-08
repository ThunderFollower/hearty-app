import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import 'updater_controller.dart';

/// An adapter that implements [UpdaterController], responsible for opening
/// the application's store page for updates using an environment-specific URL.
class UpdaterControllerAdapter implements UpdaterController {
  /// Constructs an [UpdaterControllerAdapter] with the necessary [logger].
  UpdaterControllerAdapter({
    required this.logger,
  });

  /// The URL to the application's store page, obtained from environment variables.
  static const updateUrl = String.fromEnvironment('UPDATE_URL');

  /// Logger for debugging and error logging.
  final Logger logger;

  @override
  Future<void> openStore() async {
    try {
      await launchUrl(
        Uri.parse(updateUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (error, stackTrace) {
      logger.e('Failed to open update URL: $updateUrl', error, stackTrace);
    }
  }
}
