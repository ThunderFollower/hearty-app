part of 'record_controller_impl.dart';

mixin _Record on _Base {
  /// The lower frequency level is 20 Hz.
  static const lowerBound = int.fromEnvironment(
    'LOWER_FREQUENCY',
    defaultValue: 20,
  );

  /// The highest frequency level after scaling is 1000 Hz for both heart and
  /// lung recordings.
  static const upperBound = int.fromEnvironment(
    'UPPER_FREQUENCY',
    defaultValue: 1000,
  );

  /// The default frequency range for heart body spots is 20-450 Hz.
  static const heartSpotLevel = int.fromEnvironment(
    'HEART_SPOT_FREQUENCY',
    defaultValue: 450,
  );

  /// The default frequency range for lung body spots is 20-500 Hz.
  static const lungSpotLevel = int.fromEnvironment(
    'LUNG_SPOT_FREQUENCY',
    defaultValue: 500,
  );

  static const heartDefaultScale = upperBound / (heartSpotLevel - lowerBound);
  static const lungsDefaultScale = upperBound / (lungSpotLevel - lowerBound);

  void _loadRecord() {
    final assetPath = recordService
        .findOne(recordId, cancellation)
        .doOnData(_handleFoundRecord)
        .map((record) => record.asset)
        .distinct()
        .switchMap((asset) => _loadAudioFile(asset));

    CombineLatestStream(
      <Stream>[
        assetPath,
        filterSubject.stream,
      ],
      _combineAssetPathFilter,
    )
        .switchMap(_handleLoadedAudio)
        .doOnData(_handlePostProcessingResult)
        .map((event) => event.item1)
        .switchMap(spectrogramGenerator.execute)
        .listen(_handleGeneratedSpectrogram, onError: _handleError)
        .addToList(this);
  }

  void _handleFoundRecord(Record record) {
    final filter = state.filter ?? _getDefaultFilter(record);
    final scale = state.scale ?? _getDefaultScale(record);

    state = state.copyWith(
      spot: record.spot,
      name: record.bodyPosition.name.tr(),
      createdAt: record.asset?.createdAt,
      filter: filter,
      scale: scale,
      duration: Config.signalDuration,
    );

    filterSubject.add(filter);
  }

  Stream<Tuple2<Asset?, String>> _loadAudioFile(Asset? asset) async* {
    if (asset != null) {
      final path = await assetService.getCachedAssetUri(asset: asset);
      yield Tuple2(asset, path);
    }
  }

  Tuple3<Asset?, String?, Filters?> _combineAssetPathFilter(
    Iterable<Object?> values,
  ) {
    assert(values.length == 2);
    final assetPath = values.elementAt(0) as Tuple2<Asset?, String>?;
    final filter = values.elementAt(1) as Filters?;

    return Tuple3(assetPath?.item1, assetPath?.item2, filter);
  }

  Stream<DoubleList2String> _handleLoadedAudio(
    Tuple3<Asset?, String?, Filters?> audio,
  ) async* {
    final declicker = audio.item1?.assetMetadata?.isDeclickerActivated;
    final path = audio.item2;
    final filter = audio.item3;

    if (path != null && filter != null) {
      yield await audioEngine.applyEffect(
        path,
        cacheKey: '$recordId.${filter.index}',
        effect: filter.effect,
        gain: filter.defaultGain,
        declicker: declicker,
      );
    }
  }

  void _handlePostProcessingResult(DoubleList2String result) {
    // Stop the audio playback just in case
    player.stopPlayer();
    state = state.copyWith(
      oscillogramData: result.item2,
      audioUri: result.item3,
      isPlaying: player.isOpen() ? false : null,
      playbackRepeatCounter: Config.recordPlaybackRepeatTimes,
    );
  }

  void _handleGeneratedSpectrogram(ui.Image data) {
    state = state.copyWith(spectrogramData: data);
  }

  static Filters _getDefaultFilter(Record record) =>
      record.spot?.organ == OrganType.heart
          ? Config.defaultHeartFilter
          : Config.defaultLungsFilter;

  static double _getDefaultScale(Record record) =>
      record.spot?.organ == OrganType.heart
          ? heartDefaultScale
          : lungsDefaultScale;
}
