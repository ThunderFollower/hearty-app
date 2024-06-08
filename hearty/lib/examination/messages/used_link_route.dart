import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app_router.gr.dart';
import '../../generated/locale_keys.g.dart';

const _svgAssetName = 'assets/images/link_expired.svg';

/// Defines a route for the Unused Link message.
final unusedLinkRoute = ModalMessageRoute(
  captionText: LocaleKeys.Link_has_been_used.tr(),
  descriptionText:
      LocaleKeys.The_link_you_are_trying_to_access_has_been_used.tr(),
  icon: SvgPicture.asset(_svgAssetName),
);
