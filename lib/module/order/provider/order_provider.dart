import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:webordernft/module/order/service/model/order_payment.dart';
import 'package:webordernft/module/order/service/order_service.dart';

class OrderProvider with ChangeNotifier {
  String? _orderName;
  String? _phoneNumber;
  String? _email;
  String? _address;
  String? _city;
  String? _postCode;
  int _orderAmount = 1; // Default order amount
  double _price = 150000;
  double _total = 0;
  double _shippingCost = 20000; // Fixed shipping cost
  double _totalToBePaid = 0;
  int _currentPage = 1;
  int _lastPage = 1;

  int get currentPage => _currentPage;
  int get lastPage => _lastPage;
  late VideoPlayerController _videoController;
  int? _paymentChannel = 0; // Default payment channel
  int _paymentStatus = 0; // Default payment status

  // Getters
  String? get orderName => _orderName;
  String? get phoneNumber => _phoneNumber;
  String? get email => _email;
  String? get address => _address;
  String? get city => _city;
  String? get postCode => _postCode;
  int get orderAmount => _orderAmount;
  int? get paymentChannel => _paymentChannel;
  int get paymentStatus => _paymentStatus;

  double get price => _price;
  double get total => _total;
  double get shippingCost => _shippingCost;
  double get totalToBePaid => _totalToBePaid;
  VideoPlayerController get videoController => _videoController;

// CAPTCHA related fields

  String _generatedCaptcha = '';
  bool _isCaptchaValid = false;
  String? _enteredCaptcha;
// CAPTCHA getters
  String get generatedCaptcha => _generatedCaptcha;
  bool get isCaptchaValid => _isCaptchaValid;

  bool _isDownloading = false;

  bool get isDownloading => _isDownloading;

  void setDownloading(bool downloading) {
    _isDownloading = downloading;
    notifyListeners();
  }

  // Setters
  set enteredCaptcha(String? value) {
    _enteredCaptcha = value;
    notifyListeners();
  }

  // Setters with internal validation
  set orderName(String? val) {
    _orderName = val;
    notifyListeners();
  }

  set phoneNumber(String? val) {
    _phoneNumber = val;
    notifyListeners();
  }

  set email(String? val) {
    _email = val;
    notifyListeners();
  }

  set address(String? val) {
    _address = val;
    notifyListeners();
  }

  set city(String? val) {
    _city = val;
    notifyListeners();
  }

  set postCode(String? val) {
    _postCode = val;
    notifyListeners();
  }

  void generateCaptcha() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    _generatedCaptcha = String.fromCharCodes(Iterable.generate(
        6, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
    notifyListeners();
  }

  bool validateCaptcha() {
    if (_enteredCaptcha == _generatedCaptcha) {
      _isCaptchaValid = true;
      notifyListeners();
      return true;
    } else {
      _isCaptchaValid = false;
      notifyListeners();
      return false;
    }
  }

  void initializeVideo(String videoPath) {
    _videoController = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        notifyListeners();
      });
  }

  void playVideo() {
    if (!_videoController.value.isPlaying) {
      _videoController.play();
      notifyListeners();
    }
  }

  set paymentChannel(int? value) {
    _paymentChannel = value;
    notifyListeners(); // Notify listeners about the change
  }

  set paymentStatus(int value) {
    _paymentStatus = value;
    notifyListeners();
  }

  void pauseVideo() {
    if (_videoController.value.isPlaying) {
      _videoController.pause();
      notifyListeners();
    }
  }

  void disposeVideo() {
    _videoController.dispose();
    notifyListeners();
  }

  void setOrderAmount(int amount) {
    _orderAmount = amount;

    _calculateTotal();

    notifyListeners();
    print("Order amount set to: $_orderAmount");
  }

  void _calculateTotal() {
    _total = _orderAmount * _price;
    _totalToBePaid = _total + _shippingCost;

    notifyListeners();
  }

  // Validate the form fields
  bool validateOrderForm() {
    if (_orderName == null || _orderName!.isEmpty) return false;
    if (_phoneNumber == null || _phoneNumber!.isEmpty) return false;
    if (_email == null || _email!.isEmpty) return false;
    if (_address == null || _address!.isEmpty) return false;
    if (_city == null || _city!.isEmpty) return false;
    if (_postCode == null || _postCode!.isEmpty) return false;
    return true;
  }

  void resetOrder() {
    _orderAmount = 1;
    _total = 0;
    _totalToBePaid = 0;
    notifyListeners();
  }

  bool submitOrder({
    required String name,
    required String phone,
    required String email,
    required String address,
    required String city,
    required String postCode,
    required String orderAmount,
  }) {
    _orderName = name;
    _phoneNumber = phone;
    _email = email;
    _address = address;
    _city = city;
    _postCode = postCode;
    _orderAmount = int.tryParse(orderAmount) ?? 1; // Cek konversi di sini
    _calculateTotal();

    // Validate the form data
    if (validateOrderForm()) {
      notifyListeners();
      return true;
    }
    return false;
  }

  void setPhoneNumber(String number) {
    phoneNumber = number;
    notifyListeners();
  }

  bool _isLoading = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> submitPaymentProof(BuildContext context, dynamic selectedFiles,
      String phoneNumber, int? paymentChannel) async {
    setLoading(true);
    setErrorMessage('');

    if (selectedFiles != null && selectedFiles.isNotEmpty) {
      var file = selectedFiles.first;
      String? fileName = kIsWeb ? file.name : file.path.split('/').last;

      if (['.jpg', '.jpeg', '.png'].any(fileName!.contains)) {
        try {
          OrderPaymentProof paymentProofData = OrderPaymentProof(
              paymentChannel: paymentChannel!,
              paymentStatus: 9,
              cellphone: phoneNumber,
              fileBytes: kIsWeb ? file.bytes : null,
              imagePath: kIsWeb ? null : file.path,
              fileName: fileName);

          await OrderService.submitPaymentProof(context, paymentProofData);
          Navigator.pushNamed(context, 'SuccessPage');
        } catch (e) {
          setErrorMessage('Error: $e');
        }
      } else {
        setErrorMessage('File must be JPG or PNG format.');
      }
    } else {
      setErrorMessage('No file selected.');
    }

    setLoading(false);
  }

  bool isSubmitting = false;
  String? submissionMessage;
}
