import 'dart:developer' as logprov;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webordernft/module/dashboard/service/dashboard_service.dart';

import '../../../common/widget/month.dart';
import '../service/model/daily_ticket.dart';
import '../service/model/monthly_ticket.dart';
import '../service/model/pin_gtv_perproduct.dart';
import '../service/model/pin_ticketmonthly.dart';
import '../service/model/resume_transaction.dart';
import '../service/model/ticket_issue.dart';
import '../service/model/ticket_status_montlhy.dart';
import '../service/model/topgtv.dart';
import '../service/model/total_user.dart';
import '../service/model/total_user_country.dart';
import '../service/model/total_user_monthly.dart';

class DashboardProvider with ChangeNotifier {
  List<Month> _listmonth = [
    Month(
      indexBln: 1,
      kodebulan: '1',
      namabulan: 'Januari ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 2,
      kodebulan: '2',
      namabulan: 'Februari ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 3,
      kodebulan: '3',
      namabulan: 'Maret ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 4,
      kodebulan: '4',
      namabulan: 'April ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 5,
      kodebulan: '5',
      namabulan: 'Mei ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 6,
      kodebulan: '6',
      namabulan: 'Juni ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 7,
      kodebulan: '7',
      namabulan: 'Juli ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 8,
      kodebulan: '8',
      namabulan: 'Agustus ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 9,
      kodebulan: '9',
      namabulan: 'September ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 10,
      kodebulan: '10',
      namabulan: 'Oktober ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 11,
      kodebulan: '11',
      namabulan: 'November ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
    Month(
      indexBln: 12,
      kodebulan: '12',
      namabulan: 'Desember ' + DateFormat('yyyy').format(new DateTime.now()),
    ),
  ];
  List<Ticketstatusmontly>? _ticketstatusmontly = [];
  List<TicketIssueMonthly> _ticketissuemontly = [];
  List<TicketIssueMonthly> _ticketSourcemontly = [];
  List<DailyTicket> _ticketDaily = [];

  List<Map<String, dynamic>> _totalUserCountryMonthly = [];
  List<Map<String, dynamic>> _totalUserMonthly = [];
  List<Map<String, dynamic>> _monthlytrxvsgtv = [];
  List<Map<String, dynamic>> _topGtv = [];
  List<Map<String, dynamic>> _topTrx = [];

  List<Map<String, dynamic>> _collection = [];
  List<Map<String, dynamic>> _collectionIssue = [];
  List<Map<String, dynamic>> _collectionTicketMontly = [];
  List<Map<String, dynamic>> _collectionTicketMontlyAll = [];
  List<Map<String, dynamic>> _monthlygtvproduct = [];
  List<Map<String, dynamic>> _monthlytrxproduct = [];
  List<ResumeTransaction>? _resumeTrx = [];

  String? _bulan = DateFormat('M').format(new DateTime.now());
  String? _bulanTopGtv = DateFormat('M').format(new DateTime.now());
  String? _bulanTopTrx = DateFormat('M').format(new DateTime.now());
  String? _bulanissue = DateFormat('M').format(new DateTime.now());
  String? _bulanMontly = DateFormat('M').format(new DateTime.now());
  String? _bulantrxvsgtv = DateFormat('M').format(new DateTime.now());
  String? _bulangtvproduct = DateFormat('M').format(new DateTime.now());
  String? _bulantrxproduct = DateFormat('M').format(new DateTime.now());
  String? _day = DateFormat('d').format(new DateTime.now());
  String? _year = DateFormat('y').format(new DateTime.now());

  String? _totalUser;

  //getter
  List<Month> get listmonth => _listmonth;
  List<Ticketstatusmontly>? get ticketstatusmontly => _ticketstatusmontly;
  List<TicketIssueMonthly> get ticketissuemontly => _ticketissuemontly;
  List<TicketIssueMonthly> get ticketSourcemontly => _ticketSourcemontly;
  List<Map<String, dynamic>> get totalUserCountryMonthly =>
      _totalUserCountryMonthly;
  List<Map<String, dynamic>> get monthlytrxvsgtv => _monthlytrxvsgtv;
  List<Map<String, dynamic>> get monthlygtvproduct => _monthlygtvproduct;
  List<Map<String, dynamic>> get monthlytrxproduct => _monthlytrxproduct;

  List<DailyTicket> get ticketDaily => _ticketDaily;
  List<Map<String, dynamic>> get collection => _collection;
  List<Map<String, dynamic>> get collectionIssue => _collectionIssue;
  List<Map<String, dynamic>> get collectionTicketMontly =>
      _collectionTicketMontly;
  List<Map<String, dynamic>> get collectionTicketMontlyAll =>
      _collectionTicketMontlyAll;

  List<Map<String, dynamic>> get totalUserMonthly => _totalUserMonthly;
  List<Map<String, dynamic>> get topGtv => _topGtv;
  List<Map<String, dynamic>> get topTrx => _topTrx;
  List<ResumeTransaction>? get resumeTrx => _resumeTrx;

  String? get bulanStatus => _bulan;
  String? get bulanissue => _bulanissue;
  String? get bulanTopGtv => _bulanTopGtv;
  String? get bulanTopTrx => _bulanTopTrx;
  String? get bulanMontly => _bulanMontly;
  String? get bulantrxvsgtv => _bulantrxvsgtv;
  String? get bulangtvproduct => _bulangtvproduct;
  String? get bulantrxproduct => _bulantrxproduct;

  String? get day => _day;
  String? get totalUser => _totalUser;

  //setter
  set resumeTrx(List<ResumeTransaction>? val) {
    _resumeTrx = val;
    notifyListeners();
  }

  set totalUserCountryMonthly(List<Map<String, dynamic>> val) {
    _totalUserCountryMonthly = val;
    notifyListeners();
  }

  set monthlygtvproduct(List<Map<String, dynamic>> val) {
    _monthlygtvproduct = val;
    notifyListeners();
  }

  set monthlytrxproduct(List<Map<String, dynamic>> val) {
    _monthlytrxproduct = val;
    notifyListeners();
  }

  set topGtv(List<Map<String, dynamic>> val) {
    _topGtv = val;
    notifyListeners();
  }

  set topTrx(List<Map<String, dynamic>> val) {
    _topTrx = val;
    notifyListeners();
  }

  set totalUserMonthly(List<Map<String, dynamic>> val) {
    _totalUserMonthly = val;
    notifyListeners();
  }

  set monthlytrxvsgtv(List<Map<String, dynamic>> val) {
    _monthlytrxvsgtv = val;
    notifyListeners();
  }

  set ticketDaily(List<DailyTicket> val) {
    _ticketDaily = val;
    notifyListeners();
  }

  set collection(List<Map<String, dynamic>> val) {
    _collection = val;
    notifyListeners();
  }

  set collectionTicketMontly(List<Map<String, dynamic>> val) {
    _collectionTicketMontly = val;
    notifyListeners();
  }

  set collectionTicketMontlyAll(List<Map<String, dynamic>> val) {
    _collectionTicketMontlyAll = val;
    notifyListeners();
  }

  set collectionIssue(List<Map<String, dynamic>> val) {
    _collectionIssue = val;
    notifyListeners();
  }

  set ticketstatusmontly(List<Ticketstatusmontly>? val) {
    _ticketstatusmontly = val;
    notifyListeners();
  }

  set ticketissuemontly(List<TicketIssueMonthly> val) {
    _ticketissuemontly = val;
    notifyListeners();
  }

  set ticketSourcemontly(List<TicketIssueMonthly> val) {
    _ticketSourcemontly = val;
    notifyListeners();
  }

  set totalUser(String? val) {
    _totalUser = val;
    notifyListeners();
  }

  set day(String? val) {
    _day = val;
    notifyListeners();
  }

  set bulangtvproduct(String? val) {
    _bulangtvproduct = val;
    notifyListeners();
  }

  set bulantrxvsgtv(String? val) {
    _bulantrxvsgtv = val;
    notifyListeners();
  }

  set bulantrxproduct(String? val) {
    _bulantrxproduct = val;
    notifyListeners();
  }

  set bulanTopTrx(String? val) {
    _bulanTopTrx = val;
    notifyListeners();
  }

  set bulanTopGtv(String? val) {
    _bulanTopGtv = val;
    notifyListeners();
  }

  set bulanStatus(String? val) {
    _bulan = val;
    notifyListeners();
  }

  set bulanMontly(String? val) {
    _bulanMontly = val;
    notifyListeners();
  }

  set bulanissue(String? val) {
    _bulanissue = val;
    notifyListeners();
  }

  set listmonth(List<Month> val) {
    _listmonth = val;
    notifyListeners();
  }

  // init function

  initDashboardUser(context) async {
    getTotalUser(context);
    getfeedUserMonthly(context);
    getfeedUserCountryMonthly(context);
  }

  initDashboardTransaction(context) async {
    getResumeTransaction(context);
    getResumeTopGtv(context);
    getResumeTopTrx(context);
    getfeedtrxvsgtv(context);
    getfeedgtvproduct(context);
    getfeedtrxproduct(context);
  }
  //function

  getDailyTicket(context) async {
    ticketDaily.clear();
    PinTicketDaily params = PinTicketDaily(day: day);

    List<DailyTicket> _result =
        await DashboardService.getDailyTicket(context, params);

    ticketDaily = _result;

    notifyListeners();
  }

  getTicketSourceMontly(context) async {
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanStatus);

    List<TicketIssueMonthly> _result =
        await DashboardService.getDataticketSourcemontly(context, params);

    ticketSourcemontly = _result;

    notifyListeners();
  }

