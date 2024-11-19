import 'dart:ui';

import 'package:webordernft/config/env.dart';

const String companyname = 'POS FINANSIAL INDONESIA';
const String companyLogo = 'assets/images/logo/logo_company.png';
const String companyLogoWhite = 'assets/images/logo/p.png';
const String companyTagline = 'WebOrderFIlateli';

const String appVersion = '1.0.1';

// radius
const double radiusVal = 15;
const double radiusForm = 30;

//time out
const timeOut = 6000;
// const timeOut = 300;

// fb params
const fbApiKey = 'AIzaSyATbW3XaliIA_aZ8gG9l6Mj1RVBTp3ZD5o';
const fbAppId = '1:924876002491:android:c7f5614baf36bc5690c59e';
const fbMsgId = '924876002491';
const fbProjId = 'weborder';
const fbStoreBucket = 'weborder.com';

// font family
const String sfProFnt = 'SFPro';
const String SFProBoldFnt = 'Poppins-Bold';
const String SFProSemiBoldFnt = 'SFProSemiBold';
const String SFProMedium = 'SFProMedium';
const String NebulaReg = 'NebulaReg';

// font Size
const double largeTitleSz = 16;
const double titleSz = 14;
const double subTitleSz = 12;
const double bodySz = 10;
const double captionSz = 8;

// mockup
const double mockupHeight = 1280;
const double mockupWidth = 1920;

const double textFieldWidth = 400;

// mapping error messge
const String errMsg_global =
    'Mohon maaf, sedang ada gangguan, silahkan ulangi beberapa saat lagi !';

const String maskingErrorText =
    'Sedang ada gangguan di jaringan atau sistem. Mohon coba kembali beberapa saat lagi.';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

// url_helper.dart

class UrlHelper {
  static String getSignatureUrl(String signingPath) {
    return '$BASE_URL/storage/signatures/manual/$signingPath';
  }
}
