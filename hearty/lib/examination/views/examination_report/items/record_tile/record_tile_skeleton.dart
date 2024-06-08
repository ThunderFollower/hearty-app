part of 'record_tile.dart';

class _TileSkeleton extends StatelessWidget {
  const _TileSkeleton();

  @override
  Widget build(BuildContext context) {
    const style = SkeletonLineStyle(
      height: _height,
      borderRadius: _borderRadius,
    );

    return SkeletonListTile(
      titleStyle: style,
      hasLeading: false,
      contentSpacing: 0,
      padding: _tilePadding,
    );
  }
}

const _height = 80.0;
const _tilePadding = EdgeInsets.zero;
