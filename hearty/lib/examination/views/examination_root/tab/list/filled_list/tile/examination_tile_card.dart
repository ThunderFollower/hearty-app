part of 'examination_tile.dart';

class _Card extends StatelessWidget {
  final String examinationId;
  final bool? received;
  const _Card(
    this.examinationId, {
    this.received,
  });

  @override
  Widget build(BuildContext context) => _warpContent(
        _Content(examinationId, received: received),
      );

  Widget _warpContent(Widget content) => Material(child: content);
}
