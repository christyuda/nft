import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GeneralProv with ChangeNotifier {
  bool _showspinner = false;
  late bool st;
  late String _message = '';
  // String _officeId = '40000';
  // String _employeeName = 'jimny';

  late String _strmessage = '';
  late String _routers = 'MainHomeScreenNew';

  //getter
  bool get showspinner => _showspinner;
  String get message => _message;
  String get strmessage => _strmessage;
  String get routers => _routers;

  //setter
  set strmessage(String val) {
    _strmessage = val;
    notifyListeners();
  }

  set routers(String val) {
    _routers = val;
    notifyListeners();
  }

  set message(String val) {
    _message = val;
    notifyListeners();
  }

  set showspinner(bool val) {
    _showspinner = val;
    notifyListeners();
  }

  genSendMessage() {
    EasyLoading.showToast(
      toastPosition: EasyLoadingToastPosition.center,
      maskType: EasyLoadingMaskType.black,
      message,
      duration: const Duration(seconds: 3),
      dismissOnTap: true,
    );
  }

  instantSendMessage(String pesan) {
    EasyLoading.showToast(
      toastPosition: EasyLoadingToastPosition.center,
      maskType: EasyLoadingMaskType.black,
      pesan,
      duration: const Duration(seconds: 3),
      dismissOnTap: true,
    );
  }

  isLoadingWithMessage(String pesan) {
    EasyLoading.show(
      status: '$pesan...',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: true,
    );
  }

  isLoading() {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: true,
    );
  }

  dissmisLoading() {
    EasyLoading.dismiss();
  }

  clearMsg() {
    strmessage = '';
    message = '';
  }
}
