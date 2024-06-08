import 'package:auto_route/auto_route.dart';
import 'package:logger/logger.dart';
import '../../../examination/index.dart';
import 'examination_body_controller.dart';

class ExaminationBodyControllerAdapter implements ExaminationBodyController {
  ExaminationBodyControllerAdapter(
    this._router,
    this._deleteExaminationUseCase,
    this._mainRouteName,
    this._notesRoute,
    this._examinationId,
  );

  final StackRouter _router;
  final DeleteExaminationUseCase _deleteExaminationUseCase;
  final String _mainRouteName;
  final PageRouteInfo _notesRoute;
  final String? _examinationId;

  final Logger _logger = Logger();
  bool _isProcessing = false;

  @override
  Future<void> openEditNotesPage() => _callWithEventLock(_openEditNotesPage);

  Future<T?> _openEditNotesPage<T>() {
    return _router.push<T?>(_notesRoute);
  }

  @override
  Future<void> closeExaminationPage() async {
    _router.popUntilRouteWithName(_mainRouteName);
  }

  @override
  Future<void> deleteExamination() => _callWithEventLock(_deleteExamination);

  Future<void> _deleteExamination() async {
    if (_examinationId == null) return;

    await _deleteExaminationUseCase.execute(_examinationId!);
    _router.popUntilRouteWithName(_mainRouteName);
  }

  Future<void> _callWithEventLock(Future Function() callback) async {
    if (_isProcessing) return;

    try {
      _isProcessing = true;
      await callback.call();
    } catch (error) {
      _logger.e('Examination body', error);
    } finally {
      _isProcessing = false;
    }
  }
}
