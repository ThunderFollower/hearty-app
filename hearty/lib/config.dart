import 'package:flutter/foundation.dart';

import 'examination/examination.dart';

class Config {
  /// The base url of the api gets from the `API_URL` environment variable.
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: kReleaseMode
        ? 'https://test.sparrowbiologic.com/'
        : 'http://localhost:8080/',
  );

  //Cache settings
  static const int maxCachedFiles = 100;
  static const Duration cacheTime = Duration(days: 365);

  static const gainControlVisibilityDuration = Duration(seconds: 1);
  static const gainControlAnimationDuration = Duration(milliseconds: 500);

  // the final length of records
  static const signalDuration = Duration(milliseconds: 20500);

  static const recordPlaybackRepeatTimes = int.fromEnvironment(
    'RECORD_PLAYBACK_REPEAT_TIMES',
    defaultValue: 3,
  );

  static const BodyPosition defaultBodyPosition = BodyPosition.sitting;
  static const Spot defaultHeartSpot = Spot.erbs;
  static const Spot defaultLungsFrontSpot = Spot.leftSubclavianLung;
  static const Spot defaultLungsBackSpot = Spot.upperBackLeftLung;
  static const Filters defaultHeartFilter = Filters.starling;
  static const Filters defaultLungsFilter = Filters.diaphragm;
  static const BodySide defaultBodySide = BodySide.front;
  static const OrganType defaultOrganType = OrganType.heart;

  static const int examinationsPerPage = 10;

  static const Duration defaultDebounceDuration = Duration(milliseconds: 2000);

  static const int maxResendCodeTickCount = 30;

  static const passwordMinLength = 10;

  static const int swipeDownThreshold = 20;

  static const audioEngineIsOnResponse = 'OK';

  static const double examBodyImageBaseWidth = 390;
  static const double bodyImageBaseHeight = 517;
  static const double bodyImageNormalScreenAspectRatio =
      428 / 926; // iPhone 13 Pro Max
  static const double bodyImageQuotientShift = 0.03;

  Config._();
}
