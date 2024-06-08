import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../../../config.dart';
import '../use_case/index.dart';

/// A command to open the help center in the default browser or app.
class OpenHelpCenter implements AsyncCommand {
  /// Creates an [OpenHelpCenter] instance with the provided [_logger].
  const OpenHelpCenter(
    this._logger,
    this._baseUrl,
  );

  /// A logger instance to log messages.
  final Logger _logger;

  /// The base url of the api.
  final String _baseUrl;

  /// Executes the command to open the help center.
  ///
  /// It tries to parse the [Config.helpCenterUrl] as a URI and launch it in
  /// the default browser or app. If there's any error, it logs the error
  /// using [_logger].
  @override
  Future<void> execute() async {
    try {
      final url = Uri.parse(_baseUrl).replace(path: _helpCenterPath);
      await url_launcher.launchUrl(url);
    } catch (e, stackTrace) {
      _logger.e('Cannot handle an URL', e, stackTrace);
    }
  }
}

const _helpCenterPath = '/help';
