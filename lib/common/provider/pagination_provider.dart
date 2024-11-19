import 'package:flutter/material.dart';

class PaginationProvider with ChangeNotifier {
  int? _page = 1;
  int? _lastPage = 0;
  int? _totalRow;
  int? _fromRow;
  int? _toRow;
  int? _currentPage;

//getter
  int? get page => _page;
  int? get lastPage => _lastPage;
  int? get totalRow => _totalRow;
  int? get fromRow => _fromRow;
  int? get toRow => _toRow;
  int? get currentPage => _currentPage;

// setter
  set currentPage(int? val) {
    _currentPage = val!;
    notifyListeners();
  }

  set toRow(int? val) {
    _toRow = val!;
    notifyListeners();
  }

  set fromRow(int? val) {
    _fromRow = val!;
    notifyListeners();
  }

  set totalRow(int? val) {
    _totalRow = val!;
    notifyListeners();
  }

  set page(int? val) {
    _page = val!;
    notifyListeners();
  }

  set lastPage(int? val) {
    _lastPage = val!;
    notifyListeners();
  }

  //function

  nextPage(context, String action) async {
    if (action == 'previous') {
      page = (currentPage! - 1);
      notifyListeners();
    }
    if (action == 'next') {
      page = (currentPage! + 1) > num.parse(lastPage.toString())
          ? lastPage
          : (currentPage! + 1);
      notifyListeners();
    }
  }
}
