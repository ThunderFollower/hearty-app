import 'package:flutter/material.dart';

import 'record_point_inner_circle/record_point_inner_circle.dart';

const _animationDuration = Duration(milliseconds: 1000);

class ActiveRecordPoint extends StatefulWidget {
  const ActiveRecordPoint({
    super.key,
    required this.nameId,
    required this.spotNumber,
  });

  final String nameId;
  final int spotNumber;

  @override
  State<ActiveRecordPoint> createState() => _ActiveRecordPointState();
}

class _ActiveRecordPointState extends State<ActiveRecordPoint>
    with TickerProviderStateMixin {
  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.pink,
        width: 6,
      ),
    ),
    end: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.pink,
        width: 0,
      ),
    ),
  );

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _animationDuration,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        _buildAnimation(),
        _buildInnerCircle(theme),
        _buildSpotNumber(theme),
      ],
    );
  }

  Widget _buildSpotNumber(ThemeData theme) {
    final color = theme.colorScheme.onSecondary;
    final textStyle = theme.textTheme.labelMedium?.copyWith(color: color);

    return Text('${widget.spotNumber}', style: textStyle);
  }

  Widget _buildInnerCircle(ThemeData theme) {
    final color = theme.colorScheme.secondary;
    return Padding(
      padding: _padding,
      child: RecordPointInnerCircle(nameId: widget.nameId, color: color),
    );
  }

  Widget _buildAnimation() => _wrap(
        DecoratedBoxTransition(
          decoration: decorationTween.animate(_controller),
          child: Container(),
        ),
      );

  Widget _wrap(Widget widget) => ScaleTransition(
        scale: _animation,
        child: RepaintBoundary(child: widget),
      );
}

const _padding = EdgeInsets.all(5);
