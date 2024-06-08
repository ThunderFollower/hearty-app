import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/views.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../config/sharing_state_provider.dart';
import '../sharing_controller.dart';

class SharingConfirmation extends ConsumerWidget {
  const SharingConfirmation({
    super.key,
    required this.examinationId,
    this.isReceivedExamination = false,
  });

  final String examinationId;
  final bool isReceivedExamination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = sharingStateProvider(examinationId);
    final state = ref.watch(stateProvider);
    final controller = ref.watch(stateProvider.notifier);

    final theme = Theme.of(context);

    const stripe = TopStripe();

    final titleText = Text(
      LocaleKeys.SharingConfirmation_Title.tr(),
      textAlign: TextAlign.center,
      style: textStyleOfBlackPearlColorMedium18,
    );

    final mainText = _buildMainText(theme, controller);

    final flexible = Flexible(child: mainText);

    final switchButton = SwitchButton(
      onChanged: controller.toggle,
      value: state.isSendingConfirmed,
    );

    final acceptanceBody = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [flexible, switchButton],
    );

    final contentArray = [
      titleText,
      const SizedBox(height: lowIndent),
      const Spacer(),
      acceptanceBody,
      const Spacer(),
    ];

    final loader = [
      const Spacer(),
      const Loader(),
      const Spacer(),
    ];

    final content = state.isBusy ? loader : contentArray;

    final sendButton = RoundCornersButton(
      enabled: state.isSendingConfirmed,
      title: LocaleKeys.SharingConfirmation_Action.tr(),
      onTap: state.isBusy ? null : controller.share,
    );

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        stripe,
        ...content,
        const SizedBox(height: middleIndent),
        sendButton,
      ],
    );

    final mediaQuery = MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: column,
    );

    return IntrinsicWidth(
      stepHeight: lowestIndent,
      child: ConstrainedBox(constraints: _constraints, child: mediaQuery),
    );
  }

  Widget _buildMainText(
    ThemeData theme,
    SharingController controller,
  ) {
    final firstTextPart = _buildFirstTextPart(theme);

    return RichText(text: firstTextPart);
  }

  TextSpan _buildFirstTextPart(ThemeData theme) {
    final textStyle = theme.textTheme.bodySmall;

    return TextSpan(
      text: LocaleKeys.SharingConfirmation_Description_BeforeLink.tr(),
      style: textStyle,
    );
  }
}

const _containerHeight = 240.0;
const _constraints = BoxConstraints(minHeight: _containerHeight);
