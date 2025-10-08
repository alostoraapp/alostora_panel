import 'dart:ui';

import '../core.dart';

abstract class AcnooStaticImage {
  static const bannerImage01 =
      'assets/images/widget_images/banner_images/banner_image01.png';
  static const articleIcon =
      'assets/images/widget_images/dashboard_icon/article.svg';

  // Widget Images
  static const featureCardBg =
      'assets/images/widget_images/card_images/feature_card/feature_card_bg.png';

  // Authentication Images
  static const signInCover =
      'assets/images/widget_images/authentication_images/signin_cover.svg';
  static const signUpCover =
      'assets/images/widget_images/authentication_images/signup_cover.svg';
  static const googleIcon =
      'assets/images/widget_images/authentication_images/google_icon.svg';
  static const appleIcon =
      'assets/images/widget_images/authentication_images/apple_icon.svg';
}

abstract class AcnooSVGIcons {
  static const copyIcon = 'assets/images/widget_images/svg_icons/copy_icon.svg';
  static const csvIcon = 'assets/images/widget_images/svg_icons/csv_icon.svg';
  static const excelIcon =
      'assets/images/widget_images/svg_icons/excel_icon.svg';
  static const pdfIcon = 'assets/images/widget_images/svg_icons/pdf_icon.svg';
  static const printIcon =
      'assets/images/widget_images/svg_icons/print_icon.svg';

  static const emailIcon = 'assets/images/sidebar_icons/envelope.svg';
  static const starIcon = 'assets/images/widget_images/svg_icons/star.svg';
  static const sendIcon = 'assets/images/widget_images/svg_icons/send.svg';
  static const editIcon = 'assets/images/widget_images/svg_icons/edit.svg';
  static const infoIcon = 'assets/images/sidebar_icons/exclamation-circle.svg';
  static const trashCanIcon = 'assets/images/widget_images/svg_icons/trash.svg';
  static const galleryIcon =
      'assets/images/widget_images/svg_icons/gallery_icon.svg';

  static const refundsIcon =
      'assets/images/widget_images/svg_icons/refunds.svg';
  static const shopIcon = 'assets/images/widget_images/svg_icons/shop.svg';
  static const tagDollarIcon =
      'assets/images/widget_images/svg_icons/tag_dollar.svg';
  static const usersIcon = SvgImageHolder(
    'assets/images/widget_images/svg_icons/users.svg',
    baseColor: Color(0xff683AFF),
  );
  static const tutorIcon = 'assets/images/widget_images/svg_icons/tutor.svg';
  static const amountIcon = 'assets/images/widget_images/svg_icons/amount.svg';
  static const flowIcon = 'assets/images/widget_images/svg_icons/flow.svg';

  //social icons
  static const facebookIcon = SvgImageHolder(
    'assets/images/static_images/icons/social_icons/facebook.svg',
    baseColor: Color(0xff487FFF),
  );
  static const cloudIcon = SvgImageHolder(
      'assets/images/static_images/icons/social_icons/cloud.svg',
      baseColor: AcnooAppColors.kError);
  static const sEmailIcon = SvgImageHolder(
    'assets/images/static_images/icons/social_icons/email.svg',
    baseColor: Color(0xff7500FD),
  );
  static const shareIcon = SvgImageHolder(
      'assets/images/static_images/icons/social_icons/share.svg',
      baseColor: AcnooAppColors.kSuccess);
  static const telegramIcon = SvgImageHolder(
    'assets/images/static_images/icons/social_icons/telegram.svg',
    baseColor: Color(0xffFD7F0B),
  );
  //delivery icons
  static const orderConfirmIcon = SvgImageHolder(
      'assets/images/widget_images/delivery_dashboard_icons/order_confirm.svg',
      baseColor: AcnooAppColors.kSuccess);
  static const orderPendingIcon = SvgImageHolder(
    'assets/images/widget_images/delivery_dashboard_icons/order_pending.svg',
    baseColor: Color(0xffFDBA40),
  );
  static const orderDeliveredIcon = SvgImageHolder(
    'assets/images/widget_images/delivery_dashboard_icons/order_delivered.svg',
    baseColor: Color(0xff7500FD),
  );
  static const orderCancelledIcon = SvgImageHolder(
    'assets/images/widget_images/delivery_dashboard_icons/order_cancelled.svg',
    baseColor: Color(0xffF26944),
  );
  //delivery earning icons
  static const deliverySoldIcon = SvgImageHolder(
    'assets/images/widget_images/delivery_dashboard_icons/sold.svg',
    baseColor: Color(0xff1D4ED8),
  );
  static const deliveryIncomeIcon = SvgImageHolder(
    'assets/images/widget_images/delivery_dashboard_icons/income.svg',
    baseColor: Color(0xff7500FD),
  );
  static const deliveryCostIcon = SvgImageHolder(
    'assets/images/widget_images/delivery_dashboard_icons/order_cancelled.svg',
    baseColor: Color(0xffE40F0F),
  );
  static const deliveryRevenuesIcon = SvgImageHolder(
    'assets/images/widget_images/delivery_dashboard_icons/revenues.svg',
    baseColor: Color(0xff00B243),
  );

