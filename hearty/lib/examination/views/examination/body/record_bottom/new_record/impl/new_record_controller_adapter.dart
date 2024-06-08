import '../../../../../../examination.dart';
import '../new_record_controller.dart';

/// An implementation of [NewRecordController] that adapts the show stethoscope
/// use case to be used for new record creation.
class NewRecordControllerAdapter implements NewRecordController {
  NewRecordControllerAdapter(this._showStethoscope);

  final ShowStethoscopeUseCase _showStethoscope;

  @override
  Future<void> onRecord() => _triggerStethoscope();

  Future<void> _triggerStethoscope() =>
      _showStethoscope.execute(mode: StethoscopeMode.recording);
}
