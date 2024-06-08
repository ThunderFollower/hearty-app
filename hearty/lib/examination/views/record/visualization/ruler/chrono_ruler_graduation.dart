part of 'chrono_ruler.dart';

class _Graduation extends StatelessWidget {
  const _Graduation();

  @override
  Widget build(BuildContext context) => VerticalDivider(
        width: _thickness,
        thickness: _thickness,
        color: Theme.of(context).colorScheme.secondary,
      );
}

const _thickness = 1.0;
