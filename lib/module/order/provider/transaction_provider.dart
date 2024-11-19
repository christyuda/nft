import 'dart:core';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html; // Impor ini hanya akan digunakan di Flutter Web

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webordernft/common/provider/general_provider.dart';
import 'package:webordernft/module/login/provider/login_provider.dart';
import 'package:webordernft/module/order/service/model/pin_search_order.dart';
import 'package:webordernft/module/order/service/order_service.dart';
import 'package:webordernft/module/order/service/model/order_list.dart';
import 'package:webordernft/module/order/service/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  List<OrderData> _orderList = [];
  String? _ordererName;
  String? _statusOrder;
  String? _startDate;
  String? _endDate;
  int? _qty;
  int? _paymentChanel = null;
  int? _paymentStatus = null;

  int? _page = 1;
  int? _lastPage = 0;
  int? _totalRow;
  int? _fromRow;
  int? _toRow;
  int? _currentPage;
  List<OrderData>? orderData;
  String? _token;
  // Getter
  List<OrderData> get orderList => _orderList;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get ordererName => _ordererName;
  String? get statusOrder => _statusOrder;
  String? get token => token;
  // Paging getter
  int? get paymentChanel => _paymentChanel;
  int? get paymentStatus => _paymentStatus;

  int? get qty => _qty;
  int? get page => _page;
  int? get lastPage => _lastPage;
  int? get totalRow => _totalRow;
  int? get fromRow => _fromRow;
  int? get toRow => _toRow;
  int? get currentPage => _currentPage;

  // Setter
  set orderList(List<OrderData> val) {
    _orderList = val;
    notifyListeners();
  }

  set endDate(String? val) {
    _endDate = val;
    notifyListeners();
  }

  set token(String? val) {
    _token = val;
    notifyListeners();
  }

  set startDate(String? val) {
    _startDate = val;
    notifyListeners();
  }

  set ordererName(String? val) {
    _ordererName = val;
    notifyListeners();
  }

  set statusOrder(String? val) {
    _statusOrder = val;
    notifyListeners();
  }

  set qty(int? val) {
    _qty = val;
    notifyListeners();
  }

  set paymentChanel(int? val) {
    _paymentChanel = val;
    notifyListeners();
  }

  set paymentStatus(int? val) {
    _paymentStatus = val;
    notifyListeners();
  }

  set page(int? val) {
    _page = val;
    notifyListeners();
  }

  set lastPage(int? val) {
    _lastPage = val;
    notifyListeners();
  }

  set totalRow(int? val) {
    _totalRow = val;
    notifyListeners();
  }

  set fromRow(int? val) {
    _fromRow = val;
    notifyListeners();
  }

  set toRow(int? val) {
    _toRow = val;
    notifyListeners();
  }

  set currentPage(int? val) {
    _currentPage = val;
    notifyListeners();
  }

  getOrderList(context) async {
    final genProv = Provider.of<GeneralProv>(context, listen: false);
    genProv.isLoading();

    OrderRequestBody param = OrderRequestBody(
        startDate: startDate,
        endDate: endDate,
        ordererName: ordererName,
        qty: qty,
        paymentChannel: paymentChanel,
        paymentStatus: paymentStatus);

    OrderList _result =
        await TransactionService.getOrderList(context, page, param);
    List<OrderData>? _dataOrder = _result.data!.data;
    orderList = _dataOrder!;
    if (_dataOrder.length > 0) {
      lastPage = _result.data!.lastPage;
      totalRow = _result.data!.total;
      fromRow = _result.data!.from;
      toRow = _result.data!.to;
      currentPage = _result.data!.currentPage;
    }

    genProv.dissmisLoading();
    notifyListeners();
  }

  nextPage(context, String action) async {
    final genProv = Provider.of<GeneralProv>(context, listen: false);
    genProv.isLoading();

    if (action == 'previous') {
      page = (currentPage! - 1);
    } else if (action == 'next') {
      page = (currentPage! + 1) > lastPage! ? lastPage : (currentPage! + 1);
    }

    await getOrderList(context);
  }

  searchBar(context) async {
    final genProv = Provider.of<GeneralProv>(context, listen: false);
    genProv.isLoading();

    OrderRequestBody param = OrderRequestBody(
        startDate: startDate,
        endDate: endDate,
        ordererName: ordererName,
        qty: qty,
        paymentChannel: paymentChanel,
        paymentStatus: paymentStatus);
    OrderList _result =
        await TransactionService.getOrderList(context, page, param);
    List<OrderData>? _dataOrder = _result.data!.data;
    orderList = _dataOrder!;
    if (_dataOrder.length > 0) {
      lastPage = _result.data!.lastPage;
      totalRow = _result.data!.total;
      fromRow = _result.data!.from;
      toRow = _result.data!.to;
      currentPage = _result.data!.currentPage;
    }

    genProv.dissmisLoading();
    notifyListeners();
  }

  downloadCsv(context, param) async {
    final genProv = Provider.of<GeneralProv>(context, listen: false);
    genProv.isLoading();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final token = loginProvider.token;
    // Membuat param request
    OrderRequestBody param = OrderRequestBody(
        startDate: startDate,
        endDate: endDate,
        ordererName: ordererName,
        qty: qty,
        paymentChannel: paymentChanel,
        paymentStatus: paymentStatus);

    try {
      final response = await TransactionService.downloadCsv(
        context,
        param,
      );
    } catch (e) {
      print('Error posting order request: $e');
    } finally {
      genProv.dissmisLoading();
      notifyListeners();
    }
  }

  // Fungsi untuk menghapus filter pencarian
  clearFilter() {
    startDate = '';
    endDate = '';
    ordererName = '';
    paymentChanel = null;
    paymentStatus = null;
    notifyListeners();
  }

  setCsv() {
    startDate = startDate;
    endDate = endDate;
    ordererName = ordererName;
    paymentChanel = paymentChanel;
    paymentStatus = paymentStatus;
    notifyListeners();
  }
}
