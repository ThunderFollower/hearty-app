part of '../record_report.dart';

class _ExpandedDiagram extends StatelessWidget {
  const _ExpandedDiagram({
    required this.diagram,
    required this.title,
  });

  final Widget diagram;
  final String title;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: textStyleOfBlackPearlColorMedium18,
    );
    final horizontalContent = RotatedBox(
      quarterTurns: 1,
      child: AppScaffold(
        backgroundColor: Colors.white,
        body: diagram,
        appBar: TitleBar.withCloseButton(
          title,
          appBarTheme: appBarTheme,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: DraggableScrollableSheet(
          minChildSize: 0.95,
          initialChildSize: 1.0,
          builder: (_, __) => horizontalContent,
        ),
      ),
    );
  }
}