  // school management icons
  static const book01 = SvgImageHolder(
      'assets/images/widget_images/svg_icons/book01.svg',
      baseColor: Color(0xff0D55B7));
  static const building01 = SvgImageHolder(
    'assets/images/widget_images/svg_icons/building01.svg',
    baseColor: Color(0xffEA8B00),
  );
  static const busTransit01 = SvgImageHolder(
      'assets/images/widget_images/svg_icons/bus_transit01.svg',
      baseColor: Color(0xff1A998E));
  static const discountTicket01 = SvgImageHolder(
      'assets/images/widget_images/svg_icons/discount_ticket01.svg',
      baseColor: Color(0xff9610FF));
  static const parent01 = SvgImageHolder(
      'assets/images/widget_images/svg_icons/parent01.svg',
      baseColor: Color(0xff4AAF57));
  static const student01 = SvgImageHolder(
    'assets/images/widget_images/svg_icons/students01.svg',
    baseColor: AcnooAppColors.kWarning,
  );
  static const student02 = SvgImageHolder(
    'assets/images/widget_images/svg_icons/students02.svg',
    baseColor: Color(0xff09B96D),
  );
  static const teacher01 = SvgImageHolder(
    'assets/images/widget_images/svg_icons/teacher01.svg',
    baseColor: Color(0xff1A96F0),
  );
  static const gropuImage = SvgImageHolder(
      'assets/images/widget_images/svg_icons/group.svg',
      gradientColors: [
        Color(0xff3250FF),
        Color(0xff2BB2FE),
      ]);

  static const supplier = SvgImageHolder(
      'assets/images/widget_images/svg_icons/supplier.svg',
      gradientColors: [
        Color(0xff7819E5),
        Color(0xffD921EA),
      ]);

  static const stock = SvgImageHolder(
    'assets/images/widget_images/svg_icons/stock_medicine.svg',
    gradientColors: [
      Color(0xff10A9FF),
      Color(0xff23DFBF),
    ],
  );

  static const expired = SvgImageHolder(
    'assets/images/widget_images/svg_icons/expired.svg',
    gradientColors: [Color(0xffEB3D4D), Color(0xffFBA37C)],
  );

  //---------------Landlord management----------------------------------
  static const userIcon = 'assets/images/widget_images/svg_icons/user.svg';
  static const withdrawalIcon =
      'assets/images/widget_images/svg_icons/withdrawal.svg';

  static const barIcon = 'assets/images/widget_images/svg_icons/bar.svg';
  static const propertyIcon =
      'assets/images/widget_images/svg_icons/property.svg';
  static const pendingIcon = SvgImageHolder(
    'assets/images/widget_images/svg_icons/pending.svg',
    baseColor: Color(0xff6200EA),
  );
  static const approvedIcon = SvgImageHolder(
    'assets/images/widget_images/svg_icons/approved.svg',
    baseColor: Color(0xff0BA63E),
  );
  static const rejectedIcon = SvgImageHolder(
    'assets/images/widget_images/svg_icons/rejected.svg',
    baseColor: Color(0xffEF8400),
  );

  // Grocery Admin Icons
  static const cartChecked = SvgImageHolder(
    'assets/images/widget_images/svg_icons/cart_checked.svg',
    baseColor: Color(0xffFF8617),
  );
  static const packageChecked = SvgImageHolder(
    'assets/images/widget_images/svg_icons/package_checked.svg',
    baseColor: Color(0xff9E2FE9),
  );
  static const dollarSack = SvgImageHolder(
    'assets/images/widget_images/svg_icons/dollar_sack.svg',
    baseColor: Color(0xff019934),
  );
  static const dollarOutSquare = SvgImageHolder(
    'assets/images/widget_images/svg_icons/dollar_out_square.svg',
    baseColor: Color(0xffDC2626),
  );
}

class SvgImageHolder {
  final String svgPath;
  final Color? baseColor;
  final List<Color> gradientColors;

  const SvgImageHolder(
    this.svgPath, {
    this.baseColor,
    this.gradientColors = const [],
  });
}
