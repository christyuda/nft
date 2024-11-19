import 'package:flutter/material.dart';
import 'package:webordernft/common/widget/succes_page.dart';
import 'package:webordernft/module/dashboard/view/index_dashboard.dart';
import 'package:webordernft/module/login/view/login_form.dart';
import 'package:webordernft/module/login/view/login_mom.dart';
import 'package:webordernft/module/mom/view/create_mom.dart';
import 'package:webordernft/module/mom/view/create_momV2.dart';
import 'package:webordernft/module/mom/view/online_signature.dart';
import 'package:webordernft/module/mom/view/signing_online.dart';
import 'package:webordernft/module/mom/view/validate_signature.dart';
import 'package:webordernft/module/order/view_bayar.dart';

import '../module/login/view/landing_page.dart';
import '../module/main/view/main_screen.dart';
import '../module/order/index_order.dart';
import '../module/order/konfirmasi_pembayaran.dart';

Route<dynamic> generateRoute(RouteSettings settings, String currentDomain) {
  print('Navigating to: ${settings.name}');
  print('Current Domain: $currentDomain');

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => const LandingPage());
    // builder: (context) => const IndexOrder());

    case 'OrderForm':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => const IndexOrder());

    case 'KonfirmasiPembayaran':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => const KonfirmasiPembayaran());
    case 'CreateMom':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => CreateMomV2());
    case '/backoffice':
      if (currentDomain == 'nft.posfin.id') {
        print('Navigating to LoginLanding for nft.posfin.id');

        return MaterialPageRoute(
            settings: routeSettings(settings),
            builder: (context) => const LoginLanding());
      } else if (currentDomain == 'io.posfin.id') {
        print('Navigating to LoginLanding for nft.posfin.id');

        return MaterialPageRoute(
            settings: routeSettings(settings),
            builder: (context) => const LoginMom());
      } else {
        print('Navigating to Default LoginLanding');

        return MaterialPageRoute(
            settings: routeSettings(settings),
            builder: (context) => const LoginLanding());
        // builder: (context) => CreateMomV2());
      }
    // builder: (context) => FormCreateMom());

    case 'MainDashboard':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => MainScreen());
    // case 'Dashboard':
    //   return MaterialPageRoute(
    //       settings: routeSettings(settings),
    //       builder: (context) => DashboardScreen());

    case 'FormListUser':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => MainScreen());
    case 'ConfirmPayment':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => PaymentConfirmationPage());
    case 'SuccessPage':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => SuccessPage());

    case 'SingingOnlinePage':
      final arguments = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => SingingOnlinePage(
          meetingId: arguments['meetingId'] as int,
        ),
      );

    case '/ValidateOnlineSignature':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => ValidateOnlineSignaturePage());

    // case 'ComingSoon':
    //   return MaterialPageRoute(
    //       settings: routeSettings(settings),
    //       builder: (context) => const ComingSoon());

    // route for sukses page
    // case 'successpage':
    //   return MaterialPageRoute(
    //       settings: routeSettings(settings),
    //       builder: (context) => SuccessScreen());

    default:
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => const LoginLanding());
  }
}

RouteSettings routeSettings(RouteSettings settings) =>
    RouteSettings(name: settings.name);
  //    RouteSettings(name: settings.name, isInitialRoute: true);
