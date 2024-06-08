enum PlayingSpeed {
  x1(1.0),
  x05(.5),
  x025(.25);

  /// The parameter is a floating point number between 0 and 1.0
  final double value;
  const PlayingSpeed(this.value);
}
