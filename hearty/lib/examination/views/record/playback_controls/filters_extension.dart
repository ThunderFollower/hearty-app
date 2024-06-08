import 'package:easy_localization/easy_localization.dart';

import '../../../../../../../generated/locale_keys.g.dart';
import '../../../examination.dart';

extension FiltersExtension on Filters {
  String get name => _names[this]!;
  String get buttonText => _buttonTexts[this]!;
  String get iconPath => _iconPaths[this]!;
  int get effect => _filterNumbers[this]!;
  int get defaultGain => _defaultGain[this]!;
  int get maxGain => _maxGain[this]!;
  int get minGain => _minGain[this]!;

  static final Map<Filters, String> _names = {
    Filters.starling: LocaleKeys.Starling.tr(),
    Filters.diaphragm: LocaleKeys.Diaphragm.tr(),
    Filters.bell: LocaleKeys.Bell.tr(),
  };

  static final Map<Filters, String> _buttonTexts = {
    Filters.starling: LocaleKeys.Starling.tr(),
    Filters.diaphragm: LocaleKeys.Dia.tr(),
    Filters.bell: LocaleKeys.Bell.tr(),
  };

  static final Map<Filters, String> _iconPaths = {
    Filters.starling: 'assets/images/starling.svg',
    Filters.diaphragm: 'assets/images/diaphragm.svg',
    Filters.bell: 'assets/images/bell.svg',
  };

  static final Map<Filters, int> _filterNumbers = {
    Filters.starling: 5,
    Filters.diaphragm: 4,
    Filters.bell: 2,
  };

  static final Map<Filters, int> _defaultGain = {
    Filters.starling: 60,
    Filters.diaphragm: 60,
    Filters.bell: 60,
  };

  static final Map<Filters, int> _maxGain = {
    Filters.starling: 120,
    Filters.diaphragm: 120,
    Filters.bell: 120,
  };

  static final Map<Filters, int> _minGain = {
    Filters.starling: 10,
    Filters.diaphragm: 10,
    Filters.bell: 10,
  };

  static final Map<Filters, int> _gainStep = {
    Filters.starling: 5,
    Filters.diaphragm: 5,
    Filters.bell: 5,
  };

  int get gainStep => _gainStep[this]!;

  static final Map<Filters, double> _oscillogramHeightDividers = {
    Filters.starling: 1,
    Filters.diaphragm: 2.5,
    Filters.bell: 1.25,
  };

  double get oscilloHeightDivider => _oscillogramHeightDividers[this]!;
}
