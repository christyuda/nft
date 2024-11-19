import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/config/palette.dart';
import 'package:webordernft/config/user_activity_detector.dart';
import 'package:webordernft/module/login/provider/login_provider.dart';
import 'package:webordernft/routes/router.dart' as router;

import 'config/constant.dart';
import 'config/provider_setup.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  initializeDateFormatting('id_ID', null).then((_) {
    String currentDomain = Uri.base.host;
    runApp(MyApp(currentDomain: currentDomain));
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String currentDomain;

  MyApp({Key? key, required this.currentDomain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: UserActivityDetector(
        child: MaterialApp(
          title: 'POSFIN',
          theme: buildThemeData(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings) =>
              router.generateRoute(settings, currentDomain),
          initialRoute: '/',
          builder: EasyLoading.init(),
        ),
      ),
    );
  }

  ThemeData buildThemeData() {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: Palette.white,
      cardColor: Palette.white,
      cardTheme: CardTheme(
        color: Colors.white,
      ),
    );
  }
}
