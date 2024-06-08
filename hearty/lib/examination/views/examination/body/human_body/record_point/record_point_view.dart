import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../config.dart';
import '../../../../../../core/views.dart';
import '../../../../../examination.dart';
import '../../../examination_controller.dart';
import '../../../providers.dart';

/// Defines a widget representing the RecordPoint business model.
class RecordPointView extends ConsumerWidget {
  final List<Record> records;
  final double offsetX;
  final double offsetY;
  final String id;
  final Spot spot;
  final String nameId;
  final bool enabled;

  const RecordPointView({
    super.key,
    required this.spot,
    required this.records,
    required this.offsetX,
    required this.offsetY,
    required this.id,
    this.nameId = 'point_id',
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotProvider = examinationStateProvider.select(
      (value) => value.currentSpot,
    );
    final currentSpot = ref.watch(spotProvider);
    final controller = ref.watch(examinationStateProvider.notifier);

    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final borderSideColor = theme.colorScheme.onSecondaryContainer;
    final primaryColor = theme.colorScheme.secondary;
    final spotNumberColor = theme.colorScheme.primaryContainer;

    final key = Key(id);
    final invisibleText = _buildInvisibleText();
    final spotNumberText = _buildSpotNumberText(spotNumberColor);
    final invisiblePointText = _buildInvisiblePointText();
    final boxDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: _pointColor(currentSpot, primaryColor),
    );
    final container = _buildContainer(
      boxDecoration,
      spotNumberText,
      invisibleText,
    );
    final elevationButtonStyle = _configureButtonStyle(
      currentSpot,
      borderSideColor,
    );
    final stack = Stack(children: [container, invisiblePointText]);
    final elevatedButton = _buildElevationButton(
      currentSpot,
      controller,
      elevationButtonStyle,
      stack,
    );

    return Positioned(
      key: key,
      top: width * offsetY,
      left: width * offsetX,
      child: elevatedButton,
    );
  }

  ButtonStyle _configureButtonStyle(Spot currentSpot, Color color) =>
      ElevatedButton.styleFrom(
        shape: _shape,
        backgroundColor: Colors.transparent,
        fixedSize: _fixedSize,
        elevation: 0,
        padding: _padding,
        side: _isCurrentSpot(currentSpot)
            ? BorderSide(color: color, width: _borderSideWidth)
            : null,
      );

  Container _buildContainer(
    BoxDecoration boxDecoration,
    Text spotNumberText,
    Text invisibleText,
  ) =>
      Container(
        alignment: Alignment.center,
        decoration: boxDecoration,
        child: Stack(children: [spotNumberText, invisibleText]),
      );

  Widget _buildElevationButton(
    Spot currentSpot,
    ExaminationController controller,
    ButtonStyle elevationButtonStyle,
    Stack stack,
  ) {
    final deselected = _isCurrentSpot(currentSpot) == false;
    return ElevatedButton(
      key: Key('${spot.number}. ${spot.name.tr()}'),
      onPressed: _resolveOnPressed(deselected, controller),
      style: elevationButtonStyle,
      child: stack,
    );
  }

  VoidCallback? _resolveOnPressed(
    bool deselected,
    ExaminationController controller,
  ) {
    return enabled && deselected
        ? () => _onElevatedButtonTap(controller)
        : null;
  }

  void _onElevatedButtonTap(ExaminationController controller) {
    controller.switchSpot(spot, _targetPosition);
  }

  BodyPosition get _targetPosition => records.isNotEmpty
      ? records.first.bodyPosition
      : Config.defaultBodyPosition;

  Text _buildInvisiblePointText() => Text(
        '${nameId.replaceAll(' ', '_').toLowerCase().replaceAll("'", '')}_point',
        style: _invisibleTextStyle,
        overflow: TextOverflow.clip,
      );

  Text _buildSpotNumberText(Color textColor) => Text(
        '${spot.number}',
        style: textStyleOfRegular14.copyWith(color: textColor),
      );

  Text _buildInvisibleText() => const Text(
        _invisibleText,
        style: _invisibleTextStyle,
        overflow: TextOverflow.clip,
      );

  Color _pointColor(Spot currentSpot, Color primaryColor) {
    late Color color;

    if (_isCurrentSpot(currentSpot)) {
      color = AppColors.grey.withOpacity(_highOpacity);
    } else {
      color = AppColors.grey.withOpacity(_lowOpacity);
    }

    if (records.isNotEmpty) {
      color = primaryColor;
    }

    return color;
  }

  bool _isCurrentSpot(Spot currentSpot) => spot == currentSpot;
}

const _shape = CircleBorder();
const _fixedSize = Size.fromRadius(9.0);
const _invisibleText = 'RECORDED';
const _invisibleTextStyle = TextStyle(fontSize: 0);
const _padding = EdgeInsets.all(6.0);
const _borderSideWidth = 2.0;
const _lowOpacity = 0.3;
const _highOpacity = 0.6;
