import 'dart:typed_data';

/// Represents the state of a PDF viewer.
///
/// Holds the information about the PDF source, which can be either a file path
/// or binary data.
class PDFViewerState {
  /// The file path of the PDF document.
  final String? path;

  /// The binary data of the PDF document.
  final Uint8List? data;

  /// Creates a new [PDFViewerState].
  const PDFViewerState({
    this.path,
    this.data,
  });

  /// Creates a copy of this state with the given fields replaced with new values.
  ///
  /// This method allows for modifying specific fields in the state while retaining
  /// others from the current state.
  PDFViewerState copyWith({
    String? path,
    Uint8List? data,
  }) =>
      PDFViewerState(
        path: path ?? this.path,
        data: data ?? this.data,
      );
}
