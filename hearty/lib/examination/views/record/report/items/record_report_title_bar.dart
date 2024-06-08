part of 'record_report.dart';

TitleBar _titleBar({
  required int spotNumber,
  required String spotName,
  required String bodyPosition,
  required BuildContext context,
}) {
  final textStyle = Theme.of(context)
      .textTheme
      .labelMedium
      ?.copyWith(color: Colors.pink.shade500);
  final appBarTheme = AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: textStyleOfBlackPearlColorMedium18,
  );

  return TitleBar.withBackButtonAndWidget(
    RichText(
      text: TextSpan(
        text: '$spotNumber. ',
        style: textStyle?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.grey.shade500,
        ),
        children: [
          TextSpan(
            text: '$spotName ',
            style: textStyle?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.grey.shade900,
            ),
          ),
          TextSpan(
            text: bodyPosition,
            style: textStyle?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey.shade700,
            ),
          ),
        ],
      ),
    ),
    appBarTheme: appBarTheme,
  );
}
