import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../examination.dart';

part 'inspection_state.freezed.dart';

/// The state for the inspection page.
@freezed
class InspectionState with _$InspectionState {
  /// Creates an instance of [InspectionState].
  const factory InspectionState({
    DateTime? createdAt,
    int? heartRate,
    bool? isFine,
    bool? hasMurmur,
    OrganType? organ,
    Spot? spot,
    String? name,
    DateTime? timestamp,
    String? examinationId,
  }) = _InspectionState;
}
