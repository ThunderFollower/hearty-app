import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_router.gr.dart';
import '../../generated/locale_keys.g.dart';

const _svgAssetName = 'assets/images/link_expired.svg';

final invalidLinkRoute = ModalMessageRoute(
  captionText: LocaleKeys.Something_went_wrong.tr(),
  descriptionText: LocaleKeys.Stethophone_cannot_open_this_examination.tr(),
  icon: SvgPicture.asset(_svgAssetName),
);
