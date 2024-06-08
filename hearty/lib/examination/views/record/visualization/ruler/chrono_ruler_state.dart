part of 'chrono_ruler.dart';

class _ChronoRulerState extends ConsumerState<ChronoRuler> {
  static const base = 10;
  static const steps = 5;

  @override
  void initState() {
    super.initState();
  }

  Duration get duration =>
      widget.duration.inSeconds == 0 ? Config.signalDuration : widget.duration;

  @override
  Widget build(BuildContext context) => RecordAnimation(
        width: widget.width,
        recordId: widget.recordId,
        margin: widget.margin,
        child: buildContent(),
      );

  Widget buildContent() => SizedBox(
        width: widget.width + widget.extraSectionsPadding,
        height: ChronoRuler.height,
        child: buildDivisions(),
      );

  Widget buildDivisions() => Column(
        children: [
          buildMinorDivisions(),
          buildMajorDivisions(),
        ],
      );

  Widget buildMinorDivisions() {
    final minorUnits = duration.inSeconds * base;
    return _MinorDivisions(
      unitWidth: widget.width / minorUnits,
      units: minorUnits + 1,
    );
  }

  Widget buildMajorDivisions() {
    final majorUnits = duration.inSeconds * base ~/ steps;
    return _MajorDivisions(
      unitWidth: widget.width / majorUnits,
      units: majorUnits + 1,
      base: base,
      step: steps,
    );
  }
}
