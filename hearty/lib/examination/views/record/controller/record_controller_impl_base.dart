part of 'record_controller_impl.dart';

abstract class _Base extends StateNotifier<RecordState>
    with SubscriptionManager, WidgetsBindingObserver
    implements RecordController {
  _Base(
    super.state, {
    required this.recordId,
    required this.router,
    required this.recordService,
    required this.segmentService,
    required this.logger,
    required this.showErrorNotification,
    required this.cardioFindingService,
    required this.assetService,
    required this.audioEngine,
    required this.authProfileService,
    required this.player,
    required this.spectrogramGenerator,
    required this.showStethoscope,
    required this.deleteRecord,
  });

  final String recordId;
  @protected
  final StackRouter router;

  @protected
  final RecordService recordService;

  @protected
  final SegmentService segmentService;

  @protected
  final Logger logger;

  /// A use case for displaying error notifications.
  @protected
  final ShowNotification showErrorNotification;

  @protected
  final CardioFindingService cardioFindingService;

  @protected
  final AssetService assetService;

  @protected
  final AudioEngine audioEngine;

  @protected
  final filterSubject = BehaviorSubject<Filters?>();

  @protected
  final AuthProfileService authProfileService;

  @protected
  final FlutterSoundPlayer player;

  @protected
  final SpectrogramGenerator spectrogramGenerator;

  @protected
  final ShowStethoscopeUseCase showStethoscope;

  @protected
  final DeleteRecordUseCase deleteRecord;

  void _handleError(Object error, StackTrace stackTrace) {
    logger.e('Operation has failed', error, stackTrace);
    showErrorNotification.execute(GenericErrorNotification(error));
  }
}