  getticketIssueMontly(context) async {
    ticketissuemontly.clear();
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanStatus);

    List<TicketIssueMonthly> _result =
        await DashboardService.getDataticketIssuemontly(context, params);

    ticketissuemontly = _result;

    notifyListeners();
  }

  getticketstatusmontly(context) async {
    collection.clear();
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanStatus);
    List<Ticketstatusmontly>? _result =
        await DashboardService.getDataticketstatusmontly(context, params);
    List<Map<String, dynamic>> mapList = [];

    _result!.forEach((e) {
      Map<String, dynamic> item = {
        'domain': e.status.toString(),
        'measure': int.parse(e.jumlah!)
      };
      mapList.add(item);
    });

    collection = mapList.toList();

    notifyListeners();
  }

  getticketformonth(context) async {
    collectionTicketMontly.clear();
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanMontly);
    List<MontlyTicket>? _result =
        await DashboardService.getticketformonth(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result!.forEach((e) {
      List<Map<String, dynamic>> mapDatum = [];
      e.data!.forEach((e) {
        Map<String, dynamic> item = {
          'domain': e.domain,
          'measure': e.measure,
        };
        mapDatum.add(item);
      });

      Map<String, dynamic> item = {
        'id': e.id,
        'data': mapDatum,
      };
      mapList.add(item);
    });

    collectionTicketMontly = mapList.toList();
    logprov.log(collectionTicketMontly.toString(), name: "montlydata");
    notifyListeners();
  }

  getticketformonthall(context) async {
    collectionTicketMontlyAll.clear();
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanMontly);
    List<MontlyTicket>? _result =
        await DashboardService.getticketformonthAll(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result!.forEach((e) {
      List<Map<String, dynamic>> mapDatum = [];
      e.data!.forEach((e) {
        Map<String, dynamic> item = {
          'domain': e.domain,
          'measure': e.measure,
        };
        mapDatum.add(item);
      });

      Map<String, dynamic> _item = {
        'id': e.id,
        'data': mapDatum,
      };
      mapList.add(_item);
    });

    collectionTicketMontlyAll = mapList.toList();
    // logprint.log(mapList.toString(), name: 'collectionTicketMontlyAll');
    notifyListeners();
  }

  // Feeder
  getTotalUser(context) async {
    List<TotalUser> _result =
        await DashboardService.getfeedTotalUser(context, '');

    totalUser = _result[0].total.toString();

    notifyListeners();
  }

  getfeedUserMonthly(context) async {
    collectionTicketMontlyAll.clear();
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanMontly);
    List<TotalUserMontly>? _result =
        await DashboardService.getfeedTotalUserYearly(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result!.forEach((e) {
      List<Map<String, dynamic>> mapDatum = [];
      e.data!.forEach((e) {
        Map<String, dynamic> item = {
          'domain': e.domain,
          'measure': e.measure,
        };
        mapDatum.add(item);
      });

      Map<String, dynamic> _item = {
        'id': e.id,
        'data': mapDatum,
      };
      mapList.add(_item);
    });

    totalUserMonthly = mapList.toList();

    notifyListeners();
  }

  getfeedUserCountryMonthly(context) async {
    collectionTicketMontlyAll.clear();
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanMontly);
    List<TotalUserCountryMontly>? _result =
        await DashboardService.getfeedTotalUserCountry(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result!.forEach((e) {
      List<Map<String, dynamic>> mapDatum = [];
      e.data!.forEach((e) {
        Map<String, dynamic> item = {
          'domain': e.domain,
          'measure': e.measure,
        };
        mapDatum.add(item);
      });

      Map<String, dynamic> _item = {
        'id': e.id,
        'data': mapDatum,
      };
      mapList.add(_item);
    });

    totalUserCountryMonthly = mapList.toList();

    notifyListeners();
  }

  getResumeTransaction(context) async {
    PinTicketDaily params = PinTicketDaily(day: day);

    List<ResumeTransaction> _result =
        await DashboardService.getfeedResumeTransaction(context, params);

    resumeTrx = _result;

    notifyListeners();
  }

  getResumeTopGtv(context) async {
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanTopGtv);

    List<TopGtv> _result =
        await DashboardService.getfeedtopgtv(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result.forEach((e) {
      Map<String, dynamic> _item = {
        'domain': e.domain,
        'measure': e.measure,
      };
      mapList.add(_item);
    });

    topGtv = mapList.toList();

    notifyListeners();
  }

  getResumeTopTrx(context) async {
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulanTopTrx);

    List<TopGtv> _result =
        await DashboardService.getfeedtoptrx(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result.forEach((e) {
      Map<String, dynamic> _item = {
        'domain': e.domain,
        'measure': e.measure,
      };
      mapList.add(_item);
    });

    topTrx = mapList.toList();

    notifyListeners();
  }

  getfeedtrxvsgtv(context) async {
    PinTicketstatusmontly params = PinTicketstatusmontly(month: bulantrxvsgtv);
    List<TotalUserCountryMontly>? _result =
        await DashboardService.getfeedtrxvsgtv(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result!.forEach((e) {
      List<Map<String, dynamic>> mapDatum = [];
      e.data!.forEach((e) {
        Map<String, dynamic> item = {
          'domain': e.domain,
          'measure': e.measure,
        };
        mapDatum.add(item);
      });

      Map<String, dynamic> _item = {
        'id': e.id,
        'data': mapDatum,
      };
      mapList.add(_item);
    });

    monthlytrxvsgtv = mapList.toList();

    notifyListeners();
  }

  getfeedgtvproduct(context) async {
    PinGtvPerProduct params = PinGtvPerProduct(
      month: '',
      year: _year,
    );

    List<TotalUserCountryMontly>? _result =
        await DashboardService.getfeedgtvproduct(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result!.forEach((e) {
      List<Map<String, dynamic>> mapDatum = [];
      e.data!.forEach((e) {
        Map<String, dynamic> item = {
          'domain': e.domain,
          'measure': e.measure,
        };
        mapDatum.add(item);
      });

      Map<String, dynamic> _item = {
        'id': e.id,
        'data': mapDatum,
      };
      mapList.add(_item);
    });

    monthlygtvproduct = mapList.toList();

    notifyListeners();
  }

  getfeedtrxproduct(context) async {
    PinGtvPerProduct params = PinGtvPerProduct(
      month: bulantrxproduct,
      year: '',
    );

    List<TotalUserCountryMontly>? _result =
        await DashboardService.getfeedtrxproduct(context, params);

    List<Map<String, dynamic>> mapList = [];

    _result!.forEach((e) {
      List<Map<String, dynamic>> mapDatum = [];
      e.data!.forEach((e) {
        Map<String, dynamic> item = {
          'domain': e.domain,
          'measure': e.measure,
        };
        mapDatum.add(item);
      });

      Map<String, dynamic> _item = {
        'id': e.id,
        'data': mapDatum,
      };
      mapList.add(_item);
    });

    monthlytrxproduct = mapList.toList();

    notifyListeners();
  }
}
