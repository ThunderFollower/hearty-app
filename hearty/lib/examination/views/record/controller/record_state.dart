import 'dart:ui' as ui;

import '../../../../config.dart';
import '../../../examination.dart';
import '../visualization/segment/segment.dart';

/// Represents the state of a medical examination record.
///
/// This class holds the details and current state of a record, including its
/// metadata, associated data like oscillogram and spectrogram, playback state,
/// and visual properties.
class RecordState {
  /// Constructs an instance of [RecordState] with the given properties.
  const RecordState({
    this.spot,
    this.name,
    this.createdAt,
    this.segments,
    this.hasMurmur,
    this.heartRate,
    this.isFine,
    this.oscillogramData,
    this.spectrogramData,
    this.filter,
    this.audioUri,
    this.isSpectrogramMode,
    this.isAdvancedMode,
    this.isPlaying,
    this.position,
    this.duration,
    this.speed,
    this.scale,
    this.scaleStart,
    this.isScaling,
    this.startPosition,
    this.isEnabled,
    this.playbackRepeatCounter = Config.recordPlaybackRepeatTimes,
  });

  /// The associated spot for this record.
  final Spot? spot;

  /// The name associated with this record.
  final String? name;

  /// The date and time when this record was created.
  final DateTime? createdAt;

  /// The segments associated with this record.
  final Iterable<SegmentState>? segments;

  /// Indicates if the record has a murmur.
  final bool? hasMurmur;

  /// The heart rate associated with this record.
  final int? heartRate;

  /// Indicates if the record is fine.
  final bool? isFine;

  /// The oscillogram data for this record.
  final Iterable<double>? oscillogramData;

  /// The spectrogram image data for this record.
  final ui.Image? spectrogramData;

  /// The filter applied to this record.
  final Filters? filter;

  /// The URI for the audio file associated with this record.
  final String? audioUri;

  /// Indicates if the spectrogram mode is active.
  final bool? isSpectrogramMode;

  /// Indicates if the advanced mode is active.
  final bool? isAdvancedMode;

  /// Indicates if audio playback is currently active.
  final bool? isPlaying;

  /// Represents the current playback position within the audio.
  final Duration? position;

  /// Represents the total duration of the audio.
  final Duration? duration;

  /// The playback speed of the audio recording.
  final double? speed;

  /// The scale factor for visualizing the record data.
  final double? scale;

  /// The initial scale value at the start of a scaling operation.
  ///
  /// This is typically used in conjunction with gestures for zooming in and out,
  /// storing the scale factor at the beginning of the zoom gesture.
  final double? scaleStart;

  /// Indicates whether a scaling operation is currently in progress.
  ///
  /// This flag can be used to manage the state of UI elements or interactions
  /// while the user is performing a scaling (zooming) action on visual
  /// components.
  final bool? isScaling;

  /// Represents the start playback position within the audio.
  final Duration? startPosition;

  /// Indicates whether changing the RecordState is permitted.
  final bool? isEnabled;

  /// Stores the number of record playback repeat time left
  final int playbackRepeatCounter;

  /// Creates a copy of this [RecordState] with the given modifications.
  ///
  /// This method allows for modifying a subset of the properties while keeping
  /// others unchanged.
  /// It returns a new instance of [RecordState] with the specified changes.
  RecordState copyWith({
    Spot? spot,
    String? name,
    DateTime? createdAt,
    Iterable<SegmentState>? segments,
    bool? hasMurmur,
    int? heartRate,
    bool? isFine,
    Iterable<double>? oscillogramData,
    ui.Image? spectrogramData,
    Filters? filter,
    String? audioUri,
    bool? isSpectrogramMode,
    bool? isAdvancedMode,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    double? speed,
    double? scale,
    double? scaleStart,
    bool? isScaling,
    Duration? startPosition,
    bool? isEnabled,
    int? playbackRepeatCounter,
  }) =>
      RecordState(
        spot: spot ?? this.spot,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        segments: segments ?? this.segments,
        hasMurmur: hasMurmur ?? this.hasMurmur,
        heartRate: heartRate ?? this.heartRate,
        isFine: isFine ?? this.isFine,
        oscillogramData: oscillogramData ?? this.oscillogramData,
        spectrogramData: spectrogramData ?? this.spectrogramData,
        filter: filter ?? this.filter,
        audioUri: audioUri ?? this.audioUri,
        isSpectrogramMode: isSpectrogramMode ?? this.isSpectrogramMode,
        isAdvancedMode: isAdvancedMode ?? this.isAdvancedMode,
        isPlaying: isPlaying ?? this.isPlaying,
        position: position ?? this.position,
        duration: duration ?? this.duration,
        speed: speed ?? this.speed,
        scale: scale ?? this.scale,
        scaleStart: scaleStart ?? this.scaleStart,
        isScaling: isScaling ?? this.isScaling,
        startPosition: startPosition ?? this.startPosition,
        isEnabled: isEnabled ?? this.isEnabled,
        playbackRepeatCounter:
            playbackRepeatCounter ?? this.playbackRepeatCounter,
      );
}
