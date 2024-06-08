part of '../record_report.dart';

/// Represents a skeleton placeholder for the Record report view.
class RecordReportSkeleton extends StatelessWidget {
  const RecordReportSkeleton();

  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SkeletonTile(height: 90),
            SizedBox(height: lowestIndent),
            _SkeletonTile(height: 80),
            SizedBox(height: lowestIndent),
            _SkeletonTile(height: 80),
            SizedBox(height: lowestIndent),
            _SkeletonTile(height: 135),
            SizedBox(height: lowestIndent),
            _SkeletonTile(height: 173),
          ],
        ),
      );
}
