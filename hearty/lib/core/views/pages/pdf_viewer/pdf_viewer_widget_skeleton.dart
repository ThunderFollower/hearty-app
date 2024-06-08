part of 'pdf_viewer_widget.dart';

/// A loading skeleton for [PDFViewerWidget].
///
/// Displays a series of skeleton paragraphs to simulate the layout of a PDF document
/// during loading. This enhances user experience by providing a visual placeholder.
class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final paragraphs = List.generate(
      _amountOfParagraphs,
      (_) => SkeletonParagraph(style: _paragraphStyle),
    );

    return wrapChildren(paragraphs);
  }

  /// Wraps skeleton paragraphs in a scrollable column layout.
  Widget wrapChildren(List<Widget> children) => SingleChildScrollView(
        padding: _contentPadding,
        child: Column(children: children),
      );
}

// Constants used for styling the skeleton paragraphs.

const _contentPadding = EdgeInsets.symmetric(horizontal: middleIndent);
const _amountOfParagraphs = 15;
const _paragraphPadding = EdgeInsets.only(bottom: extremelyHightIndent);
const _amountOfParagraphLines = 10;
const _paragraphStyle = SkeletonParagraphStyle(
  lines: _amountOfParagraphLines,
  spacing: lowestIndent,
  padding: _paragraphPadding,
);
