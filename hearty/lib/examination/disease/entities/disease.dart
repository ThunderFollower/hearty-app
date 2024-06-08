import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'disease.freezed.dart';

@freezed
class Disease with _$Disease {
  const factory Disease(
    String key,
  ) = _Disease;
}

extension DiseasePropierties on Disease {
  String get name => key.tr();
}
