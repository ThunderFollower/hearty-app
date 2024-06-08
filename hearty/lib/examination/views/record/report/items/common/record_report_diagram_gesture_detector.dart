part of '../record_report.dart';

class _DiagramGestureDetector extends StatelessWidget {
  const _DiagramGestureDetector({
    required this.diagramProvider,
    required this.title,
  });

  final Widget Function({required bool verticalLayout}) diagramProvider;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showExpandedDiagram(context, title),
      child: diagramProvider.call(verticalLayout: true),
    );
  }

  void _showExpandedDiagram(BuildContext context, String title) {
    final expandedDiagram = GestureDetector(
      onTap: context.router.pop,
      child: diagramProvider.call(verticalLayout: false),
    );
    showModalBottomSheet<bool>(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (_) => _ExpandedDiagram(diagram: expandedDiagram, title: title),
    );
  }
}
