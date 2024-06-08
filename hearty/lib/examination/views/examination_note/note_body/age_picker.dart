import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/views/theme/indentation_constants.dart';
import '../../../../generated/locale_keys.g.dart';

class AgePicker extends StatefulWidget {
  const AgePicker({
    super.key,
    this.onSelected,
    this.selectedValue,
  });

  final Function(int)? onSelected;
  final int? selectedValue;

  @override
  State<AgePicker> createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  late final scrollController = FixedExtentScrollController(
    initialItem: _calculateInitialIndex(),
  );

  int _calculateInitialIndex() {
    if (widget.selectedValue != null) {
      return widget.selectedValue! - _minAge + 1;
    }
    return 0;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primaryContainer;

    final cupertinoPicker = CupertinoPicker.builder(
      childCount: _maxAge - _minAge + 2,
      backgroundColor: backgroundColor,
      itemExtent: belowHightIndent,
      onSelectedItemChanged: (index) {
        widget.onSelected?.call(_takeSelectedAge(index));
      },
      itemBuilder: (_, index) => Text(_getText(index)),
      scrollController: scrollController,
    );
    return SizedBox(height: height * _heightQuotient, child: cupertinoPicker);
  }

  String _getText(int index) => index == 0
      ? LocaleKeys.NotesBody_Age_Select_age.tr()
      : _takeSelectedAge(index).toString();

  int _takeSelectedAge(int index) => index + _minAge - 1;

  /// The maximum age available to select.
  static const _maxAge = int.fromEnvironment(
    'MAX_AGE',
    defaultValue: 130,
  );

  /// The minimum age available to select.
  static const _minAge = int.fromEnvironment(
    'MIN_AGE',
    defaultValue: 18,
  );
}

const _heightQuotient = 0.3;
