part of 'record_header.dart';

class _TitleSkeleton extends StatelessWidget {
  const _TitleSkeleton();

  @override
  Widget build(BuildContext context) => const SkeletonLine(
        style: SkeletonLineStyle(
          height: 24,
          randomLength: true,
          maxLength: 150.0,
          minLength: 100.0,
        ),
      );
}
