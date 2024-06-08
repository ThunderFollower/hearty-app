import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../use_cases/use_cases.dart';
import 'link_handler.dart';

class LinkHandlerAdapter implements LinkHandler {
  /// A abstract command to open an email application.
  final OpenEmailAppUseCase openEmailAppUseCase;

  const LinkHandlerAdapter({required this.openEmailAppUseCase});

  @override
  Future<void> handleLink([String? link]) async {
    if (link == null) return;

    await _handleLink(link);
  }

  Future<void> _handleLink(String link) async {
    if (link.contains(_emailPart)) {
      final mail = link.replaceAll(_emailPart, '');
      await openEmailAppUseCase.execute(mail);
    } else {
      final uri = Uri.parse(link);
      await url_launcher.launchUrl(uri);
    }
  }
}

const _emailPart = 'mailto:';
