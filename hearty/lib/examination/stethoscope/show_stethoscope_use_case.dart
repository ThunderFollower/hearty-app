import '../../core/core.dart';
import '../record/index.dart';
import 'stethoscope_mode.dart';

/// [ShowStethoscopeUseCase] is an interface that defines a command
/// to show the stethoscope, with a specified mode and an optional record.
abstract class ShowStethoscopeUseCase extends AsyncCommand<void> {
  /// Executes the command with a [StethoscopeMode] and an optional [Record].
  ///
  /// If no mode is provided, the default mode is [StethoscopeMode.listening].
  ///
  /// If a [recordId] is provided, the command will apply this record during the
  /// operation.
  ///
  /// Note: If mode is [StethoscopeMode.recording], the provided [Record] must
  /// be not null.
  @override
  Future<void> execute({
    StethoscopeMode mode = StethoscopeMode.listening,
    String? recordId,
  });
}
