import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../generated/locale_keys.g.dart';

/// A widget that displays a message when an unspecified error occurs.
///
/// This widget displays a localized string indicating a generic error message.
/// It is typically used in situations where an operation fails unexpectedly and
/// the specific reason isn't exposed to the user.
/// The message is centered within the widget's bounding box.
class GenericErrorNotification extends StatelessWidget {
  final Object? error;

  const GenericErrorNotification([this.error]);

  @override
  Widget build(BuildContext context) => Text(
        _textData,
        textAlign: TextAlign.center,
      );

  String get _textData => kDebugMode && error != null
      ? error.toString()
      : LocaleKeys.Something_went_wrong.tr();
}
