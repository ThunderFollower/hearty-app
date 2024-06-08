import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/views.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../examination.dart';
import '../../../providers.dart';
import 'new_record_button.dart';
import 'value_picker/value_picker.dart';

part 'human_model.dart';

class NewRecord extends StatelessWidget {
  final RecordPoint recordPoint;
  final double height;
  final bool enabled;

  const NewRecord({
    super.key,
    required this.recordPoint,
    required this.height,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final bottomPadding = mediaQueryData.padding.bottom == 0
        ? 10.0
        : mediaQueryData.padding.bottom;
    return Container(
      height: height,
      width: mediaQueryData.size.width,
      padding: EdgeInsets.only(
        top: 20.0,
        left: 24,
        right: 24,
        bottom: bottomPadding,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Header(spot: recordPoint.spot),
          const _Body(),
          NewRecordButton(recordPoint: recordPoint, enabled: enabled),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.spot});

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyle = theme.textTheme.titleLarge;

    final spotColor = theme.colorScheme.onPrimary;
    final spotNameTextStyle = textStyle?.copyWith(color: spotColor);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: RichText(
        key: _bodySpotBottomSheetKey,
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.center,
        textScaleFactor: 1.1,
        text: TextSpan(
          text: LocaleKeys.WelcomeGuidePage_Record.tr(),
          style: spotNameTextStyle,
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(examinationStateProvider.notifier);
    final bodyPosition = ref.watch(
      examinationStateProvider.select((state) => state.bodyPosition),
    );

    final theme = Theme.of(context);
    const positions = BodyPosition.values;

    return ValuePicker(
      initialValue: bodyPosition.name.tr(),
      handler: () => showModalDialog(
        context: context,
        child: _HumanModel(
          icons: [
            ...positions.map((e) => _getIcon(e, bodyPosition, theme)),
          ],
          currentLabel: bodyPosition.name.tr(),
          labels: [...BodyPosition.values.map((e) => e.name.tr())],
          actions: [
            ...positions.map(
              (position) => () => controller.switchBodyPosition(position),
            ),
          ],
        ),
      ),
      width: double.infinity,
      height: 56.0,
      bgColor: Colors.pink.shade50,
    );
  }

  Widget _getIcon(
    BodyPosition e,
    BodyPosition bodyPosition,
    ThemeData theme,
  ) {
    final activeIconColor = theme.colorScheme.primaryContainer;
    final inactiveIconColor = theme.colorScheme.secondary;

    return LocalImage(
      assetPath: e.iconPath,
      color: e == bodyPosition ? activeIconColor : inactiveIconColor,
    );
  }
}

// Keys
const _bodySpotBottomSheetKey = Key('body_spot_bottom_sheet_header_key');
